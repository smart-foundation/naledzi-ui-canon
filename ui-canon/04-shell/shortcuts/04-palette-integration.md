---
id: SHELL-SHORTCUT-PALETTE
title: Shortcuts — Palette Integration
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-REGISTRY, FW-PALETTE-INDEX]
acceptance: [AC-SHELL-SHORTCUT-040]
---

# Shortcuts — Palette Integration

---

## 1. Palette

- The palette lists every command with its current shortcut (or "no shortcut").
- Typing filters by title, description, keywords and shortcut.
- Selecting a command runs it; the shortcut is shown as a hint.
- The palette is the discovery surface for shortcuts (`ADR-0018`).

## 2. Rules

- **SHELL-SHORTCUT-041.** The palette MUST show the shortcut for every command that has
  one.
- **SHELL-SHORTCUT-042.** A command with no shortcut shows "no shortcut" and offers
  "assign".
- **SHELL-SHORTCUT-043.** Voice invokes the same command IDs as the palette.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-040` | Palette lists every command with its shortcut. |
| `AC-SHELL-SHORTCUT-041` | Voice maps to the same commands. |