---
id: SHELL-SPACES-CROSSDEV
title: Spaces — Cross-Device
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, ARCH-ECOSYSTEM-INDEX]
acceptance: [AC-SHELL-SPACES-050]
---

# Spaces — Cross-Device

---

## 1. Principles

- Spaces are local by default; sync is opt-in (`LAW-017`).
- "Continue on another device" moves the *task*, not necessarily the whole space: the
  target device opens the relevant surface in its own space, with a link back.
- A space may be shared (read-only or collaborative) between devices/users with explicit
  grants.

## 2. Handoff

- Handoff is initiated from the strip or the palette ("continue on …").
- The target device receives the surface state (or a deep link) and opens it; the origin
  may close or keep it (user chooses).
- Handoff of a whole space is supported but rare; usually a single surface moves.

## 3. Conflict

- If both devices edit the same surface's state, the last writer wins with a visible
  merge note; the user can revert.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-050` | Continue-on-another-device opens the task on the target. |
| `AC-SHELL-SPACES-051` | Sync is opt-in and conflicts are visible. |