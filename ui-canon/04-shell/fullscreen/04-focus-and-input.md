---
id: SHELL-FULLSCREEN-FOCUS
title: Fullscreen Focus and Input
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-MODEL-FOCUS, APP-INPUT, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-040, AC-SHELL-FULLSCREEN-041]
---

# Fullscreen Focus and Input

> Fullscreen changes input ownership but does not trap focus for non-modal apps. Capture
> leases, keyboard, remote and gamepad keep working; the reserved gestures survive.

---

## 1. Focus

- On entering fullscreen, focus moves into the fullscreen surface (if it accepts input) or
  stays where it was if the surface does not accept input.
- Focus is **not trapped** for non-modal fullscreen. The user can move focus out via the
  strip, palette or reserved gestures; the fullscreen remains.
- Modal fullscreen (a declared presentation that owns the session, e.g., a kiosk) traps
  focus and declares the trap.
- On exit, focus returns to the surface that invoked fullscreen, or to a declared default.

---

## 2. Capture leases

- A fullscreen app may hold a capture lease (drag, game input) for the duration of the
  interaction.
- The lease ends on release, cancel, timeout, or policy revocation.
- A crashed fullscreen app's lease expires; the pointer is not stuck.
- The strip and palette, when summoned during a lease, do not steal the lease; they overlay
  it.

---

## 3. Keyboard

- All keyboard input goes to the focused element in the fullscreen surface.
- Reserved shortcuts (Escape, F11, Home, palette) are intercepted by the shell first.
- IME composition works as normal.
- Sticky keys, switch access and screen reader remain functional.

---

## 4. Remote and gamepad

- Remote/TV: directional pad navigates within the fullscreen surface; Back exits.
- Gamepad: app binds buttons inside content; reserved buttons (Back, Home, Menu) are
  shell-owned.
- Voice: maps to the same command IDs.

---

## 5. No focus trap for non-modal

A non-modal fullscreen app MUST NOT trap focus. If it does, the shell overrides and
records a defect. Trapping is reserved for modal layers (dialogs, permission prompts,
lock) and declared kiosk mode.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-040` | Non-modal fullscreen does not trap focus; focus can leave via strip/palette. |
| `AC-SHELL-FULLSCREEN-041` | Capture lease expires on release, cancel, timeout, crash. |
| `AC-SHELL-FULLSCREEN-042` | Reserved shortcuts work inside fullscreen. |
| `AC-SHELL-FULLSCREEN-043` | Focus returns to the invoker on exit. |