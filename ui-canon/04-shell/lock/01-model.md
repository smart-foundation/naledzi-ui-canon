---
id: SHELL-LOCK-MODEL
title: Lock — Model
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-010]
---

# Lock — Model

---

## 1. States

| State | Meaning |
|---|---|
| `locked` | Device locked; no app content visible; authentication required |
| `authenticating` | Credential being verified |
| `unlocked` | Session active; surfaces visible |
| `lockout` | Too many failed attempts; cooldown or recovery required |

## 2. Lock vs login vs session

- **Login**: establishing a user identity on the device (may happen at boot or on
  user switch).
- **Lock**: the session exists but is gated; unlocking restores the session.
- **Session**: the set of surfaces and state belonging to a user.

A locked device still has a session; it is just not visible. Unlocking does not restart
apps.

## 3. Invariants

- **SHELL-LOCK-011.** A locked device shows no app content, no notifications beyond
  safety, and no strip. Only the lock screen and safety indicators.
- **SHELL-LOCK-012.** Lock state is owned by the OS; no app can read or bypass it.
- **SHELL-LOCK-013.** Auto-lock triggers on idle timeout, lid close, removal (watch),
  or explicit user action.
- **SHELL-LOCK-014.** Unlock restores the session exactly, including focus and scroll.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-010` | Locked state hides all app content. |
| `AC-SHELL-LOCK-011` | Unlock restores session without app restart. |