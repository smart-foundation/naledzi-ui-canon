---
id: ARCH-PERF-REGRESSIONS
title: Regressions
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PERF-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PERF-REG-001, AC-PERF-REG-002]
---

# Regressions

> Gates, baselines, bisection. A regression is a budget failure; it blocks
> merge.

---

## 1. Gates

Performance gates run on every change: budgets must pass on reference devices
at p95. A gate failure blocks merge until resolved or explicitly waived by an
ADR.

---

## 2. Baselines

Baselines are stored per scenario per device. A change is compared against the
baseline; a regression beyond tolerance fails the gate.

---

## 3. Bisection

When a regression is detected, bisection identifies the offending change.
Baselines and scenarios are version-controlled to support this.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PERF-REG-001` | A budget regression fails the gate. |
| `AC-PERF-REG-002` | Bisection identifies the offending change. |

---

## 5. Open questions

See `06-open-questions.md`.

---

## 6. References

See `08-references.md`.