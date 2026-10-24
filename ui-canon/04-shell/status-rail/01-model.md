---
id: SHELL-STATUS-MODEL
title: Status Rail — Model
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-INDEX, SHELL-MODEL-INDEX, ARCH-PRESENT-INDEX, CANON-LAWS, CANON-DECISIONS]
acceptance: [AC-SHELL-STATUS-010]
---

# Status Rail — Model

> The status rail is not a bar. It is a **derived, priority-ordered set of indicators**
> that the OS commits at `system` elevation. The OS owns the facts; the envelope's policy
> owns the presentation decision. This file defines the boundary.

---

## 1. What the rail is

- A **commit** at `system` elevation, numbered by the presentation authority
  (`ARCH-PRESENT-AUTHORITY`).
- A **derived view** of OS facts: time, power, connectivity, privacy, notification state,
  safety state. It is never a second owner of any fact (`LAW-001`).
- **Adaptive**: which indicators appear, in what order, and whether the rail is visible at
  all, is decided by the envelope's policy from a priority table.
- **UX-owned**: the rail's content and collapse rules are a design decision, not a
  platform default (`ADR-0007`).

## 2. What the rail is not

- Not a fixed bar inherited from desktop or terminal conventions (`ADR-0007`).
- Not app-drawn. No app may draw at `system` elevation or paint its own status bar
  (`APP-STANDARD` §3.2).
- Not a notification centre. Notifications are delivered through the notification system
  (`notifications/`); the rail only shows their *state* (count, do-not-disturb, safety).
- Not a place for app titles, window names or navigation. Those live in the app frame or
  the strip.
- Not permanent without a job. On desktop the rail is hidden by default and summoned on
  demand; on IoT it may be a single LED or absent (`LAW-010`).

## 3. Facts vs presentation

| Fact | Owner | Rail's use |
|---|---|---|
| Time | system clock service | displayed indicator |
| Power / battery | power service | icon + percentage on small envelopes |
| Connectivity | network service | signal icon; offline state |
| Privacy state | capability/privacy service | indicator when an observation capability is active |
| Notification state | notification system | count / do-not-disturb / safety override |
| Safety state | safety envelope (EV/spaceship) | protected indicators, never collapsed |
| Activity | motion/sensor service | watch activity ring |

The rail reads these facts through the contract. It never polls; it commits on change
(`LAW-004`). If a fact is `NOT REPORTED`, the rail shows the indicator as unknown with
that label — never a fabricated value (`LAW-011`).

## 4. Visibility states

| State | Meaning |
|---|---|
| `visible` | Rail is on screen with its current indicator set |
| `collapsed` | Low-priority indicators hidden; high-priority remain |
| `hidden` | Rail not on screen (desktop default, fullscreen immersive) |
| `safety` | Safety mode: only protected indicators; all others suppressed |
| `unknown` | A required fact is `NOT REPORTED`; indicator shows unknown |

Transitions between these states are motion-explained (`FOUND-MOTION`) and settle-and-stop.

## 5. Envelope-specific form

The rail's geometry (edge, height, anchoring) is owned by the envelope spec
(`06-envelopes/`). This shell spec owns *what* appears and *why*; the envelope owns
*where* and *how big*. Neither may contradict the other; conflicts are recorded as open
questions.

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-010` | Rail commits at `system` elevation and is numbered by the authority. |
| `AC-SHELL-STATUS-011` | No app draws a status bar; no fact is duplicated in the rail. |
| `AC-SHELL-STATUS-012` | A `NOT REPORTED` fact renders the indicator as unknown, never a default. |
| `AC-SHELL-STATUS-013` | Hidden rail costs zero over one hour. |