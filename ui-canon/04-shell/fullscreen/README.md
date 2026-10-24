---
id: SHELL-FULLSCREEN-INDEX
title: Fullscreen
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-000]
children:
  - 01-model.md
  - 02-system-ui.md
  - 03-entry-and-exit.md
  - 04-focus-and-input.md
  - 05-notifications.md
  - 06-multi-window.md
  - 07-per-envelope.md
  - 08-failure.md
  - 09-acceptance.md
---

# Fullscreen

> Fullscreen is a **declared behaviour**, not a hidden mode. It must specify what happens to
> the status rail, the strip, notifications, gestures, focus, multi-window and safety zones.
> An app cannot imply fullscreen by drawing over everything; it declares intent and the
> shell honours it per envelope.

**Scope:** the meaning of fullscreen, the system UI during fullscreen, entry and exit, focus
and input, notifications, multi-window consequences, per-envelope behaviour, and failure.

**Non-goals:** rendering, buffer lifetimes (`presentation/`, `rendering/`); app domain
logic (`05-apps/`).

---

## 1. The single question this branch answers

> When an app or the system goes fullscreen, what is on screen, what is hidden, and how does
> the person get back?

---

## 2. The four fullscreen kinds

| Kind | Meaning | System UI |
|---|---|---|
| `immersive` | App content fills the output; system UI is hidden until summoned | Status rail and strip hidden; edge reveals |
| `maximised` | App fills the work area; system UI adapts | Status rail may collapse; strip still summonable |
| `presentation` | A declared presentation mode (slides, video, game) with its own rules | Per declaration; safety zones remain |
| `safety-fullscreen` | Safety envelope takes the whole output; nothing else may show | Only safety indicators; no app |

A fullscreen request that does not name its kind is rejected (`LAW-011`).

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What fullscreen means; the four kinds |
| [02-system-ui.md](02-system-ui.md) | Status rail, strip, notifications, hot corners/edges, pointer, cursor, IME |
| [03-entry-and-exit.md](03-entry-and-exit.md) | Explicit control, Escape, F11, gesture, remote, voice, kiosk, safety |
| [04-focus-and-input.md](04-focus-and-input.md) | Capture leases, keyboard, remote, gamepad; no focus trap for non-modal |
| [05-notifications.md](05-notifications.md) | What appears, priority, safety override, do-not-disturb |
| [06-multi-window.md](06-multi-window.md) | Other windows/spaces; PiP; split |
| [07-per-envelope.md](07-per-envelope.md) | Watch, phone, tablet, desktop, TV, EV, spaceship, IoT, spatial, remote |
| [08-failure.md](08-failure.md) | Lost exit, stuck pointer, crashed app, display disconnected |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-FULLSCREEN-001` | Every fullscreen kind has a declared system-UI behaviour. |
| `AC-SHELL-FULLSCREEN-002` | Every fullscreen kind has at least one exit path on every envelope. |