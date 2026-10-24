---
id: FOUND-MOTION-OQ-14
title: Motion Open Questions
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-REFS-13]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-140]
---

# Motion Open Questions

> An open question with an owner and a deadline is a deliverable. An open question
> without them is a defect.

---

## 1. Open questions

| ID | Question | Owner | Deadline | Blocking |
|---|---|---|---|---|
| `OQ-MOTION-001` | Safety motion profile certification. The EV and spaceship envelopes need a certified, non-overshooting profile with measured settle bounds. Who certifies it, and against which standard (ISO 26262, NASA-STD-3001)? | Safety Lead + Motion Lead | Before envelope implementation | EV, spaceship |
| `OQ-MOTION-002` | Vestibular user testing. No vestibular user testing of parallax and spring motion has been performed (GAP-RES-04). Motion limits are conservative, not calibrated. Who runs it, on how many participants, and what is the pass criterion? | Motion Lead + Accessibility Lead | Before motion canon | All envelopes |
| `OQ-MOTION-003` | Release-velocity filtering. The 80 ms low-pass window and the 400 px/s throw threshold are proposals. Are they right for touch, mouse and crown? Needs measurement per input. | Input Lead + Motion Lead | Before component implementation | Gestures |
| `OQ-MOTION-004` | Settle epsilons. The 0.5 px / 0.5 px/s defaults are proposals. Need to verify they are below the perceptual threshold on the weakest display. | Motion Lead | Before token freeze | All |
| `OQ-MOTION-005` | Spatial comfort bounds. The comfort limits for world-locked motion (acceleration, field of view, duration) are referenced but not quantified here. They live in `accessibility/08-vestibular.md`, which does not yet exist. | Accessibility Lead + Motion Lead | Before spatial envelope | Spatial |
| `OQ-MOTION-006` | Remote browser jitter tolerance. The 18 rad/s cap and the "instant on latency spike" rule need a measured latency distribution for the target remote path. | Remote Output Lead | Before remote-browser envelope | Remote browser |
| `OQ-MOTION-007` | E-ink and sub-60 Hz displays. Motion is discouraged but not fully specified. Is `SPRING-REDUCED` sufficient, or should motion be forbidden outright? | Motion Lead + Envelope Lead | Before IoT envelope | IoT, e-ink |
| `OQ-MOTION-008` | Multi-monitor and large travel. The 25% viewport travel cap assumes one viewport. How does it apply across multiple monitors on a desktop? | Desktop Envelope Lead | Before desktop envelope | Desktop |
| `OQ-MOTION-009` | Haptic coupling. Should a state change that is animated also fire a haptic, and if so, on which envelopes? Owned jointly with sound-haptics. | Motion Lead + Sound/Haptics Lead | Before haptics canon | All |
| `OQ-MOTION-010` | Reduced-motion channel detection. The three channels (system, media query, explicit toggle) need a single source of truth. Which service owns it? | Accessibility Lead | Before implementation | All |

---

## 2. Resolved by this foundation (for the record)

- Spring physics is the motion model (ADR-0005). Resolved.
- Fixed simulation step of 1/120 s. Resolved.
- Underdamped motion forbidden in safety envelopes. Resolved (ADR-0017).
- Named springs by intent. Resolved.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-140` | Every open question has an owner and a deadline; a review confirms no question is left unowned. |