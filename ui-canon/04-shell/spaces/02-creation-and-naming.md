---
id: SHELL-SPACES-CREATE
title: Spaces — Creation and Naming
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SPACES-020]
---

# Spaces — Creation and Naming

---

## 1. Creation

- Create: from the strip fan-out ("New space"), from the palette ("new space"), or
  automatically when a full-screen app requests a dedicated space.
- A new space starts empty with a default name ("Space N") and the user is prompted to
  name it; naming is skippable but the default is editable later.
- Templates: "Empty", "Work" (mail + calendar + notes), "Media" (music + photos). Templates
  are starting points, not fixed layouts; the user owns the result.

## 2. Naming

- Names are short (≤ 24 chars), user-editable, unique within the space set (suffix on
  collision).
- Names support any script; stored as text; displayed with the user's locale.
- An unnamed space displays its default name; renaming is always available from the
  switcher context menu and the palette.

## 3. Deletion

- Delete requires confirmation if the space contains unsaved work; otherwise instant with
  undo (5 s).
- Deleting the active space moves focus to the previous space; if none, the next.
- The last space cannot be deleted; the action is disabled with an explanation.

## 4. Reordering and grouping

- Drag to reorder in the switcher.
- Spaces may be pinned (stay at the front) and colour-coded (a user-chosen accent, not a
  theme).
- Search the space set by name from the switcher and the palette.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-020` | Create, name, rename, delete, undo all work and are announced. |
| `AC-SHELL-SPACES-021` | Last space cannot be deleted; action explained. |
| `AC-SHELL-SPACES-022` | Templates produce editable starting layouts. |