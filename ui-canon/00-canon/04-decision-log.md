---
id: CANON-DECISIONS
title: Decision Log
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-LAWS, CANON-TIMELESSNESS]
acceptance: [AC-DOC-005]
---

# Decision Log

> Every decision that changes a normative statement is recorded here before the statement
> is edited. A decision without a record is a rumour.

---

## Format

```markdown
## ADR-NNNN — <title>

**Status:** proposed | accepted | superseded by ADR-NNNN | rejected
**Date:** YYYY-MM-DD
**Deciders:** <roles>
**Affects:** <IDs>

### Context
### Decision
### Alternatives considered
### Consequences
### Evidence / acceptance
```

Rules:

- ADRs are append-only. A reversed decision is a new ADR that supersedes the old one.
- "We tried it and it was faster" is evidence only with numbers.
- An ADR that affects a law must cite the law.
- An ADR with no alternative considered is not a decision; it is a preference.

---

## ADR-0001 — Numbered stills are the presentation truth

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `ARCH-PRESENT-*`, `LAW-005`

**Context.** Presentation systems keep pixels, hit-testing, accessibility and input
ownership in separate structures that are "kept in sync" by convention. The result is a
class of consistency bugs: a moved window with stale hit targets, a screen reader
describing a gone control, a buffer recycled while visible.

**Decision.** The visible truth of an output is one atomic, versioned fact: pixels, hit
map, accessibility snapshot, input ownership and buffer lifetimes, committed together and
numbered by the authority. Observers read a still; they do not read a mutable scene.

**Alternatives.** (a) Keep separate pipelines and add synchronization. (b) Make the policy
the owner of truth. (c) Use a scene graph with implicit commits.

**Consequences.** Commits must be explicit. The authority is mandatory and small. Policy
becomes optional. The model is more demanding to implement, but removes whole bug classes
and enables forensics, crash recovery and remote output.

**Evidence.** Race tests: move+click, close+read, recycle+scanout must never observe a
half-state (`AC-ARCH-PRESENT-*`).

---

## ADR-0002 — Authority is mandatory; policy is optional

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-006`, `ARCH-PRESENT-*`

**Context.** A watch or IoT display may have one surface and no window management. A
desktop needs stacking and workspaces. A car needs protected zones. Forcing one policy
binary on every device creates per-device forks.

**Decision.** Validation, still numbering and crash-safe truth are always present
(authority). Layout, stacking, focus and arbitration are a replaceable policy app, present
only where needed.

**Alternatives.** (a) One compositor for all devices. (b) No authority, policy owns truth.
(c) Per-device presentation stacks.

**Consequences.** Simple devices have almost no UI machinery. Complex devices swap policy
without losing the screen. Safety-critical policy can be separately certified.

**Evidence.** Kill the policy; stills remain; input leases expire; a new policy adopts the
truth (`AC-ARCH-PRESENT-CRASH-*`).

---

## ADR-0003 — MirUI is the app-side runtime, not the compositor

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `FW-MIRUI-*`, `LAW-013`

**Context.** MirUI is an ECS-driven UI toolkit with layout, raster, text and dirty-region
tracking. It has no multi-client arbitration, no output ownership and no capability/trust
model.

**Decision.** MirUI is the client-side runtime for apps and the shell. It produces buffers
and declared damage. It does not own outputs, arbitrate clients or define the system's
presentation contract.

**Alternatives.** (a) Make MirUI the compositor. (b) Write a second UI toolkit. (c) Use a
different toolkit per app.

**Consequences.** One ECS, one layout, one scheduler for app content. The presentation
contract stays independent and replaceable. MirUI's release risk is contained by pinning,
an adapter layer and conformance tests.

**Evidence.** An app built on MirUI runs under two different executors without code changes
(`AC-FW-MIRUI-*`).

---

## ADR-0004 — Depth, not glassmorphism

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-007`, `FOUND-DEPTH-*`

**Context.** Glassmorphism is a surface fashion: blur, transparency, highlight. It is
expensive, fails on low-end and outdoor displays, and carries no hierarchy.

**Decision.** The visual language is depth: one light model, a fixed elevation scale,
contact and ambient shadows, parallax, occlusion, focus dimming and material rules.
Translucency is a declared material for specific transient layers, never the foundation.

**Alternatives.** (a) Glassmorphism. (b) Flat/Material. (c) Neumorphism. (d) Brutalist
monochrome.

**Consequences.** Depth tokens become mandatory. Shadows and parallax need performance
budgets. Accessibility must guarantee contrast and reduced-motion alternatives.

**Evidence.** Depth test: remove the shadow; hierarchy must still be readable from position
and contrast. Contrast passes WCAG 2.2 AA in every material (`AC-FOUND-DEPTH-*`).

---

## ADR-0005 — Spring physics is the motion foundation

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-008`, `FOUND-MOTION-*`

**Context.** Fixed-duration easing curves cannot be interrupted gracefully; restarting a
curve mid-flight produces a jump. Human motion is spring-like.

**Decision.** Motion is target-based spring physics: response, damping, velocity
preservation, deterministic integration, settle-and-stop. Springs are named by intent.
Gestures hand off velocity to the spring on release.

**Alternatives.** (a) Cubic-bezier only. (b) Duration-based keyframes. (c) Physics engine
for all motion.

**Consequences.** One motion engine. Reduced-motion alternatives. Safety envelopes use
bounded, non-overshooting springs. Motion tokens are shared by all apps.

**Evidence.** Interrupt halfway; no jump; settle within bound; identical at 60/90/120/144 Hz
(`AC-FOUND-MOTION-*`).

---

## ADR-0006 — The strip replaces the dock

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-010`, `SHELL-STRIP-*`

**Context.** A dock is permanent chrome that assumes a wide pointer-driven screen, conflates
launching and switching, and shows memorized icons. It fails on watch, TV, car and
low-power devices.

**Decision.** The bottom-edge affordance is a summon-only depth reel of **live stills**:
cards with real content, magnification via one spring, launch and switch in one surface,
privacy-controlled. Pulling it up fans out into the full spatial switcher. It is not
permanently visible.

**Alternatives.** (a) Keep a dock. (b) Icon grid launcher. (c) Exposé only. (d) No switcher.

**Consequences.** The authority must expose stills to the shell under an observation
capability. Thumbnails are commit-driven, not polled. Apps may blank or omit themselves.

**Evidence.** Hidden strip costs zero; visible strip updates only on commit; watch/TV/car
variants are specified (`AC-SHELL-STRIP-*`).

---

## ADR-0007 — The status rail is adaptive and UX-owned

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-010`, `SHELL-STATUS-*`

**Context.** A fixed status bar is inherited from desktop and terminal conventions. The
information a person always needs differs by envelope: time and activity on a watch; time,
signal, battery and privacy on a phone; almost nothing persistent on a desktop; speed,
range and warnings in a car.

**Decision.** The status area is an adaptive indicator rail owned by the envelope's policy.
Indicators have priority and collapse rules. The OS provides facts (time, power,
connectivity, privacy, notifications); the policy decides what is always visible.

**Alternatives.** (a) Fixed OS bar. (b) No status area. (c) App-drawn status bars.

**Consequences.** Per-envelope status specifications. Safety indicators override
entertainment. The rail is accessible and never truncates a critical warning.

**Evidence.** Each envelope's rail has a priority table and a collapse test
(`AC-SHELL-STATUS-*`).

---

## ADR-0008 — Damage is declared, not detected

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-003`, `REND-DAMAGE-*`

**Context.** Runtime diffing burns CPU and scales with screen size to rediscover what the
producer already knew.

**Decision.** The producer declares damage. The system never compares frames. An app that
cannot track damage declares the full surface and remains correct.

**Alternatives.** (a) OS-side frame diffing. (b) Tile dirty tracking in the OS. (c) Always
full-frame.

**Consequences.** Frameworks carry the dirty-region knowledge (MirUI already does). The
commit carries an explicit rect list. Damage merging is deterministic and bounded.

**Evidence.** Instrumentation shows zero frame comparisons and zero pixel readbacks
(`AC-REND-DAMAGE-*`).

---

## ADR-0009 — Buffers are capabilities; no global raw pointers

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-002`, `SEC-*`

**Context.** Handing an app a global pointer lets it forge, retain or outlive the resource.
A global handle table is an ambient authority.

**Decision.** Buffers cross boundaries as capabilities: scoped, revocable, unforgeable.
The producer owns the buffer; the consumer receives a right to use it for a defined
operation and lifetime. No raw address ever crosses the boundary.

**Alternatives.** (a) Global buffer IDs. (b) Shared memory with an offset. (c) Copy every
frame.

**Consequences.** Import/export is a capability operation. Revocation is real. Thumbnails
and remote outputs are observation capabilities, not memory reads.

**Evidence.** An app holding a stale capability cannot read or present the buffer after
revocation (`AC-SEC-CAP-*`).

---

## ADR-0010 — Solar icons plus a Naledzi glyph set

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `FOUND-ICON-*`, `LAW-013`

**Context.** A custom icon set from zero is expensive and inconsistent. Solar is a large,
coherent, multi-weight open icon set with a permissive license. It does not cover
OS-specific concepts.

**Decision.** Use Solar as the base icon language, pinned and vendored with its license.
Add a small Naledzi glyph set for concepts Solar does not carry (authority, still, strip,
capability, envelope, safety zone). Icons are referenced by semantic name, never by file
path. The renderer consumes vector paths/SDF through MirUI.

**Alternatives.** (a) Fully custom set. (b) Material Symbols. (c) Lucide. (d) Phosphor.

**Consequences.** License and attribution are recorded. Weights map to depth/emphasis. A
mapping table is mandatory. Custom glyphs follow the same grid and stroke rules.

**Evidence.** Every icon in every wireframe maps to a semantic name and a source
(`AC-FOUND-ICON-*`).

---

## ADR-0011 — Every entity is a directory

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `DOC-SYSTEM`, all entities

**Context.** One Markdown file per app forces unrelated questions into one place, makes
review coarse and makes a reader scroll through what they do not need.

**Decision.** Every app, component, envelope, pipeline and flow is a directory of small
files with a shared anatomy. The README is the manifest. Files answer one question each.

**Alternatives.** (a) One file per app. (b) A database. (c) A wiki.

**Consequences.** The corpus is large but navigable. Review is per-file. Agents can own a
leaf. Duplication is easier to detect.

**Evidence.** The calculator tree is the exemplar; a stranger can implement it from the
directory alone (`AC-APP-CALC-*`).

---

## ADR-0012 — Tabs are transformed into a Section Set

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-010`, `COMP-SECTION-SET-*`

**Context.** The need — comparing parallel peers — is timeless. The tab strip is a 1994
desktop rendering that fails on narrow screens and fights split views.

**Decision.** The primitive is a Section Set: labelled peers with a spatial model. It
renders as a horizontal rail on desktop, segmented control on phone, crown-scroll on watch
and a list on TV. A tab bar is one rendering, not the primitive.

**Alternatives.** (a) Keep tabs everywhere. (b) Sidebar only. (c) No sections.

**Consequences.** Components implement the primitive, not the chrome. Apps declare sections
semantically.

**Evidence.** The same section content is usable on watch and desktop without a different
information architecture (`AC-COMP-SECTION-*`).

---

## ADR-0013 — The remote browser is an executor, not a VNC stream

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-017`, `ENV-REMOTE-*`

**Context.** Whole-screen pixel streaming is bandwidth-heavy, input-latent and creates a
second UI stack.

**Decision.** A browser session is another executor of the same commits. It receives
structured stills/deltas over the protocol. Heavy media may stream as a declared exception.
Reconnection reconciles unknown actions instead of replaying them blindly.

**Alternatives.** (a) VNC/RDP only. (b) Browser-native WASM mode only. (c) A separate web
app.

**Consequences.** Two supported modes: browser-native and structured presentation. Both use
the same semantics.

**Evidence.** A network interruption recovers without corrupting state
(`AC-ENV-REMOTE-*`).

---

## ADR-0014 — GPU and CPU are paths of one model

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `REND-*`, `LAW-002`, `LAW-016`

**Context.** A GPU-only stack excludes devices; a CPU-only stack wastes the hardware. A
separate pipeline per path doubles the bugs.

**Decision.** Direct scanout, hardware planes, GPU blit and CPU fallback are paths of the
same composition model, selected per case. Zero-copy is used when format, domain,
coherence and security allow; otherwise a declared copy. Every path has the same damage,
fence and still semantics.

**Alternatives.** (a) GPU only. (b) CPU only. (c) Separate stacks.

**Consequences.** Format negotiation and fences are first-class. The degradation ladder is
explicit. Benchmarks cover every path.

**Evidence.** The same scene renders correctly on all four paths within budget
(`AC-REND-PATH-*`).

---

## ADR-0015 — Design gates precede implementation

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-012`, `PROC-*`

**Context.** Rushed specs cut layers because code is already being written.

**Decision.** No slice is implemented until its design gate passes: purpose, model,
behaviour, flows, states, a11y, performance, acceptance. Spikes are disposable.

**Alternatives.** (a) Code-first. (b) Parallel design and code. (c) Docs after code.

**Consequences.** Slower start, fewer rewrites. The gate is auditable.

**Evidence.** Every implemented slice links to a passed gate (`AC-PROC-GATE-*`).

---

## ADR-0016 — Spacious is a density mode, not a theme

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `FW-ADAPT-*`, `LAW-013`

**Context.** "Spacious" is often treated as a skin. It changes spacing, not hierarchy, and
breaks on small screens.

**Decision.** Spacious is a declared density mode with its own spacing scale, action
visibility and type rhythm. It is orthogonal to light/dark and to envelope. It degrades to
compact by rule, not by hiding content.

**Alternatives.** (a) A theme. (b) Per-app spacing. (c) No density control.

**Consequences.** Density tokens. Tests at each density on each envelope. No content loss.

**Evidence.** The same flow completes at every density without hidden actions
(`AC-FW-DENSITY-*`).

---

## ADR-0017 — Safety envelopes use bounded motion

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `ENV-EV-*`, `ENV-SPACESHIP-*`, `LAW-008`

**Context.** Overshooting springs can momentarily obscure a warning or move a critical
readout.

**Decision.** Safety-critical envelopes use bounded, non-overshooting motion with a short
settle and no decorative parallax. Critical indicators never animate through an occluding
path.

**Alternatives.** (a) Same motion everywhere. (b) No motion in safety envelopes.

**Consequences.** A safety motion profile. Motion is still used to explain change, but
constrained. Reduced motion is always available.

**Evidence.** No warning is obscured at any frame (`AC-ENV-SAFETY-*`).

---

## ADR-0018 — The palette is a foundation

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `FW-PALETTE-*`, `LAW-010`

**Context.** Menus and toolbars are permanent chrome that scales badly across devices.
Naming what you want works on every input.

**Decision.** Every app exposes its actions, navigation and search to a universal palette.
The palette is the primary accelerator and the remote/watch fallback. It is not the only
path; every action has a visible affordance somewhere.

**Alternatives.** (a) Menu bar only. (b) Toolbar only. (c) Voice only.

**Consequences.** A command registry, stable command IDs, ranking, recents, context
scoping. Accessibility uses the same registry.

**Evidence.** Every app action is reachable from the palette and has a non-palette path
(`AC-FW-PALETTE-*`).

---

## ADR-0019 — Local first; remote is a peer

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `LAW-017`, `ARCH-*`

**Context.** Treating the network as a dependency makes the device useless offline and
makes remote output a second product.

**Decision.** The local device is always fully usable. Remote output and services are peers
with the same contract. Reconnection reconciles.

**Alternatives.** (a) Cloud-first. (b) Remote-only thin client. (c) Local-only.

**Consequences.** Offline is a normal state, not an error. Sync is explicit and
reconcilable.

**Evidence.** Airplane-mode core flows pass; reconnection passes (`AC-ARCH-OFFLINE-*`).

---

## ADR-0020 — Spaceship and spatial envelopes are first-class

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `ENV-SPACESHIP-*`, `ENV-SPATIAL-*`

**Context.** A timeless OS must survive beyond the rectangle. Safety-critical and spatial
displays expose assumptions that phones hide.

**Decision.** Spaceship and spatial (AR/VR/neural) are declared envelopes with their own
constraints, input, performance, failure and acceptance. They are not "desktop with a
different skin".

**Alternatives.** (a) Treat them as desktop. (b) Defer indefinitely.

**Consequences.** The model is tested against deterministic timing, redundancy, glare,
motion sickness and non-rectangular layouts. The result strengthens the rectangle case.

**Evidence.** A core flow passes on the spaceship and spatial envelope specs
(`AC-ENV-SPACE-*`, `AC-ENV-SPATIAL-*`).

---

## ADR-0021 — Shortcuts are accelerators, never the only path

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `SHELL-SHORTCUT-*`, `LAW-009`

**Context.** Keyboard-only shortcuts exclude touch, remote and accessibility users. Hidden
shortcuts are secrets.

**Decision.** Every command has a visible path. Shortcuts are accelerators bound to stable
command IDs, discoverable in the palette, remappable, and shown in context. Per-envelope
bindings are declared, not assumed.

**Alternatives.** (a) Shortcut-first. (b) No shortcuts. (c) Per-app bindings.

**Consequences.** A global shortcut registry. Conflict resolution. Accessibility
equivalents.

**Evidence.** Every shortcut has a discoverable command and a non-shortcut path
(`AC-SHELL-SHORTCUT-*`).

---

## ADR-0022 — Real UX research is normative for principles

**Status:** accepted · **Date:** 2026-10-22 · **Affects:** `RESEARCH-UX-*`, `LAW-*`

**Context.** Invented heuristics produce confident, unusable interfaces. Real research —
perception, cognition, motor control, human factors, accessibility — is the evidence base.

**Decision.** UX principles in this corpus MUST cite a research tradition or a measured
result. Where evidence is thin, the document says so and the decision is marked
provisional. We adapt principles; we do not copy a vendor's guideline list.

**Alternatives.** (a) Vendor heuristics only. (b) Pure intuition. (c) A/B tests only.

**Consequences.** A research subtree with sources. Principles are traceable. Contradictions
are resolved by evidence and recorded.

**Evidence.** Every principle file has sources and an implication table
(`AC-RESEARCH-UX-*`).
