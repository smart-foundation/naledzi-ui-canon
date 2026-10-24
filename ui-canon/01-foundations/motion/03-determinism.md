---
id: FOUND-MOTION-DETERM-03
title: Determinism
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-SPRINGS-01, FOUND-MOTION-INDEX, LAW-004, LAW-008, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-030, AC-FOUND-MOTION-031, AC-FOUND-MOTION-032, AC-FOUND-MOTION-033]
---

# Determinism

> A spring that settles in 320 ms on a 60 Hz display and 290 ms on a 120 Hz display is not
> one spring. It is two. Determinism is what makes a spring a spring across devices.

---

## 1. The problem

Naive animation advances by the wall-clock delta between frames. On a 60 Hz display that
delta is ~16.67 ms; on a 120 Hz display it is ~8.33 ms. Two consequences:

1. The same spring with the same parameters settles in a different number of frames and
   a different wall-clock time, because the integrator's per-step error differs with step
   size.
2. A slow frame (GC, tab switch, debugger) makes the step huge, which can make a spring
   explode or teleport.

Both are unacceptable for a system that ships on watches, phones, TVs, EVs and spacecraft
with different refresh rates and different load profiles.

---

## 2. The solution: fixed simulation timestep

The motion engine runs its simulation at a **fixed step** `Δt_sim = 1/120 s` (8.333 ms),
independent of the display's refresh rate and independent of wall-clock jitter. The
display's refresh rate only determines how often the *rendered* (interpolated) state is
sampled and committed.

```text
accumulator = 0
last_time   = now()
loop:
    now_time   = now()
    frame_time = clamp(now_time - last_time, 0, MAX_FRAME_TIME)   // MAX = 33.33 ms (4 steps)
    last_time  = now_time
    accumulator += frame_time
    while accumulator >= Δt_sim:
        integrate_one_step(Δt_sim)   // semi-implicit Euler, 01-springs.md §3
        accumulator -= Δt_sim
    alpha = accumulator / Δt_sim     // 0..1
    render_state = lerp(prev_state, curr_state, alpha)
    commit_still(render_state)
```

Rules:

- **FOUND-MOTION-140.** The simulation step MUST be fixed at `1/120 s`. It MUST NOT vary
  with the display refresh rate or the wall-clock delta.
- **FOUND-MOTION-141.** Wall-clock time MUST enter the simulation only through the
  accumulator. The integrator MUST NOT see a variable delta.
- **FOUND-MOTION-142.** A frame longer than `MAX_FRAME_TIME` (33.33 ms) MUST be clamped.
  The simulation runs 4 steps and the remainder is absorbed into interpolation. The
  motion slows slightly; it does not explode.
- **FOUND-MOTION-143.** The accumulator MUST be reset to 0 when the motion settles, so
  that no pending time is carried into the next motion.

---

## 3. Render interpolation

The display may refresh at 60, 90, 120 or 144 Hz (or other rates on exotic hardware). The
committed still uses the interpolated state between the last two simulation steps:

```
rendered_x = prev_x + (curr_x - prev_x) * alpha
rendered_v = prev_v + (curr_v - prev_v) * alpha
```

where `alpha = accumulator / Δt_sim`. This gives sub-frame smoothness on a 144 Hz display
while the simulation stays at 120 Hz. The interpolation is linear in state, which is
correct for the small deltas involved (8.33 ms).

Rules:

- **FOUND-MOTION-150.** The committed still MUST use the interpolated state, not the raw
  simulation state, so that motion is smooth at refresh rates above 120 Hz.
- **FOUND-MOTION-151.** The interpolation MUST be applied to position, velocity, opacity
  and scale independently, using the same `alpha`.
- **FOUND-MOTION-152.** A display whose refresh rate is below 120 Hz (for example a 60 Hz
  watch) commits a subset of the simulation steps. The simulation still runs at 120 Hz
  in the background when motion is active; when motion is settled, it stops.

---

## 4. Frame budget

Motion is not free. Every active spring costs integration and commit work. The budget is
per frame, on the weakest supported envelope.

| Cost | Budget per frame (watch, weakest) | Budget per frame (desktop) |
|---|---|---|
| Simulation (all active springs) | ≤ 0.4 ms CPU | ≤ 0.6 ms CPU |
| Interpolation + commit | ≤ 0.2 ms CPU | ≤ 0.3 ms CPU |
| Total motion cost | ≤ 0.6 ms | ≤ 0.9 ms |

Rules:

- **FOUND-MOTION-160.** The number of simultaneously animating springs on one surface MUST
  be bounded by the token-declared maximum (default 4 properties per surface).
- **FOUND-MOTION-161.** If the frame budget is exceeded, the degradation ladder in
  `10-performance.md` applies: reduce motion → shorten springs → disable parallax →
  instant. Motion MUST NOT be allowed to drop the whole frame rate silently.
- **FOUND-MOTION-162.** Idle surfaces (no active spring) MUST schedule zero motion work
  (`LAW-004`).

---

## 5. Refresh-rate coverage

The supported refresh rates are 60, 90, 120 and 144 Hz. Exotic rates (for example 240 Hz
gaming panels, or 30 Hz e-ink) are handled by the same algorithm: the simulation stays at
120 Hz and the display samples more or fewer frames.

| Display rate | Simulation steps per display frame | Commit cadence |
|---|---|---|
| 60 Hz | 2 | every display frame |
| 90 Hz | 1.33 (interpolated) | every display frame |
| 120 Hz | 1 | every display frame |
| 144 Hz | 0.83 (interpolated) | every display frame |
| 30 Hz (e-ink) | 4 | every 4th simulation step; motion is discouraged |
| 240 Hz | 0.5 (interpolated) | every display frame |

Rules:

- **FOUND-MOTION-170.** A display rate below 60 Hz (for example e-ink) SHOULD avoid motion
  entirely; any motion used MUST be `SPRING-REDUCED` and the settle must be visible.
- **FOUND-MOTION-171.** A display rate above 144 Hz MUST NOT change the simulation step.
  More samples of the same 120 Hz simulation is the only permitted behaviour.

---

## 6. How to test identically across rates

A motion is deterministic if, given the same starting state, target, spring parameters and
input sequence, it produces the same final state and the same settle time on every supported
refresh rate. The test procedure:

1. Record the input sequence (pointer positions, timestamps) at the source rate.
2. Replay it through the motion engine at each target refresh rate, using the fixed 120 Hz
   simulation.
3. Compare the final `x`, `v` (must be 0 after settle) and the settle wall-clock time.
4. Pass condition: final `x` within `ε_pos` (0.5 px) of the reference, settle time within
   8 ms (one simulation step) of the reference, and no visible jump at any frame.

The test harness MUST be able to force the engine into each refresh-rate mode without
changing the hardware, by overriding the display cadence and the commit clock.

- **FOUND-MOTION-180.** Every named spring MUST pass the cross-rate determinism test at
  60, 90, 120 and 144 Hz before it can be used in a component.
- **FOUND-MOTION-181.** A spring that passes at 120 Hz but fails at 60 Hz is
  non-conformant. There is no "acceptable on high-refresh displays only" motion.
- **FOUND-MOTION-182.** The test MUST be automated and run in CI on every change to the
  motion engine or to a spring token.

---

## 7. Numerical stability

- **FOUND-MOTION-190.** All spring state MUST be stored as `f64` (double precision). `f32`
  accumulates visible drift over long sessions.
- **FOUND-MOTION-191.** Time values MUST be stored as integer microseconds internally and
  converted to seconds only at the integrator boundary, to avoid floating-point
  accumulation in the accumulator.
- **FOUND-MOTION-192.** A spring whose `|x - t|` exceeds 10 000 px MUST be clamped to
  that distance before integration, to prevent overflow on degenerate inputs. The clamp
  MUST be logged.
- **FOUND-MOTION-193.** Division by zero in the integration is impossible by construction
  (`ω > 0`), but an implementation MUST still guard `ω` against a zero token and fail
  loudly rather than produce NaN.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-030` | Run the same motion at 60, 90, 120 and 144 Hz; final position within 0.5 px and settle time within 8 ms of the 120 Hz reference. |
| `AC-FOUND-MOTION-031` | Inject a 50 ms frame stall during a motion; the spring advances 4 steps and absorbs the rest; no explosion, no teleport, no NaN. |
| `AC-FOUND-MOTION-032` | Leave a motion running for 10 minutes on a 60 Hz display; no drift in settle position; no accumulated error above 0.5 px. |
| `AC-FOUND-MOTION-033` | An idle surface schedules zero motion work; measured wakeups are zero over 10 minutes. |