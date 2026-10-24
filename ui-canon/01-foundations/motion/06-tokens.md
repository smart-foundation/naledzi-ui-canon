---
id: FOUND-MOTION-TOKENS-06
title: Motion Tokens
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-SPRINGS-01, FOUND-MOTION-INDEX, FOUND-DEPTH-TOKENS-08, LAW-008, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-060, AC-FOUND-MOTION-061, AC-FOUND-MOTION-062]
---

# Motion Tokens

> Tokens are the proposed values. The foundation states what a value means and when it is
> legal; the token file states the number. A token without a foundation rule is
> decoration; a foundation rule without a token is unimplementable.

**Status:** proposed. These IDs and values are proposals for `03-framework/tokens/`. They are
not minted in the shared token index by this subtree. Values are in CSS/engine units and
are given as ranges where the exact value is envelope-dependent.

---

## 1. Named spring tokens

Each token maps to `(ω rad/s, ζ, ε_pos, ε_vel, max_duration_ms)`. Values are proposals.

| Token | Intent | ω (rad/s) | ζ | ε_pos | ε_vel | max (ms) |
|---|---|---|---|---|---|---|
| `TOK-MOTION-SPRING-ENTER` | Surface appearing | 18 | 0.85 | 0.5 px | 0.5 px/s | 600 |
| `TOK-MOTION-SPRING-EXIT` | Surface leaving | 24 | 1.00 | 0.5 px | 0.5 px/s | 400 |
| `TOK-MOTION-SPRING-MOVE` | Position/size change in place | 28 | 1.00 | 0.5 px | 0.5 px/s | 300 |
| `TOK-MOTION-SPRING-SCROLL` | Scroll position and momentum | 40 | 1.00 | 0.5 px | 0.5 px/s | 200 |
| `TOK-MOTION-SPRING-SETTLE` | Released drag returning to rest | 14 | 0.90 | 0.5 px | 0.5 px/s | 800 |
| `TOK-MOTION-SPRING-MAGNIFY` | Strip magnification fan | 16 | 0.80 | 0.5 px | 0.5 px/s | 500 |
| `TOK-MOTION-SPRING-SAFETY` | Safety envelopes and critical indicators | 12 | 1.20 | 0.5 px / 1 unit | 0.5 /s | 400 |
| `TOK-MOTION-SPRING-REDUCED` | Substitute under reduced motion | 60 | 1.00 | 0.5 px | 0.5 px/s | 100 |
| `TOK-MOTION-SPRING-SPATIAL` | Comfort-bounded spatial motion | 6 | 1.10 | 1 deg / 2 px | 1 /s | 1000 |
| `TOK-MOTION-SPRING-VALUE` | A numeric value ticking | 20 | 1.00 | 1 unit | 1 unit/s | 300 |

Rules:

- **FOUND-MOTION-300.** A spring token MUST declare `ω`, `ζ`, `ε_pos`, `ε_vel` and
  `max_duration_ms`. A token missing any field is incomplete.
- **FOUND-MOTION-301.** A spring token's `ζ` MUST be > 0. A token with `ζ ≤ 0` is
  invalid.
- **FOUND-MOTION-302.** `TOK-MOTION-SPRING-SAFETY` MUST have ζ ≥ 1.2. A value below
  1.2 is invalid.

---

## 2. Axis and property tokens

| Token | Value | Meaning |
|---|---|---|
| `TOK-MOTION-EPS-POS-PX` | 0.5 px | Position settle epsilon |
| `TOK-MOTION-EPS-POS-DEG` | 0.1 deg | Rotation settle epsilon |
| `TOK-MOTION-EPS-UNIT` | 0.005 | Opacity/scale settle epsilon |
| `TOK-MOTION-EPS-VEL-PX` | 0.5 px/s | Velocity settle epsilon |
| `TOK-MOTION-SIM-STEP` | 1/120 s | Fixed simulation step |
| `TOK-MOTION-MAX-FRAME` | 33.33 ms | Maximum frame time (4 steps) |
| `TOK-MOTION-SETTLE-FRAMES` | 4 | Consecutive steps required for settle |
| `TOK-MOTION-THROW-THRESHOLD` | 400 px/s | Velocity above which a release becomes a flick |
| `TOK-MOTION-VELOCITY-WINDOW` | 80 ms | Window for release-velocity filtering |
| `TOK-MOTION-STAGGER-DELAY` | 40 ms (range 20–60) | Delay between staggered items |
| `TOK-MOTION-ENTER-OPACITY-DURATION` | 120 ms | Reduced-motion enter fade |
| `TOK-MOTION-EXIT-OPACITY-DURATION` | 80 ms | Reduced-motion exit fade |
| `TOK-MOTION-SAFETY-APPEAR` | 200 ms | Safety alert appear cap |
| `TOK-MOTION-TRAVEL-MAX-PCT` | 25% | Maximum viewport travel per motion |
| `TOK-MOTION-COMBINED-DISPLACEMENT` | 4 px | Combined displacement threshold (with scale) |
| `TOK-MOTION-COMBINED-SCALE` | 0.5% | Combined scale threshold (with displacement) |

---

## 3. Per-envelope mapping

Not every spring is legal on every envelope. The table states which springs are available
and any envelope-specific override.

| Envelope | Available springs | Overrides |
|---|---|---|
| Watch | ENTER, EXIT, MOVE, SETTLE, REDUCED | ω capped at 24; no MAGNIFY, no STAGGER above 3 items, no SCROLL momentum |
| Phone | All | none |
| Tablet | All | none |
| Desktop | All | none |
| TV | ENTER, EXIT, MOVE, REDUCED | No SCROLL momentum; focus-led; no MAGNIFY; stagger delay 60 ms |
| EV | SAFETY, REDUCED | All other springs forbidden; ω ≤ 12; ζ ≥ 1.2 |
| Spaceship | SAFETY, REDUCED | All other springs forbidden; deterministic timing; no MAGNIFY |
| IoT | REDUCED only | Motion discouraged; instant preferred |
| Spatial | SPATIAL, ENTER, EXIT, REDUCED | Comfort bounds; ω ≤ 6 for world-locked; no SCROLL |
| Remote browser | REDUCED, ENTER, EXIT | ω ≤ 18; no MAGNIFY; no parallax; jitter-tolerant |

Rules:

- **FOUND-MOTION-310.** An envelope MUST NOT use a spring that is not in its available
  set. Using `SPRING-MAGNIFY` on a TV is forbidden.
- **FOUND-MOTION-311.** An EV or spaceship envelope MUST use only `SPRING-SAFETY` and
  `SPRING-REDUCED`. Any other spring there is a safety defect.
- **FOUND-MOTION-312.** An envelope that overrides a value MUST declare the override in
  its envelope file. A silent override is a defect.

---

## 4. Duration bounds

Springs do not take a duration input, but they have expected settle bounds. These bounds
are the acceptance thresholds, not inputs.

| Spring | Expected settle (ms) | Hard max (ms) |
|---|---|---|
| ENTER | 250–400 | 600 |
| EXIT | 150–250 | 400 |
| MOVE | 100–200 | 300 |
| SCROLL | 50–150 | 200 |
| SETTLE | 300–500 | 800 |
| MAGNIFY | 200–350 | 500 |
| SAFETY | 150–300 | 400 |
| REDUCED | ≤ 50 | 100 |
| SPATIAL | 500–800 | 1000 |
| VALUE | 150–250 | 300 |

- **FOUND-MOTION-320.** A spring that has not settled by its hard max MUST be forced to
  settle and logged as a failure (`11-failure.md` §1).
- **FOUND-MOTION-321.** A spring that consistently settles above its expected range
  SHOULD trigger a review of the parameters or the distance.

---

## 5. What this model refuses

- A duration input on a spring.
- A token without a foundation rule.
- A spring available on an envelope where it is not declared.
- An override that is not declared in the envelope file.
- A safety spring with ζ < 1.2.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-060` | Every named spring token declares all five fields; a conformance script reports zero incomplete tokens. |
| `AC-FOUND-MOTION-061` | Every envelope uses only its declared available set; a conformance script reports zero violations. |
| `AC-FOUND-MOTION-062` | Every spring settles within its hard max on the reference surfaces; a spring that exceeds it is logged as a failure. |><|start|><|start|>write to=assistant<|channel|>analysis<|message|>Created file successfully: naledzi/docs/ui-canon/01-foundations/motion/06-tokens.md