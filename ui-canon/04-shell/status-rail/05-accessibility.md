---
id: SHELL-STATUS-A11Y
title: Status Rail — Accessibility
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-MODEL, CANON-LAWS, FOUND-DEPTH-INDEX]
acceptance: [AC-SHELL-STATUS-050]
---

# Status Rail — Accessibility

---

## 1. Semantics

- The rail is a `region` with an accessible name ("Status").
- Each indicator is a `button` (or `status` live region for read-only facts) with a
  `label` and `value`. Safety indicators are `alert` live regions with `assertive`
  politeness.
- The rail's collapse state is announced: "Status collapsed: showing time and battery."

## 2. Focus and order

- Focus order follows the visual priority order (highest priority first).
- Tab moves through indicators; Enter activates.
- Focus is never lost when an indicator collapses; focus moves to the next surviving
  indicator.
- On screen-reader-only paths, the rail is readable as a list of facts.

## 3. Announcements

| Event | Announcement |
|---|---|
| Indicator appears | "Battery 42 percent" (only if it is a new fact, not a re-render) |
| Indicator collapses | "Collapsed: date hidden" |
| Safety warning appears | assertive: "Warning: …" |
| Privacy indicator appears | "Camera in use" |
| Rail hidden/shown | "Status hidden" / "Status shown" |

Announcements respect the user's announcement preferences and quiet hours; safety
warnings are never silenced.

## 4. Adaptation

- **High contrast:** indicators use shape + text, not colour alone; safety indicators use
  a distinct shape.
- **200% text:** rail grows or collapses; icons keep minimum target size (44 px CSS).
- **Reduced motion:** collapse is instant (no travel); state change still announced.
- **RTL:** order mirrors; icons with directional meaning flip.
- **Colour vision deficiency:** safety uses shape and pattern, not colour alone.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-050` | Rail is fully operable with keyboard, screen reader and voice. |
| `AC-SHELL-STATUS-051` | Safety warnings are assertive live regions on every envelope. |
| `AC-SHELL-STATUS-052` | Collapse is announced and focus is preserved. |
| `AC-SHELL-STATUS-053` | Passes at 200% text and high contrast. |