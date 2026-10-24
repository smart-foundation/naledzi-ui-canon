---
id: SHELL-SPACES-MODEL
title: Spaces — Model
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-INDEX, SHELL-MODEL-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-SPACES-010]
---

# Spaces — Model

---

## 1. What a space is

A space is a **named context** carrying:

- the set of surfaces (apps/windows) it contains,
- their arrangement (position, size, z-order),
- the focus owner,
- scroll positions and selection state per surface,
- the density mode if overridden,
- a stable ID and a user-given name.

It is not a screenshot, not a virtual desktop in the legacy sense, and not a saved
session file the user must manage.

## 2. What a space is not

- Not a process group or a container. Apps run independently of spaces; a space
  references surfaces.
- Not a security boundary. Capability scoping is per app, not per space.
- Not required. A device with one space behaves as if spaces do not exist (watch, IoT).

## 3. Invariants

- **SHELL-SPACES-011.** Every space has a stable ID and a name. An unnamed space is a
  defect.
- **SHELL-SPACES-012.** A space is addressable: it can be linked to, restored and
  tested directly (`LAW-018`).
- **SHELL-SPACES-013.** There is always at least one space. Deleting the last space
  recreates a fresh one named "Space".
- **SHELL-SPACES-014.** Focus and scroll state travel with the space, not the device.
- **SHELL-SPACES-015.** A surface may belong to more than one space (referenced, not
  copied). Moving a surface between spaces changes references, not the surface.

## 4. Space set ordering

- Spaces are ordered by the user (drag in the switcher) with a sensible default
  (most-recently-used).
- The active space is marked; the switcher shows previews derived from numbered stills
  (`LAW-001`), never a second copy.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-010` | A space round-trips (create → switch → restart → restore) with focus and scroll intact. |
| `AC-SHELL-SPACES-011` | Deleting the last space recreates a fresh named space. |
| `AC-SHELL-SPACES-012` | A surface referenced by two spaces is one surface. |