---
id: FOUND-MOTION-RULES-07
title: Motion Rules
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, FOUND-MOTION-CHOREO-02, FOUND-MOTION-DETERM-03, FOUND-MOTION-REDUCED-04, FOUND-MOTION-SAFETY-05, FOUND-MOTION-TOKENS-06]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-210, AC-FOUND-MOTION-211]
---

# Motion Rules

> This is the one-page normative index. The model files explain why. This file states what is
> binding and what proves it. If a rule here disagrees with a model file, the model file is
> wrong and must be corrected in the same change.

Every rule uses `MUST`, `MUST NOT`, `SHOULD` or `MAY` in the sense of RFC 2119. A `SHOULD`
may be deviated from only with a recorded reason in the component or envelope spec. A `MAY`
is a real option, not a hint. Rules are grouped by topic; IDs are stable and never reused.

---

## 1. Foundation (from README.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-001` | Motion MUST explain what changed, where it came from and where it went. | All | `AC-FOUND-MOTION-001` |
| `FOUND-MOTION-002` | Motion MUST be target-based spring physics: current value, target, response, damping. | All | `AC-FOUND-MOTION-001` |
| `FOUND-MOTION-003` | Motion MUST settle and stop. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-004` | Motion MUST be interruptible at any frame without a jump, preserving velocity. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-005` | Every motion MUST have a reduced-motion alternative removing travel. | All | `AC-FOUND-MOTION-041` |

---

## 2. Springs (from 01-springs.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-010` | A spring MUST have ζ > 0. Undamped is forbidden. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-011` | A spring MUST have finite, non-zero ω. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-012` | Safety envelopes and critical indicators MUST use ζ ≥ 1. | Safety | `AC-FOUND-MOTION-050` |
| `FOUND-MOTION-020` | Retarget MUST preserve x and v. | All | `AC-FOUND-MOTION-010` |
| `FOUND-MOTION-021` | Retarget MUST NOT produce a discontinuity in x or v. | All | `AC-FOUND-MOTION-010` |
| `FOUND-MOTION-030` | Gesture release MUST hand off measured velocity to the spring. | Gestures | `AC-FOUND-MOTION-011` |
| `FOUND-MOTION-031` | Release velocity MUST be filtered (80 ms low-pass). | Gestures | `AC-FOUND-MOTION-011` |
| `FOUND-MOTION-032` | A grab MUST suspend the spring. | Gestures | `AC-FOUND-MOTION-022` |
| `FOUND-MOTION-040` | A spring MUST stop scheduling once settled. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-041` | Settle MUST snap to the exact target. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-042` | Settle thresholds MUST be declared per axis type. | All | `AC-FOUND-MOTION-012` |
| `FOUND-MOTION-043` | A spring not settled by its max duration MUST be forced to settle and logged. | All | `AC-FOUND-MOTION-062` |
| `FOUND-MOTION-050` | A component MUST request motion by named spring. | Components | `AC-FOUND-MOTION-001` |
| `FOUND-MOTION-051` | A named spring MUST be used only for its declared intent. | Components | `AC-FOUND-MOTION-001` |
| `FOUND-MOTION-052` | `SPRING-SAFETY` MUST be used in EV/spaceship and on critical indicators. | Safety | `AC-FOUND-MOTION-050` |
| `FOUND-MOTION-053` | `SPRING-REDUCED` MUST be used as the substitute under reduced motion. | All | `AC-FOUND-MOTION-043` |
| `FOUND-MOTION-060` | Springs on different axes of one surface MUST share a named spring and start together. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-061` | A spring MUST NOT be coupled to another surface's spring. | All | `AC-FOUND-MOTION-020` |

---

## 3. Choreography (from 02-choreography.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-070` | An enter MUST have a declared origin. | All enters | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-071` | An enter MUST NOT move the underlying surface. | All enters | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-072` | An E3 enter MUST add its scrim in the same still. | Overlays | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-073` | Opacity-only enter is the default under reduced motion. | Reduced | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-080` | An exit MUST animate to a declared destination. | All exits | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-081` | An exit MUST preserve the underlying surface's state. | All exits | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-082` | An E3 exit MUST remove the scrim in the same still. | Overlays | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-083` | An exit interrupted by a new enter of the same kind is cancelled; the new surface takes over. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-090` | A gesture MUST suspend the spring while active. | Gestures | `AC-FOUND-MOTION-022` |
| `FOUND-MOTION-091` | On release, initial velocity MUST be the measured release velocity. | Gestures | `AC-FOUND-MOTION-011` |
| `FOUND-MOTION-092` | Target on release MUST be the resting position or nearest snap point. | Gestures | `AC-FOUND-MOTION-022` |
| `FOUND-MOTION-093` | Above throw threshold, target is the next snap point (flick); below, current snap point. | Gestures | `AC-FOUND-MOTION-022` |
| `FOUND-MOTION-094` | A cancelled gesture MUST hand off with v = 0 and return to last stable position. | Gestures | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-100` | A shared element MUST animate geometry with one spring per property, started together. | Shared element | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-101` | Source fades out and destination fades in; at least one visible in every frame. | Shared element | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-102` | A shared element MUST NOT be implemented as remove-then-add. | Shared element | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-103` | If destination not ready, animate to placeholder and hold. | Shared element | `AC-FOUND-MOTION-021` |
| `FOUND-MOTION-110` | Stagger MUST be used only for a list of related items entering together. | Lists | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-111` | Stagger delay MUST be a token in 20–60 ms. | Lists | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-112` | Each staggered item uses `SPRING-ENTER`. | Lists | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-113` | Stagger MUST be cancelled if the list changes before completion. | Lists | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-114` | Under reduced motion, stagger is removed. | Reduced | `AC-FOUND-MOTION-023` |
| `FOUND-MOTION-120` | An interrupt MUST NOT reset x or v (except cancelled gesture). | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-121` | An interrupt MUST NOT introduce a frame at neither target. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-122` | Re-targeting to the original target resumes as if uninterrupted. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-123` | Conflicting motions: the later wins; the earlier cancels with velocity preservation. | All | `AC-FOUND-MOTION-020` |
| `FOUND-MOTION-130` | A critical indicator MUST NOT animate position/size/opacity except a declared value tick. | Safety | `AC-FOUND-MOTION-054` |
| `FOUND-MOTION-131` | A focus ring MUST track focus in the same still. | Focus | `AC-FOUND-MOTION-001` |
| `FOUND-MOTION-132` | Text MUST NOT animate its glyphs. | Text | `AC-FOUND-MOTION-001` |

---

## 4. Determinism (from 03-determinism.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-140` | Simulation step MUST be fixed at 1/120 s. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-141` | Wall-clock time enters only via the accumulator. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-142` | A frame > 33.33 ms MUST be clamped to 4 steps. | Engine | `AC-FOUND-MOTION-031` |
| `FOUND-MOTION-143` | Accumulator MUST reset to 0 on settle. | Engine | `AC-FOUND-MOTION-032` |
| `FOUND-MOTION-150` | Committed still MUST use interpolated state. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-151` | Interpolation MUST apply to position, velocity, opacity, scale with one alpha. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-152` | Below-120 Hz displays commit a subset; simulation still runs at 120 Hz. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-160` | Simultaneously animating springs per surface bounded by token max (default 4). | All | `AC-FOUND-MOTION-061` |
| `FOUND-MOTION-161` | Budget exceeded → degradation ladder. | All | `AC-FOUND-MOTION-062` |
| `FOUND-MOTION-162` | Idle surfaces schedule zero motion work. | All | `AC-FOUND-MOTION-033` |
| `FOUND-MOTION-170` | Below 60 Hz SHOULD avoid motion; any motion uses `SPRING-REDUCED`. | Envelopes | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-171` | Above 144 Hz MUST NOT change the simulation step. | Engine | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-180` | Every named spring MUST pass cross-rate determinism at 60/90/120/144 Hz. | All | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-181` | A spring passing only at 120 Hz is non-conformant. | All | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-182` | The determinism test MUST be automated in CI. | Process | `AC-FOUND-MOTION-030` |
| `FOUND-MOTION-190` | Spring state MUST be stored as f64. | Engine | `AC-FOUND-MOTION-032` |
| `FOUND-MOTION-191` | Time values MUST be integer microseconds internally. | Engine | `AC-FOUND-MOTION-032` |
| `FOUND-MOTION-192` | A spring with |x-t| > 10 000 px MUST be clamped and logged. | Engine | `AC-FOUND-MOTION-031` |
| `FOUND-MOTION-193` | An implementation MUST guard ω against zero and fail loudly. | Engine | `AC-FOUND-MOTION-031` |

---

## 5. Reduced motion (from 04-reduced-motion.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-200` | Parallax, large-field motion, spin and zoom MUST be independently removable. | All | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-201` | Looping or autoplaying motion MUST NOT exist. | All | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-210` | Reduced motion MUST be honoured from system, media query and explicit toggle. | All | `AC-FOUND-MOTION-040` |
| `FOUND-MOTION-211` | A mid-session change applies to the next motion; in-flight settles and is not restarted. | All | `AC-FOUND-MOTION-040` |
| `FOUND-MOTION-212` | The setting MUST be an explicit input, not inferred. | All | `AC-FOUND-MOTION-040` |
| `FOUND-MOTION-220` | Reduced motion MUST remove travel while preserving the state change. | All | `AC-FOUND-MOTION-041` |
| `FOUND-MOTION-221` | A reduced-motion alternative MUST be a declared substitute, not absence of feedback. | All | `AC-FOUND-MOTION-041` |
| `FOUND-MOTION-222` | Safety motion MUST NOT be reduced. | Safety | `AC-FOUND-MOTION-043` |
| `FOUND-MOTION-223` | `SPRING-REDUCED` settles within one frame on a 60 Hz display. | All | `AC-FOUND-MOTION-043` |
| `FOUND-MOTION-230` | A single motion MUST NOT move more than 25% of the viewport. | All | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-231` | A motion MUST NOT change position and scale beyond combined thresholds. | All | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-232` | System-initiated motion MUST be shorter and smaller than user-triggered. | All | `AC-FOUND-MOTION-042` |
| `FOUND-MOTION-233` | No element MUST flash, blink or strobe; at most one non-repeating pulse. | All | `AC-FOUND-MOTION-044` |
| `FOUND-MOTION-240` | No surface MUST flash above 3 Hz. | All | `AC-FOUND-MOTION-044` |
| `FOUND-MOTION-241` | Emissive/colour-cycling indicators MUST pulse below 3 Hz or be static. | All | `AC-FOUND-MOTION-044` |
| `FOUND-MOTION-242` | If flashing cannot be determined, treat as flashing and disable. | All | `AC-FOUND-MOTION-044` |
| `FOUND-MOTION-250` | Reduced motion MUST be testable by toggling a single setting. | All | `AC-FOUND-MOTION-040` |

---

## 6. Safety motion (from 05-safety-motion.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-260` | Every spring in EV/spaceship MUST use `SPRING-SAFETY` or ζ ≥ 1.2. | Safety | `AC-FOUND-MOTION-050` |
| `FOUND-MOTION-261` | A safety spring MUST NOT overshoot. | Safety | `AC-FOUND-MOTION-050` |
| `FOUND-MOTION-262` | A safety spring MUST settle within 400 ms. | Safety | `AC-FOUND-MOTION-050` |
| `FOUND-MOTION-263` | Decorative parallax is forbidden in safety envelopes. | Safety | `AC-FOUND-MOTION-054` |
| `FOUND-MOTION-264` | System-initiated safety motion uses `SPRING-SAFETY` and is not reduced. | Safety | `AC-FOUND-MOTION-053` |
| `FOUND-MOTION-270` | A critical indicator MUST NOT animate through an occluding path. | Safety | `AC-FOUND-MOTION-054` |
| `FOUND-MOTION-271` | A transition MUST NOT pass any surface through a protected zone. | Safety | `AC-FOUND-MOTION-051` |
| `FOUND-MOTION-272` | If a protected zone cannot be drawn, use the redundant indicator. | Safety | `AC-FOUND-MOTION-051` |
| `FOUND-MOTION-273` | A critical indicator's container MUST NOT move; only its value may tick. | Safety | `AC-FOUND-MOTION-054` |
| `FOUND-MOTION-280` | A protected zone MUST be declared with geometry, priority, redundant indicator. | Safety | `AC-FOUND-MOTION-051` |
| `FOUND-MOTION-281` | Motion entering/crossing/leaving a protected zone MUST be rejected by the authority. | Safety | `AC-FOUND-MOTION-051` |
| `FOUND-MOTION-282` | Remote/recorded output MUST preserve the protected zone or declare it unavailable. | Remote | `AC-FOUND-MOTION-054` |
| `FOUND-MOTION-283` | An EV/spaceship policy MUST NOT disable, shrink or reorder a protected zone. | Safety | `AC-FOUND-MOTION-051` |
| `FOUND-MOTION-290` | Safety alert makes non-safety motion yield. | Safety | `AC-FOUND-MOTION-052` |
| `FOUND-MOTION-291` | A safety alert's enter MUST use `SPRING-SAFETY` and complete within 200 ms. | Safety | `AC-FOUND-MOTION-052` |
| `FOUND-MOTION-292` | After dismissal, non-safety motion resumes or restarts from current position with preserved velocity. | Safety | `AC-FOUND-MOTION-052` |
| `FOUND-MOTION-293` | A gesture in progress when a safety alert appears MUST be cancelled. | Safety | `AC-FOUND-MOTION-052` |

---

## 7. Tokens (from 06-tokens.md)

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-300` | A spring token MUST declare ω, ζ, ε_pos, ε_vel, max_duration_ms. | Tokens | `AC-FOUND-MOTION-060` |
| `FOUND-MOTION-301` | A spring token's ζ MUST be > 0. | Tokens | `AC-FOUND-MOTION-060` |
| `FOUND-MOTION-302` | `TOK-MOTION-SPRING-SAFETY` MUST have ζ ≥ 1.2. | Tokens | `AC-FOUND-MOTION-060` |
| `FOUND-MOTION-310` | An envelope MUST NOT use a spring outside its available set. | Envelopes | `AC-FOUND-MOTION-061` |
| `FOUND-MOTION-311` | EV/spaceship MUST use only `SPRING-SAFETY` and `SPRING-REDUCED`. | Safety | `AC-FOUND-MOTION-061` |
| `FOUND-MOTION-312` | An envelope override MUST be declared in its envelope file. | Envelopes | `AC-FOUND-MOTION-061` |
| `FOUND-MOTION-320` | A spring not settled by its hard max MUST be forced to settle and logged. | All | `AC-FOUND-MOTION-062` |
| `FOUND-MOTION-321` | A spring consistently settling above its expected range SHOULD trigger review. | All | `AC-FOUND-MOTION-062` |

---

## 8. Governance rules added by this file

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-MOTION-400` | A component consuming motion MUST declare its spring by token ID. | Components | `AC-FOUND-MOTION-210` |
| `FOUND-MOTION-401` | A token value change that alters a reference still MUST be an ADR. | Tokens | `AC-FOUND-MOTION-211` |
| `FOUND-MOTION-402` | A new named spring MUST NOT be added without an ADR and an intent. | Model | `AC-FOUND-MOTION-000` |
| `FOUND-MOTION-403` | A motion that cannot satisfy a rule MUST declare its degraded state. | All | `AC-FOUND-MOTION-062` |
| `FOUND-MOTION-404` | A review MUST test every rule in this file against the reference surfaces. | Review | `AC-FOUND-MOTION-000` |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-210` | Every `FOUND-MOTION-*` rule in this file appears in at least one model or token file, and no rule exists only here. |
| `AC-FOUND-MOTION-211` | A conformance script walks every component spec, finds each motion declaration by token ID, and reports zero literals and zero undeclared springs. |