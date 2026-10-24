---
id: FW-RUNTIME-MIRUI
title: "MirUI: what it is and is not"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
supersedes: []
superseded_by: []
acceptance: [AC-FW-MIRUI-001, AC-FW-MIRUI-002]
---

# MirUI: what it is and is not

> MirUI is the app-side runtime. It is not the compositor, not the authority, and not the
> policy. It owns the pixels an app declares; the authority owns the still.

---

## 1. What MirUI is

MirUI 0.51.0 is a `no_std`, MIT-licensed, ECS-driven, retained-tree UI runtime with a
software rasteriser. Verified: it compiles for `x86_64-unknown-none` (`ui-layer-mirui.md` §0).
It provides, inside one app process:

1. **ECS** — entities, components, systems, commands, resources, scheduling
   (`src/ecs/*`).
2. **Flex layout** — constraint-based, intrinsic sizing, wrap, gap, grow/shrink
   (`src/ui/layout/node.rs`, `src/ui/layout/flex.rs`).
3. **Raster** — software renderer writing into caller-owned `&mut [u8]` via
   `FramebufferAccess::framebuffer()` returning a `Texture`; zero copy on the pixel path
   (`ui-layer-mirui.md` §0).
4. **Text** — shaping, bidi (`TextDirection`), wrap, overflow, language tags
   (`src/ui/widgets/text.rs`).
5. **Damage** — per-entity dirty tracking, `mark_subtree_dirty` for global changes
   (`src/ui/dirty.rs`).
6. **Input** — event model, focus, hit-testing, gestures, scroll motion
   (`src/input/*`).
7. **Animation primitives** — scroll motion, rotary feedback; general spring integration is
   framework-owned (see `07-animation.md`).
8. **Theming hooks** — `ColorToken`, `WidgetState` (`src/ui/theme.rs`).

## 2. What MirUI is not

MirUI is **not** any of the following, and the framework MUST NOT let it become one:

| Not this | Owner instead | Contract |
|---|---|---|
| The compositor | Compositor service (Phase 2) or the single owner of the framebuffer in `console`/`glance`/`cluster` envelopes | `surface.capnp` |
| The authority / still owner | Presentation authority | `LAW-005`, `LAW-006` |
| The policy (layout arbitration, stacking) | Policy app (optional, replaceable) | `LAW-006` |
| The theme authority | Theme service | `theme.capnp` |
| The input authority | Input service | `input.capnp` |
| The font authority | Font service | `font.capnp` |
| A window manager | Shell / policy | `app.capnp` |
| A second scheduler for the OS | The OS scheduler; MirUI schedules only within its app | `runtime/09-scheduler.md` |

MirUI is an implementation detail of the app, hidden behind `naledzi-ui`. Apps never name
mirui types in their public API (`ui-layer-mirui.md` §4, Lock 1).

## 3. The adapter boundary in detail

`naledzi-ui` implements `mirui::surface::Surface` (3 methods) over the Naledzi contracts:

- `display_info()` reads `display.capnp` monitor info: resolution, refresh, shape
  (rect/circular/fold), HDR, kiosk/signage.
- `flush(area)` sends `surface.capnp` `commit(FrameSubmission{surfaceId, bufferId,
  damage: area, present})`. The damage is the declared rect; no pixels cross the boundary
  (LAW-002).
- `poll_event()` pulls `input.capnp` `pullInputEvents`.

Additional adapter wiring:

- `mirui::core::time::set_clock()` <- `clock.capnp`.
- `mirui::render::font::FontProvider` <- font service bitmap raster (Phase 0a): either
  bitmap raster immediately, or TTF via `ttf-parser` later (`ui-layer-mirui.md` §2 gap).
- Theme: `theme.capnp` tokens -> mirui `Theme`/`ColorToken`, one-way, no hardcoded colours.

The adapter is ~80 lines of trait impl plus theme/font wiring (`ui-layer-mirui.md` §1).

## 4. Zero-copy pixel path

The software renderer writes BGRA8888 directly into caller-owned `&mut [u8]`:

```
mirui software renderer --writes BGRA8888--> &mut [u8] owned by the app
                                                  |
                                       flush(area) = one capnp message
                                       {bufferId, damage, present}
                                                  v
                                       surface service composites
                                                  v
                                       framebuffer (HHDM vaddr)
```

- Zero copies app->framebuffer for the single-app case when the app owns the whole output
  (`FramebufferAccess`, `Texture::new(&mut [u8], w, h, BGRA8888)`).
- One capnp message per damaged frame, not per pixel.
- No heap allocation on the pixel path (`Texture::new` borrows).

Caveat: the framebuffer stride must be packed (`width*4`). QEMU's fb is packed
(stride 5120 for 1280-wide, `ui-layer-mirui.md` §1 Lock 2). If a future panel pads rows,
the adapter renders into a packed staging buffer and blits; mirui's `Texture` is always
packed (`PlaneLayout::packed`). Stride is read from `display.capnp`'s `Framebuffer.stride`.

## 5. MirUI as one ECS

MirUI owns one ECS per app process. The framework MUST NOT create a second ECS, a second
layout engine, a second theme, a second scheduler or a second event loop
(`../README.md` §2). An app composes MirUI entities; it does not own a parallel tree.

## 6. Honest absence

Where MirUI does not provide a capability the framework needs, the gap is named, not hidden:

- No grid primitive -> compose flex rows or app-owned pass (`../README.md` §2.2).
- No layout RTL -> framework adaptation pass (`03-layout.md`).
- No accessibility semantics -> framework semantic tree (`06-input.md`).
- No central spring engine -> framework-owned (see note above).
- No grid -> declared in open questions.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-MIRUI-001` | An app built on `naledzi-ui` compiles for `x86_64-unknown-none` and commits a still through the adapter without naming mirui in its public API. |
| `AC-FW-MIRUI-002` | The pixel path allocates zero heap bytes per frame in the single-app case (verified by allocator instrumentation). |
| `AC-FW-MIRUI-003` | No second ECS, layout engine, theme, scheduler or event loop exists in an app. |