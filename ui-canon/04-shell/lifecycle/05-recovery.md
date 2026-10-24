---
id: SHELL-LIFECYCLE-RECOVERY
title: Lifecycle — Recovery
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-050]
---

# Lifecycle — Recovery

---

## 1. Recovery mode

- Entered when boot fails, on explicit user request, or from a failed update.
- Offers: repair install, restore from backup, reset settings (keep data), factory reset.
- Recovery is accessible (keyboard, screen reader) and works without a network where
  possible.

## 2. Rules

- **SHELL-LIFECYCLE-051.** Recovery MUST preserve user data unless factory reset is
  explicitly chosen and confirmed.
- **SHELL-LIFECYCLE-052.** Every destructive recovery action requires confirmation
  with a clear statement of consequence.
- **SHELL-LIFECYCLE-053.** Recovery MUST be reachable without a working OS (hardware
  key combination at boot).

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-050` | Recovery repairs without data loss by default. |
| `AC-SHELL-LIFECYCLE-051` | Factory reset requires confirmation. |
| `AC-SHELL-LIFECYCLE-052` | Recovery reachable via hardware key. |