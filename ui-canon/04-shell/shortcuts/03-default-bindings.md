---
id: SHELL-SHORTCUT-DEFAULTS
title: Shortcuts — Default Bindings
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-MODEL, APP-INPUT]
acceptance: [AC-SHELL-SHORTCUT-030]
---

# Shortcuts — Default Bindings

---

## 1. System defaults

| Command | Default (desktop) | Notes |
|---|---|---|
| `system.palette` | Ctrl/Cmd+K | Universal |
| `system.strip` | Super+Space | Summon strip |
| `system.home` | Super+H | Home |
| `system.back` | Escape / Alt+Left | Back |
| `system.search` | Ctrl/Cmd+F (in context) | Find |
| `system.lock` | Super+L | Lock |
| `system.spaces.next` | Ctrl+Alt+Right | Next space |
| `system.spaces.prev` | Ctrl+Alt+Left | Prev space |
| `system.spaces.new` | Super+T | New space |
| `system.notifications` | Super+N | Notification history |
| `system.settings` | — | No default; palette |
| `system.help` | F1 | Help |

## 2. Rules

- **SHELL-SHORTCUT-031.** Defaults are a starting point; the user may remap any of
  them.
- **SHELL-SHORTCUT-032.** A remapped default leaves its command reachable via the
  palette.
- **SHELL-SHORTCUT-033.** Defaults are per-envelope (`06-per-envelope.md`); a desktop
  default may not exist on a watch.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-030` | Defaults are declared per envelope. |
| `AC-SHELL-SHORTCUT-031` | Remapping preserves palette reachability. |