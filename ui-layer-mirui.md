# Naledzi UI Layer — mirui as the app-suite provider

> **Status:** plan. Nothing built. No file in this plan has been written.
>
> **Decision requested:** approve the four architectural locks below, then execute Phase 0.
>
> **Scope:** the *architecture* of the Naledzi UI layer, and the concrete path from
> "mirui is a good library" to "a developer can build a complete, consistent,
> contract-clean app for EV, watch, phone, or PC."

---

## 0. The finding that changes the plan

mirui **0.51.0 compiles for `x86_64-unknown-none`** and is MIT-licensed, `no_std`,
ECS-driven, retained-tree, with a software rasterizer. Verified in this session:

```
cd /tmp/stack-test && cargo build --target x86_64-unknown-none
   Finished dev profile — mirui 0.51 + rlsf + critical-section, no_std, bare-metal
```

Three facts make mirui a *fit*, not a hope:

| mirui fact | Why it matters to Naledzi |
|---|---|
| `mirui::surface::Surface` has **3 required methods**: `display_info()`, `flush(area)`, `poll_event()` | Naledzi already owns the equivalents: `display.capnp` monitor info, `surface.capnp` `commit(FrameSubmission{damage})`, `input.capnp` `pullInputEvents`. The adapter is ~80 lines, not a port. |
| `FramebufferAccess::framebuffer()` returns a `Texture` over **caller-owned `&mut [u8]`** | The software renderer can write **directly into the framebuffer** — `Texture::new(&mut [u8], w, h, BGRA8888)`. Zero copy, zero allocation on the pixel path. QEMU's fb is already BGRA32 at `0xffff8000fd000000`, 1280x800, stride 5120 (`target/qemu-logs/a2-transcript.log:337`). |
| `ColorToken` enum ≈ Naledzi's `theme.capnp` `ThemeColors` | mirui: Primary/OnPrimary/Secondary/Tertiary/Surface/OnSurface/SurfaceVariant/Success/Error/Outline/Shadow. `theme.capnp` has primary/onPrimary/secondary/tertiary/surface/onSurface/surfaceVariant/error/outline/shadow — **but is missing success/warning/info**. 2 crates compile `theme.capnp` (theme service + smart-shell) → cheap to amend. |

mirui is **not** a DE, not a compositor, not a window manager, not a shell. It is a
**widget/render runtime** that an *app* embeds. That is precisely the shape Naledzi
wants: the OS provides contracts; a program provides the experience.

---

## 1. The architecture — four locks

Everything else follows from these. They are the whole design.

### Lock 1 — The UI contract is capnp. mirui is an implementation detail of the *app*, never of the OS.

The OS-level UI contract is **already written** and is not negotiable:

```
protocol/schemas/theme.capnp      tokens: colors, typography, spacing, shape, motion, variants
protocol/schemas/surface.capnp    rectangles: geometry, z-order, damage, input regions, material
protocol/schemas/display.capnp    outputs: modes, HDR, kiosk, signage, circular, fold, gesture zones
protocol/schemas/input.capnp      events: keyboard + the pointer/touch/scroll set
protocol/schemas/app.capnp        lifecycle: launch, focus, permissions, health, delegation
protocol/schemas/font.capnp       glyph metrics + licensing
```

`theme-service` (`services.toml:210`), `surface-service` (`services.toml:238`),
`font-service` (`services.toml:217`), `display-fb-embedded` (`services.toml:24`) and
`input-service` (`services.toml:30`) are **already enabled and already announce
discovery tags** (`theme/src/main.rs:1288` -> `"theme-tokens"`,
`surface/src/main.rs:1364` -> `"surface-table"`, `font/src/main.rs:410` ->
`"font-catalogue"`).

**What mirui is:** the render+widget runtime an app links. The app *also* links
`naledzi-ui` — a thin Naledzi adapter crate — and that is the only place mirui
appears.

```
   ┌─────────────────────────────────────────────────────────────┐
   │  app binary (userspace, no_std, its own trust domain)        │
   │                                                              │
   │   ┌──────────────┐        ┌───────────────────────────────┐  │
   │   │  mirui 0.51  │◄──────►│  naledzi-ui  (adapter crate)  │  │
   │   │  ECS, widget │        │  implements mirui::Surface     │  │
   │   │  tree, layout│        │  over capnp contracts         │  │
   │   │  raster, text│        │  - flush()  → surface.commit  │  │
   │   │  input, focus│        │  - poll_event() → input.pull  │  │
   │   └──────────────┘        │  - theme   → theme.getTheme   │  │
   │                           │  - clock   → clock.service    │  │
   │                           │  - font    → font.service     │  │
   │                           └───────────────┬───────────────┘  │
   └───────────────────────────────────────────┼──────────────────┘
                                               │ capnp (smart protocol)
        ┌──────────────┬───────────┬──────────┴────────┬──────────────┐
        │ theme-service│surface-svc│  input-service    │ font-service  │
        └──────────────┴───────────┴───────────────────┴──────────────┘
```

**Why this satisfies "if Naledzi is deleted, a new smart-protocol OS still fits":**
the app's dependency surface is *capnp messages*, not Naledzi internals. Swap in
another smart-protocol OS that serves the same schemas, and the same `naledzi-ui`
adapter + the same mirui app binary works unchanged. The adapter is where
portability lives, and it is ~1 crate.

**Why this satisfies "never name another service as a literal":** `naledzi-ui`
resolves peers through the **discovery tag** mechanism that already exists
(`ipc-service/src/lib.rs:1355-1374` sends a lookup filtered by tag; `discovery` has
`lookup_by_tag` at `discovery/src/handlers.rs:205`). No service name is a literal
anywhere in the adapter.

### Lock 2 — Zero-cost means: pixels never cross a contract boundary.

```
mirui software renderer ──writes BGRA8888──▶ &mut [u8] owned by the app
                                                       │
                                            flush(area) = one capnp message
                                            carrying {bufferId, damage, present}
                                                       ▼
                                            surface-service composites
                                                       ▼
                                            framebuffer (HHDM vaddr)
```

- **Zero copies app->framebuffer** for the single-app case: the app's `Texture` is
  constructed over the framebuffer's own `&mut [u8]` when it owns the whole output
  (`FramebufferAccess` in mirui, `Texture::new(&mut [u8], w, h, BGRA8888)`), and
  `flush(area)` is the *damage notification*, not a copy.
- **One capnp message per damaged frame**, not per pixel and not per scanline.
- **No heap allocation on the pixel path** — mirui's `Texture::new` borrows.
- The `PresentIntent` union in `surface.capnp:158-166` already has `immediate`,
  `nextVsync`, `atTime`, `periodic` — the timing policy is a contract field, so
  "vsync" costs nothing extra.

**One honest caveat, because it is load-bearing:** the framebuffer's stride is 5120
bytes for a 1280-wide 32bpp panel (`stride=5120` in the boot log) — that is
`width*4`, i.e. **packed**, so a `Texture::new` over the framebuffer is exact. If a
future panel pads rows, the adapter must render into a packed staging buffer and
blit; mirui's `Texture` is always packed (`PlaneLayout::packed`). This is a
per-output property, read from `display.capnp`'s `Framebuffer.stride`.

### Lock 3 — Theme is the only aesthetic authority, and it is *data*, not code.

The Design Law (Rams re-derived) is **enforced in the token graph, not in app code**:

| Law | Token-level enforcement |
|---|---|
| The material is void | `ThemeColors.background` = true black on OLED profiles; `surface`/`surfaceVariant` are the *only* elevation steps. |
| Structure is type and air | `ThemeShape` radii are one knob; `ThemeSpacing` is the 4px rhythm. No border/shadow token is *required* by any widget. |
| One permanent resident per screen | Enforced by the shell's layout, not the token graph. |
| The accent is attention, not identity | `ThemeColors.primary` is the *attention ink*; it is only ever painted on the focused element. Not a brand colour. |
| Truth is visible | `T.Error{code,message,context}` already carries the reason. A degraded value renders `N/A — <reason>`; a stale value carries its age. **This is `types.capnp` + the honesty idiom already in `display.capnp:276-334` (`physicalSizeValid`/`refreshRateValid`).** |

**The theme service is where the law is written.** It already has a real palette
(`theme/src/main.rs:77-107` DARK/LIGHT/HIGH_CONTRAST/MONOCHROME), an accent override
(`set_accent_color`), a font scale, and per-variant kinds (`ThemeVariantKind`:
default/highContrast/monochrome/colorful/accessibility/brand/custom).

**What must change in the theme service (data, not architecture):**
- The dark palette must become **void + grey shade ladder + one vibrant accent**.
  Today it is a blue-tinted Material-ish ramp (`DARK[0] = [0.42,0.63,0.95,1.0]`,
  `DARK[16] = [0.05,0.07,0.10,1.0]`). The ask is black background, shades of grey,
  vibrant accent, and explicitly *not* green-tinted greys.
- `theme.capnp` `ThemeColors` needs **`success` / `warning` / `info`** added — it has
  `error` but not the other two, and mirui's `ColorToken` has `Success`+`Error`.
  2 crates recompile. Cheap.
- **Attention-ink semantics**: today `primary` is a brand role. It must become *the
  focus ink*. The schema already has `ThemeVariantKind.brand` for branding — so
  `primary` frees up to mean attention. No schema change; a token-value +
  convention change, documented in the law.

**Corner radius and squares are tokens.** `ThemeShape.extraSmall/small/medium/large`
already exist. Round or square is a profile choice, not an architectural one.

### Lock 4 — One app-facing UI vocabulary, so the suite is consistent and every app is *complete*.

The question was: how do I build my app suite with mirui, and what architecture
makes apps get *finished, complete, and consistent*.

**The answer: `naledzi-ui` ships a *widget set*, not just a mirui re-export.**

mirui's own widgets are generic (button, slider, text_input, lazy_list, tabbar,
navigation, page_view, switch, checkbox, progress_bar, image, icon). A Naledzi app
suite built directly on those would look like every other Rust GUI app and would
re-invent chrome in every app.

So `naledzi-ui` provides **Naledzi widgets** built on mirui, themed exclusively by
`theme.capnp` tokens:

```
naledzi-ui
├── naledzi::theme      → theme.capnp tokens → mirui Theme/ColorToken (one-way, no hardcoded colours)
├── naledzi::surface    → mirui::Surface over surface.capnp (flush/poll_event/display_info)
├── naledzi::font       → font.capnp + mirui FontProvider
├── naledzi::clock      → clock.capnp → mirui::core::time::set_clock
├── naledzi::input      → input.capnp → mirui InputEvent
└── widgets/
    ├── StatusBar       permanent resident; clock, battery, network, notifications
    ├── CommandPalette  type-to-launch, the one entry point
    ├── List            virtualised (mirui lazy_list) — file manager, app list
    ├── FileRow         name, size, kind, modified — one row, used by every file view
    ├── TextField       mirui text_input + text_editing (1145 lines of editing already done)
    ├── Button, Toggle, Slider, Tabs, Nav
    └── Value           a *value + its truth*: fresh / stale(age) / N/A(reason) / denied
```

**`Value` is the honesty primitive made visual.** It is the widget that renders
`120 km/h · 4s` or `N/A — sensor unreachable`. Every Naledzi app that shows data
uses it. That is how "the OS lies about nothing" becomes a *visual* property rather
than a convention, and it is why the suite looks like one system.

**The suite is then complete by construction:** every app gets StatusBar,
CommandPalette, List, FileRow, TextField, Value, and the theme for free. An app
author writes *their* thing (a file browser, a map, a media player), not the chrome.

---

## 2. The honest gaps — what is NOT built yet

| Gap | Evidence | Cost |
|---|---|---|
| **No compositor.** `surface-service` tracks a *table* of surfaces; it never composites. `handle_commit` records frame stats; there is no blit anywhere in the live tree. | `surface/src/main.rs:479-525`; `grep -rn "fn blit\|fn composite" uspace/` -> only the two dead vendored `kage`/`kukan-slint` checkouts, which are **not workspace members** and are winit/slint-based (hosted, not bare-metal). | Phase 2. One service owns the framebuffer and blits committed surfaces. The *only* new OS service in the plan, optional per envelope. |
| **Pointer input is not wired.** `input-service` polls only PS/2 keyboard (`poll_ps2`, `input/src/main.rs:92`); `backend.poll()` is never called for the mouse/touch backends, and `Ps2Mouse::poll()` returns `Vec::new()` (`input-ps2-mouse/src/lib.rs:98`). `input.capnp`'s live `InputEvent` union has **no pointer arm** — pointer/touch/scroll live in `compositor.capnp`'s separate `InputEvent`. | `input.capnp:696-704` vs `compositor.capnp:246-262` | `input.capnp` gains a pointer arm. 3 crates compile it (input, console, smart-shell). Cheap. **Two authorities for one fact must be collapsed** — pick `input.capnp` (the live one) and have `compositor.capnp` reference it. |
| **The framebuffer has one owner today: `console-service`.** It maps HHDM and writes glyphs directly. | `console/src/main.rs:63-70` | The compositor takes the framebuffer; console-service becomes *a client* that draws into a surface, or the console keeps it in the `console` envelope and the compositor only exists in the `graphical` envelope. Envelope decides. |
| **No real allocator in services.** Every service has a bump allocator that never frees (4 KiB–512 KiB). mirui's ECS (hashbrown, `Vec`, `BTreeMap`, `Rc`) allocates and frees. | `grep -rn "BumpAllocator" uspace/servers/` | `rlsf` (TLSF, MIT, no_std) over a kernel-issued region. `daily-drive-complete-spec.md` D6 already names this. **Verified `rlsf` + mirui + critical-section link for `x86_64-unknown-none`.** |
| **No TTF/text shaping in the font service.** `font-service` rasterises `noto-sans-mono-bitmap` (8x8 bitmap, MIT). mirui wants a `FontProvider`; mirx wants a MIRX container. | `font/src/main.rs:41`; mirui's `FontProvider` trait is public and implementable | Either (a) implement `FontProvider` over Naledzi's own bitmap raster (immediate, monospace, matches the console today), or (b) ship a TTF and use `ttf-parser` for shaping. **(a) first — the console's font is already the one users see.** |
| **No app launch path from the filesystem.** `process-service` spawn works, but `load_binary` only resolves names from the *boot manifest* (`process/src/loader.rs:76-85`). | `process/src/loader.rs:76` | Extend the loader to read from a filesystem path. Separate plan; not blocking the UI layer. |
| **No device profile in the boot manifest.** Envelope selection exists for the *kernel* (`boot.capnp:150-176` `KernelSelectionSet`), not for the UI. | `boot.capnp` | A `presentation profile` in the boot manifest: form factor, screen shape, input modalities, safety class. This is what makes "morphs by device" real rather than aspirational. |
| **`compositor.capnp` (883 methods) is dormant** and compiled by zero live crates. | `grep -rln '"compositor.capnp"' --include=build.rs` -> 0 | Do **not** implement it wholesale. The UI layer uses `theme` + `surface` + `input` + `display` + `app`. `compositor.capnp` stays dormant or gets trimmed later. This is the single biggest scope trap in the repo. |

---

## 3. Envelopes — how the UI morphs by device

Not a runtime mode switch. A **boot-time** selection, exactly like `KernelSelectionSet`.

| Envelope | Device | Who owns the framebuffer | Compositor? | Input | Apps |
|---|---|---|---|---|---|
| `console` | server, spacecraft ops | console-service | no | keyboard | smart-shell |
| `glance` | watch | the app | no | crown, touch | glance apps |
| `cluster` | EV cluster, HUD | the app (or a 2-surface compositor) | no | touch, voice | cluster app |
| `ambient` | phone, tablet | compositor | yes | touch | suite |
| `desktop` | PC, workstation | compositor | yes | keyboard, mouse, touch | suite |

`KernelSelectionSet` already models exactly this shape (`available` / `selectedIndex`
/ `selectedPresent` / `defaultIndex` / `selectedBy`). The UI envelope is the same
pattern applied to the *presentation* domain — a sibling field, not a new mechanism.

**Per-envelope, the app suite adapts through:**
- **tokens** -> the theme service publishes a per-envelope variant (watch: larger
  type, higher contrast, fewer tones; EV cluster: high-contrast, glance-safe;
  desktop: dense).
- **layout** -> the app's own layout reacts to the display geometry from
  `display.capnp` and to the form factor from the boot manifest. mirui's layout is
  constraint-based, so the *same* tree reflows.
- **input** -> the app sees the modalities the device actually has, from
  `input.capnp` (`listDevices`, `getDevice`).

**One code path, five envelopes.** That is the "multi-paradigm" requirement
satisfied without a DE, without runtime mode switching, and without a compositor
where none is needed.

---

## 4. The developer story (the answer to "how do I build my suite")

```rust
// 1. depend on the adapter, not on mirui
//    naledzi-ui = { path = "uspace/lib/naledzi-ui" }

use naledzi_ui::prelude::*;

#[derive(Default)]
struct FileManager {
    dir: PathBuf,
    rows: Vec<FileRow>,
    filter: String,
}

impl App for FileManager {
    fn theme(&self) -> &Theme { &self.theme }          // from theme-service
    fn build(&self) -> Widget {                          // mirui tree, themed only by tokens
        Column()
            .child(StatusBar::new())                      // free
            .child(CommandPalette::new())                // free
            .child(FileList::new(self.rows.clone()))      // free, virtualised
            .child(TextField::new(&self.filter))          // free
    }
    fn on_event(&mut self, e: Event) {                   // intent, not pixels
        match e {
            Event::FileActivated(p) => self.open(p),
            Event::FilterChanged(s) => { self.filter = s; self.reload(); }
            _ => {}
        }
    }
}

// 3. run it
fn main() { naledzi_ui::run(FileManager::default()); }
```

**The developer writes their app. Not a widget library. Not a compositor. Not a
theme.** The suite's look comes from `naledzi-ui` + `theme-service`; the contract
compatibility comes from capnp; the speed comes from direct-to-framebuffer
rendering.

**The app is a full OS citizen**, not a special case:
- It is a **service** in `services.toml`, so it gets its own trust domain, its own
  stack, its own IPC channel, its own scheduling class.
- It is discoverable by role tag, so the shell can find it without naming it.
- It uses `app.capnp` for launch/focus/permissions/health — the contracts for
  "an app" already exist.

---

## 5. Execution phases

Ordered by dependency. Each phase ends in a **verified, bootable** state. No phase
is deferred or cut.

### Phase 0 — The adapter crate + the theme law (foundation)

**0a. `naledzi-ui` crate.** New workspace member `uspace/lib/naledzi-ui`.
- `mirui 0.51` with `default-features = false` (verified no_std build).
- `rlsf 0.2` for a real allocator over a kernel-issued region.
- `critical-section` impl. Naledzi's scheduler preempts at tick boundaries
  (`sched.rs`, 10-tick slice), and mirui's reactive runtime guards a `static mut`
  with `critical_section` — so the impl must **actually defer preemption**, not
  pretend. (Verified it compiles and links; correctness of the impl is Phase 0a
  work.)
- `mirui::surface::Surface` impl over the Naledzi contracts:
  `display_info()` <- `display.capnp`; `flush(area)` <- `surface.capnp`
  `commit(FrameSubmission{surfaceId, bufferId, damage: area, present})`;
  `poll_event()` <- `input.capnp` `pullInputEvents`.
- `mirui::core::time::set_clock()` <- `clock.capnp`.
- `mirui::render::font::FontProvider` over Naledzi's bitmap raster.

**0b. Theme law.** Rewrite the theme service's dark palette to void + grey ladder +
one vibrant attention accent. Add `success`/`warning`/`info` to `theme.capnp`
`ThemeColors` (2 crates recompile). Write `docs/DESIGN-LAW.md`: the five laws, the
token mapping, the honesty idiom.

**Verify:** `cargo check --target x86_64-unknown-none -p naledzi-ui -p theme-service`.
Then boot the ISO and confirm the theme service publishes the new palette and the
shell renders the status line in it (the shell already consumes `Theme.getTheme` and
renders styled text — `smart-shell/src/theme.rs:143`, `main.rs:1461`).

### Phase 1 — The first real app (a file manager)

Proves the whole stack: contract -> adapter -> mirui -> pixels -> input -> honesty.

- New service `uspace/apps/filemanager`, in `services.toml`.
- Uses `filesystem.capnp` (already implemented and live: `listDirectory` at
  `filesystem/src/main.rs:1267`, plus create/rename/remove/copy),
  `theme.capnp`, `input.capnp`, `surface.capnp`.
- Renders with mirui into a surface; commits damage.
- `Value` widget shows file sizes/dates with provenance; a failed stat renders
  `N/A — <reason>`, never a zero.

**Verify:** boot ISO, pty-driven, run the file manager, navigate a real directory,
create/rename/remove a file, and assert the transcript shows real names, real
sizes, and `N/A — reason` for anything the filesystem cannot stat.

### Phase 2 — The compositor service (the only new OS service)

- One service owns the framebuffer and composites committed surfaces in z-order
  (`surface.capnp` already has `setZOrder`, `raiseToTop`, `lowerToBottom`).
- Honours `PresentIntent` (immediate / nextVsync / atTime / periodic).
- Damage-only blits: `surface.capnp`'s `DamageOption` already carries the rect.
- Reads `display.capnp` for the output's real geometry and pixel format.

**Verify:** two apps visible at once, z-order correct on focus change, and the
compositor's blit count equals the sum of the damage areas (reported honestly via
`logging`).

### Phase 3 — Pointer input, so the suite is usable with a mouse/touch

- `input.capnp` `InputEvent` gains a **pointer arm** (position, buttons, delta) and
  a **touch arm**. Collapse the duplicate in `compositor.capnp` so there is one
  authority.
- `input-service` actually polls the PS/2 mouse backend and routes IRQ12 to it
  (today only IRQ0/IRQ1 are wired — `idt.rs:150` sets the keyboard handler).
- `input-service` stops returning `NOT REPORTED` for pointer state.

**Verify:** pty + QEMU mouse injection moves a cursor and selects a file in the
file manager.

### Phase 4 — The shell becomes a suite host (workspaces, palette, launcher)

- The **command palette** is the one entry point (type to launch/search/act).
- **Workspaces** are app arrangements, owned by the shell, persisted.
- The **status bar** is the one permanent resident on every screen.
- Windows become surfaces. No window-manager service — the shell composes (or, in
  the `console` envelope, no windows at all).

**Verify:** launch apps by name from the palette; switch workspaces; the status bar
shows real clock/battery/network, and `N/A — reason` for anything with no producer.

### Phase 5 — Envelopes (morph by device)

- Boot manifest gains a **presentation profile**: form factor, screen shape
  (rect/circular/foldable), input modalities, safety class.
- `theme-service` publishes a matching token variant.
- The `cluster` and `glance` envelopes run **without** a compositor — the app owns
  the framebuffer.

**Verify:** one app binary, three envelopes, three layouts, one contract.

### Phase 6 — The honest-performance pass

Measure, do not assert. For each: input->pixel latency, frame time, compositor blit
volume, allocation per frame, and **whether the numbers meet a stated budget**.
Report the numbers even if they are bad. AGENTS.md §6: "Never fabricate a value."

---

## 6. Risks and how each is answered

| Risk | Answer |
|---|---|
| mirui 0.51 is young (25% documented) | It is behind `naledzi-ui`. If it dies, the adapter is rewritten; **the contract and the app's own code do not change.** That is the whole point of Lock 1. |
| mirui pulls a big dep tree (textflow, mirx, ttf-parser, hashbrown, lyon-optional) | Measured at build time. If it is too heavy for a flight target, `naledzi-ui` grows a second backend — the `Surface` trait is 3 methods, so a hand-rolled renderer is a ~400-line alternative. |
| Services have no real heap | `rlsf` over a kernel-issued region. Already named in `daily-drive-complete-spec.md` D6. |
| `compositor.capnp` is an 883-method trap | Explicitly **not** in scope. The UI layer uses theme+surface+input+display+app. |
| Two input-event authorities (`input.capnp` vs `compositor.capnp`) | Collapsed in Phase 3 onto the live schema. |
| `critical-section` in a preemptive scheduler | mirui guards a `static mut` in its reactive runtime; Naledzi preempts at tick boundaries. The impl must actually defer preemption. Handled in Phase 0a. |

---

## 7. What this plan does NOT do

- It does not revive `compositor.capnp`.
- It does not build a DE, a window manager service, a settings daemon, or a
  notification daemon.
- It does not add a runtime "desktop mode" switch. Envelopes are chosen at boot.
- It does not port egui/iced/slint. It uses mirui, which compiles on bare metal
  today, behind an adapter.
- It does not touch the kernel. Every phase is userspace + contracts.

---

## 8. The decisions I need

1. **Lock 1** — mirui is an *app-side* implementation behind `naledzi-ui`; the OS
   contract stays capnp. *Approve?*
2. **Lock 3 / theme** — the accent becomes **attention ink** (focus only), the dark
   palette becomes void + grey ladder + one vibrant accent, and `theme.capnp` gains
   `success`/`warning`/`info`. Which vibrant accent hue? (Proposal: a cool
   electric blue-cyan for the dark profile. The palette is data, so this is
   changeable without touching code.)
3. **Phase order** — adapter+theme first, then the file manager as the proving app,
   then the compositor, then pointer input, then the shell, then envelopes. Or
   pointer input earlier (it is small, and it makes the file manager feel real
   sooner)?
4. **Scope of Phase 0a** — the `naledzi-ui` crate: adapter + minimal widget set
   (StatusBar, CommandPalette, List, FileRow, TextField, Value) in one go, or
   adapter-only first and widgets grown as each app needs them?
