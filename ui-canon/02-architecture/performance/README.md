---
id: ARCH-PERF-INDEX
title: Performance
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PERF-000]
children:
  - 01-budgets.md
  - 02-measurement.md
  - 03-idle.md
  - 04-regressions.md
  - 05-acceptance.md
  - 06-open-questions.md
  - 07-changelog.md
  - 08-references.md
---

# Performance

> Budgets, measurement, regressions. Performance is a design constraint, not
> an optimization phase.

---

## 1. The single question

> What are the budgets, how are they measured, and how does the system degrade
> honestly?

---

## 2. Directory map

| File | Question |
|---|---|
| `01-budgets.md` | per envelope; startup, input, frame, commit, memory, idle, energy |
| `02-measurement.md` | instruments, p95, reference devices, reproducible scenarios |
| `03-idle.md` | zero wakeups, commit-driven, no polling |
| `04-regressions.md` | gates, baselines, bisection |
| `05-acceptance.md` | AC index |
| `06-open-questions.md` | unresolved |
| `07-changelog.md` | creation record |
| `08-references.md` | evidence |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PERF-000` | Branch coverage complete. |

---

## 4. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `diagnostics.capnp`, `task_scheduler.capnp`.