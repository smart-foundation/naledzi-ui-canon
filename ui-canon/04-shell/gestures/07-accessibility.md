---
id: SHELL-GESTURES-A11Y
title: Gestures — Accessibility
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-GRAMMAR, CANON-LAWS]
acceptance: [AC-SHELL-GESTURES-070]
---

# Gestures — Accessibility

---

## 1. Principles

- Every gesture has a non-gesture path (`APP-INPUT`).
- Switch access and voice can invoke every gesture's outcome.
- Gesture feedback is announced when the outcome is not visually obvious.

## 2. Reduced motion

- Gestures still work; the visual travel is removed; state changes are announced.
- Edge swipes produce the same result without a sliding animation.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-070` | Every gesture outcome reachable without the gesture. |
| `AC-SHELL-GESTURES-071` | Switch and voice can invoke all outcomes. |