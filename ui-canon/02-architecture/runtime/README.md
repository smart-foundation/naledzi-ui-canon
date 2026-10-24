---
id: ARCH-RUNTIME-INDEX
title: Runtime
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-RUNTIME-000]
children:
  - 01-services.md
  - 02-sessions.md
  - 03-envelopes.md
  - 04-scheduling.md
  - 05-power.md
  - 06-updates.md
  - 07-acceptance.md
  - 08-open-questions.md
  - 09-changelog.md
  - 10-references.md
---

# Runtime

> Which processes exist, how are they supervised, and how does state survive.
> Services, sessions, envelopes, scheduling, power, updates.

---

## 1. The single question

> Which processes exist, how are they supervised, and how does state survive?

---

## 2. Directory map

| File | Question |
|---|---|
| `01-services.md` | lifecycle, supervision, restart, dependency on roles not names |
| `02-sessions.md` | user session, capability scope, multi-user |
| `03-envelopes.md` | device profile, resource profile, policy presence |
| `04-scheduling.md` | real-time vs best-effort, safety envelopes |
| `05-power.md` | idle, suspend, resume, thermal |
| `06-updates.md` | atomic, rollback, data compatibility |
| `07-acceptance.md` | AC index |
| `08-open-questions.md` | unresolved |
| `09-changelog.md` | creation record |
| `10-references.md` | evidence |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-RUNTIME-000` | Branch coverage complete. |

---

## 4. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `service.capnp`, `process.capnp`, `session.capnp`, `power.capnp`,
  `update.capnp`, `task_scheduler.capnp`.