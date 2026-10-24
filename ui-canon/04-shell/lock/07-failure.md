---
id: SHELL-LOCK-FAILURE
title: Lock — Failure
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-070]
---

# Lock — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Biometric sensor failure | Fall back to PIN/password; announce sensor unavailable |
| Too many failed attempts | Enter lockout with cooldown; offer recovery |
| Authenticator unavailable | Lock remains; offer recovery path; never unlock without auth |
| Crash while locked | Stay locked; restore lock screen |
| Crash while unlocked | Restore session or lock, per policy; never leave unlocked unattended past timeout |
| Power loss | Boot to lock (or login) on next start |

## 2. Rules

- **SHELL-LOCK-071.** The device never unlocks without a successful authentication.
- **SHELL-LOCK-072.** A sensor failure is announced and a fallback is offered.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-070` | Every failure mode exercised. |
| `AC-SHELL-LOCK-071` | No unlock without auth. |