---
id: SHELL-LIFECYCLE-ACCEPTANCE
title: Lifecycle — Acceptance
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX]
acceptance: [AC-SHELL-LIFECYCLE-000]
---

# Lifecycle — Acceptance

---

## 1. Golden flows

### Flow A — Boot and restore

1. Device boots.
2. Services start; progress shown.
3. Lock/login screen appears.
4. User authenticates.
5. Previous session restored.

### Flow B — Update with rollback

1. Update staged.
2. User restarts.
3. New version fails to boot.
4. Auto-rollback to previous; report shown.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-LIFECYCLE-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-LIFECYCLE-001` | Boot reaches usable or honest failure | Flow A |
| `AC-SHELL-LIFECYCLE-002` | Update rolls back | Flow B |
| `AC-SHELL-LIFECYCLE-003` | First-run works offline | First-run tests |