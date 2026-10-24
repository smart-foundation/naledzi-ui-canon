---
id: SHELL-SHORTCUT-ENVELOPES
title: Shortcuts — Per Envelope
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-DEFAULTS, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-060]
---

# Shortcuts — Per Envelope

---

## 1. Envelope table

| Envelope | Input | Bindings |
|---|---|---|
| Watch | Crown + voice | Crown actions + voice commands; no keyboard defaults |
| Phone | Touch + optional keyboard | Touch verbs + keyboard where a keyboard is present |
| Tablet | Keyboard + touch + pointer | Full keyboard defaults |
| Desktop | Full keyboard | Full keyboard defaults |
| TV | Remote | Remote buttons map to verbs; no keyboard |
| EV | Wheel + voice | Voice + wheel controls; no keyboard while driving |
| Spaceship | Procedure keys + voice | Declared procedure keys |
| IoT | n/a | No shortcuts |
| Spatial | Gesture + voice | Gesture/voice commands |
| Remote browser | Browser shortcuts + app shortcuts | Browser-mediated |

## 2. Rules

- **SHELL-SHORTCUT-061.** Bindings MUST be declared per envelope; an envelope without a
  binding table is a defect.
- **SHELL-SHORTCUT-062.** On envelopes without a keyboard, every action remains
  reachable via touch/remote/voice/palette.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-060` | Every envelope's binding table declared. |