---
id: SHELL-LOCK-INDEX
title: Lock
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-LOCK-000]
children:
  - 01-model.md
  - 02-authentication.md
  - 03-lock-screen.md
  - 04-sessions-and-users.md
  - 05-recovery.md
  - 06-accessibility.md
  - 07-failure.md
  - 08-acceptance.md
---

# Lock

> Lock is **identity and session control**. It separates "the device is locked" from
> "the user is logged in" from "the session is active". Lock is not a screensaver; it
> is a security boundary with a UX.

**Scope:** model, authentication, lock screen, sessions and users, recovery,
accessibility, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app internals; biometric hardware specifics
(those are capability contracts).

---

## 1. The single question this branch answers

> Who is using the device, how do we know, and how does the device protect itself when
> they step away?

---

## 2. The model in one page

```text
    LOCKED  ──auth──►  UNLOCKED (session active)
       ▲                      │
       │  idle/timeout/        │ explicit lock / lid close
       │  explicit lock        ▼
       └──────────────  LOCKED
```

- Lock is a state of the session, not a screen. The lock screen is the UI of that state.
- Authentication is a capability the OS requests from an authenticator (PIN, biometric,
  key, multi-factor).
- A locked device shows no app content; only the lock screen and safety indicators.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | Lock vs login vs session; states |
| [02-authentication.md](02-authentication.md) | PIN, biometric, key, multi-factor, fallback |
| [03-lock-screen.md](03-lock-screen.md) | What the lock screen shows and does |
| [04-sessions-and-users.md](04-sessions-and-users.md) | Multi-user, guest, kiosk |
| [05-recovery.md](05-recovery.md) | Forgotten credential, lockout, recovery |
| [06-accessibility.md](06-accessibility.md) | Screen reader, switch, voice |
| [07-failure.md](07-failure.md) | Failed auth, sensor failure, lockout |
| [08-acceptance.md](08-acceptance.md) | How it is proved |

---

## 4. Envelope coverage

| Envelope | Lock |
|---|---|
| Watch | PIN/biometric; auto-lock on removal |
| Phone | biometric/PIN |
| Tablet | biometric/PIN |
| Desktop | password/key |
| TV | PIN (optional) |
| EV | PIN/key |
| Spaceship | multi-factor |
| IoT | PIN (optional) |
| Spatial | biometric |
| Remote browser | account |

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-LOCK-001` | Lock state hides all app content. |
| `AC-SHELL-LOCK-002` | Multi-user isolation holds. |