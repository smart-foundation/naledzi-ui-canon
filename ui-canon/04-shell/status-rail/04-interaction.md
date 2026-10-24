---
id: SHELL-STATUS-INTERACTION
title: Status Rail — Interaction
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-MODEL, SHELL-STATUS-INDICATORS, APP-INPUT]
acceptance: [AC-SHELL-STATUS-040]
---

# Status Rail — Interaction

> The rail is not just a display. Each indicator is a tap target that opens the relevant
> control surface. The rail is the entry point to quick settings, not a menu.

---

## 1. Bindings

| Action | Pointer | Touch | Keyboard | Remote | Voice |
|---|---|---|---|---|---|
| Open control centre / quick settings | click rail | tap rail | Super+Shift+S / F9 | Menu on rail | "quick settings" |
| Open indicator detail | click indicator | tap indicator | focus + Enter | OK | "open …" |
| Dismiss open surface | click outside / Esc | swipe down | Escape | Back | "close" |
| Toggle a quick toggle | click toggle | tap toggle | Space | OK | "turn … on/off" |

## 2. Rules

- **SHELL-STATUS-041.** Every indicator MUST be a labelled tap target with a visible
  focus ring. No indicator is display-only.
- **SHELL-STATUS-042.** Tapping the rail opens the control centre (quick settings) for
  that envelope; tapping a single indicator opens its detail (e.g. battery opens power
  settings, privacy opens the active capability list).
- **SHELL-STATUS-043.** The control centre is a transient overlay at `overlay` elevation;
  it traps focus while open and restores focus on dismiss.
- **SHELL-STATUS-044.** On TV and remote-only envelopes, the rail is navigable with the
  d-pad; focus is always visible.
- **SHELL-STATUS-045.** On EV, the rail is glanceable; interaction while driving is
  limited to voice and wheel controls; touch targets are disabled when the vehicle is in
  motion (`ENV-EV`).
- **SHELL-STATUS-046.** The rail MUST NOT become a second settings app. It opens the
  relevant pane; it does not duplicate controls.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-040` | Every indicator opens a relevant control surface on every supported input. |
| `AC-SHELL-STATUS-041` | Rail never duplicates a settings control. |
| `AC-SHELL-STATUS-042` | Focus is restored after dismissing the control centre. |