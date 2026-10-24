---
id: FOUND-MOTION-TIMELESS-12
title: Timelessness
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, CANON-TIMELESSNESS, LAW-008]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-120, AC-FOUND-MOTION-121]
---

# Timelessness

> A fixed-duration curve is a bet on a specific display, a specific input and a specific
> decade. A spring is a statement about physics. Physics does not change.

---

## 1. Why springs survive

1. **Input independence.** A spring does not care whether it was triggered by a mouse,
   a finger, a crown, a voice command or a remote. It receives a target and an initial
   velocity. The input layer changes; the spring does not.
2. **Display independence.** A spring does not care about the refresh rate, the resolution
   or the panel technology. The fixed simulation step makes it identical across all of
   them (`03-determinism.md`).
3. **Scale independence.** A spring on a watch and a spring on a desktop use the same
   equation; only the parameters differ, and the parameters are tokens, not code.
4. **Decade independence.** The damped harmonic oscillator is not a fashion. It describes
   how humans move (`Flash & Hogan, 1985`) and how objects settle. It will describe the
   same things in twenty years.

---

## 2. What would break timelessness

| Threat | Why it is a threat | Defence |
|---|---|---|
| Fixed durations | A 300 ms fade assumes a 60 Hz display and a specific reading speed | Springs derive duration from physics |
| Device-specific motion | A "phone swipe" that does not work on a crown | Target + velocity model works for any input |
| Decorative motion | A fashion that dates the interface | Motion must explain change; decoration is forbidden |
| Coupled motion | Motion that depends on another surface's state | Springs are independent |
| Vendor guidelines copied | A motion that exists because a platform has it | Every motion cites a human constant |
| Hidden state | A motion that encodes state the person cannot see | State is announced, not only moved |

Rules:

- **FOUND-MOTION-490.** A motion MUST be expressible as a target, an initial velocity,
  a response and a damping. If it cannot, it is not a spring and is forbidden.
- **FOUND-MOTION-491.** A motion MUST NOT depend on a specific input device, display
  rate or resolution.
- **FOUND-MOTION-492.** A motion MUST NOT be added because a platform or vendor has it.
  It must cite a human constant (`ADR-0022`).

---

## 3. The timelessness test

1. Remove the input layer. Can the motion still be triggered with a target and a
   velocity? If yes, it is input-independent.
2. Change the display rate. Does the motion behave identically? If yes, it is
   display-independent.
3. Wait ten years. Does the motion still explain a change? If yes, it is timeless.

- **FOUND-MOTION-500.** A motion that fails the timelessness test MUST be removed or
  re-derived.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-120` | Every motion in the reference set is expressible as target + velocity + response + damping. |
| `AC-FOUND-MOTION-121` | Every motion passes the cross-rate determinism test, so it is display-independent. |