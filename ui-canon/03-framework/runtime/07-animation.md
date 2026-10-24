---
id: FW-RUNTIME-ANIMATION
title: "Animation: spring engine, retarget, frame scheduling, reduced motion, determinism"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-ANIM-001]
---

# Animation

> Motion explains change (LAW-008). The framework owns the spring engine; MirUI contributes
> scroll motion. One spring model, target-based, velocity-preserving, settle-and-stop.

---

## 1. Spring model

State: `x` (current), `v` (velocity), target `t`, response `ω` (stiffness), damping `ζ`.

- Step: semi-implicit Euler at fixed Δt (1/120 s simulation, render-interpolated)
  (`FOUND-MOTION-INDEX` §2).
- Retarget: changing `t` mid-flight keeps `x` and `v`; no jump.
- Handoff: gesture velocity `v₀` becomes the spring's initial velocity on release.
- Settle: `|x-t| < ε` and `|v| < δ` for N consecutive frames -> stop, schedule nothing.
- Safety: `ζ ≥ 1` (critically/over-damped) for EV, spaceship, critical indicators.

## 2. Named springs

Springs are named by intent, not by number: `SPRING-ENTER`, `SPRING-MOVE`, `SPRING-
DISMISS`, etc. Values live in `tokens/07-motion.md` (`TOK-MOTION-*`). A component asks
for a named spring; it never hardcodes stiffness/damping.

- FW-ANIM-001. A component MUST NOT create an unnamed spring or a fixed-duration curve as
  its primary motion.
- FW-ANIM-002. Fixed-duration easing is permitted only for non-interruptible, non-physical
  transitions (e.g. a fade) and must have a reduced-motion alternative.

## 3. Frame scheduling

- FW-ANIM-003. An animation schedules frames only while not settled. At settle it stops
  scheduling (LAW-004).
- FW-ANIM-004. Animation frames are budgeted under the frame budget (`09-scheduler.md`);
  if the budget is exceeded, motion degrades gracefully (shorter travel, no stagger).
- FW-ANIM-005. Multiple animations on the same frame batch their damage.

## 4. Retarget and interruption

- FW-ANIM-006. Interrupting at any frame with a new target continues from current `x`, `v`
  without a jump (FOUND-MOTION-004).
- FW-ANIM-007. A gesture that interrupts an animation hands off its velocity.
- FW-ANIM-008. If a new target arrives while settling, the spring re-activates.

## 5. Reduced motion

- FW-ANIM-009. Reduced motion removes travel while preserving the state change
  (FOUND-MOTION-005). Opacity/colour may still change; position does not animate.
- FW-ANIM-010. The preference is read from accessibility settings and is an explicit input.
- FW-ANIM-011. Safety envelopes (EV, spaceship) use bounded motion regardless of
  preference; reduced motion further restricts travel.

## 6. Determinism

- FW-ANIM-012. The same motion at 60/90/120/144 Hz produces indistinguishable final state
  and path (FOUND-MOTION-003 test).
- FW-ANIM-013. Simulation uses fixed Δt; render interpolates. Wall-clock jitter does not
  affect outcome.
- FW-ANIM-014. Animation state is part of the reproducibility harness (`10-testing.md`).

## 7. Safety motion

- FW-ANIM-015. Critical indicators never animate through occlusion; protected zones are
  respected (EV/spaceship envelope constraints).
- FW-ANIM-016. Alarm/alert motion is bounded and non-overshooting.

## 8. Honest absence

MirUI provides scroll motion (`src/input/event/scroll/motion.rs`) but no general spring
engine. The framework owns the engine; integration with MirUI's render loop is an open
question (FW-RUNTIME-Q-004).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-ANIM-001` | A spring interrupted mid-flight continues from current position/velocity without a jump at 60/90/120/144 Hz. |
| `AC-FW-ANIM-002` | Reduced motion removes travel while state change remains. |
| `AC-FW-ANIM-003` | Idle app schedules zero frames after settle. |