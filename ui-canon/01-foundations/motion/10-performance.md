---
id: FOUND-MOTION-PERF-10
title: Motion Performance
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-DETERM-03, FOUND-MOTION-TOKENS-06, LAW-004, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-100, AC-FOUND-MOTION-101, AC-FOUND-MOTION-102, AC-FOUND-MOTION-103]
---

# Motion Performance

> Motion is a feature with a cost. The cost is small when it is designed in and large
> when it is not. The degradation ladder exists so that a slow device degrades honestly
> rather than dropping frames.

---

## 1. What motion costs

| Cost | Per active spring per frame | Notes |
|---|---|---|
| Integration (semi-implicit Euler) | ~0.02 ms CPU | 2 mul + 2 add per axis |
| Interpolation + commit | ~0.01 ms CPU | lerp + still commit |
| Render (compositor) | ~0.05 ms GPU/CPU | Damage is limited to the moving surface |
| Total per spring | ~0.08 ms | On the weakest envelope |

With the default cap of 4 animating properties per surface, one animating surface costs
~0.32 ms per frame. Ten animating surfaces cost ~3.2 ms, which exceeds the watch budget
and triggers degradation.

Rules:

- **FOUND-MOTION-380.** The number of simultaneously animating springs on one surface
  MUST be bounded by the token-declared maximum (default 4).
- **FOUND-MOTION-381.** Damage MUST be limited to the animating surface and its declared
  dependants. A motion MUST NOT force a full-surface redraw.
- **FOUND-MOTION-382.** Motion MUST NOT allocate per frame. All spring state is
  pre-allocated and reused.

---

## 2. Idle cost

Idle is silent (`LAW-004`). A surface with no active spring schedules nothing.

| State | Motion wakeups per minute | GPU time per minute |
|---|---|---|
| No motion active | 0 | 0 |
| Motion active, settling | 120 (simulation steps) | per commit |
| Motion active, settled | 0 (stopped) | 0 |

Rules:

- **FOUND-MOTION-390.** A settled spring MUST stop scheduling. No timer, no wakeup, no
  redraw.
- **FOUND-MOTION-391.** A surface that has never moved MUST NOT have a motion scheduler
  attached.
- **FOUND-MOTION-392.** The motion engine MUST report its idle cost in the performance
  audit. A non-zero idle cost is a defect.

---

## 3. The degradation ladder

When the frame budget is exceeded, motion degrades in this order, and only this order:

1. **Reduce motion** — honour the reduced-motion setting if it is set (this is not a
   degradation, it is a preference; check it first).
2. **Shorten springs** — use `SPRING-REDUCED` (ω ≈ 60, ζ = 1) for non-safety motion.
   Travel shrinks; state changes remain.
3. **Disable parallax** — remove parallax entirely (depth owns the parallax; motion
   removes the scheduling).
4. **Instant** — remove all non-safety motion; state changes are instant.

Safety motion (`SPRING-SAFETY`) is never degraded. It is the last thing to remain.

Rules:

- **FOUND-MOTION-410.** Degradation MUST follow the ladder in order. Skipping a step is
  forbidden.
- **FOUND-MOTION-411.** Degradation MUST be declared and observable. A motion that
  silently disappears is a defect (`LAW-011`).
- **FOUND-MOTION-412.** Safety motion MUST NOT be degraded. If the budget cannot
  accommodate safety motion, the design is not finished.
- **FOUND-MOTION-413.** Degradation MUST be reversible: when the budget recovers, motion
  returns to its declared level.

---

## 4. Measurement

| Metric | Method | Pass condition |
|---|---|---|
| Motion CPU per frame | Profiler on reference surfaces | ≤ 0.6 ms on watch, ≤ 0.9 ms on desktop |
| Motion GPU per frame | GPU trace | ≤ 0.2 ms additional over static |
| Idle wakeups | 10-minute idle test | 0 |
| Damage scope | Damage trace during motion | Limited to animating surface |
| Allocation | Heap profiler during motion | 0 allocations per frame |

Rules:

- **FOUND-MOTION-420.** Motion performance MUST be measured on the weakest supported
  envelope, not the development machine (`LAW-016`).
- **FOUND-MOTION-421.** A motion that fails its budget MUST be redesigned or degraded,
  not shipped with a note.

---

## 5. What this model refuses

- A motion that allocates per frame.
- A motion that forces a full-surface redraw.
- A degradation that skips a step or hides the change.
- A safety motion that is degraded.
- An idle surface that schedules motion work.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-100` | Motion CPU per frame ≤ 0.6 ms on the watch reference; ≤ 0.9 ms on desktop. |
| `AC-FOUND-MOTION-101` | Idle surfaces schedule zero motion work over 10 minutes. |
| `AC-FOUND-MOTION-102` | Damage during motion is limited to the animating surface. |
| `AC-FOUND-MOTION-103` | Under load, degradation follows the ladder in order and is observable. |