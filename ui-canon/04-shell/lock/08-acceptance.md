---
id: SHELL-LOCK-ACCEPTANCE
title: Lock — Acceptance
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-INDEX]
acceptance: [AC-SHELL-LOCK-000]
---

# Lock — Acceptance

---

## 1. Golden flows

### Flow A — Lock and unlock

1. User locks (explicit).
2. Lock screen shows time + auth.
3. User authenticates (biometric → success).
4. Session restored with focus.

### Flow B — Lockout and recovery

1. 5 failed PIN attempts.
2. Lockout with 30 s cooldown.
3. Recovery offered; user resets PIN via recovery key.
4. New PIN works; data intact.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-LOCK-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-LOCK-001` | Locked hides app content | Flow A |
| `AC-SHELL-LOCK-002` | Unlock restores session | Flow A |
| `AC-SHELL-LOCK-003` | Multi-user isolation | Multi-user tests |
| `AC-SHELL-LOCK-004` | Recovery works | Flow B |