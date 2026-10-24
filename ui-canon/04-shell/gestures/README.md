---
id: SHELL-GESTURES-INDEX
title: Gestures
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-GESTURES-000]
children:
  - 01-grammar.md
  - 02-system-gestures.md
  - 03-conflict-and-arbitration.md
  - 04-capture-leases.md
  - 05-discoverability.md
  - 06-per-envelope.md
  - 07-accessibility.md
  - 08-failure.md
  - 09-acceptance.md
---

# Gestures

> Gestures are **reserved OS-level inputs** plus a grammar apps may use inside their
> content. The policy arbitrates conflicts. A gesture is never the only path to a primary
> action (`APP-INPUT`).

**Scope:** grammar, system gestures, conflict and arbitration, capture leases,
discoverability, per-envelope, accessibility, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app-private gestures that duplicate system ones;
secret gestures.

---

## 1. The single question this branch answers

> Which movements of the person's body belong to the OS, which to the app, and how are
> conflicts resolved?

---

## 2. The model in one page

```text
    SYSTEM-RESERVED GESTURES  (edges, home, strip, palette, back)
        │  cannot be overridden
        ▼
    APP CONTENT GESTURES      (swipe, pinch, long-press inside content)
        │  may be used; must have visible alternative
        ▼
    POLICY ARBITRATION        (edge wins; content gets the rest; capture leases scoped)
```

---

## 3. Directory map

| File | Question |
|---|---|
| [01-grammar.md](01-grammar.md) | The gesture vocabulary and rules |
| [02-system-gestures.md](02-system-gestures.md) | Reserved system gestures and their meaning |
| [03-conflict-and-arbitration.md](03-conflict-and-arbitration.md) | Who wins when gestures collide |
| [04-capture-leases.md](04-capture-leases.md) | Scoped, revocable input capture |
| [05-discoverability.md](05-discoverability.md) | How a person learns a gesture |
| [06-per-envelope.md](06-per-envelope.md) | Gestures per envelope |
| [07-accessibility.md](07-accessibility.md) | Non-gesture paths, switch, voice |
| [08-failure.md](08-failure.md) | Stuck capture, misrecognition, ambiguity |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-GESTURES-001` | Every reserved gesture has a visible, non-gesture path. |
| `AC-SHELL-GESTURES-002` | Capture leases expire on release, cancel, timeout, crash. |