---
id: ARCH-PERF-ACCEPTANCE
title: Performance Acceptance
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PERF-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PERF-000]
---

# Performance Acceptance

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-PERF-000` | Branch coverage complete. |
| `AC-PERF-BUDGET-001` | Every entity declares a budget. |
| `AC-PERF-BUDGET-002` | Budgets measured on reference devices. |
| `AC-PERF-MEAS-001` | Budgets at p95 on reference device. |
| `AC-PERF-MEAS-002` | Scenarios scripted and reproducible. |
| `AC-PERF-IDLE-001` | One hour untouched yields zero wakeups. |
| `AC-PERF-IDLE-002` | No polling or heartbeat redraws. |
| `AC-PERF-REG-001` | Budget regression fails gate. |
| `AC-PERF-REG-002` | Bisection identifies offending change. |

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PERF-000` | Branch coverage complete. |

## 3. Open questions

See `06-open-questions.md`.

## 4. References

See `08-references.md`.