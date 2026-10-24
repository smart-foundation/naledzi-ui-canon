---
id: ARCH-RUNTIME-SCHED
title: Scheduling
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-SCHED-001, AC-RUNTIME-SCHED-002]
---

# Scheduling

> Real-time vs best-effort, safety envelopes. Scheduling separates hard
> deadlines from best-effort work; safety envelopes get deterministic timing.

---

## 1. Real-time vs best-effort

- **Real-time:** work with a hard deadline (scanout, input, safety indicators).
  Scheduled with priority and jitter bounds.
- **Best-effort:** work without a hard deadline (indexing, sync, analytics).
  Runs only when real-time work is idle.

`task_scheduler.capnp` carries scheduling contracts. Safety envelopes (EV,
spaceship) use bounded, non-overshooting motion and deterministic timing
(`ADR-0017`).

---

## 2. Safety envelopes

Safety-critical work is scheduled ahead of best-effort and never preempted by
it. Critical indicators never animate through an occluding path. Reduced
motion is always available.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-SCHED-001` | Real-time work meets its deadline under best-effort load. |
| `AC-RUNTIME-SCHED-002` | Safety indicators are never preempted. |

---

## 4. Open questions

See `08-open-questions.md`.

---

## 5. References

See `10-references.md`.