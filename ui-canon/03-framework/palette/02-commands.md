---
id: FW-PALETTE-CMDS
title: Commands
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-002]
---

# Commands

---

## 1. Command identity

Every command has a **stable ID** that does not change across releases, locales or
themes. Format: `<namespace>.<verb>.<object>` in ASCII, e.g. `file.save`, `view.zoom.in`.
IDs are case-sensitive and never localised.

## 2. Command record

| Field | Type | Required | Notes |
|---|---|---|---|
| `id` | string | yes | Stable, unique within the app/shell/system scope. |
| `title` | localised string | yes | Imperative verb phrase ("Save changes"). |
| `subtitle` | localised string | no | Disambiguation ("in current folder"). |
| `group` | string | yes | For grouping in menus/palette ("File", "View"). |
| `keywords` | string[] | no | Additional search terms, localised. |
| `icon` | semantic icon name | no | Solar/Naledzi glyph name, never a path. |
| `shortcut` | key chord | no | Registered in the shortcut registry. |
| `availability` | predicate | yes | When the command may run. |
| `enabled_reason` | string | no | Why disabled, shown on hover/focus. |
| `destructive` | bool | yes | Requires confirmation or undo. |
| `capability` | capability id | no | Required capability to run. |
| `scope` | global/app/selection/object | yes | Context in which it applies. |
| `handler` | function | yes | The effect. |
| `undo` | undo token | no | Reversibility (`LAW-015`). |

## 3. Visible paths

A command MUST declare every surface on which it is reachable: palette, menu, toolbar,
context menu, shortcut, voice. A command reachable only by shortcut violates
`LAW-010`/`LAW-008` (shortcuts are accelerators, never the only path). The palette is
always a visible path.

## 4. Rules

- `FW-PALETTE-CMD-001`: A command ID is unique within its registering scope; collisions
  across scopes are resolved by scope precedence (object > selection > app > global).
- `FW-PALETTE-CMD-002`: A destructive command MUST declare either an undo token or a
  confirmation prompt. Silence is a defect.
- `FW-PALETTE-CMD-003`: A disabled command MUST expose a reason and a path to enable it.
- `FW-PALETTE-CMD-004`: Command titles are localised; IDs never are.
- `FW-PALETTE-CMD-005`: No command may be registered twice with the same ID in the same
  scope.
