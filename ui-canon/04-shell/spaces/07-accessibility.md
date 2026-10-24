---
id: SHELL-SPACES-A11Y
title: Spaces — Accessibility
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SPACES-070]
---

# Spaces — Accessibility

---

## 1. Semantics

- The space set is a list (or tablist, depending on envelope) with each space as an item
  with name, active state and preview.
- Switching is announced: "Switched to Work space."
- Creating/deleting/renaming announced.

## 2. Input

- Keyboard: Ctrl+Alt+Arrow or Super+PageUp/Down to switch; Super+T new space.
- Remote: spaces are reachable via the strip/palette; d-pad navigates.
- Voice: "switch to Work", "new space", "close this space".
- Switch access: each space is a focusable target.

## 3. Adaptation

- **Reduced motion:** instant swap; announced.
- **Screen reader:** space previews are described by their surface titles, not images.
- **200% text:** switcher scrolls; names truncate with tooltip, never the active marker.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-070` | Spaces fully operable by keyboard, remote, voice, switch. |
| `AC-SHELL-SPACES-071` | Switch announced with space name. |