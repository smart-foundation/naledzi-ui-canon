---
id: SHELL-LIFECYCLE-A11Y
title: Lifecycle — Accessibility
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-070]
---

# Lifecycle — Accessibility

---

## 1. Principles

- Every lifecycle screen is operable by keyboard, screen reader, switch and voice.
- Boot and recovery progress is announced.
- First-run is fully accessible including the tour (which is skippable).

## 2. Adaptation

- Reduced motion: boot progress is static; no animated splash.
- High contrast: progress and failure screens use shape + text.
- 200% text: all lifecycle screens reflow.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-070` | All lifecycle screens operable by keyboard and screen reader. |
| `AC-SHELL-LIFECYCLE-071` | Progress announced during boot. |