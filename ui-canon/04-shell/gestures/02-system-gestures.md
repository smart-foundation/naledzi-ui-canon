---
id: SHELL-GESTURES-SYSTEM
title: Gestures — System Gestures
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-GRAMMAR, APP-INPUT]
acceptance: [AC-SHELL-GESTURES-020]
---

# Gestures — System Gestures

---

## 1. Reserved gestures

| Gesture | Action | Notes |
|---|---|---|
| Left edge swipe | Back | Always available; never trapped |
| Right edge swipe | Forward (browser/history) | Only where a forward stack exists |
| Bottom edge swipe (short) | Home | Returns to the app's/home surface |
| Bottom edge swipe (hold/up) | Strip / switcher | Opens the depth reel |
| Top edge pull (short) | Notifications | Opens notification history/banner area |
| Top edge pull (long) | Palette | Opens the universal command surface |
| Three/four-finger swipe (horizontal) | Switch space | Per envelope allow-list |
| Pinch on home | Show all spaces | Desktop/spatial only |

## 2. Rules

- **SHELL-GESTURES-021.** System gestures are reserved at the OS level. An app cannot
  override them at the edge, even if it requests the gesture inside its content.
- **SHELL-GESTURES-022.** A system gesture MUST have a visible, non-gesture path
  (button, keyboard, voice, remote).
- **SHELL-GESTURES-023.** System gestures MUST work in every app state, including
  fullscreen immersive (edge reveal).
- **SHELL-GESTURES-024.** On safety envelopes, gestures that could occlude a warning are
  disabled or redirected (`ADR-0017`).

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-020` | Every system gesture works in every app state. |
| `AC-SHELL-GESTURES-021` | No app overrides a system gesture at the edge. |