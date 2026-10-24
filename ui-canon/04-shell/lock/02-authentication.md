---
id: SHELL-LOCK-AUTH
title: Lock — Authentication
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-020]
---

# Lock — Authentication

---

## 1. Methods

| Method | Envelopes | Notes |
|---|---|---|
| PIN | all | Fallback everywhere; never the only method on capable devices |
| Password | desktop, remote | For high-security accounts |
| Biometric | phone, tablet, watch, spatial | Revocable; falls back to PIN |
| Security key | desktop, remote, spaceship | Hardware token |
| Multi-factor | spaceship, EV (fleet), remote | Two or more methods |

## 2. Rules

- **SHELL-LOCK-021.** Authentication is a capability provided by an authenticator; the
  OS does not implement biometrics itself, it requests a verification result.
- **SHELL-LOCK-022.** Biometric failure always falls back to PIN/password. Biometric
  alone is never the only path.
- **SHELL-LOCK-023.** Failed attempts are counted; after N failures (default 5) the
  device enters `lockout` with a cooldown (default 30 s, escalating).
- **SHELL-LOCK-024.** During lockout, safety indicators remain visible; no app content.
- **SHELL-LOCK-025.** Authentication inputs are never logged; password fields never
  echo, suggest or log (`APP-INPUT` §6).

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-020` | Biometric falls back to PIN. |
| `AC-SHELL-LOCK-021` | Lockout triggers after N failures with cooldown. |
| `AC-SHELL-LOCK-022` | Auth inputs are never logged. |