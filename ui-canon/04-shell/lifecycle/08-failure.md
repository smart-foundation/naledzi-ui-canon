---
id: SHELL-LIFECYCLE-FAILURE
title: Lifecycle — Failure
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-080]
---

# Lifecycle — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Service fails to start | Degraded boot with report; core services retried |
| Update fails to boot | Auto-rollback to previous version; report |
| Restore fails | Fresh session + report; no hang |
| Shutdown hang | Timeout then force-close with report; protect unsaved drafts |
| Thermal emergency | Shutdown with clear message |
| Battery critical | Sleep then shutdown with draft save |

## 2. Rules

- **SHELL-LIFECYCLE-081.** No lifecycle failure is silent; every failure produces a
  report or an honest screen (`LAW-011`).
- **SHELL-LIFECYCLE-082.** A failed boot never leaves a black screen.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-080` | Every failure mode exercised. |