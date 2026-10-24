---
id: SHELL-SPACES-SAFETY
title: Spaces — Safety and Protected
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, ENV-EV-INDEX, ENV-SPACESHIP-INDEX]
acceptance: [AC-SHELL-SPACES-060]
---

# Spaces — Safety and Protected

---

## 1. Protected spaces

- Safety envelopes (EV, spaceship) define protected spaces that cannot be dismissed,
  covered or reorganised by an app.
- The driver space in an EV is fixed: status, navigation, media (passenger). The user
  may not remove the safety indicators.
- Spaceship spaces are procedure-bound: the active procedure determines the visible
  surfaces; switching is gated by procedure state.

## 2. Rules

- **SHELL-SPACES-061.** An app may not create, delete or reorder a protected space.
- **SHELL-SPACES-062.** A protected space's safety indicators occupy protected zones and
  are never occluded (`ADR-0017`).
- **SHELL-SPACES-063.** On EV, passenger spaces are separate from the driver space and
  may be dismissed without affecting the driver space.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-060` | Protected spaces cannot be removed by an app. |
| `AC-SHELL-SPACES-061` | Safety indicators never occluded in a protected space. |