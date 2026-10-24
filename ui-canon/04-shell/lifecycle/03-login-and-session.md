---
id: SHELL-LIFECYCLE-LOGIN
title: Lifecycle — Login and Session
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, SHELL-LOCK-INDEX]
acceptance: [AC-SHELL-LIFECYCLE-030]
---

# Lifecycle — Login and Session

---

## 1. Login

- Login establishes the user identity and unlocks their session.
- Login methods follow `lock/02-authentication.md`.
- A device may auto-login a single user if configured (kiosk/personal), with the
  security trade-off stated.

## 2. Session

- A session holds the user's surfaces, spaces, clipboard and capability grants for the
  duration of use.
- Session timeout locks the device; the session persists.
- Multiple concurrent sessions on one device are supported where the envelope allows
  (desktop).

## 3. Rules

- **SHELL-LIFECYCLE-031.** Session state is restored on unlock, not recreated.
- **SHELL-LIFECYCLE-032.** Capability grants persist with the session and are
  revocable at any time.
- **SHELL-LIFECYCLE-033.** A session ends only on explicit logout or user switch.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-030` | Session restores after lock/unlock. |
| `AC-SHELL-LIFECYCLE-031` | Capability grants revocable mid-session. |