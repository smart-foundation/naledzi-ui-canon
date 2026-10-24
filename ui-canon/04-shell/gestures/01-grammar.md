---
id: SHELL-GESTURES-GRAMMAR
title: Gestures — Grammar
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-INDEX, APP-INPUT, CANON-LAWS]
acceptance: [AC-SHELL-GESTURES-010]
---

# Gestures — Grammar

---

## 1. The vocabulary

| Gesture | Meaning | Reserved? |
|---|---|---|
| Left edge swipe | Back | Yes (system) |
| Right edge swipe | Forward (where applicable) | Yes (system) |
| Bottom edge swipe (short) | Home | Yes (system) |
| Bottom edge swipe (hold/up) | Strip / switcher | Yes (system) |
| Top edge pull | Palette / notifications | Yes (system) |
| Horizontal swipe (content) | Scroll / history | No (app) |
| Pinch | Zoom | No (app) |
| Long-press | Context / select | Shared (system wins at edge) |
| Two-finger tap | Context | No (app) |
| Drag | Move item/value | No (app, with capture lease) |

## 2. Rules

- **SHELL-GESTURES-011.** A gesture MUST be cancellable at any point; cancellation
  returns to the prior state with no partial effect.
- **SHELL-GESTURES-012.** A gesture MUST have a visible affordance or be a
  system-reserved gesture with a standard meaning (`APP-INPUT` §5).
- **SHELL-GESTURES-013.** A gesture MUST NOT be the only path to a primary action.
- **SHELL-GESTURES-014.** Reduced motion changes the feedback of a gesture, never
  disables it.
- **SHELL-GESTURES-015.** Gesture recognition MUST be deterministic and must not depend
  on device orientation tricks or hidden thresholds.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-010` | Every gesture in the vocabulary is cancellable. |
| `AC-SHELL-GESTURES-011` | No primary action is gesture-only. |