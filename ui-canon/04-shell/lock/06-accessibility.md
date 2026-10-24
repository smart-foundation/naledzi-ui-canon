---
id: SHELL-LOCK-A11Y
title: Lock — Accessibility
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-060]
---

# Lock — Accessibility

---

## 1. Semantics

- The lock screen is a `dialog` with an accessible name; its content is announced on
  lock.
- PIN pad buttons are labelled; biometric prompt is announced.
- Lockout state is announced with remaining time.

## 2. Input

- Full keyboard unlock: type PIN/password, Enter to submit.
- Switch access: each digit/control is a focusable target.
- Voice: "unlock with PIN …" with confirmation; biometric via platform.
- Screen reader: no app content is announced while locked.

## 3. Adaptation

- High contrast: PIN pad has clear borders; no colour-only feedback.
- 200% text: pad scales; no clipping.
- Reduced motion: no animated transitions on lock/unlock beyond a fade.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-060` | Lock/unlock fully operable by keyboard, switch, voice. |
| `AC-SHELL-LOCK-061` | No app content announced while locked. |