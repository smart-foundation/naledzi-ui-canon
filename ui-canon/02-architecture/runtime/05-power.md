---
id: ARCH-RUNTIME-POWER
title: Power
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-PWR-001, AC-RUNTIME-PWR-002]
---

# Power

> Idle, suspend, resume, thermal. Idle is silent; power state changes are
> declared and recoverable.

---

## 1. Idle

Idle means no change, no work, no messages, no wakeups (`LAW-004`). Springs
stop at rest. Clocks commit on the tick they choose. Status indicators update
on change. Idle silence is what makes a watch last a week.

---

## 2. Suspend and resume

On suspend, the runtime persists the authority's state (still numbers, still
records) and releases non-essential resources. On resume, it restores state
and re-attaches executor/policy. The current still is preserved across
suspend/resume.

---

## 3. Thermal

Under thermal pressure, the degradation ladder reduces fidelity (motion,
resolution, frame rate) before dropping correctness. Thermal state is an
observation with validity. Safety indicators never degrade for thermal reasons.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-PWR-001` | Idle produces zero wakeups/messages/GPU time (except declared clock ticks). |
| `AC-RUNTIME-PWR-002` | Current still preserved across suspend/resume. |

---

## 5. Open questions

See `08-open-questions.md`.

---

## 6. References

See `10-references.md`. `power.capnp` for power contracts.