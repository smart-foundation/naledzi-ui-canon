---
id: ARCH-PERF-IDLE
title: Idle
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PERF-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PERF-IDLE-001, AC-PERF-IDLE-002]
---

# Idle

> Zero wakeups, commit-driven, no polling. Idle is the default state and the
> cheapest state.

---

## 1. Idle semantics

A surface that has not changed MUST send nothing and schedule nothing
(`LAW-004`). No polling, no heartbeat, no redraw to appear alive. Springs
stop at rest. Clocks commit on the tick they choose. Status indicators update
on change.

---

## 2. Commit-driven

All work is triggered by commits or input events. There is no background loop
waiting for change. Idle silence is what makes a watch last a week and a
desktop stay cool.

---

## 3. Measurement

Idle is measured: leave every surface untouched for one hour; measure
messages, wakeups, GPU time, battery. Expected result: zero (or the declared
periodic cost of a clock). `AC-PERF-IDLE-001` enforces.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PERF-IDLE-001` | One hour untouched yields zero wakeups/messages/GPU time except declared clock ticks. |
| `AC-PERF-IDLE-002` | No polling or heartbeat redraws exist. |

---

## 5. Open questions

See `06-open-questions.md`.

---

## 6. References

See `08-references.md`. `LAW-004`.