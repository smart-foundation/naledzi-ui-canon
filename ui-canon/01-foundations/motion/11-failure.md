---
id: FOUND-MOTION-FAILURE-11
title: Motion Failure
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, FOUND-MOTION-DETERM-03, FOUND-MOTION-SAFETY-05, LAW-011, LAW-015]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-110, AC-FOUND-MOTION-111, AC-FOUND-MOTION-112, AC-FOUND-MOTION-113]
---

# Motion Failure

> A spring that will not settle is not a minor bug; it is a battery drain and a lie about
> state. Every failure here has a visible or announced consequence and a recovery path.

---

## 1. Spring that will not settle

**Cause:** parameters too soft (low ω, low ζ), distance too large, or a retarget that
keeps moving the target.

**Behaviour:**

1. The spring integrates up to its hard max duration (`06-tokens.md` §4).
2. If it has not settled by then, the engine forces `x = t`, `v = 0` and stops
   scheduling.
3. The force-settle is logged as a failure with the spring name, the axis, the distance
   and the parameters.
4. The surface commits one final still at the target.

Rules:

- **FOUND-MOTION-430.** A spring MUST be force-settled at its hard max. It MUST NOT run
  indefinitely.
- **FOUND-MOTION-431.** A force-settle MUST be logged. A silent force-settle is forbidden
  (`LAW-011`).
- **FOUND-MOTION-432.** A spring that is force-settled more than once per session on the
  same surface SHOULD trigger a review of its parameters or the distance.

---

## 2. Interrupted gesture

**Cause:** pointer or touch cancelled by the system (incoming call, safety alert, focus
loss, app crash) mid-gesture.

**Behaviour:**

1. The gesture is cancelled; the surface receives a zero-velocity handoff
   (`FOUND-MOTION-094`).
2. The surface returns to its last stable position with `SPRING-SETTLE` (or
   `SPRING-REDUCED` under reduced motion).
3. The cancellation is logged.
4. If a safety alert caused the cancellation, safety motion takes precedence
   (`FOUND-MOTION-293`).

Rules:

- **FOUND-MOTION-440.** A cancelled gesture MUST hand off with `v = 0` and return to the
  last stable position. Continuing the gesture's motion is forbidden.
- **FOUND-MOTION-441.** A gesture cancellation MUST be announced to assistive paths if
  it changes focus or state.

---

## 3. Capture lease expiry

**Cause:** an input lease (pointer, touch, focus) expires while a spring is in flight or
a gesture is active. This is a presentation-authority concern (`LAW-006`), but motion
must behave correctly when it happens.

**Behaviour:**

1. If a gesture is active when the lease expires, the gesture is cancelled (§2) and the
   surface returns to its last stable position.
2. If a spring is in flight (not gesture-driven), it continues to settle; the lease
   expiry does not cancel it, because the spring is not input-owned.
3. The surface's motion state is committed in the next still after the lease expiry, so
   that observers see a consistent truth.

Rules:

- **FOUND-MOTION-450.** A gesture-driven motion MUST be cancelled when its input lease
  expires. A spring that is not input-driven MUST continue to settle.
- **FOUND-MOTION-451.** Lease expiry MUST NOT produce a jump in any committed still.

---

## 4. Timer drift

**Cause:** the wall-clock or the display cadence drifts (thermal throttling, background
tab, debugger attached, low-power mode).

**Behaviour:**

1. The accumulator clamps frame time to 33.33 ms (`FOUND-MOTION-142`), so a single
   long frame does not explode the spring.
2. If drift is sustained (more than 4 clamped frames in a row), the engine logs a
   warning and continues to integrate at 120 Hz in the background; the display commits
   fewer frames.
3. The spring still settles within its hard max wall-clock time, because the simulation
   runs at 120 Hz regardless of display cadence (`FOUND-MOTION-152`).
4. On e-ink or sub-60 Hz displays, motion is discouraged and uses `SPRING-REDUCED`.

Rules:

- **FOUND-MOTION-460.** Sustained frame drops MUST be logged, not hidden.
- **FOUND-MOTION-461.** A spring MUST NOT accumulate unbounded time. The accumulator
  MUST be clamped and reset on settle.
- **FOUND-MOTION-462.** On a display below 60 Hz, non-essential motion MUST be disabled
  automatically and the reason logged.

---

## 5. Other failure cases

| Failure | Visible result | Required behaviour |
|---|---|---|
| NaN or infinity in spring state | Surface at wrong position | Guard ω against zero; clamp distance; log; force-settle |
| Spring state overflow | Surface teleports | Clamp |x-t| to 10 000 px; log |
| Missing spring token | Component cannot animate | Fall back to `SPRING-REDUCED`; log; component still functions |
| Reduced-motion toggle mid-flight | Motion must stop | Settle current spring; do not restart with new parameters |
| Safety alert during motion | Non-safety motion yields | Safety motion runs; non-safety resumes or cancels with velocity preservation |
| Display disconnect mid-motion | Commit stops | Simulation continues in background; on reconnect, commit current interpolated state |
| Remote output lag | Motion stutters | Use `SPRING-REDUCED`; never drop frames silently |

Rules:

- **FOUND-MOTION-470.** A missing spring token MUST fall back to `SPRING-REDUCED` and
  log. A crash is forbidden.
- **FOUND-MOTION-471.** A NaN in spring state MUST be caught before commit. The
  previous still remains.
- **FOUND-MOTION-472.** A display disconnect MUST NOT lose motion state. On reconnect,
  the current interpolated state is committed.

---

## 6. Recovery

- **FOUND-MOTION-480.** After any failure, the surface MUST end at a declared, stable
  state (settled at target, or last stable position for a cancelled gesture).
- **FOUND-MOTION-481.** A failure MUST leave the accessibility snapshot consistent with
  the pixels in the same still.
- **FOUND-MOTION-482.** A failure MUST be recoverable without a restart: the next motion
  on the same surface starts from the settled state.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-110` | Force a spring to not settle (soft params, large distance); it force-settles at hard max and logs; final position is the target. |
| `AC-FOUND-MOTION-111` | Cancel a gesture mid-flight via a system event; the surface returns to its last stable position without a jump. |
| `AC-FOUND-MOTION-112` | Expire an input lease during a gesture; the gesture cancels; a spring in flight continues to settle. |
| `AC-FOUND-MOTION-113` | Sustain a 50 ms frame drop for 2 seconds; the spring settles within its hard max; no NaN; a warning is logged. |
| `AC-FOUND-MOTION-114` | Disconnect and reconnect a display during motion; on reconnect, the current interpolated state is committed. |