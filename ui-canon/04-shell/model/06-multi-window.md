---
id: SHELL-MODEL-MULTIWINDOW
title: Multi-Window — Split, Tiling, Floating, Fullscreen and PiP
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, SHELL-MODEL-SURFACES, SHELL-MODEL-POLICY, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-060, AC-SHELL-MODEL-061]
---

# Multi-Window

> Multi-window is a policy decision, not a primitive. The primitive is a surface with a
> placement hint. Split, tiling, floating, fullscreen and picture-in-picture are ways a
> policy places surfaces. None of them is a window in the legacy sense.

---

## 1. Placement modes

| Mode | Meaning | Earned by |
|---|---|---|
| Single | One surface fills the work area | watch, phone (default), TV |
| Split | Two or more surfaces share the work area by ratio | tablet, desktop, spatial |
| Tiling | Surfaces occupy a grid; policy manages the grid | desktop, spatial |
| Floating | Free-positioned surfaces, optionally snapped | desktop, spatial |
| Fullscreen | One surface fills the output (declared behaviour) | all (declared) |
| PiP | Small, always-on-top, non-safety surface | phone, tablet, desktop, TV |
| Spatial | Surfaces anchored in 3D space | spatial |

An envelope earns a mode by its input and display. A phone does not tile by default; a
desktop does. A mode not earned by an envelope is `n/a`, not "available but unused".

---

## 2. Split

- A split is a ratio between two or more surfaces (e.g., 1:1, 1:2, 2:1).
- The user can resize by dragging the divider; the divider is a focusable, keyboard-
  operable control.
- Minimum sizes are declared per surface; a surface below its minimum collapses to a
  thumbnail or moves to the strip.
- Split persists per space.
- On touch envelopes, split is invoked by a gesture or by the palette; there is no
  permanent divider chrome until a split exists.

---

## 3. Tiling

- Tiling is a grid managed by the policy. The user can move surfaces between cells.
- Tiling never hides a surface; overflowing surfaces go to the strip or another space.
- Tiling is optional: a desktop policy may be free-floating only.

---

## 4. Floating

- Floating surfaces have free position and z-order within the policy's plan.
- They may be snapped to edges or to other surfaces.
- They may be raised above or lowered below peers.
- Floating is a desktop/spatial concept; on touch envelopes, floating is limited to
  transient layers (popovers, sheets).

---

## 5. Fullscreen

Fullscreen is a **declared behaviour**, not a hidden mode. See `fullscreen/`. It specifies
what happens to the status rail, strip, notifications, gestures, focus, multi-window and
safety zones. An app declares fullscreen intent; the shell honours it per envelope.

---

## 6. Picture-in-picture

- PiP is a small, always-on-top, non-safety surface.
- It is user-dismissable and never occludes a safety indicator.
- It pauses or continues per app declaration and power state.
- On EV, PiP is passenger-only and is dismissed when the vehicle is in motion if it
  occludes a protected zone.

---

## 7. Multi-display

- A desktop or spatial session may span multiple outputs.
- The policy decides which surfaces go to which output.
- A surface may move between outputs by user action or by policy.
- The status rail and strip are per-output or shared per the envelope's declaration.
- Disconnecting an output triggers `fullscreen/08-failure.md` and `lifecycle/` recovery.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-060` | Split, tiling and floating produce a plan; killing the policy leaves stills intact. |
| `AC-SHELL-MODEL-061` | A surface below its minimum in a split collapses to the strip, not to zero size. |
| `AC-SHELL-MODEL-062` | PiP never occludes a safety indicator on any envelope. |
| `AC-SHELL-MODEL-063` | Multi-display disconnect restores surfaces to a remaining output or declares absence. |