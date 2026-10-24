---
id: SHELL-SHORTCUT-DISCOVER
title: Shortcuts — Discoverability
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-PALETTE, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-050]
---

# Shortcuts — Discoverability

---

## 1. Principles

- A shortcut that is not shown anywhere is a secret; secrets are forbidden
  (`APP-INPUT` §3).
- Shortcuts are shown in context menus, tooltips, and the palette.
- A "show shortcuts" command lists all bindings for the current context.

## 2. Surfaces

- Context menu shows the shortcut next to each item.
- Tooltip on hover (where hover exists) shows the shortcut.
- Settings → Keyboard lists all bindings, searchable, remappable.
- First-run mentions the palette shortcut.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-050` | Every shortcut is shown in at least one discoverable surface. |
| `AC-SHELL-SHORTCUT-051` | First-run mentions the palette shortcut. |