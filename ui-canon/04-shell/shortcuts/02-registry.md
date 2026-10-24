---
id: SHELL-SHORTCUT-REGISTRY
title: Shortcuts — Registry
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-020]
---

# Shortcuts — Registry

---

## 1. Global registry

- Commands register at app/service start with: ID, title, description, scope, default
  binding, icon, keywords.
- The registry is queryable by the palette, Settings and help.
- Registration is idempotent; duplicate IDs are rejected.

## 2. Conflict resolution

| Situation | Resolution |
|---|---|
| Two commands claim the same binding in the same scope | First registered wins; the other is unbound and flagged in Settings |
| System binding vs app binding | System wins in `global` scope; app may bind in `app` scope |
| User remap creates a conflict | The conflicting binding is cleared; user is told |
| Safety shortcut vs any | Safety always wins |

## 3. Rules

- **SHELL-SHORTCUT-021.** Conflict resolution MUST be deterministic and reported, not
  silent.
- **SHELL-SHORTCUT-022.** A command that fails to bind is still reachable via the
  palette.
- **SHELL-SHORTCUT-023.** The registry MUST be available offline.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-020` | Conflicts resolve and are reported. |
| `AC-SHELL-SHORTCUT-021` | Unbound command still reachable via palette. |