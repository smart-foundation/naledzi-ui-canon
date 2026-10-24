---
id: SHELL-SPACES-PERSIST
title: Spaces — Persistence and Restore
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SPACES-040]
---

# Spaces — Persistence and Restore

---

## 1. Persistence

- Spaces are persisted locally per user, including arrangement, focus and scroll.
- Persistence is debounced (on idle) and flushed on close/crash (`LAW-015`).
- Sync across devices is optional and explicit (user opts in); conflicts are resolved
  by last-writer-wins with a visible merge note, never silently.

## 2. Restore

- On restart, the active space and its surfaces are restored to a complete state, not a
  loading shell (`APP-STANDARD` §3.4 rule 3.10).
- If a surface cannot be restored (app unavailable), the space shows an honest placeholder
  with a path to install/open.
- Restore is announced to assistive tech.

## 3. Crash recovery

- A crash mid-transition restores to the last committed space.
- Unsaved work in surfaces is protected by the app's own recovery draft.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-040` | Restart restores active space with focus and scroll. |
| `AC-SHELL-SPACES-041` | Crash mid-transition restores last committed space. |
| `AC-SHELL-SPACES-042` | Unavailable app shows honest placeholder. |