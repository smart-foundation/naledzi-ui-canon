---
id: ARCH-ECO-REMOTEIN
title: Remote Input
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX, ARCH-PRESENT-INPUT]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-RIN-001, AC-ECO-RIN-002]
---

# Remote Input

> Phone as keyboard/pointer/gamepad, PC as keyboard for TV, latency, capture
> leases. Remote input is capability-scoped and latency-budgeted.

---

## 1. Model

Remote input devices (phone as keyboard/pointer/gamepad, PC as keyboard for
TV) send input events to the receiving device's authority, which routes them
using the current still's hit map and input ownership. Capture leases may be
granted for remote drags/gestures, scoped and revocable.

---

## 2. Latency

Remote input has a declared latency budget (`performance/01-budgets.md`). If
the budget is exceeded, the system degrades (e.g., disables prediction) but
never silently drops input. Input is never routed to a stale hit map.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-RIN-001` | Remote input is routed via the authority's hit map. |
| `AC-ECO-RIN-002` | Exceeded latency budget degrades, not drops input. |

---

## 4. Open questions

See `13-open-questions.md`.

---

## 5. References

See `15-references.md`. `input.capcp` (input.capnp), `ime.capnp`.