---
id: SHELL-LOCK-RECOVERY
title: Lock — Recovery
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-AUTH, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-050]
---

# Lock — Recovery

---

## 1. Forgotten credential

- Recovery via: recovery key, trusted device, or account recovery (remote).
- Recovery requires a second factor where possible (multi-factor).
- Recovery resets the credential, not the data; data remains encrypted until the new
  credential unlocks it (where hardware-backed).

## 2. Lockout

- After extended lockout, the device offers recovery (not just more waiting).
- Recovery is rate-limited to prevent brute force.

## 3. Rules

- **SHELL-LOCK-051.** Recovery never silently bypasses authentication; it is a
  declared, auditable path.
- **SHELL-LOCK-052.** Recovery does not delete user data.
- **SHELL-LOCK-053.** A device with no recovery path declared is a defect.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-050` | Recovery resets credential without data loss. |
| `AC-SHELL-LOCK-051` | Recovery is rate-limited. |