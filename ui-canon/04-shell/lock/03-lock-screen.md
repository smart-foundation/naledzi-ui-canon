---
id: SHELL-LOCK-SCREEN
title: Lock — Lock Screen
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-MODEL, FOUND-DEPTH-INDEX]
acceptance: [AC-SHELL-LOCK-030]
---

# Lock — Lock Screen

---

## 1. What it shows

- Time and date (large, glanceable).
- Safety indicators (EV/spaceship) — always visible.
- Notification previews (user-controllable: full, count-only, none).
- Media controls for currently playing media (if allowed).
- The authentication affordance (PIN pad, biometric prompt, password field).
- A hint for the gesture/keyboard to unlock.

## 2. What it does not show

- No app content, no strip, no status rail beyond safety + time.
- No notification bodies if the user chose count-only or none.
- No personal data beyond what the user allows on the lock screen.

## 3. Rules

- **SHELL-LOCK-031.** The lock screen is a commit at `system` elevation; it does not
  leak app content through blur or translucency (`LAW-011`).
- **SHELL-LOCK-032.** Notification previews are user-controllable per channel.
- **SHELL-LOCK-033.** Media controls on the lock screen invoke the same command IDs as
  the media app.
- **SHELL-LOCK-034.** The lock screen respects reduced motion and high contrast.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-030` | Lock screen shows no app content. |
| `AC-SHELL-LOCK-031` | Notification preview level is user-controllable. |
| `AC-SHELL-LOCK-032` | Media controls work from lock screen. |