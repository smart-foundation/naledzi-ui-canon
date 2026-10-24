---
id: FOUND-EXPERIENCE-FELT
title: Felt Experience — Intended Feelings and How They Are Produced and Tested
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-EMOTION, UX-TRUST]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-FELT-001, AC-EXP-FELT-002, AC-EXP-FELT-003]
---

# Felt Experience

> What the person should feel, how each feeling is produced, and how it is tested
> without faking it.

## 1. Intended feelings

The six intended feelings of Naledzi OS are: **calm, confident, in control, respected,
capable, unhurried.** They are not marketing words. Each is produced by a specific,
testable design property and fails a specific test if absent.

| Feeling | Produced by | Tested by |
|---|---|---|
| Calm | Idle silence (`LAW-004`); bounded, settling motion; no decoration; quiet hours; spacious default on large envelopes | Idle test: one hour, zero wakeups, zero redraws |
| Confident | Honest state; visible cause of every change; a recovery path for every failure; no fake success | Failure test: deny, disconnect, remove, fill disk |
| In control | Reversibility (`LAW-015`); direct manipulation; no silent background action; visible effect of every action | Reversibility test: undo, kill mid-action, crash recovery |
| Respected | No blame in errors; privacy by default; no surveillance; no dark patterns | Persona acceptance scenarios; ethics review |
| Capable | Progressive disclosure; recognition over recall; first success without a manual; feedback on every action | First-contact test: primary action in < 5 s |
| Unhurried | Spacious density; no urgency decoration; no countdowns; no forced tours | Stress scenario test; task-completion under load |

## 2. How calm is produced

Calm is the absence of unnecessary demand. It is produced by:

- **Idle silence.** A surface that has not changed sends nothing and schedules nothing
  (`LAW-004`). No heartbeat, no polling, no redraw to look alive.
- **Bounded motion.** Every motion settles and stops (`FOUND-MOTION-003`). No infinite
  loops, no decorative animation.
- **No decoration.** Every element earns its place (`LAW-010`). Empty space is not a
  defect.
- **Quiet hours and notification budgets.** Attention is not spent on the system's
  behalf (`LAW-020`).
- **Spacious default on large envelopes.** More space, fewer visible actions, calmer
  hierarchy.

Calm is destroyed by: heartbeat animations, badge counts that never clear, urgent
colours used for non-urgent state, and any motion that does not explain a change.

## 3. How confidence is produced

Confidence is the belief that the system is telling the truth and that the person can
recover. It is produced by:

- **Honest state.** Unsupported, denied, unknown, stale and degraded states are shown as
  such (`LAW-011`). `NOT REPORTED` is a valid answer.
- **Visible cause.** Every change that matters is motion-explained or announced
  (`LAW-008`, `01-perception.md`).
- **Recovery path.** Every failure names the cause and the recovery
  (`05-error-recovery.md`).
- **No fake success.** The system never fabricates data or aliveness.

## 4. How control is produced

Control is the feeling that the person, not the system, is driving. It is produced by:

- **Direct manipulation.** Effects are visible immediately (`06-learning.md`).
- **Reversibility.** Undo where possible; confirmation for the irreversible
  (`LAW-015`).
- **No silent action.** Nothing happens to the person's data in the background without
  their knowledge and consent (`LAW-020`).
- **Explicit capability grants.** Observation capabilities are off by default and
  revocable.

## 5. How respect is produced

Respect is the absence of shame, blame and surveillance. It is produced by:

- **No blame in errors.** Messages name the cause and the recovery, never the person
  (`05-error-recovery.md`).
- **Privacy by default.** Data and attention are the person's (`LAW-020`).
- **Dignity across cultures.** No single culture is the default; dignity is not a
  locale (`07-culture-language.md`).
- **No dark patterns.** No nagging, no forced consent, no hidden costs.

## 6. How capability is produced

Capability is the feeling of being able to do the task. It is produced by:

- **Progressive disclosure.** Simple default; advanced on demand (`06-learning.md`).
- **Recognition over recall.** Visible options, labelled actions, palette by name.
- **First success without a manual.** Onboarding is learn-by-doing
  (`04-onboarding.md`).
- **Feedback on every action.** Silent actions cannot be learned.

## 7. How unhurried is produced

Unhurried is the absence of artificial urgency. It is produced by:

- **Spacious density.** More space, fewer visible actions, calmer hierarchy
  (`09-research/ux/13-spacious.md`).
- **No urgency decoration.** Urgent colour is reserved for urgent state.
- **No countdowns without necessity.** Timers are shown only when the task requires
  them.
- **No forced tours.** The person moves at their own pace.

## 8. What is intentionally absent

- A "delight" feature list. Delight is friction removal, not a feature.
- A mood board. Feelings are produced by properties, not by aesthetics.
- A single global density. Density is per-envelope and per-person.

## 9. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-FELT-001` | Idle test passes for every reference screen (zero wakeups, zero redraws). |
| `AC-EXP-FELT-002` | Failure test passes: deny, disconnect, remove, fill disk — every state honest. |
| `AC-EXP-FELT-003` | First-contact test: primary action discovered in < 5 s on every reference screen. |