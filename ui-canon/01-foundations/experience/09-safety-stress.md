---
id: FOUND-EXPERIENCE-SAFETY
title: Safety and Stress — Stress, Workload, Fatigue, Emergency, Procedure-Following, Trust Under Pressure
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-SAFETY-CRITICAL, UX-EMOTION]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-SAFETY-001, AC-EXP-SAFETY-002, AC-EXP-SAFETY-003]
---

# Safety and Stress

> Stress, workload, fatigue, emergency, procedure-following, trust under pressure.

## 1. Principle

Under stress, attention narrows, working memory shrinks, and people follow procedures
rather than reason. The system reduces demand, simplifies displays, uses redundant
cues, and supports procedure-following. It never adds urgency decoration. Trust under
pressure is built by predictability and honesty, not by reassurance.

## 2. Rules

1. **Reduce demand under stress.** Spacious mode, fewer visible actions, larger
   targets, bounded motion.
2. **Simplify displays.** Remove non-essential information; highlight the critical.
3. **Redundant cues.** Critical state is shown in more than one channel (visual +
   audio + haptic on safety envelopes).
4. **Procedure-first.** Under high workload, show short, specific, step-confirmed
   procedures.
5. **No urgency decoration.** Urgent colour and motion are reserved for urgent state;
   no pulsing, no shaking.
6. **Bounded motion.** ζ ≥ 1 in safety envelopes; no overshoot.
7. **Critical indicators never animate through occlusion.** Protected zones.
8. **Honesty.** Degraded states are shown as degraded; no fake reassurance.

## 3. Trust under pressure

Trust under pressure is built by:

- Predictability: the system behaves as expected, every time.
- Honesty: degraded states are shown; no false reassurance.
- Reversibility: a way back even in an emergency.
- Redundancy: critical information in more than one channel.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-SAFETY-001` | Stress scenario: task completion holds in spacious mode. |
| `AC-EXP-SAFETY-002` | Critical indicators never occluded in safety flow. |
| `AC-EXP-SAFETY-003` | Procedure-following completes under simulated high workload. |