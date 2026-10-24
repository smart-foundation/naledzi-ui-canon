---
id: SHELL-SPACES-INDEX
title: Spaces
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-SPACES-000]
children:
  - 01-model.md
  - 02-creation-and-naming.md
  - 03-transitions.md
  - 04-persistence-and-restore.md
  - 05-cross-device.md
  - 06-safety-and-protected.md
  - 07-accessibility.md
  - 08-failure.md
  - 09-acceptance.md
---

# Spaces

> Spaces are **named contexts of work**. They replace the legacy "multiple desktops" idea
> with a first-class, named, persistent, reachable state. A space is a set of surfaces and
> their arrangement, not a screenshot.

**Scope:** model, creation and naming, transitions, persistence and restore,
cross-device, safety and protected spaces, accessibility, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app internals (`05-apps/`); a fixed number of
spaces; hidden spaces.

---

## 1. The single question this branch answers

> How does a person keep separate trains of thought separate, move between them, and get
> them back after a restart?

---

## 2. The model in one page

```text
    SPACE = named context: surfaces + arrangement + focus + scroll positions
        │
        ▼
    SPACE SET (ordered, user-arranged, searchable)
        │
        ▼
    TRANSITION (spring, velocity-preserving; content swaps; focus follows)
        │
        ▼
    PERSISTENCE (local; sync optional; restore on restart)
```

- A space is addressable (`LAW-018`): deep-linkable, restorable, testable.
- There is no "default" space that cannot be named or removed.
- Spaces are not virtual desktops in the legacy sense: they carry focus and scroll
  state, not just window positions.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What a space is; what it carries; what it is not |
| [02-creation-and-naming.md](02-creation-and-naming.md) | Create, name, rename, delete, templates |
| [03-transitions.md](03-transitions.md) | Switching, animation, focus, velocity |
| [04-persistence-and-restore.md](04-persistence-and-restore.md) | Save, restore, crash recovery |
| [05-cross-device.md](05-cross-device.md) | Sync, continue on another device |
| [06-safety-and-protected.md](06-safety-and-protected.md) | Safety envelopes; protected spaces |
| [07-accessibility.md](07-accessibility.md) | Screen reader, keyboard, switch |
| [08-failure.md](08-failure.md) | Lost space, corrupt state, too many |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Envelope coverage

| Envelope | Spaces |
|---|---|
| Watch | single space (no switcher) |
| Phone | named spaces, gesture switch |
| Tablet | named spaces |
| Desktop | named spaces, full switcher |
| TV | single or pinned spaces |
| EV | protected spaces (driver/passenger) |
| Spaceship | protected, redundant spaces |
| IoT | n/a |
| Spatial | spatial spaces |
| Remote browser | browser-mediated |

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-SPACES-001` | A space is addressable and restorable. |
| `AC-SHELL-SPACES-002` | Transition preserves velocity and focus. |
| `AC-SHELL-SPACES-003` | Crash recovery restores spaces. |