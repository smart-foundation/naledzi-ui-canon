---
id: FW-TOKENS-MOTION
title: "Motion tokens (TOK-MOTION-*)"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-MOTION-001]
---

# Motion tokens

Named springs by intent, not by number. Values are (response ω, damping ζ, settle bound ε/δ).
Components ask for a named spring; they never hardcode stiffness/damping.

| Token ID | Intent | Response | Damping | Settle bound | Reduced-motion alternative |
|---|---|---|---|---|---|
| `TOK-MOTION-ENTER` | Enter/appear | high | ~0.8 | tight | fade only |
| `TOK-MOTION-MOVE` | Position change | medium | ~0.9 | tight | instant |
| `TOK-MOTION-DISMISS` | Exit/dismiss | medium-high | ~1.0 | tight | fade only |
| `TOK-MOTION-EXPAND` | Disclosure open | medium | ~0.85 | tight | instant height |
| `TOK-MOTION-SCROLL-SETTLE` | Scroll inertia settle | medium | ~0.95 | loose | instant stop |
| `TOK-MOTION-DRAG` | Drag follow | very high | ~0.7 | n/a (active) | n/a |
| `TOK-MOTION-SPRING-SAFETY` | Safety envelopes (EV/spaceship) | bounded | ≥1.0 (over-damped) | tight | minimal travel |
| `TOK-MOTION-ALERT` | Alert appearance | medium | ≥1.0 | tight | fade only |

Additional: `TOK-MOTION-STAGGER-STEP` (delay between items), `TOK-MOTION-DURATION-FADE`
(for non-physical fades), `TOK-MOTION-REDUCED-SCALE` (0 = no travel).

Safety: `ζ ≥ 1` for EV, spaceship, critical indicators (bounded, non-overshooting).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-MOTION-001` | Every motion in the reference set is a named token above. |
| `AC-FW-TOK-MOTION-002` | Safety profiles use over-damped springs. |