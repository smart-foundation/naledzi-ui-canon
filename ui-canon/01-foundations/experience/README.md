---
id: FOUND-EXPERIENCE-INDEX
title: Experience — Felt Experience, Personas, Emotion, Onboarding, Rare Cases
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, PROC-COMPLETENESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-EXPERIENCE-000, AC-FOUND-EXPERIENCE-001, AC-FOUND-EXPERIENCE-002]
children:
  - 01-felt-experience.md
  - 02-personas.md
  - 03-emotional-journey.md
  - 04-onboarding.md
  - 05-error-recovery.md
  - 06-rare-cases.md
  - 07-culture-language.md
  - 08-attention-notifications.md
  - 09-safety-stress.md
  - 10-acceptance.md
---

# Experience

> The felt experience of Naledzi OS: how the person feels, not just what they click.
> Confidence, calm, control, trust, flow, delight, error recovery, stress, cognitive
> load, onboarding, learnability, dignity, cultural difference. Owned by the Experience
> Lead; this subtree is the human-facing counterpart to the perceptual foundations
> (depth, motion, typography, colour).

**Scope.** Felt experience, personas, emotional journey, onboarding, error recovery,
rare cases, culture and language, attention and notifications, safety and stress,
acceptance.

**Non-goals.** Implementation code, component anatomy, tokens, platform guidelines.

---

## 1. The experience laws

- **EXP-LAW-01.** The default feeling is calm confidence. Every screen is tested
  against the intended-feelings table in `01-felt-experience.md`.
- **EXP-LAW-02.** The first success happens without a manual, a tour or a hint.
- **EXP-LAW-03.** Errors never blame. They name the cause and the recovery.
- **EXP-LAW-04.** Rare cases are designed, not crashed into.
- **EXP-LAW-05.** Dignity is not optional and is not a locale.
- **EXP-LAW-06.** Attention is owned by the person; the system budgets it.
- **EXP-LAW-07.** Stress reduces demand; the system gets simpler, not louder.
- **EXP-LAW-08.** Onboarding is learn-by-doing.

## 2. Directory map

| File | Question |
|---|---|
| [01-felt-experience.md](01-felt-experience.md) | What should the person feel, and how is each feeling produced and tested? |
| [02-personas.md](02-personas.md) | Who are the people, with routines, constraints, emotional states and acceptance scenarios? |
| [03-emotional-journey.md](03-emotional-journey.md) | What is the emotional curve from first contact to long-term trust? |
| [04-onboarding.md](04-onboarding.md) | How does a person start, learn and pair devices? |
| [05-error-recovery.md](05-error-recovery.md) | How are errors worded and recovered from without shame? |
| [06-rare-cases.md](06-rare-cases.md) | How does the system behave in rare and extreme cases? |
| [07-culture-language.md](07-culture-language.md) | How does culture and language shape dignity and layout? |
| [08-attention-notifications.md](08-attention-notifications.md) | What is the attention budget and interruption contract? |
| [09-safety-stress.md](09-safety-stress.md) | How does the system behave under stress, workload, fatigue and emergency? |
| [10-acceptance.md](10-acceptance.md) | How is the experience proved without faking it? |

## 3. Dependency and ownership

| Fact | Owner | Consumers |
|---|---|---|
| Intended feelings and their production | This subtree | All foundations, shell, apps |
| Personas | This subtree | Research, design, testing |
| Rare-case register | This subtree | All entities |
| Attention budget | This subtree + `04-shell/notifications/` | Shell, apps |

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-EXPERIENCE-000` | Every file listed in `children` exists; no file contains `TODO`, an empty heading or "similar to". |
| `AC-FOUND-EXPERIENCE-001` | Every persona has a routine, constraints, emotional state and acceptance scenario. |
| `AC-FOUND-EXPERIENCE-002` | Every rare case in `06-rare-cases.md` is specified and tested. |
| `AC-FOUND-EXPERIENCE-003` | Experience ACs in `10-acceptance.md` are measurable and falsifiable. |