---
id: UX-EMOTION
title: Emotion — Affect, Stress, Confidence, Calm Technology, Flow, Delight, Dignity, Loss of Control
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-COGNITION, UX-MOTOR]
supersedes: []
superseded_by: []
acceptance: [AC-UX-EMOTION-001, AC-UX-EMOTION-002, AC-UX-EMOTION-003]
---

# Emotion

> What the person should feel, how each feeling is produced, and how it is tested without
> faking it. Emotion is not decoration; it is the outcome of the design.

## 1. Principle

Emotion is information. Affect shapes cognition: positive affect broadens attention and
supports creative problem-solving; stress and negative affect narrow attention and
increase error. Calm technology informs without demanding. Flow is the state of
absorbed, skilful action. Delight is earned by removing friction, not by adding
surprise. Dignity is the absence of blame, shame and surveillance. Loss of control —
the feeling that the system is acting on its own — destroys trust and must be designed
out.

## 2. Evidence

### 2.1 Affect and cognition

- **Fredrickson, B. L. (2001).** "The role of positive emotions in positive psychology:
  the broaden-and-build theory of positive emotions." *American Psychologist*, 56(3),
  pp. 218–226. (URL: https://doi.org/10.1037/0003-066X.56.3.218 ; accessed
  23 October 2026.) Finding: positive affect broadens the thought-action repertoire;
  negative affect narrows it. Limit: effect sizes are modest and context-dependent.
  Implication: a calm, confident interface supports exploration and recovery; a
  stressed user needs a narrower, simpler surface (spacious, fewer actions).

- **Schwarz, N. (2000).** "Emotion, cognition, and decision making." *Cognition and
  Emotion*, 14(4), pp. 433–440. (URL: https://doi.org/10.1080/026999300402745 ;
  accessed 23 October 2026.) Finding: affect is used as information in judgement;
  misattribution is common. Implication: the interface must not manufacture false
  affect (fake success, fake aliveness); honesty is the affective baseline
  (`LAW-011`).

### 2.2 Stress and workload

- **Hancock, P. A. and Warm, J. S. (1989).** "A dynamic model of stress and sustained
  attention." *Human Factors*, 31(5), pp. 519–537. (URL:
  https://doi.org/10.1177/001872088903100503 ; accessed 23 October 2026.) Finding:
  stress (too little or too much) degrades sustained attention; there is an optimal
  arousal band. Implication: Naledzi reduces demand under stress (spacious, fewer
  actions, larger targets) and never adds urgency decoration; emergency states use
  bounded, non-overshooting motion (`FOUND-MOTION-05`).

- **Staal, M. A. (2004).** *Stress, Cognition, and Human Performance: A Literature
  Review and Conceptual Framework.* NASA Technical Memorandum NASA/TM-2004-212824.
  (URL: https://ntrs.nasa.gov/citations/20040084465 ; accessed 23 October 2026.)
  Finding: stress impairs working memory, attention and decision-making; training and
  procedure-following mitigate. Implication: safety envelopes (EV, spaceship) use
  procedure-first displays and redundant cues; see `08-safety-critical.md`.

### 2.3 Calm technology

- **Weiser, M. and Brown, J. S. (1997).** "The coming age of calm technology." In
  *Beyond Calculation*, P. J. Denning and R. M. Metcalfe (eds.), Springer, pp. 75–85.
  (URL: https://doi.org/10.1007/978-1-4612-0685-9_6 ; accessed 23 October 2026.)
  Finding: technology should inform without demanding attention; the periphery is the
  right place for ambient information. Implication: Naledzi's status rail is adaptive
  and collapses; notifications are budgeted; idle is silent (`LAW-004`, `LAW-020`).

- **Weiser, M. (1991).** "The computer for the 21st century." *Scientific American*,
  265(3), pp. 94–104. (URL: https://doi.org/10.1038/scientificamerican0991-94 ;
  accessed 23 October 2026.) Finding: ubiquitous computing should be invisible until
  needed. Implication: no permanent chrome without a timeless job (`LAW-010`).

### 2.4 Flow

- **Csikszentmihalyi, M. (1990).** *Flow: The Psychology of Optimal Experience.*
  Harper & Row. (URL: https://www.worldcat.org/title/flow/oclc/21197513 ; accessed
  23 October 2026.) Finding: flow is the state of absorbed, skilful action when
  challenge matches skill; interruptions break it. Implication: Naledzi protects flow:
  no unnecessary interruption, no chrome that competes, no forced tours; the
  onboarding is learn-by-doing.

### 2.5 Delight

- **Norman, D. A. (2004).** *Emotional Design: Why We Love (or Hate) Everyday Things.*
  Basic Books. (URL: https://www.worldcat.org/title/emotional-design/oclc/52741033 ;
  accessed 23 October 2026.) Finding: visceral, behavioural and reflective levels of
  design; beauty and usability interact; delight is a property of the whole, not a
  feature. Implication: delight in Naledzi is the absence of friction and the presence
  of honesty, not surprise animations or confetti; decoration is not delight.

### 2.6 Dignity and blame

- **Norman, D. A. (1988).** *The Design of Everyday Things.* Basic Books. (URL:
  https://www.worldcat.org/title/design-of-everyday-things/oclc/17693014 ; accessed
  23 October 2026.) Finding: when things go wrong, people blame themselves; good
  design blames the design. Implication: Naledzi error messages never blame the
  person; they name the cause and the recovery; see `05-error-recovery.md`.

### 2.7 Loss of control

- **Shneiderman, B. (1992).** "Designing the user interface: strategies for effective
  human-computer interaction." *Designing the User Interface.* Addison-Wesley. (URL:
  https://www.worldcat.org/title/designing-the-user-interface/oclc/24469645 ; accessed
  23 October 2026.) Finding: direct manipulation gives the feeling of control; the
  user must see the effect of their action. Implication: every action has an immediate,
  visible, reversible effect where possible; no silent background action on the
  person's data (`LAW-015`, `LAW-020`).

- **Hassenzahl, M. (2010).** *Experience Design: Technology for All the Right Reasons.*
  Morgan & Claypool. (URL: https://doi.org/10.2200/S00261ED1V01Y201003HCI008 ;
  accessed 23 October 2026.) Finding: experience is the consequence of need
  fulfilment and the product's character; "beauty" is a quality of interaction, not
  appearance. Implication: Naledzi's felt experience is designed as an outcome, not
  a skin; see `01-foundations/experience/`.

## 3. Intended feelings (Naledzi)

The intended feelings are: **calm, confident, in control, respected, capable,
unhurried.** Each is produced by a specific design property:

| Feeling | Produced by | Tested by |
|---|---|---|
| Calm | Idle silence, bounded motion, no decoration, quiet hours | Idle test (1 hour, zero wakeups) |
| Confident | Honest state, visible cause, recovery path | Failure test (deny, disconnect, remove) |
| In control | Reversibility, direct manipulation, no silent action | Reversibility test (undo, kill mid-action) |
| Respected | No blame, dignity in errors, privacy by default | Persona acceptance scenarios |
| Capable | Progressive disclosure, recognition over recall, first success | First-contact test (< 5 s) |
| Unhurried | Spacious density, no urgency, no countdowns | Stress scenario test |

## 4. What this predicts for Naledzi

1. **Default feeling is calm confidence.** (`UX-LAW-04`.)
2. **Stress reduces demand.** Spacious, fewer actions, larger targets, bounded motion.
3. **Never blame.** Error messages name cause and recovery.
4. **No false affect.** No fake success, fake aliveness, fake data.
5. **Delight is friction removal.** Not surprise.
6. **Flow is protected.** No unnecessary interruption.
7. **Loss of control is designed out.** Direct manipulation, reversibility, no silent
   action.

## 5. Limits and contested claims

- Affect research is largely lab-based with small samples; effect sizes are modest.
  The implications are design hypotheses, marked as such.
- "Delight" is not a measurable quantity; the operationalisation here is friction
  removal and honesty, which is measurable.
- Flow research is mostly in games and sports; transfer to productivity tools is
  interpretation.

## 6. Where implemented (IDs)

- `UX-LAW-04`.
- `01-foundations/experience/01-felt-experience.md` — intended feelings.
- `01-foundations/experience/05-error-recovery.md` — blame and trust repair.
- `04-shell/notifications/` — interruption and quiet hours.
- `07-wireframes/modes/spacious/` — spacious density.

## 7. Acceptance implications

- `AC-UX-EMOTION-001`: In the stress scenario test, task completion rate does not
  drop when spacious mode is active.
- `AC-UX-EMOTION-002`: No error message in the reference set blames the user.
- `AC-UX-EMOTION-003`: Idle test passes (zero wakeups, zero redraws) for one hour.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-EMOTION-001` | Stress scenario: task completion holds in spacious mode. |
| `AC-UX-EMOTION-002` | No blaming error messages. |
| `AC-UX-EMOTION-003` | Idle silence verified. |