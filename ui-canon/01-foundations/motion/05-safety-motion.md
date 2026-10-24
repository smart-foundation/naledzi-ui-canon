---
id: FOUND-MOTION-SAFETY-05
title: Safety Motion
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-SPRINGS-01, FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX, LAW-008, LAW-011, ADR-0017, ADR-0020]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-050, AC-FOUND-MOTION-051, AC-FOUND-MOTION-052, AC-FOUND-MOTION-053]
---

# Safety Motion

> In a car or a spacecraft, a spring that overshoots can hide a warning for 200 ms. That
> is not a polish issue. Safety motion is motion that has been told what it is not allowed
> to do.

---

## 1. What a safety envelope is

EV and spaceship are safety envelopes (`06-envelopes/`). They carry critical indicators:
speed, range, battery, warnings, alarms, procedure steps, fault states. These indicators
occupy protected zones (`FOUND-DEPTH-200`) that no app surface may occlude. Motion in
these envelopes is constrained by `ADR-0017`: bounded, non-overshooting, short settle, no
decorative parallax.

The constraints here apply in addition to everything in `01-springs.md` and
`02-choreography.md`. Where this file is stricter, this file wins.

---

## 2. Bounded, non-overshooting springs

In a safety envelope, every spring uses `SPRING-SAFETY` (ζ ≥ 1.2) or a spring with an
even higher damping ratio. Underdamped motion is forbidden.

| Property | Safety value | Reason |
|---|---|---|
| Damping ratio ζ | ≥ 1.2 | No overshoot; the indicator never passes its target |
| Response ω | ≤ 12 rad/s (settles in ≤ 400 ms) | Fast enough to feel responsive, slow enough to read |
| Overshoot | 0 (none) | An overshooting value can be misread as the real value |
| Settle bound ε_pos | 0.5 px or 1 unit of the indicator | Tight enough to be exact |
| Max duration | 400 ms | Beyond this, the change is too slow for a safety context |

Rules:

- **FOUND-MOTION-260.** Every spring in an EV or spaceship envelope MUST use
  `SPRING-SAFETY` or a spring with ζ ≥ 1.2. Underdamped motion is forbidden.
- **FOUND-MOTION-261.** A safety spring MUST NOT overshoot its target in position,
  value, opacity or scale. An overshoot is a defect, not a style choice.
- **FOUND-MOTION-262.** A safety spring MUST settle within 400 ms. A motion that takes
  longer MUST be forced to settle and logged.
- **FOUND-MOTION-263.** Decorative parallax is forbidden in safety envelopes
  (`FOUND-DEPTH-112`). No layer moves relative to another for appearance.
- **FOUND-MOTION-264.** A system-initiated motion in a safety envelope (for example a
  value ticking, a warning appearing) MUST use `SPRING-SAFETY` and MUST NOT be reduced
  under reduced motion (`FOUND-MOTION-222`).

---

## 3. Critical indicators never animate through occlusion

A critical indicator is a value or warning whose reading affects safety: speed, fuel or
battery, warnings, alarms, procedure steps, fault codes. These live in protected zones
(`FOUND-DEPTH-200`).

Rules:

- **FOUND-MOTION-270.** A critical indicator MUST NOT animate its position, size or
  opacity through an occluding path. It appears, changes value or disappears; it does not
  travel across the screen.
- **FOUND-MOTION-271.** A transition (enter, exit, shared element, sheet) MUST NOT pass
  any surface through a protected zone at any frame. `FOUND-DEPTH-201`.
- **FOUND-MOTION-272.** If a protected zone cannot be drawn (missing asset, degraded
  output), the system MUST use the redundant indicator (audio/haptic) and state what is
  unavailable. Motion does not substitute for the indicator.
- **FOUND-MOTION-273.** A critical indicator that changes value (for example speed
  increasing) MAY animate the value itself with `SPRING-SAFETY`, but the indicator's
  container MUST NOT move.

### 3.1 Protected zone frames

```text
Frame 1 — normal driving, no occlusion
+--------------------------------------+
|  [speed]  [range]   (protected zone)  |
|                                      |
|  map / media content                 |
|                                      |
+--------------------------------------+

Frame 2 — sheet enters (must not cross protected zone)
+--------------------------------------+
|  [speed]  [range]   (protected zone)  |
|  +--------------------------------+  |
|  |  sheet content (below zone)     |  |
|  +--------------------------------+  |
+--------------------------------------+

Frame 3 — forbidden: sheet crosses protected zone
+--------------------------------------+
|  +--------------------------------+  |
|  |  sheet (OCCLUDES speed)  <-- DEFECT
|  +--------------------------------+  |
+--------------------------------------+
```

---

## 4. Protected zones

A protected zone is declared by geometry, priority and a redundant indicator. It is owned
jointly by this foundation and the EV/spaceship envelope constraints.

Rules:

- **FOUND-MOTION-280.** A protected zone MUST be declared per envelope, with geometry,
  priority and a redundant indicator (`FOUND-DEPTH-200`).
- **FOUND-MOTION-281.** A motion that would enter, cross or leave a protected zone MUST
  be rejected by the authority before it is committed. The previous still remains.
- **FOUND-MOTION-282.** A remote or recorded output MUST preserve the protected zone or
  declare the indicator unavailable (`FOUND-DEPTH-202`).
- **FOUND-MOTION-283.** An EV or spaceship policy MUST NOT be able to disable, shrink or
  reorder a protected zone. The zone is a safety property, not a preference.

---

## 5. Interrupt and yield

In a safety envelope, safety motion takes precedence over non-safety motion.

Rules:

- **FOUND-MOTION-290.** When a safety alert or warning appears, non-safety motion MUST
  yield: it either completes its current step and pauses, or cancels with velocity
  preservation. It MUST NOT continue underneath a safety alert.
- **FOUND-MOTION-291.** A safety alert's enter MUST use `SPRING-SAFETY` and MUST complete
  within 200 ms.
- **FOUND-MOTION-292.** After a safety alert is dismissed, non-safety motion MAY resume
  from its paused state, or restart from its current position with preserved velocity.
  It MUST NOT restart from the beginning.
- **FOUND-MOTION-293.** A gesture in progress when a safety alert appears MUST be
  cancelled (zero velocity handoff, `FOUND-MOTION-094`) and the surface returns to its
  last stable position.

---

## 6. What this model refuses (safety)

- An underdamped spring anywhere in an EV or spaceship envelope.
- An overshooting value on a critical indicator.
- A transition that passes through a protected zone.
- Decorative parallax in a safety envelope.
- A safety alert that takes longer than 200 ms to appear.
- A critical indicator that moves to make room for an app surface.
- Reduced motion that disables safety motion.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-050` | Run the EV and spaceship reference flows; every spring uses `SPRING-SAFETY` or stricter; no overshoot is measurable. |
| `AC-FOUND-MOTION-051` | Inject a transition that would cross a protected zone; the authority rejects it; the previous still remains; the protected zone is untouched. |
| `AC-FOUND-MOTION-052` | Trigger a safety alert during a non-safety motion; the non-safety motion yields; the alert appears within 200 ms; after dismissal, motion resumes without a jump. |
| `AC-FOUND-MOTION-053` | Under reduced motion, safety motion is unchanged; critical indicators still animate their declared state changes. |
| `AC-FOUND-MOTION-054` | No critical indicator is occluded at any frame of the safety reference flow at 1 m and 4 m viewing distances. |