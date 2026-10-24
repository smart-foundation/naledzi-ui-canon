---
id: FW-RUNTIME-INDEX
title: Runtime — MirUI as the app-side runtime
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-README, CANON-LAWS, APP-STANDARD]
supersedes: []
superseded_by: []
acceptance: [AC-FW-RUNTIME-000]
children:
  - 01-mirui.md
  - 02-ecs.md
  - 03-layout.md
  - 04-text.md
  - 05-damage.md
  - 06-input.md
  - 07-animation.md
  - 08-state.md
  - 09-scheduler.md
  - 10-testing.md
  - 11-failure.md
  - 12-acceptance.md
---

# Runtime — MirUI as the app-side runtime

> MirUI is the app-side runtime: ECS, layout, raster, text, damage, animation, input and
> scheduling inside one app process. It is not the compositor, not the authority, and not the
> policy (ADR-0003 / Lock 1 of `ui-layer-mirui.md`). The authority owns the still; MirUI owns
> the pixels it declares.

**Scope.** Everything that happens between an app's intent and the declared damage rect it
commits: entity storage, component data, systems, layout, text shaping, raster, damage
tracking, input delivery, animation integration, app state, frame scheduling, testing and
failure.

**Non-goals.** Window management, output ownership, global focus arbitration, theme authority,
network, persistence authority. Those belong to the OS contracts (`surface.capnp`,
`theme.capnp`, `input.capnp`, `app.capnp`) and to the authority/policy/executor.

---

## 1. The adapter boundary

MirUI never talks to the OS directly. It talks through `naledzi-ui`, the adapter crate,
which implements `mirui::surface::Surface` over the Naledzi contracts:

| MirUI trait method | Naledzi contract | Evidence |
|---|---|---|
| `display_info()` | `display.capnp` monitor info | `ui-layer-mirui.md` §1 Lock 2 |
| `flush(area)` | `surface.capnp` `commit(FrameSubmission{surfaceId, bufferId, damage, present})` | `ui-layer-mirui.md` §1 Lock 2 |
| `poll_event()` | `input.capnp` `pullInputEvents` | `ui-layer-mirui.md` §1 Lock 2 |

The adapter is the only place mirui appears. Apps depend on `naledzi-ui`, never on mirui
directly (`ui-layer-mirui.md` §4). This is what makes an app portable to another
smart-protocol host.

## 2. Verified substrate limits (MirUI 0.51.0)

Cited from the vendored crate at
`~/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/mirui-0.51.0`.

| Limit | Evidence | Consequence |
|---|---|---|
| Flex layout only; no grid primitive | `src/ui/layout/node.rs:1`–`46` enumerates `FlexDirection`, `FlexWrap`, `JustifyContent`, `AlignItems`, `Position`; `src/ui/layout/flex.rs` is the sole algorithm | Grid-like layouts compose nested flex rows with declared tracks, or an app-owned pass. No third engine. |
| No layout-level RTL mirroring | `src/ui/layout/node.rs:48`–`67` has `left` and `top` only; no `right`/`bottom`/`start`/`end`; no direction on `LayoutStyle` | RTL is a framework adaptation pass plus text-level bidi (`src/ui/widgets/text.rs:51` `TextDirection`). |
| No accessibility semantics in substrate | Search of `src/` for roles/ARIA/semantic trees returns no API | Framework owns the semantic tree and host adapter (`runtime/06-input.md` §accessibility). |
| Five widget states only | `src/ui/theme.rs:33` `WidgetState` = `Enabled, Disabled, Hovered, Pressed, Error` | Selected, focused, expanded, busy, read-only are framework states composed on top. |
| Damage is per-entity, not inherited | `src/ui/dirty.rs:1`–`8`; `mark_subtree_dirty` for global changes | Every component declares its own damage; parent style change must explicitly mark subtree. |
| Full-frame diff is diagnostic only | `src/render/partial.rs:5` `dirty_rect` compares two framebuffers | Used for verification/fallback only. Production damage is declared (LAW-003). |
| Scroll motion exists; no central spring engine | `src/input/event/scroll/motion.rs` | Spring integration for general animation is framework-owned (runtime/07). |
| Text direction/bidi supported | `src/ui/widgets/text.rs:51` `TextDirection::{Auto, LeftToRight, RightToLeft}` | Text-level RTL; layout mirroring is framework pass. |

## 3. Directory map

| File | Question |
|---|---|
| [01-mirui.md](01-mirui.md) | What is MirUI and what is it not; ECS, layout, raster, text, damage, animation; adapter boundary. |
| [02-ecs.md](02-ecs.md) | Entities, components, systems, scheduling, determinism, no second ECS. |
| [03-layout.md](03-layout.md) | Constraints, flex, intrinsic sizing, overflow, density, 200% text, RTL, non-rectangular safe areas. |
| [04-text.md](04-text.md) | Shaping, bidi, fallback, IME, selection, accessibility, variable fonts. |
| [05-damage.md](05-damage.md) | Declared damage, invalidation, merging, full-surface fallback, zero readback. |
| [06-input.md](06-input.md) | Event model, focus, capture leases, gestures, remote, voice, IME. |
| [07-animation.md](07-animation.md) | Spring engine, retarget, frame scheduling, reduced motion, determinism. |
| [08-state.md](08-state.md) | App state, restore, persistence, crash recovery. |
| [09-scheduler.md](09-scheduler.md) | Frame budget, priority, idle, background work, safety timing. |
| [10-testing.md](10-testing.md) | Headless stills, golden flows, semantic audit, performance harness. |
| [11-failure.md](11-failure.md) | Failure modes and recovery. |
| [12-acceptance.md](12-acceptance.md) | Acceptance criteria. |

## 4. Laws applied

FW-LAW-001..008 (see `../README.md` §4). Plus: one ECS only (LAW-001), declared damage
(LAW-003), idle silence (LAW-004), numbered stills (LAW-005), authority mandatory (LAW-006).

## 5. Open questions

| ID | Question | Owner | Needed by |
|---|---|---|---|
| FW-RUNTIME-Q-001 | `critical-section` impl in a preemptive scheduler: must actually defer preemption, not pretend. | Framework Guild + Kernel Guild | Phase 0a |
| FW-RUNTIME-Q-002 | Whether framework supplies a track-composition helper for grid-like layouts (MirUI has no grid). | Framework Guild | `data-grid` implementation |
| FW-RUNTIME-Q-003 | RTL layout pass performance cost unmeasured. | Framework Guild + i18n | RTL conformance |
| FW-RUNTIME-Q-004 | Spring engine location: framework-owned, not substrate; integration with MirUI render loop. | Foundations + Framework | Animation conformance |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-RUNTIME-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-FW-RUNTIME-001` | An app can be built, run headless, and commit a numbered still through the adapter without touching mirui directly. |
| `AC-FW-RUNTIME-002` | Declared damage rects are the only regions re-rendered; no frame-to-frame diff in production path. |
| `AC-FW-RUNTIME-003` | Idle app schedules zero frames. |