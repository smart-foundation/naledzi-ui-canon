---
id: FOUND-MOTION-CHANGELOG-15
title: Motion Changelog
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-150]
---

# Motion Changelog

> Append-only. A new entry is added; old entries are never rewritten.

---

## 2026-10-23 — Initial creation of the motion foundation

Created the motion subtree from scratch under `01-foundations/motion/`, per ADR-0005
(spring physics is the motion foundation) and the completeness contract.

Files created:

- `README.md` — index, manifest, ownership, acceptance.
- `01-springs.md` — response/damping, velocity preservation, retarget, settle-and-stop,
  determinism; named springs by intent; formulas; spring physics equations.
- `02-choreography.md` — enter/exit, shared element, stagger, interrupt, gesture handoff;
  velocity preserved across interruption; no jumps; wireframes.
- `03-determinism.md` — refresh-rate independence (60/90/120/144), fixed timestep,
  frame budget, cross-rate test procedure.
- `04-reduced-motion.md` — vestibular safety, motion sickness, alternatives that never
  remove state change; vestibular literature cited.
- `05-safety-motion.md` — EV/spaceship bounded non-overshooting springs; critical
  indicators never animate through occlusion; protected zones.
- `06-tokens.md` — proposed `TOK-MOTION-*` values (response, damping, duration bounds)
  with semantics and per-envelope mapping.
- `07-rules.md` — consolidated normative rule set (`FOUND-MOTION-001`…).
- `08-envelopes.md` — motion per envelope (watch, phone, tablet, desktop, TV, EV,
  spaceship, IoT, spatial, remote browser).
- `09-assistive.md` — non-visual / switch / screen-reader path.
- `10-performance.md` — cost, degradation ladder, idle cost.
- `11-failure.md` — spring that will not settle, interrupted gesture, capture lease
  expiry, timer drift.
- `12-timelessness.md` — why springs survive input/decade change.
- `13-references.md` — evidence with limits; Fitts 1954, Accot & Zhai steering law,
  Flash & Hogan 1985, vestibular/motion-sickness literature, predictive processing.
- `14-open-questions.md` — unresolved, owner, deadline.
- `acceptance.md` — `AC-FOUND-MOTION-*` criteria.

Decisions recorded:

- Simulation step fixed at 1/120 s with semi-implicit Euler integration.
- Springs named by intent; components never hard-code `(ω, ζ)`.
- Safety motion uses `SPRING-SAFETY` (ζ ≥ 1.2, non-overshooting) and is never reduced.
- Degradation ladder: reduce motion → shorten springs → disable parallax → instant.
- Settle detection requires 4 consecutive steps below threshold; force-settle at hard max.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-150` | The changelog lists every file created in this subtree and the date of creation. |