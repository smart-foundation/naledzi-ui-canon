---
id: UX-IMPLICATIONS
title: Implications — Traceability from Principle to Naledzi Law/Decision to Implementation to Acceptance
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-IMPLICATIONS-001, AC-UX-IMPLICATIONS-002]
---

# Implications

> Traceability table: research principle → Naledzi law/decision → where implemented →
> acceptance. No blank cell. A blank cell is a defect.

## 1. Research principle → Naledzi law/decision → implementation → acceptance

| # | Research principle (file) | Naledzi law / decision | Where implemented (IDs) | Acceptance |
|---|---|---|---|---|
| 1 | Occlusion dominates depth cues (`01`) | `LAW-007` depth communicates hierarchy; `FOUND-DEPTH-001` | `FOUND-DEPTH/05-occlusion-and-focus.md` | `AC-FOUND-DEPTH-002` |
| 2 | Depth carried by more than shadow (`01`) | `LAW-007`; `FOUND-DEPTH-002` | `FOUND-DEPTH/03-shadows.md`, `02-elevation.md` | `AC-FOUND-DEPTH-001` |
| 3 | Motion explains change (`01`, `03`) | `LAW-008`; `FOUND-MOTION-001`..`005` | `FOUND-MOTION/01-springs.md`, `02-choreography.md` | `AC-FOUND-MOTION-001` |
| 4 | Change blindness: silent changes missed (`01`) | `LAW-005` numbered still; `LAW-011` honesty | `04-shell/notifications/`; `02-architecture/presentation/` | `AC-UX-PERCEPTION-003` |
| 5 | Critical signals are basic features (`01`) | `LAW-007`; safety envelopes | `06-envelopes/ev/`, `spaceship/` | `AC-UX-SAFETY-001` |
| 6 | Working memory ~4 chunks (`02`) | `UX-LAW-02`; `LAW-010` chrome | `03-framework/adaptivity/`; `07-wireframes/` | `AC-UX-COGNITION-001` |
| 7 | Choice cost logarithmic (`02`) | `UX-LAW-02`; palette as foundation | `03-framework/palette/` | `AC-UX-COGNITION-002` |
| 8 | Extraneous load is a defect (`02`) | `LAW-010` no chrome; `UX-LAW-02` | `04-shell/strip/`; `07-wireframes/modes/spacious/` | `AC-UX-COGNITION-003` |
| 9 | Consistency is cognitive (`02`) | `LAW-013` one vocabulary one grammar | `03-framework/`; `05-apps/_standard/` | `AC-DOC-003` |
| 10 | Predictions must succeed (`02`) | `LAW-008`, `LAW-011` | `FOUND-MOTION/`; `02-architecture/presentation/` | `AC-FOUND-MOTION-001` |
| 11 | Interruptions restore context (`02`, `07`) | `LAW-015` reversibility | `04-shell/spaces/`; `04-shell/notifications/` | `AC-UX-ATTENTION-002` |
| 12 | Targets obey Fitts's law (`03`) | `UX-LAW-03`; WCAG 2.5.5/2.5.8 | `06-envelopes/`; `03-framework/components/` | `AC-UX-MOTOR-001` |
| 13 | Edges/corners infinite (pointer only) (`03`) | `UX-LAW-03` | `04-shell/gestures/`; `06-envelopes/desktop/` | `AC-UX-MOTOR-001` |
| 14 | Steering paths wide and smooth (`03`) | `UX-LAW-03` | `03-framework/components/` (sliders, scrollbars) | `AC-UX-MOTOR-002` |
| 15 | Gesture velocity preserved (`03`) | `FOUND-MOTION-004`; `LAW-008` | `FOUND-MOTION/02-choreography.md` | `AC-UX-MOTOR-003` |
| 16 | Motion settles and stops (`03`) | `FOUND-MOTION-003`; `LAW-004` | `FOUND-MOTION/01-springs.md` | `AC-FOUND-MOTION-001` |
| 17 | Crossing is accelerator (`03`) | `LAW-010` | `04-shell/gestures/` | `AC-UX-MOTOR-003` |
| 18 | Default feeling calm confidence (`04`) | `UX-LAW-04`; `LAW-020` | `01-foundations/experience/01-felt-experience.md` | `AC-UX-EMOTION-001` |
| 19 | Stress reduces demand (`04`) | `UX-LAW-04`; spacious stress rule | `07-wireframes/modes/spacious/01-principles.md` | `AC-UX-SPACIOUS-003` |
| 20 | Never blame (`04`) | `LAW-011` honesty | `01-foundations/experience/05-error-recovery.md` | `AC-UX-EMOTION-002` |
| 21 | No false affect (`04`) | `LAW-011`; `LAW-004` | `04-shell/notifications/` | `AC-UX-EMOTION-003` |
| 22 | Delight is friction removal (`04`) | `LAW-010` | `01-foundations/experience/01-felt-experience.md` | `AC-UX-EMOTION-001` |
| 23 | Flow protected (`04`) | `LAW-020` attention | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 24 | Loss of control designed out (`04`) | `LAW-015`, `LAW-020` | `02-architecture/security/`; `04-shell/` | `AC-UX-TRUST-002` |
| 25 | Trust calibrated (`05`) | `UX-LAW-05`; `LAW-011` | `01-foundations/experience/05-error-recovery.md` | `AC-UX-TRUST-003` |
| 26 | Automation visible/interruptible (`05`) | `LAW-011`, `LAW-015` | `02-architecture/security/`; `04-shell/` | `AC-UX-TRUST-002` |
| 27 | Observation off by default (`05`) | `LAW-020` | `04-shell/settings/` (privacy) | `AC-UX-TRUST-001` |
| 28 | Notification budgets/quiet hours (`05`) | `LAW-020` | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 29 | Reversibility mandatory (`05`) | `LAW-015` | `04-shell/`; `02-architecture/presentation/` | `AC-UX-TRUST-002` |
| 30 | Honesty over polish (`05`) | `LAW-011` | everywhere | `AC-UX-TRUST-001` |
| 31 | Recognition over recall (`06`) | `UX-LAW-06`; `LAW-010` | `03-framework/palette/`; `05-apps/_standard/` | `AC-UX-LEARNING-003` |
| 32 | Progressive disclosure (`06`) | `UX-LAW-06` | `01-foundations/experience/04-onboarding.md` | `AC-UX-LEARNING-001` |
| 33 | Consistency (`06`) | `LAW-013` | `03-framework/`; `05-apps/` | `AC-DOC-003` |
| 34 | First success without manual (`06`) | `LAW-012` design before code | `01-foundations/experience/04-onboarding.md` | `AC-UX-LEARNING-001` |
| 35 | Feedback on every action (`06`) | `LAW-005`, `LAW-009` | `03-framework/components/` | `AC-UX-LEARNING-002` |
| 36 | Shortcuts are accelerators (`06`) | `LAW-010` | `04-shell/shortcuts/` | `AC-UX-LEARNING-003` |
| 37 | Attention budget (`07`) | `LAW-020` | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 38 | Interruptions queued unless urgent (`07`) | `LAW-020` | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 39 | Breakpoint delivery (`07`) | `LAW-020` | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 40 | Resumption restores context (`07`) | `LAW-015` | `04-shell/spaces/` | `AC-UX-ATTENTION-002` |
| 41 | Alarms actionable/accurate (`07`) | `LAW-011` | `04-shell/notifications/` | `AC-UX-ATTENTION-003` |
| 42 | Quiet hours (`07`) | `LAW-020` | `04-shell/notifications/` | `AC-UX-ATTENTION-001` |
| 43 | Situation awareness designed (`08`) | `UX-LAW-08`; safety envelopes | `06-envelopes/ev/`, `spaceship/` | `AC-UX-SAFETY-001` |
| 44 | Safety displays simple/redundant/stable (`08`) | `LAW-007`, `LAW-008` | `06-envelopes/spaceship/` | `AC-UX-SAFETY-001` |
| 45 | Bounded non-overshooting motion (`08`) | `FOUND-MOTION-005`; safety motion | `01-foundations/motion/05-safety-motion.md` | `AC-UX-SAFETY-001` |
| 46 | Procedure-first under workload (`08`) | `UX-LAW-08` | `06-envelopes/spaceship/` | `AC-UX-SAFETY-003` |
| 47 | Workload measured (NASA-TLX) (`08`) | `LAW-016` performance | `08-process/` (acceptance) | `AC-UX-SAFETY-002` |
| 48 | Alarms prioritised/accurate (`08`) | `LAW-011` | `04-shell/notifications/` | `AC-UX-SAFETY-003` |
| 49 | EV glance/total bounds (NHTSA) (`08`) | `UX-LAW-08` | `06-envelopes/ev/` | `AC-UX-SAFETY-002` |
| 50 | WCAG 2.2 AA floor (`09`) | `UX-LAW-09`; `LAW-009` | `01-foundations/accessibility/` | `AC-UX-ACCESSIBILITY-001` |
| 51 | Accessibility structural (`09`) | `LAW-009` | `02-architecture/presentation/` | `AC-FOUND-DEPTH-002` |
| 52 | Reduced motion mandatory (`09`) | `FOUND-MOTION-005`; `LAW-008` | `FOUND-MOTION/04-reduced-motion.md` | `AC-UX-ACCESSIBILITY-002` |
| 53 | Colour not only carrier (`09`) | `UX-LAW-09` | `01-foundations/color/` | `AC-UX-ACCESSIBILITY-001` |
| 54 | Target sizes 24/44 px (`09`) | `UX-LAW-03`, `UX-LAW-09` | `03-framework/components/` | `AC-UX-MOTOR-001` |
| 55 | Switch/voice/eye-gaze (`09`) | `LAW-009` | `06-envelopes/`; `04-shell/` | `AC-UX-ACCESSIBILITY-003` |
| 56 | Plain language/predictable (`09`) | `LAW-011` | `01-foundations/experience/05-error-recovery.md` | `AC-UX-ACCESSIBILITY-003` |
| 57 | No redundant entry / cognitive auth (`09`) | `UX-LAW-09` | `05-apps/settings/` | `AC-UX-ACCESSIBILITY-003` |
| 58 | No single culture default (`10`) | `UX-LAW-10`; `LAW-019` | `01-foundations/experience/07-culture-language.md` | `AC-UX-CULTURE-001` |
| 59 | RTL structural (`10`) | `UX-LAW-10` | `01-foundations/typography/`; `03-framework/adaptivity/` | `AC-UX-CULTURE-001` |
| 60 | Scripts shaped (Unicode/CLDR) (`10`) | `UX-LAW-10` | `01-foundations/typography/` | `AC-UX-CULTURE-001` |
| 61 | Numerals/dates CLDR (`10`) | `UX-LAW-10` | `01-foundations/typography/` | `AC-UX-CULTURE-002` |
| 62 | Icons concrete and labelled (`10`) | `UX-LAW-10` | `01-foundations/iconography/` | `AC-UX-CULTURE-003` |
| 63 | Translation length/direction (`10`) | `UX-LAW-10` | `03-framework/adaptivity/` | `AC-UX-CULTURE-002` |
| 64 | Dignity cross-cultural (`10`) | `LAW-020`; `UX-LAW-10` | `01-foundations/experience/07-culture-language.md` | `AC-UX-CULTURE-003` |
| 65 | Usability measured (`11`) | `LAW-012`, `LAW-016` | `08-process/` | `AC-UX-USABILITY-001` |
| 66 | Formative before summative (`11`) | `LAW-012` | `08-process/` | `AC-UX-USABILITY-001` |
| 67 | Think-aloud (`11`) | `LAW-012` | `08-process/` | `AC-UX-USABILITY-001` |
| 68 | Field studies (`11`) | `LAW-012` | `06-envelopes/ev/` | `AC-UX-USABILITY-002` |
| 69 | Simulator testing (`11`) | safety envelopes | `06-envelopes/spaceship/` | `AC-UX-USABILITY-003` |
| 70 | Inclusive recruitment (`11`) | `LAW-009` | `01-foundations/experience/10-acceptance.md` | `AC-UX-USABILITY-002` |
| 71 | Ethics (`11`) | `LAW-020` | `08-process/` | `AC-UX-USABILITY-002` |
| 72 | Needs are ancient (`12`) | `CANON-TIMELESSNESS` Q1 | `05-apps/00-portfolio/` | `AC-UX-TIMELESSNESS-001` |
| 73 | Form is disposable (`12`) | `CANON-TIMELESSNESS` | `02-architecture/` | `AC-UX-TIMELESSNESS-001` |
| 74 | Primitives scored (`12`) | `CANON-TIMELESSNESS` | `00-canon/01-timelessness-test.md` | `AC-UX-TIMELESSNESS-001` |
| 75 | Claims falsifiable (`12`) | `LAW-012` | every `11-acceptance.md` | `AC-UX-TIMELESSNESS-002` |
| 76 | Rejected ideas recorded (`12`) | `CANON-TIMELESSNESS` §6 | `00-canon/05-anti-patterns.md` | `AC-UX-TIMELESSNESS-003` |
| 77 | Spacious is density mode (`13`) | `UX-LAW-13`; master brief | `07-wireframes/modes/spacious/` | `AC-UX-SPACIOUS-001` |
| 78 | Spacious changes spacing/actions/hierarchy (`13`) | `UX-LAW-13` | `03-framework/adaptivity/` | `AC-UX-SPACIOUS-001` |
| 79 | Degradation by rule (`13`) | `UX-LAW-13` | `07-wireframes/modes/spacious/03-adaptation.md` | `AC-UX-SPACIOUS-002` |
| 80 | No content loss (`13`) | `UX-LAW-13`; `LAW-010` | `07-wireframes/modes/spacious/03-adaptation.md` | `AC-UX-SPACIOUS-002` |
| 81 | Spacious helps cognition/motor/stress/low vision (`13`) | `UX-LAW-13` | `07-wireframes/modes/spacious/` | `AC-UX-SPACIOUS-003` |

## 2. Naledzi law → research principle (reverse)

| Law | Research principle | File |
|---|---|---|
| `LAW-001` one fact one owner | (structural, not human) | `n/a — architecture, not UX research` |
| `LAW-002` pixels never cross boundary | (structural) | `n/a — architecture` |
| `LAW-003` declared not detected | (structural) | `n/a — architecture` |
| `LAW-004` idle is silent | Motion perception, Kahneman attention (`01`, `02`) | `01-perception.md` §2.2 |
| `LAW-005` numbered still | Change blindness (`01`) | `01-perception.md` §2.3 |
| `LAW-006` authority mandatory | (structural) | `n/a — architecture` |
| `LAW-007` depth communicates hierarchy | Cutting & Vishton, Mamassian (`01`) | `01-perception.md` §2.1 |
| `LAW-008` motion explains change | Flash & Hogan (`03`); Clark (`02`) | `03-motor.md` §2.3 |
| `LAW-009` accessibility structural | WCAG, WAI-ARIA (`09`) | `09-accessibility.md` |
| `LAW-010` no permanent chrome | Weiser calm tech (`04`); Norman (`04`, `06`) | `04-emotion.md` §2.3 |
| `LAW-011` honesty over polish | Schwarz affect (`04`); Parasuraman & Riley (`05`) | `04-emotion.md` §2.1; `05-trust.md` |
| `LAW-012` design before code | Nielsen usability (`11`); Popper (`12`) | `11-usability-research.md` |
| `LAW-013` one vocabulary one grammar | Norman consistency (`06`); Friston (`02`) | `06-learning.md` §2.3 |
| `LAW-014` smallest contract wins | (structural) | `n/a — architecture` |
| `LAW-015` reversibility | Norman (`05`); Reason (`08`) | `05-trust.md` §2.5 |
| `LAW-016` performance is constraint | Hart & Staveland (`08`); Tullis (`13`) | `08-safety-critical.md` |
| `LAW-017` local first | (structural) | `n/a — architecture` |
| `LAW-018` every screen is a state | Norman (`06`); Endsley (`05`, `07`) | `06-learning.md`; `07-attention.md` |
| `LAW-019` no hidden global state | Hofstede (`10`); W3C i18n (`10`) | `10-culture-language.md` |
| `LAW-020` user owns data/attention | Weiser (`04`); LAW-020 canon | `04-emotion.md`; `07-attention.md` |

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-UX-IMPLICATIONS-001` | Every row in section 1 has no blank cell. |
| `AC-UX-IMPLICATIONS-002` | Every Naledzi law appears in section 2 with either a research principle or a declared `n/a — reason`. |