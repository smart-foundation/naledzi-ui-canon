---
id: FOUND-MOTION-SPRINGS-01
title: Springs
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX, LAW-004, LAW-007, LAW-008, ADR-0005, ADR-0017]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-010, AC-FOUND-MOTION-011, AC-FOUND-MOTION-012, AC-FOUND-MOTION-013]
---

# Springs

> A spring is the only motion model that can be interrupted without lying. It has a current
> value, a target, a stiffness and a damping, and it carries its velocity forward. A curve has
> a start time and an end time; a spring has a state.

---

## 1. What a spring is

A spring is a second-order dynamical system with a single equilibrium point that moves when
the target changes. It is defined by four quantities and nothing else:

| Quantity | Symbol | Meaning | Unit |
|---|---|---|---|
| Current value | `x` | where the surface is now | px, deg, unitless |
| Target value | `t` | where it is going | same as x |
| Response (natural frequency) | `ω` (omega) | how quickly it reacts | rad/s |
| Damping ratio | `ζ` (zeta) | how much it overshoots | dimensionless |

Velocity `v = dx/dt` is not an input. It is a consequence of `x`, `t`, `ω` and `ζ`, and it
is preserved across every interruption, retarget and frame boundary. **Duration is never an
input.** A spring's duration is whatever its parameters and the distance produce.

The governing equation is the damped harmonic oscillator in standard form:

```
x'' + 2 ζ ω x' + ω² (x - t) = 0
```

where `x''` is acceleration, `x'` is velocity, `ω = sqrt(k/m)` is the natural (response)
frequency, and `ζ = c / (2 sqrt(m k))` is the damping ratio. Equivalently, with stiffness
`k`, mass `m` and damping coefficient `c`:

```
m x'' + c x' + k (x - t) = 0
```

The mass `m` is normalised to 1 in Naledzi; only `ω` and `ζ` are exposed as tokens. The
response time constant is `τ = 1/ω` seconds. A larger `ω` is a stiffer, faster spring.

---

## 2. Damping regimes

The damping ratio determines whether the spring overshoots. This is a property of the
parameters, not of the envelope, and it is the main lever for safety.

| Regime | ζ range | Behaviour | Use |
|---|---|---|---|
| Underdamped | 0 < ζ < 1 | Oscillates around target with decaying amplitude; settles with a visible wobble | Enter/exit of transient surfaces where life is wanted |
| Critically damped | ζ = 1 | Fastest return to target with no overshoot | Move, scroll, gesture settle, default |
| Overdamped | ζ > 1 | Slower, no overshoot, no oscillation | Safety, large travel, reduced-motion substitute |
| Undamped | ζ = 0 | Never settles; oscillates forever | **Forbidden** (`FOUND-MOTION-003`) |

The settling envelope for an underdamped spring is `e^{-ζ ω t}`; the oscillation
frequency is `ω_d = ω sqrt(1 - ζ²)`. The number of visible wobbles before settling is
roughly `1 / (2 π ζ sqrt(1-ζ²))` for small ζ; for ζ above 0.7 the wobble is not
perceptible.

- **FOUND-MOTION-010.** A spring MUST have `ζ > 0`. An undamped spring is forbidden
  because it never settles and violates `LAW-004`.
- **FOUND-MOTION-011.** A spring MUST have `ω > 0` and finite. A zero or infinite
  response is forbidden.
- **FOUND-MOTION-012.** Safety envelopes and critical indicators MUST use `ζ ≥ 1`
  (critically or over-damped). Underdamped motion is forbidden there
  (`ADR-0017`, `FOUND-MOTION-050`).

---

## 3. Integration: how a spring advances

A spring is advanced by a fixed simulation step `Δt_sim = 1/120 s` (see
`03-determinism.md`). The integration method is **semi-implicit (symplectic) Euler**:

```
a  = -ω² (x - t) - 2 ζ ω v
v  = v + a · Δt_sim
x  = x + v · Δt_sim
```

Semi-implicit Euler is chosen because it is symplectic: it conserves energy well enough
that an underdamped spring does not gain amplitude over thousands of steps, and it is
cheap (two multiplies and two adds per axis). Explicit Euler gains energy and explodes;
Verlet is not needed for a first-order-in-velocity system of this size. The method is
fixed by this foundation; an implementation MAY NOT substitute a different integrator
without an ADR and a re-run of the acceptance suite, because the settle times and the
perceived path depend on it.

When the wall-clock elapsed time between frames exceeds `Δt_sim` (slow frame, background
tab, debugger), the engine runs **multiple sub-steps** of `Δt_sim` (clamped to a
maximum of 4 per frame, i.e. 33 ms) and discards the remainder. If more than 4 sub-steps
are needed, the motion is advanced by 4 steps and the lag is absorbed into the render
interpolation; the motion slows slightly but never explodes. See `03-determinism.md` §4.

---

## 4. Retarget: changing the target mid-flight

When the target changes while a spring is in flight, the spring **keeps its current `x`
and `v`** and adopts the new target. It does not restart, does not reset velocity and does
not recompute a duration. This is the single most important property of the model.

```
on retarget(new_t):
    t = new_t
    // x, v unchanged
```

Consequences:

- A menu that is animating open and is dismissed mid-way animates closed from wherever it
  is, at whatever velocity it has. It does not jump to the open position and start a close
  curve.
- A list item that is being dragged and released re-targets the spring to its resting
  position with the release velocity as the initial condition.
- A shared-element transition whose destination moves (window resize, rotation) re-targets
  without a jump.

- **FOUND-MOTION-020.** Retarget MUST preserve `x` and `v`. Resetting either on a
  target change is forbidden.
- **FOUND-MOTION-021.** A retarget MUST NOT produce a discontinuity in `x` or `v` at the
  frame boundary. The first frame after retarget uses the same integration step as any
  other frame.

---

## 5. Velocity preservation across interruption

An interruption is any event that changes what the spring is doing: a new target, a gesture
grab, a state change, a policy change, a focus change. The rule is the same in every case:
**the velocity survives.**

Three cases:

1. **Target change (retarget).** `v` is unchanged (§4).
2. **Gesture grab.** While a pointer or touch holds the surface, the spring is suspended
   and the surface follows the input directly. The input's velocity is measured by a
   filtered differentiator over the last 80 ms. On release, that velocity becomes the
   spring's initial `v`, and the target becomes the resting position. This is the gesture
   handoff; see `02-choreography.md` §4.
3. **State replacement.** If a surface is removed and re-created (for example a list row
   recycled), the new instance does not inherit the old spring's state; the old instance's
   spring must settle or be cancelled first. There is no teleportation of state between
   instances.

- **FOUND-MOTION-030.** A gesture release MUST hand off the measured release velocity to
  the spring as its initial velocity. A release that sets `v = 0` is forbidden.
- **FOUND-MOTION-031.** The release velocity MUST be filtered (low-pass, 80 ms window) to
  remove single-frame noise. An unfiltered single-sample velocity is forbidden.
- **FOUND-MOTION-032.** A grab MUST suspend the spring; the spring MUST NOT continue to
  integrate underneath a held surface.

---

## 6. Settle and stop

A spring that never stops violates idle silence (`LAW-004`) and burns battery forever. Settle
detection is therefore mandatory and conservative.

Settle condition (all must hold for `K = 4` consecutive simulation steps):

```
|x - t| < ε_pos   (position epsilon)
|v|     < ε_vel   (velocity epsilon)
```

Default epsilons (proposed, see `06-tokens.md`):

| Axis type | ε_pos | ε_vel |
|---|---|---|
| Position (px) | 0.5 px | 0.5 px/s |
| Rotation (deg) | 0.1 deg | 0.1 deg/s |
| Opacity / scale (unitless) | 0.005 | 0.005 /s |

When the condition holds, the engine **snaps** `x = t`, `v = 0` and **stops scheduling**
the spring. No further sub-steps run. The surface commits one final still at rest. If a
new target arrives later, the spring restarts from rest with the new target.

- **FOUND-MOTION-040.** A spring MUST stop scheduling once it has settled. Continuing to
  integrate a settled spring is forbidden (`LAW-004`).
- **FOUND-MOTION-041.** Settle MUST snap to the exact target, not to a near value, so that
  two surfaces that share a target end at identical positions.
- **FOUND-MOTION-042.** The settle thresholds MUST be declared per axis type in the token
  file. A spring MUST NOT use an ad hoc threshold.
- **FOUND-MOTION-043.** A spring that has not settled within its declared maximum duration
  (see `06-tokens.md`) MUST be forced to settle and logged as a failure
  (`11-failure.md` §1).

---

## 7. Named springs by intent

Components never request stiffness and damping numbers. They request a named spring by its
intent, and the token file maps the name to `(ω, ζ, settle bound, max duration)`. The
names below are the canonical set; adding a name requires an ADR.

| Name | Intent | Typical ω | Typical ζ | Overshoot? |
|---|---|---|---|---|
| `SPRING-ENTER` | A surface appearing (sheet, dialog, popover) | medium (≈ 18 rad/s) | 0.85 | slight |
| `SPRING-EXIT` | A surface leaving | high (≈ 24 rad/s) | 1.0 | none |
| `SPRING-MOVE` | A surface changing position or size in place | high (≈ 28 rad/s) | 1.0 | none |
| `SPRING-SCROLL` | Scroll position and momentum | very high (≈ 40 rad/s) | 1.0 | none |
| `SPRING-SETTLE` | A released drag returning to rest | medium (≈ 14 rad/s) | 0.9 | slight |
| `SPRING-MAGNIFY` | Strip magnification fan | medium (≈ 16 rad/s) | 0.8 | slight |
| `SPRING-SAFETY` | Any motion in EV/spaceship or on a critical indicator | medium (≈ 12 rad/s) | 1.2 | none |
| `SPRING-REDUCED` | Substitute used under reduced motion | very high (≈ 60 rad/s) | 1.0 | none (near-instant) |
| `SPRING-SPATIAL` | Comfort-bounded motion in a spatial envelope | low (≈ 6 rad/s) | 1.1 | none |

The values are proposals in `06-tokens.md`; the names and their intents are normative. A
component that uses `SPRING-ENTER` for an exit, or `SPRING-SCROLL` for a dialog, is
non-conformant.

- **FOUND-MOTION-050.** A component MUST request motion by named spring. Hard-coded
  `(ω, ζ)` in a component is forbidden.
- **FOUND-MOTION-051.** A named spring MUST be used only for its declared intent. Misuse
  is a conformance failure, not a style issue.
- **FOUND-MOTION-052.** `SPRING-SAFETY` MUST be used for all motion in EV and spaceship
  envelopes and for all motion on or adjacent to a critical indicator. Using a livelier
  spring there is forbidden (`ADR-0017`).
- **FOUND-MOTION-053.** `SPRING-REDUCED` MUST be used as the substitute when reduced
  motion is requested and the motion is not removed entirely.

---

## 8. Multi-axis and coupled springs

A surface that moves in 2D uses two independent springs (x and y) with the same named
spring's parameters. They are integrated independently; there is no coupling term. Rotation
uses its own spring. Scale and opacity use their own springs with the unitless epsilons.

A surface that must keep two points aligned (for example a shared-element transition
where the source and destination rectangles differ in aspect ratio) uses one spring per
animated property (left, top, width, height) with the same parameters, started together.
They settle together because they share parameters and distance scales.

- **FOUND-MOTION-060.** Springs on different axes of one surface MUST use the same named
  spring and start on the same frame, so the motion reads as one gesture.
- **FOUND-MOTION-061.** A spring MUST NOT be coupled to another surface's spring. Coupling
  creates hidden ordering dependencies and breaks interruptibility.

---

## 9. What this model refuses

- A fixed duration as an input. Duration is derived.
- A curve that restarts on interruption.
- A spring with no settle condition.
- A spring that keeps running after it has settled.
- A component that hard-codes stiffness.
- An underdamped spring on a safety surface.
- A spring that is coupled across surfaces.
- A spring whose velocity is discarded on grab or release.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-010` | Retarget a spring mid-flight; `x` and `v` are continuous across the retarget frame; no jump is visible at 120 Hz slow-motion capture. |
| `AC-FOUND-MOTION-011` | Release a dragged surface; the measured release velocity (filtered, 80 ms) becomes the spring's initial velocity; the path matches a reference recording. |
| `AC-FOUND-MOTION-012` | Leave every spring running; each settles and stops scheduling within its declared bound; idle wakeups are zero. |
| `AC-FOUND-MOTION-013` | Request reduced motion; springs use `SPRING-REDUCED` or are removed; no underdamped motion remains on any surface. |