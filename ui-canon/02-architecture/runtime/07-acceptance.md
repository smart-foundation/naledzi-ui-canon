---
id: ARCH-RUNTIME-ACCEPTANCE
title: Runtime Acceptance
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-RUNTIME-000]
---

# Runtime Acceptance

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-RUNTIME-000` | Branch coverage complete. |
| `AC-RUNTIME-SVC-001` | Service restart does not crash consumers. |
| `AC-RUNTIME-SVC-002` | Absent dependency degrades, not crashes. |
| `AC-RUNTIME-SES-001` | Session end revokes all capabilities/handles. |
| `AC-RUNTIME-SES-002` | Multi-user switching no leak. |
| `AC-RUNTIME-ENV-001` | Runtime configures from envelope profile. |
| `AC-RUNTIME-ENV-002` | Policy starts only if profile requires. |
| `AC-RUNTIME-SCHED-001` | Real-time meets deadline under best-effort load. |
| `AC-RUNTIME-SCHED-002` | Safety indicators never preempted. |
| `AC-RUNTIME-PWR-001` | Idle produces zero wakeups except declared ticks. |
| `AC-RUNTIME-PWR-002` | Current still preserved across suspend/resume. |
| `AC-RUNTIME-UPD-001` | Failed update rolls back. |
| `AC-RUNTIME-UPD-002` | User data survives update/rollback. |

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-RUNTIME-000` | Branch coverage complete. |

## 3. Open questions

See `08-open-questions.md`.

## 4. References

See `10-references.md`.