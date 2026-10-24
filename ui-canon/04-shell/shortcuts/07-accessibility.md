---
id: SHELL-SHORTCUT-A11Y
title: Shortcuts — Accessibility
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SHORTCUT-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SHORTCUT-070]
---

# Shortcuts — Accessibility

---

## 1. Principles

- Shortcuts are accelerators, never the only path (`ADR-0021`, `LAW-009`).
- Every shortcut's outcome is reachable by keyboard navigation, voice and switch.
- Sticky keys, slow keys and filter keys are supported where the platform provides them.

## 2. Adaptation

- Screen reader announces the shortcut when a command is focused.
- High contrast shows shortcut text with sufficient contrast.
- Reduced motion does not affect shortcuts.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-070` | Every shortcut outcome reachable without the shortcut. |
| `AC-SHELL-SHORTCUT-071` | Sticky/slow/filter keys supported. |