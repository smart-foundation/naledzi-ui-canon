---
id: SHELL-SHORTCUT-FAILURE
title: Shortcuts — Failure
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-REGISTRY, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-080]
---

# Shortcuts — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Binding conflict | First registered wins; other unbound and flagged |
| Missing binding (user cleared) | Command reachable via palette |
| Invalid remap (reserved key) | Rejected with explanation |
| Registry unavailable | Cached bindings used; palette still lists commands |
| Command unregistered | Binding removed; palette no longer lists it |

## 2. Rules

- **SHELL-SHORTCUT-081.** A failed binding never crashes the shell.
- **SHELL-SHORTCUT-082.** Reserved keys cannot be bound by apps.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-080` | Every failure mode exercised. |