---
id: SHELL-NOTIF-FAILURE
title: Notifications — Failure
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-NOTIF-080]
---

# Notifications — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Origin app crashed | Notification already delivered remains; actions that need the app show "app unavailable" with retry |
| Delivery dropped (budget/quiet) | Recorded as queued/expired; not silently lost |
| Cross-device conflict | Reconcile by timestamp; never duplicate; never lose |
| Expired notification | Removed from banner; retained in history as expired |
| Channel missing | Falls back to origin's default channel; logged |
| Sound/haptic unavailable | Visual delivery proceeds; no fake sound |
| Network unavailable (remote notification) | Queued; delivered on reconnect; origin notified of delay |

## 2. Rules

- **SHELL-NOTIF-081.** A notification is never silently dropped. Every created
  notification ends in delivered, queued, expired or dismissed (`LAW-011`).
- **SHELL-NOTIF-082.** A failed action shows the failure and offers retry or open-app.
- **SHELL-NOTIF-083.** Cross-device reconciliation never fabricates a delivered state.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-080` | Every failure mode is exercised. |
| `AC-SHELL-NOTIF-081` | No notification is silently dropped. |