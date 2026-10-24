---
id: FW-PALETTE-A11Y
title: Accessibility
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-007]
---

# Accessibility

---

## 1. Semantics

- The palette is a `dialog`/`combobox` hybrid: an input with a `listbox` of options.
- Each result is an `option` with name, description and state.
- The input has an accessible label "Command palette".

## 2. Keyboard

- `Tab`/`Shift+Tab`: move between input and list (or focus stays in input with arrows
  for list).
- `ArrowDown`/`ArrowUp`: move highlight.
- `Enter`: dispatch highlighted command.
- `Escape`: close without dispatch.
- `Ctrl/Cmd+K`: toggle.

## 3. Announcements

- On open: "Command palette. Type to search commands."
- On result count change: "N commands" (debounced, not per keystroke).
- On dispatch: command title announced if it produces no visible change.

## 4. Focus management

- On open, focus moves to the input.
- On close, focus returns to the previously focused element, or the focus root.
- Focus trap while open (modal overlay).

## 5. Reduced motion / high contrast / 200% text / RTL

- Open/close animation becomes instant under reduced motion; state change still announced.
- High contrast keeps the focus ring and selection visible.
- At 200% text, the palette reflows to full width; results wrap.
- RTL mirrors layout and caret direction; command IDs stay LTR.
