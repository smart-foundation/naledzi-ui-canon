---
id: SHELL-MODEL-SPACES
title: Spaces — Workspaces, Named Contexts, Transitions and Persistence
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, SHELL-MODEL-FOCUS, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-050, AC-SHELL-MODEL-051]
---

# Spaces (Model)

> A space is a named context: a set of surfaces, a focus, a layout, and a name. It is not a
> virtual desktop that swaps a list of windows. It is a context a person returns to, with
> its state intact.

This file defines spaces at model level. The deep specification (creation, naming,
transitions, persistence, cross-device, safety, failure) lives in `spaces/`.

---

## 1. What a space is

A space contains:

- a **name** (user-chosen or system-suggested; unique within the user's spaces),
- a **set of surfaces** with their placement (layout),
- a **focus** (saved per space),
- a **space type** (general, protected, single-app, kiosk),
- optional **rules** (which apps may open here, which surfaces are pinned),
- a **space ID** stable for the space's lifetime.

A space does not contain app domain state; apps own that. A space contains the *arrangement*
of surfaces and the focus.

---

## 2. Space types

| Type | Meaning | Envelopes |
|---|---|---|
| `general` | Normal workspace | all |
| `protected` | Safety envelope; constrained layout, bounded motion | EV, spaceship |
| `single-app` | One app fullscreen, no switching | kiosk, TV app mode |
| `presentation` | Fullscreen presentation mode with declared system UI | all |
| `safe-mode` | Recovery space with minimal surfaces | all (recovery) |

---

## 3. Space transitions

Switching spaces is a motion that explains the change (`LAW-008`):

- The outgoing space's surfaces are retained (not destroyed) unless memory pressure forces
  eviction (declared).
- The incoming space's surfaces are restored from their saved layout.
- Focus moves to the incoming space's saved focus (or default).
- The transition uses a named spring with velocity preservation and settle-and-stop.
- Reduced motion removes travel while preserving the state change.
- In safety envelopes, transitions are bounded and non-overshooting (`ADR-0017`).

A transition that disorients (jump, teleport, loss of identity) is a defect.

---

## 4. Persistence

Spaces persist across:

- session end and restart (restored on login),
- crash (restored from the last committed still),
- device handoff (transferred as session state, adapted to the receiving device),
- update (preserved across update and rollback).

Persistence is a property of the space store, owned by the shell, not of app memory.

---

## 5. Cross-device spaces

A space may be continued on another device. The receiving device:

- restores the surfaces that can run there,
- declares (not hides) surfaces that cannot run there,
- adapts layout to the receiving envelope,
- preserves the space name and focus intent.

See `spaces/05-cross-device.md`.

---

## 6. Safety spaces

On EV and spaceship, certain spaces are **protected**: they cannot be closed, cannot be
occluded by a non-safety surface, and cannot be transitioned away from during a critical
event. See `spaces/06-safety.md`.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-050` | A space saves and restores its surfaces, layout and focus across restart. |
| `AC-SHELL-MODEL-051` | Space transition uses a named spring, settles, and has a reduced-motion alternative. |
| `AC-SHELL-MODEL-052` | A protected space cannot be occluded or closed by a non-safety surface. |
| `AC-SHELL-MODEL-053` | Cross-device space continuation adapts layout and declares unsupported surfaces. |