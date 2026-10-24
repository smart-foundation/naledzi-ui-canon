---
id: SHELL-SHORTCUT-MODEL
title: Shortcuts — Model
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUTS-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-010]
---

# Shortcuts — Model

---

## 1. What a shortcut is

A shortcut is a **binding from an input gesture to a command ID**. The command ID is the
truth (`APP-STANDARD`: commands exposed to the palette); the binding is a preference
that can change without changing the command.

## 2. Command IDs

- Stable, namespaced: `<origin>.<verb>` (e.g. `files.open`, `system.palette`).
- Owned by the origin (app or system service); never renamed without a deprecation.
- Registered in the global command registry.

## 3. Scope

| Scope | Meaning |
|---|---|
| `global` | Works anywhere, including over an app |
| `app` | Works when the app is focused |
| `surface` | Works when a specific surface is focused |
| `context` | Works in a specific state (e.g. editing) |

A more specific scope overrides a less specific one for the same input.

## 4. Rules

- **SHELL-SHORTCUT-011.** A shortcut MUST bind to a command ID, never to a raw action
  string (`ADR-0021`).
- **SHELL-SHORTCUT-012.** Every command MUST have a visible, non-shortcut path
  (`LAW-009` adjacent; shortcuts are accelerators).
- **SHELL-SHORTCUT-013.** User remapping never deletes the command; it changes the
  binding.
- **SHELL-SHORTCUT-014.** Shortcuts are per-user and may roam if the user opts in.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-010` | Every shortcut binds to a registered command ID. |
| `AC-SHELL-SHORTCUT-011` | Every command has a non-shortcut path. |