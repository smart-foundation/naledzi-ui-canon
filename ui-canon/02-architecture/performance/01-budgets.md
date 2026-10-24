---
id: ARCH-PERF-BUDGETS
title: Budgets
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PERF-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PERF-BUDGET-001, AC-PERF-BUDGET-002]
---

# Budgets

> Per envelope: startup, input, frame, commit, memory, idle, energy. A design
> that cannot meet its budget on the target envelope is not finished.

---

## 1. Budget classes

Every entity declares a budget in these dimensions where applicable:

- **Startup:** time from power-on to first interactive still.
- **Input latency:** time from input event to visible response.
- **Frame time:** time to produce and present one still.
- **Commit latency:** time from commit receipt to numbered still.
- **Memory:** resident memory for the presentation stack.
- **Idle wakeups/energy:** wakeups per minute and energy per hour at idle.
- **Message rate:** messages per second on the hot path.

---

## 2. Per-envelope stance

Budgets are envelope-specific and declared per envelope (`06-envelopes/`). The
architecture does not invent numbers; each envelope file declares its own with
measurement method. Constrained envelopes (watch, IoT) have tighter budgets;
safety envelopes (EV, spaceship) have deterministic deadlines.

---

## 3. Honest measurement

A budget is measured, not estimated. p95 on a reference device. A design that
passes on paper but fails on the weakest supported envelope is not done
(`LAW-016`).

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PERF-BUDGET-001` | Every entity declares a budget in applicable dimensions. |
| `AC-PERF-BUDGET-002` | Budgets are measured on reference devices, not estimated. |

---

## 5. Open questions

See `06-open-questions.md`.

---

## 6. References

See `08-references.md`. `diagnostics.capnp` for measurement contracts.