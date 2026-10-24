---
id: SHELL-GESTURES-ENVELOPES
title: Gestures — Per Envelope
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-GESTURES-060]
---

# Gestures — Per Envelope

---

## 1. Envelope table

| Envelope | Primary gesture input | Notes |
|---|---|---|
| Watch | Crown + edge | Crown scrolls; edge swipes for back/home |
| Phone | Touch edges | Full touch grammar |
| Tablet | Touch + pointer | Pointer may use edges; touch reserved |
| Desktop | Pointer edges + keyboard | Gestures are accelerators, not required |
| TV | Remote (no gestures) | d-pad replaces gestures |
| EV | Driver-safe (voice/wheel) | Touch gestures disabled while driving |
| Spaceship | Gloves + voice | Touch may be unavailable; voice primary |
| IoT | n/a | No gesture input |
| Spatial | 6-DOF | Hand tracking; fallback to controller |
| Remote browser | Pointer/keyboard | Browser-mediated |

## 2. Rules

- **SHELL-GESTURES-061.** A gesture set MUST be declared per envelope; an envelope
  without a gesture set is a defect, not an omission.
- **SHELL-GESTURES-062.** On envelopes without gesture input (TV, IoT), every action has
  a non-gesture path.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-060` | Every envelope's gesture set is declared and tested. |