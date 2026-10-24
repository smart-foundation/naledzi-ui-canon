---
id: FOUND-MOTION-INDEX
title: Motion
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, CANON-DECISIONS, FOUND-INDEX, FOUND-DEPTH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-000]
children:
  - 01-springs.md
  - 02-choreography.md
  - 03-determinism.md
  - 04-reduced-motion.md
  - 05-safety-motion.md
  - 06-tokens.md
  - 07-rules.md
  - 08-envelopes.md
  - 09-assistive.md
  - 10-performance.md
  - 11-failure.md
  - 12-timelessness.md
  - 13-references.md
  - 14-open-questions.md
  - 15-changelog.md
  - acceptance.md
---

# Motion

> Motion explains change. It is spring physics with velocity preservation, deterministic
> integration and settle-and-stop. It is not decoration, not a transition effect and not a
> timer. If removing a motion leaves the state change equally clear, the motion was
> decoration and does not belong in this model.

**Scope:** the perceptual and interaction grammar of change: how a surface appears, moves,
interrupts, hands off from a gesture, settles and stops. Every transition, enter/exit,
shared-element move, stagger, gesture handoff and safety-bounded motion in the corpus
composes inside it.

**Non-goals:** fixed-duration easing as the primary model, keyframe timelines as the default,
infinite decorative loops, parallax-as-decoration (owned by depth), and any motion whose
purpose is to look modern rather than to explain what changed.

---

## 1. The human constant

Human movement is not a sequence of positions chosen in advance; it is the output of a
spring-like neuromuscular system that minimises jerk. Flash and Hogan (1985) showed that
point-to-point arm movements are well described by a minimum-jerk trajectory, which is the
response of a critically or near-critically damped spring to an equilibrium-point shift.
That is the physical fact the model is built on: the hand does not teleport, and neither
should the thing it moves.

Motion is also cognition. A sudden position change without an intermediate path is
perceived as a replacement, not a change; the person loses the object's identity and must
re-search the screen. Motion that preserves velocity across an interruption is perceived as
the same object continuing; motion that restarts is perceived as a new event. This is the
difference between a spring and a curve.

Naledzi turns those facts into a rule:

- **FOUND-MOTION-001.** Motion MUST explain what changed, where it came from and where it
  went. A motion with no explanatory role MUST NOT exist.
- **FOUND-MOTION-002.** Motion MUST be target-based spring physics: a current value, a target
  value, a response (stiffness) and a damping. Duration is a consequence, never an input.
- **FOUND-MOTION-003.** Motion MUST settle and stop. A spring that never reaches rest
  violates idle silence (`LAW-004`) and is a defect.
- **FOUND-MOTION-004.** Motion MUST be interruptible at any frame without a jump, and MUST
  preserve velocity across the interruption.
- **FOUND-MOTION-005.** Every motion MUST have a reduced-motion alternative that removes
  travel while preserving the state change (`LAW-008`).

---

## 2. The model in one page

```text
state:   x (current), v (velocity), target t, response ω, damping ζ
step:    semi-implicit Euler at fixed Δt (1/120 s simulation, render-interpolated)
handoff: gesture velocity v₀ becomes spring initial velocity on release
settle:  |x - t| < ε AND |v| < δ for N consecutive frames → stop, schedule nothing
safety:  ζ ≥ 1 (critically/over-damped) for EV, spaceship, critical indicators
```

Springs are named by intent, not by number. A component asks for `SPRING-ENTER`, not for
`stiffness 240, damping 28`. The token file proposes the values; the engine owns the
integration.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-springs.md](01-springs.md) | What are response and damping, and how do retarget, settle and determinism work? |
| [02-choreography.md](02-choreography.md) | How do enter, exit, shared element, stagger, interrupt and gesture handoff behave? |
| [03-determinism.md](03-determinism.md) | How is motion identical at 60, 90, 120 and 144 Hz? |
| [04-reduced-motion.md](04-reduced-motion.md) | How is vestibular safety provided, and what survives? |
| [05-safety-motion.md](05-safety-motion.md) | What motion is legal in safety envelopes and protected zones? |
| [06-tokens.md](06-tokens.md) | Which `TOK-MOTION-*` values are proposed? |
| [07-rules.md](07-rules.md) | What is the consolidated normative rule set? |
| [08-envelopes.md](08-envelopes.md) | How does motion change per envelope? |
| [09-assistive.md](09-assistive.md) | What does a non-visual or switch path receive instead of motion? |
| [10-performance.md](10-performance.md) | What does motion cost, and how does it degrade? |
| [11-failure.md](11-failure.md) | What happens when a spring will not settle, a gesture is interrupted or a timer drifts? |
| [12-timelessness.md](12-timelessness.md) | Why do springs survive input and decade change? |
| [13-references.md](13-references.md) | What is the evidence, with limits? |
| [14-open-questions.md](14-open-questions.md) | What is unresolved, owned and due? |
| [15-changelog.md](15-changelog.md) | What changed? |
| [acceptance.md](acceptance.md) | How is the whole foundation proved? |

---

## 4. Dependency and ownership

| Fact | Owner | Consumers |
|---|---|---|
| Spring integration, settle detection, scheduling | Motion engine (framework runtime) | Every component, shell, app |
| Named spring tokens (response, damping, bounds) | This foundation, minted by `03-framework/tokens/` | Components, apps, envelopes |
| Gesture velocity on release | Input/gesture owner per envelope | Motion engine (handoff) |
| Reduced-motion preference | Accessibility / system settings | Motion engine, depth |
| Safety motion profile (bounded, non-overshooting) | This foundation + EV/spaceship envelope constraints | Safety indicators, alerts |
| Critical-indicator protection | EV and spaceship envelope constraints + this foundation | Safety surfaces |
| Refresh-rate independence | This foundation | Renderer, motion engine |

The motion foundation does not own layout, depth levels or input grammar. It owns the
meaning of a change and the consequences of moving something from one state to another.

---

## 5. What is intentionally absent

| Item | Reason |
|---|---|
| A physics engine for all motion | `n/a — a full rigid-body engine is a cost without a benefit for UI; springs are enough (ADR-0005).` |
| Fixed-duration easing as the primary model | `n/a — cannot be interrupted without a jump; rejected by ADR-0005.` |
| Infinite decorative motion | `n/a — forbidden by LAW-004 (idle is silent) and FOUND-MOTION-003.` |
| Per-component animation timelines | `n/a — springs are target-based and shared; timelines are a second authority.` |
| Motion on audio-only or braille output | `n/a — non-visual paths receive state changes, not travel (09-assistive.md).` |
| Per-envelope pixel values in prose | `n/a — values live in 06-tokens.md and are referenced by ID.` |

---

## 6. The motion test

Every motion decision is tested three ways:

1. **Interrupt.** Start the motion, interrupt it at an arbitrary frame with a new target or
   a gesture. Does it continue from its current position and velocity without a jump? If a
   jump is visible, the motion is not a spring.
2. **Settle.** Leave the motion running. Does it reach rest and stop scheduling within its
   declared bound? If it drifts or never stops, it violates idle silence.
3. **Rate.** Run the same motion at 60, 90, 120 and 144 Hz. Are the final position and the
   perceived path indistinguishable? If not, the integration is not deterministic.

A design that fails any test is not finished.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-000` | Every file listed in `children` exists; every file in the directory is listed; no file contains `TODO` or an empty section. |
| `AC-FOUND-MOTION-001` | Every motion in the reference set is a named spring, settles within its bound, is interruptible without a jump, and has a reduced-motion alternative. |
| `AC-FOUND-MOTION-002` | The same motion run at 60, 90, 120 and 144 Hz produces indistinguishable final state and path. |
| `AC-FOUND-MOTION-003` | Reduced motion removes travel while the state change remains visible or announced. |
| `AC-FOUND-MOTION-004` | No critical indicator is occluded at any frame of the safety reference flow. |