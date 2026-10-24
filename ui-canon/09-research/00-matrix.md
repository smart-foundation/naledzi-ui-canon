---
id: RESEARCH-UX-MATRIX-01
title: Research Coverage Matrix and Principle Register
kind: research
entity: research
status: review
normative: true
version: 0.1.0
owner: UX Research Lead
depends: [PROC-MASTER-BRIEF, PROC-COMPLETENESS, DOC-SYSTEM, CANON-LAWS]
acceptance: [AC-RES-001, AC-RES-002, AC-RES-003, AC-RES-004]
---

# Research Coverage Matrix and Principle Register

> This file is the audit, not the argument. Every domain below names its question, its
> files, its principles, its sources, its limits and its acceptance. A blank cell is a
> defect. The prose files carry the evidence; this register proves that no domain was
> sampled and abandoned.

**Status of this subtree.** `review`. The findings are evidence-backed; the Naledzi
implications are design hypotheses until a named envelope test passes. Adoption into
`canon` is the Canon Editor's act, not this agent's.

**Access date for every source in this subtree:** 2026-10-22.

---

## 1. Scope

The research subtree answers thirteen questions that the rest of the corpus is not allowed
to answer by assertion:

| # | Question | Owning directory |
|---|---|---|
| 1 | How do people see, group, search and read an interface? | `ux-principles/perception/` |
| 2 | How do attention, memory, load, choice and prediction shape interaction? | `ux-principles/cognition/` |
| 3 | How do people aim, steer, interrupt and hand off movement? | `ux-principles/motor/` |
| 4 | What makes an interface feel calm, confident, effortful, delightful or degrading? | `ux-principles/emotion/` |
| 5 | When and why do people rely on, distrust, over-trust or repair trust in automation? | `ux-principles/trust/` |
| 6 | How do novices become experts, and how does an interface teach without a tour? | `ux-principles/learning/` |
| 7 | What consumes attention, and what does an interruption actually cost? | `ux-principles/attention/` |
| 8 | What changes when a mistake can kill someone? | `ux-principles/safety-critical/` |
| 9 | What must be true for disabled people to complete the same jobs? | `ux-principles/accessibility/` |
| 10 | What changes across language, script, direction, numerals and culture? | `ux-principles/culture-language/` |
| 11 | What have other platforms already proved, and what must not be copied? | `prior-art/` |
| 12 | How should depth, motion, input and performance be specified so they stay true? | `depth/`, `input/`, `performance/` |
| 13 | Which of today's primitives will still be true in ten years, and how would we know? | `timelessness/` |

Out of scope for this agent: the actual component, envelope and flow specifications. Those
consume these findings and must cite the principle IDs minted here.

---

## 2. Domain coverage

Every domain has a `README.md` index, at least one principles file, and a limits file. The
"principles" column counts distinct normative principle IDs, not headings.

| Domain | Files | Principles | Core sources | Explicit limits |
|---|---|---|---|---|
| Perception | `perception/README.md`, `01-grouping-and-depth.md`, `02-motion-and-change.md`, `03-search-colour-reading.md`, `04-limits.md` | 19 | Wertheimer 1923; Cutting & Vishton 1995; Simons & Levin 1997; Treisman & Gelade 1980; CIE/WCAG contrast; Bringhurst 2004 | Lab stimuli; 2-D screens; colour-naming variance; reading research is Latin-script heavy |
| Cognition | `cognition/README.md`, `01-attention-and-memory.md`, `02-load-and-choice.md`, `03-models-prediction-bias.md`, `04-limits.md` | 16 | Miller 1956; Cowan 2001; Baddeley & Hitch 1974; Sweller 1988; Hick 1952; Clark 2013; Tversky & Kahneman 1974 | Capacity numbers contested; CLT measurement weak; Hick confounded by practice; predictive processing contested |
| Motor | `motor/README.md`, `01-fitts-and-steering.md`, `02-kinematics-and-handoff.md`, `03-limits.md` | 13 | Fitts 1954; Accot & Zhai 1997; Flash & Hogan 1985; Meyer et al. 1988 | Throughput depends on device and posture; lab pointing tasks; tremor under-represented |
| Emotion | `emotion/README.md`, `01-affect-and-stress.md`, `02-confidence-calm.md`, `03-flow-dignity-control-limits.md` | 15 | Russell 1980; Lazarus & Folkman 1984; Bandura 1977; Csikszentmihalyi 1990; Weiser & Brown 1996 | Self-report; cultural display rules; Yerkes–Dodson over-generalised; "delight" under-specified |
| Trust | `trust/README.md`, `01-models-and-calibration.md`, `02-overtrust-distrust.md`, `03-transparency-privacy-repair-limits.md` | 14 | Parasuraman & Riley 1997; Lee & See 2004; Hoff & Bashir 2015; Bainbridge 1983; Endsley & Kiris 1995 | Trust is not a single variable; lab automation ≠ OS; transparency can backfire |
| Learning | `learning/README.md`, `01-novice-expert-disclosure.md`, `02-transfer-consistency-recall.md`, `03-errorful-and-limits.md` | 12 | Sweller 1988; Nielsen 1993; Card et al. 1983; Bjork & Bjork 2011 (desirable difficulties) | Expertise reversal; transfer is hard to measure; "intuitive" is learned |
| Attention | `attention/README.md`, `01-budget-interruption.md`, `02-resumption-notifications.md`, `03-signal-alarm-restoration-limits.md` | 13 | Mark et al. 2008; Iqbal & Horvitz 2007; Cvach 2012; Green & Swets 1966; Kaplan & Kaplan 1989 | Interruption studies are office-bound; alarm base rates differ by domain; restoration evidence outdoor-heavy |
| Safety-critical | `safety-critical/README.md`, `01-situation-awareness.md`, `02-workload-fatigue.md`, `03-human-error-and-procedures.md`, `04-alarm-complacency.md`, `05-domain-requirements-and-limits.md` | 18 | Endsley 1995; Hart & Staveland 1988; Reason 1990/2000; FAA HF-STD-001B; NASA-STD-3001; MIL-STD-1472H; NHTSA 2013; SAE J3016 | Standards are minima, not proofs; domain transfer is unsafe; fatigue models are weak |
| Accessibility | `accessibility/README.md`, `01-wcag-aria.md`, `02-vestibular-motion.md`, `03-colour-motor.md`, `04-cognitive-switch-voice.md`, `05-text-screenreader-limits.md` | 21 | WCAG 2.2; WAI-ARIA 1.2; APG; Machado et al. 2009; ISO 9241-110:2020 | Conformance ≠ usability; assistive-tech combinations untested; vestibular evidence thin |
| Culture & language | `culture-language/README.md`, `01-models-rtl.md`, `02-scripts-numerals.md`, `03-icons-translation.md`, `04-dignity-privacy-limits.md` | 16 | Hofstede 2001; Hall 1976; UAX #9; CLDR; W3C i18n; Henrich et al. 2010 | National-culture scores are group-level; bidi is algorithmic, not stylistic; localisation quality varies |
| Prior art | `prior-art/README.md`, `01-platforms.md`, `02-rendering-stacks.md`, `03-what-not-to-copy.md` | 12 claims | Apple HIG; Material 3; Fluent 2; GNOME HIG; KDE HIG; Fuchsia; Wayland; SurfaceFlinger; Vulkan; KMS; dma-buf; Core Animation; Cap'n Proto | Documentation changes; vendor systems are not evidence of human outcomes; licences differ |
| Depth | `depth/README.md`, `01-cues-elevation.md`, `02-parallax-light.md`, `03-performance-failure.md` | 11 | Cutting & Vishton 1995; Wertheimer 1923; WCAG 2.2; Apple HIG; Material 3 | Depth perception research is real-world; screen depth is cue mimicry |
| Input | `input/README.md`, `01-pointer-touch-keyboard.md`, `02-remote-voice-gesture.md`, `03-motor-text-latency.md` | 14 | Fitts 1954; WCAG 2.2 SC 2.5.7/2.5.8; W3C pointer events; platform HIGs | Voice recognition error rates vary; remote focus is under-researched |
| Performance | `performance/README.md`, `01-thresholds-jank.md`, `02-power-idle.md`, `03-measurement-budgets.md` | 12 | Nielsen 1993 response limits; WCAG 2.3.3; Android frame timing; Vulkan/KMS docs | Thresholds are perceptual, not frame-rate laws; measurement variance |
| Timelessness | `timelessness/README.md`, `01-why-designs-age.md`, `02-primitives.md`, `03-decade-test.md` | 9 tests | CANON-TIMELESSNESS; Norman 2013; Nielsen 1993; platform history | Falsification of a decade claim takes a decade; survivorship bias |
| References | `references/README.md`, `01-bibliography.md`, `02-register.md` | n/a | All of the above | Paywalled works are cited by verified metadata, not full text |

Total distinct principle IDs minted: **213**. They are listed in §4 and expanded in the
domain files. A principle ID is stable; a later file may refine its wording but may not
reuse the ID for a different claim.

---

## 3. Required content per research file

The completeness contract (§2.5) requires six things. This is the cell test applied to every
file in this subtree.

| Element | Test | Where it lives |
|---|---|---|
| Principle, stated precisely | One sentence, falsifiable, scoped | Opening of each numbered principle |
| Sources | Author, title, year, URL, access date | `Sources` under each principle or the domain source table |
| Evidence strength and limits | `Strong`, `Moderate`, `Weak`, `Contested` + why | `Evidence` and `Limits` |
| Prediction for Naledzi | A concrete behaviour, not a virtue | `Naledzi implication` |
| Implementation IDs | Proposed `COMP-*`, `ENV-*`, `SHELL-*`, `FW-*`, `TOK-*`, `AC-*` | `Implementation` |
| Contradiction or uncertainty | Named, with the competing finding | `Contested` or the limits file |
| Acceptance implication | A test that can fail | `Acceptance` |

A file that has a principle without a source is a defect. A file that cites a source it did
not open is a worse defect. The register in `references/02-register.md` records what was
opened and what was only bibliographically verified.

---

## 4. Principle register

The register is grouped by domain. Each entry is `ID — statement — evidence — primary
file`. Evidence grades: **A** meta-analysis or replicated standard; **B** peer-reviewed
experiment or official standard; **C** single study, vendor documentation or expert
synthesis; **D** design hypothesis (no direct human-outcome evidence).

### 4.1 Perception (PER)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-PER-001` | Grouping by proximity, similarity, continuity and closure is pre-attentive and precedes deliberate reading. | A | `perception/01-grouping-and-depth.md` |
| `RES-PER-002` | Figure–ground assignment determines what is treated as object and what as surface; ambiguous assignment costs time. | B | `perception/01-grouping-and-depth.md` |
| `RES-PER-003` | Common fate groups elements that move together more strongly than static similarity. | B | `perception/01-grouping-and-depth.md` |
| `RES-PER-004` | Relative size, occlusion, height in the visual field, texture gradient and motion parallax are the strongest unaided depth cues on a flat display. | A | `perception/01-grouping-and-depth.md` |
| `RES-PER-005` | Convergence and accommodation are weak depth cues at screen distances. | A | `perception/01-grouping-and-depth.md` |
| `RES-PER-006` | Cast shadows are read as contact and elevation only when the light direction is consistent across the scene. | B | `perception/01-grouping-and-depth.md` |
| `RES-PER-007` | Change blindness is the norm, not the exception, when a change is not attended or not cued. | A | `perception/02-motion-and-change.md` |
| `RES-PER-008` | Motion capturing attention is obligatory; it cannot be trained away by instruction. | B | `perception/02-motion-and-change.md` |
| `RES-PER-009` | Smooth pursuit and vection can produce sickness when visual motion contradicts vestibular signals. | B | `perception/02-motion-and-change.md` |
| `RES-PER-010` | Feature search is parallel; conjunction search is serial and scales with distractor count. | A | `perception/03-search-colour-reading.md` |
| `RES-PER-011` | Colour is a weak absolute code and a strong relative code; it must never be the only carrier of meaning. | A | `perception/03-search-colour-reading.md` |
| `RES-PER-012` | Perceived contrast depends on luminance, surround and spatial frequency, not on a single RGB distance. | A | `perception/03-search-colour-reading.md` |
| `RES-PER-013` | Reading speed and comprehension depend on measure, leading, x-height and line length; 45–75 Latin characters per line is a robust working range. | B | `perception/03-search-colour-reading.md` |
| `RES-PER-014` | Numerals and symbols are read as shapes; unfamiliar glyph forms slow recognition even when the language is known. | C | `perception/03-search-colour-reading.md` |
| `RES-PER-015` | Attention is required to bind features; without it, illusory conjunctions occur. | B | `perception/03-search-colour-reading.md` |
| `RES-PER-016` | Peripheral vision has low acuity and poor colour discrimination; critical information belongs in the central field. | A | `perception/03-search-colour-reading.md` |
| `RES-PER-017` | Flicker and high-contrast periodic motion can trigger photosensitive seizures in susceptible people. | A | `perception/02-motion-and-change.md` |
| `RES-PER-018` | Visual masking and backward masking shorten effective display time; a frame shown for one refresh may not be perceivable. | B | `perception/02-motion-and-change.md` |
| `RES-PER-019` | Individual differences in colour naming and acuity are large enough that population means cannot certify a single user's perception. | A | `perception/04-limits.md` |

### 4.2 Cognition (COG)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-COG-001` | Working memory is limited and temporary; the active span is closer to four chunks than seven for novel material. | A | `cognition/01-attention-and-memory.md` |
| `RES-COG-002` | Chunking expands effective capacity only when the chunk is already meaningful to the person. | A | `cognition/01-attention-and-memory.md` |
| `RES-COG-003` | Recognition is cheaper and more reliable than recall; visible options outperform memorised commands. | A | `cognition/01-attention-and-memory.md` |
| `RES-COG-004` | Prospective memory (remembering to do something later) is fragile and benefits from external cues. | B | `cognition/01-attention-and-memory.md` |
| `RES-COG-005` | Extraneous cognitive load consumes capacity without advancing the task; intrinsic load is the work itself. | A | `cognition/02-load-and-choice.md` |
| `RES-COG-006` | Choice reaction time rises approximately linearly with the information content (log₂ of equiprobable alternatives). | A | `cognition/02-load-and-choice.md` |
| `RES-COG-007` | Hick's slope is not a universal constant; practice, compatibility and stimulus structure change it substantially. | A | `cognition/02-load-and-choice.md` |
| `RES-COG-008` | More choice is not always better, but "choice overload" is conditional and frequently overstated. | B | `cognition/02-load-and-choice.md` |
| `RES-COG-009` | People act on mental models, not on system models; a wrong model produces confident errors. | A | `cognition/03-models-prediction-bias.md` |
| `RES-COG-010` | The brain predicts forward; unexpected events cost more when the prediction error is large and unexplained. | C | `cognition/03-models-prediction-bias.md` |
| `RES-COG-011` | Defaults, anchoring, availability and loss aversion shape decisions even when the person is competent. | A | `cognition/03-models-prediction-bias.md` |
| `RES-COG-012` | Heuristics are often accurate in structured environments and biased in unstructured ones. | B | `cognition/03-models-prediction-bias.md` |
| `RES-COG-013` | Satisficing is rational under time pressure; an interface that demands optimisation will be abandoned. | A | `cognition/03-models-prediction-bias.md` |
| `RES-COG-014` | Interruption costs are highest when the task is at a fragile intermediate state. | B | `cognition/01-attention-and-memory.md` |
| `RES-COG-015` | Cognitive load is task- and person-relative; a design that reduces load for a novice can increase it for an expert. | A | `cognition/02-load-and-choice.md` |
| `RES-COG-016` | Automation changes the cognitive task rather than removing it; monitoring is itself work. | A | `cognition/03-models-prediction-bias.md` |

### 4.3 Motor (MOT)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-MOT-001` | Movement time to a target rises with distance and falls with target width: `MT = a + b·log₂(D/W + 1)`. | A | `motor/01-fitts-and-steering.md` |
| `RES-MOT-002` | Throughput (bits/s) is a device property, not a universal human constant. | B | `motor/01-fitts-and-steering.md` |
| `RES-MOT-003` | Path-constrained movement obeys a steering law: time rises with path length and falls with corridor width. | A | `motor/01-fitts-and-steering.md` |
| `RES-MOT-004` | Aimed movements have a ballistic phase followed by corrective sub-movements; the last correction dominates precision. | A | `motor/02-kinematics-and-handoff.md` |
| `RES-MOT-005` | Human reaching approximates minimum-jerk trajectories, but only when the task is unconstrained and well learned. | B | `motor/02-kinematics-and-handoff.md` |
| `RES-MOT-006` | Targets at screen edges and corners are effectively larger because the pointer cannot overshoot. | B | `motor/01-fitts-and-steering.md` |
| `RES-MOT-007` | Gesture handoff must preserve position and velocity or the object appears to jump. | B | `motor/02-kinematics-and-handoff.md` |
| `RES-MOT-008` | Visible latency above roughly 100 ms degrades direct manipulation; above 200 ms it feels disconnected. | B | `motor/03-limits.md` |
| `RES-MOT-009` | Tremor and spasticity change the effective target width; a nominal 44 px target may be unusable. | B | `motor/03-limits.md` |
| `RES-MOT-010` | Touch targets below 24×24 CSS px fail many users; 44×44 is the safer mobile baseline. | A | `motor/03-limits.md` |
| `RES-MOT-011` | Two-handed and whole-body input have different transfer functions; they are not scaled versions of a mouse. | C | `motor/02-kinematics-and-handoff.md` |
| `RES-MOT-012` | Repetitive small movements contribute to musculoskeletal strain; frequency and force matter more than distance alone. | B | `motor/03-limits.md` |
| `RES-MOT-013` | Haptic feedback improves targeting only when it is time-aligned with the visual event. | B | `motor/02-kinematics-and-handoff.md` |

### 4.4 Emotion (EMO)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-EMO-001` | Affect varies along at least valence and arousal; "positive" is not one state. | A | `emotion/01-affect-and-stress.md` |
| `RES-EMO-002` | Arousal and performance have an inverted-U relationship only under some task conditions; the simple curve is not a law. | C | `emotion/01-affect-and-stress.md` |
| `RES-EMO-003` | Stress is an appraisal of demand versus resource, not a property of the event alone. | A | `emotion/01-affect-and-stress.md` |
| `RES-EMO-004` | Mastery experiences are the strongest source of self-efficacy. | A | `emotion/02-confidence-calm.md` |
| `RES-EMO-005` | Calm technology informs without demanding the centre of attention. | C | `emotion/02-confidence-calm.md` |
| `RES-EMO-006` | Flow requires a balance of challenge and skill, clear goals and immediate feedback. | B | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-007` | Delight is a surprise that exceeds expectation; it decays with repetition and cannot be a permanent baseline. | C | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-008` | Dignity is the preservation of agency, privacy and competence in the interaction. | C | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-009` | Loss of control is experienced as threat; restoring a visible path back reduces the threat response. | B | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-010` | Emotional states are measured by self-report, behaviour and physiology; no single channel is sufficient. | A | `emotion/01-affect-and-stress.md` |
| `RES-EMO-011` | Positive affect broadens exploration; negative affect narrows it. | B | `emotion/01-affect-and-stress.md` |
| `RES-EMO-012` | Waiting feels longer when it is unexplained and unbounded. | B | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-013` | A system that apologises without changing behaviour is experienced as dishonest. | D | `emotion/03-flow-dignity-control-limits.md` |
| `RES-EMO-014` | Aesthetic quality affects perceived usability, but the effect is not a substitute for task success. | B | `emotion/02-confidence-calm.md` |
| `RES-EMO-015` | Emotional contagion and anthropomorphism make tone and voice part of function. | B | `emotion/01-affect-and-stress.md` |

### 4.5 Trust (TRU)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-TRU-001` | Trust is a willingness to accept vulnerability based on expectations of competence, honesty and benevolence. | B | `trust/01-models-and-calibration.md` |
| `RES-TRU-002` | Appropriate reliance, not maximal trust, is the design goal. | A | `trust/01-models-and-calibration.md` |
| `RES-TRU-003` | Trust is calibrated by observed performance, transparency and the cost of error. | A | `trust/02-overtrust-distrust.md` |
| `RES-TRU-004` | Overtrust produces complacency and misuse; distrust produces disuse and manual overload. | A | `trust/02-overtrust-distrust.md` |
| `RES-TRU-005` | Explanations improve trust only when they are selective, verifiable and matched to the user's model. | B | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-006` | Observation capabilities are trust decisions; a thumbnail, a clipboard read and a screen recording are different grants. | B | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-007` | Trust repair requires acknowledgement, cause, remedy and a change in future behaviour. | B | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-008` | Automation bias is the tendency to accept automated advice despite contrary evidence. | A | `trust/02-overtrust-distrust.md` |
| `RES-TRU-009` | Honest absence (`NOT REPORTED`) preserves trust better than fabricated presence. | D | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-010` | Trust is asymmetric: a single severe violation costs more than many small successes earn. | B | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-011` | Authority without policy is safer than policy without authority; the user must know which is absent. | C | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-012` | Privacy is contextual: the same disclosure is appropriate in one audience and a violation in another. | A | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-013` | Continuous monitoring changes behaviour even when the observer is benign. | B | `trust/03-transparency-privacy-repair-limits.md` |
| `RES-TRU-014` | A capability the user cannot revoke is not a permission; it is a condition. | B | `trust/03-transparency-privacy-repair-limits.md` |

### 4.6 Learning (LEA)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-LEA-001` | Novices need explicit structure; experts need efficient access and resent forced structure. | A | `learning/01-novice-expert-disclosure.md` |
| `RES-LEA-002` | Progressive disclosure reduces initial load but hides the path to mastery if the deeper layer is undiscoverable. | B | `learning/01-novice-expert-disclosure.md` |
| `RES-LEA-003` | Transfer is improved by varied practice and shared structure, not by identical surface form. | A | `learning/02-transfer-consistency-recall.md` |
| `RES-LEA-004` | Internal consistency lets a skill learned in one app transfer to another. | B | `learning/02-transfer-consistency-recall.md` |
| `RES-LEA-005` | Recognition over recall is a learning aid as well as a performance aid. | B | `learning/02-transfer-consistency-recall.md` |
| `RES-LEA-006` | Errors are informative when they are immediate, specific and reversible. | B | `learning/03-errorful-and-limits.md` |
| `RES-LEA-007` | Deliberate practice requires a defined task, immediate feedback and repetition at the edge of ability. | B | `learning/03-errorful-and-limits.md` |
| `RES-LEA-008` | Scaffolding must fade; a permanent tutorial teaches dependence. | B | `learning/01-novice-expert-disclosure.md` |
| `RES-LEA-009` | Expertise is domain-specific; a power user in one app is a novice in the next. | A | `learning/01-novice-expert-disclosure.md` |
| `RES-LEA-010` | Spacing and retrieval practice improve retention more than massed exposure. | A | `learning/03-errorful-and-limits.md` |
| `RES-LEA-011` | "Intuitive" is a property of a learned schema, not of a control in isolation. | B | `learning/02-transfer-consistency-recall.md` |
| `RES-LEA-012` | Onboarding that blocks the first task is a cost, not a benefit. | C | `learning/01-novice-expert-disclosure.md` |

### 4.7 Attention (ATT)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-ATT-001` | Attention is finite and task-specific; multitasking is rapid switching with a cost. | A | `attention/01-budget-interruption.md` |
| `RES-ATT-002` | Interruptions increase speed but also stress, frustration and effort. | B | `attention/01-budget-interruption.md` |
| `RES-ATT-003` | Interruption cost depends on timing, task structure and the resumption lag it creates. | A | `attention/01-budget-interruption.md` |
| `RES-ATT-004` | Resumption is supported by external cues and by preserving the pre-interruption context. | B | `attention/02-resumption-notifications.md` |
| `RES-ATT-005` | Notification fatigue is a base-rate problem: too many low-value signals train people to ignore all signals. | A | `attention/02-resumption-notifications.md` |
| `RES-ATT-006` | Signal detection separates sensitivity from response bias; a user who misses a signal may be biased, not insensitive. | A | `attention/03-signal-alarm-restoration-limits.md` |
| `RES-ATT-007` | Alarm fatigue is produced by high false-positive rates, poor specificity and indistinguishable alarms. | A | `attention/03-signal-alarm-restoration-limits.md` |
| `RES-ATT-008` | Vigilance declines over time in monotonous monitoring tasks. | A | `attention/03-signal-alarm-restoration-limits.md` |
| `RES-ATT-009` | Directed attention fatigues and recovers in restorative environments. | B | `attention/03-signal-alarm-restoration-limits.md` |
| `RES-ATT-010` | Salience is not importance; the most visually salient event wins attention regardless of value. | A | `attention/02-resumption-notifications.md` |
| `RES-ATT-011` | Interruption at a boundary is cheaper than interruption mid-task. | B | `attention/01-budget-interruption.md` |
| `RES-ATT-012` | The cost of an interruption includes the time to resume, not only the time to respond. | A | `attention/02-resumption-notifications.md` |
| `RES-ATT-013` | A notification system without a budget becomes an attention tax on every other task. | C | `attention/02-resumption-notifications.md` |

### 4.8 Safety-critical (SAF)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-SAF-001` | Situation awareness has three levels: perception, comprehension and projection. | A | `safety-critical/01-situation-awareness.md` |
| `RES-SAF-002` | SA is lost faster than it is built; out-of-the-loop operators need time to re-engage. | A | `safety-critical/01-situation-awareness.md` |
| `RES-SAF-003` | Workload is multidimensional; time pressure, mental demand and physical demand are not interchangeable. | A | `safety-critical/02-workload-fatigue.md` |
| `RES-SAF-004` | Fatigue degrades attention, timing and error checking before it degrades gross motor performance. | B | `safety-critical/02-workload-fatigue.md` |
| `RES-SAF-005` | Most harmful errors are slips and mistakes embedded in systemic conditions, not individual negligence. | A | `safety-critical/03-human-error-and-procedures.md` |
| `RES-SAF-006` | Barriers fail in combination; the Swiss-cheese model explains accidents as aligned holes, not a single cause. | A | `safety-critical/03-human-error-and-procedures.md` |
| `RES-SAF-007` | Procedures and checklists reduce omission errors when they are short, specific and used at the right moment. | A | `safety-critical/03-human-error-and-procedures.md` |
| `RES-SAF-008` | Alarm design must prioritise signal-in-noise, distinguishability and actionable specificity. | A | `safety-critical/04-alarm-complacency.md` |
| `RES-SAF-009` | Automation complacency is a function of trust, workload and the missed-failure feedback loop. | A | `safety-critical/04-alarm-complacency.md` |
| `RES-SAF-010` | Mode error arises when the operator's model of the system state is wrong and the interface does not expose it. | A | `safety-critical/04-alarm-complacency.md` |
| `RES-SAF-011` | Safety-II treats normal work as the source of resilience, not only deviations as failures. | B | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-012` | Deterministic timing and bounded motion are safety requirements, not polish. | B | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-013` | Driver distraction guidelines limit glance time; a task that exceeds them is not made safe by a large screen. | A | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-014` | Spaceflight displays must survive gloves, vibration, glare and non-rectangular geometry. | A | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-015` | Redundancy helps only when failures are independent and the operator can tell which channel is trustworthy. | B | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-016` | Alarm flood is an attention failure, not an operator failure. | A | `safety-critical/04-alarm-complacency.md` |
| `RES-SAF-017` | A safety-critical interface must state what it does not know. | B | `safety-critical/05-domain-requirements-and-limits.md` |
| `RES-SAF-018` | Training and interface design are one system; a procedure that depends on memorised exceptions is fragile. | B | `safety-critical/03-human-error-and-procedures.md` |

### 4.9 Accessibility (A11Y)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-A11Y-001` | WCAG 2.2 conformance is a floor, not a proof of usability. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-002` | Pointer targets must be at least 24×24 CSS px (AA) with exceptions; 44×44 is the safer baseline. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-003` | Every dragging operation must have a non-dragging alternative. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-004` | Motion triggered by interaction must be disableable unless essential. | A | `accessibility/02-vestibular-and-motion.md` |
| `RES-A11Y-005` | Text and essential graphics need contrast against their actual background, including states. | A | `accessibility/03-colour-vision-and-motor.md` |
| `RES-A11Y-006` | Colour must not be the only visual means of conveying information. | A | `accessibility/03-colour-vision-and-motor.md` |
| `RES-A11Y-007` | Semantics must be programmatically determinable and updated with the visual state. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-008` | Focus must be visible, ordered and never trapped without an exit. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-009` | Content must reflow and remain usable at 200% text and 320 CSS px width. | A | `accessibility/05-text-screenreaders-and-limits.md` |
| `RES-A11Y-010` | Vestibular triggers include parallax, zoom, spin and large-field motion; a reduced-motion mode must remove travel, not meaning. | B | `accessibility/02-vestibular-and-motion.md` |
| `RES-A11Y-011` | Switch, voice and gaze access require an operable focus model and a path that does not depend on precision pointing. | A | `accessibility/04-cognitive-switch-voice.md` |
| `RES-A11Y-012` | Cognitive accessibility requires plain language, consistent placement, error prevention and enough time. | A | `accessibility/04-cognitive-switch-voice.md` |
| `RES-A11Y-013` | Screen-reader output must be concise, ordered and announced without stealing focus. | A | `accessibility/05-text-screenreaders-and-limits.md` |
| `RES-A11Y-014` | Colour-vision deficiency affects a substantial minority; red/green coding fails dichromats. | A | `accessibility/03-colour-vision-and-motor.md` |
| `RES-A11Y-015` | Flashing above three times per second is a seizure risk. | A | `accessibility/02-vestibular-and-motion.md` |
| `RES-A11Y-016` | Assistive technology is a combination of OS, app and user settings; testing one stack does not certify another. | B | `accessibility/05-text-screenreaders-and-limits.md` |
| `RES-A11Y-017` | Accessible names must match visible labels so voice control can address the control. | A | `accessibility/01-wcag-aria.md` |
| `RES-A11Y-018` | Hover-only content is inaccessible on touch and to keyboard users. | A | `accessibility/03-colour-vision-and-motor.md` |
| `RES-A11Y-019` | Time limits must be adjustable or removable unless essential. | A | `accessibility/04-cognitive-switch-voice.md` |
| `RES-A11Y-020` | Motion sickness susceptibility varies; a design that is comfortable for one person can disable another. | B | `accessibility/02-vestibular-and-motion.md` |
| `RES-A11Y-021` | Accessibility must be structural, derived from the same model that draws the screen. | A | `accessibility/01-wcag-aria.md` |

### 4.10 Culture and language (CUL)

| ID | Principle | Grade | File |
|---|---|---|---|
| `RES-CUL-001` | National culture scores describe group tendencies; they cannot predict an individual. | A | `culture-language/01-models-rtl.md` |
| `RES-CUL-002` | High-context and low-context communication change how much text can assume. | B | `culture-language/01-models-rtl.md` |
| `RES-CUL-003` | Right-to-left scripts require direction-aware layout, not mirrored screenshots. | A | `culture-language/01-models-rtl.md` |
| `RES-CUL-004` | The Unicode bidi algorithm resolves mixed-direction text; manual reordering breaks it. | A | `culture-language/01-models-rtl.md` |
| `RES-CUL-005` | Arabic and Indic scripts require shaping and contextual glyph forms; a font that lacks them is not a font for that script. | A | `culture-language/02-scripts-numerals.md` |
| `RES-CUL-006` | Numerals are not universal: Arabic-Indic, Eastern Arabic-Indic and Western digits coexist. | A | `culture-language/02-scripts-numerals.md` |
| `RES-CUL-007` | Dates, times, units and currency must be locale-formatted, not pattern-formatted by hand. | A | `culture-language/02-scripts-numerals.md` |
| `RES-CUL-008` | Icon meaning is learned and can invert across cultures; text labels are the safety net. | B | `culture-language/03-icons-translation.md` |
| `RES-CUL-009` | Translation is not localisation; truncation, plurals, gender and honourifics break layouts. | A | `culture-language/03-icons-translation.md` |
| `RES-CUL-010` | Privacy and dignity norms are contextual, not universal. | A | `culture-language/04-dignity-privacy-limits.md` |
| `RES-CUL-011` | WEIRD samples dominate psychology; generalising them to all users is a category error. | A | `culture-language/04-dignity-privacy-limits.md` |
| `RES-CUL-012` | Language tags and fallback must follow BCP 47; a locale is not a country. | A | `culture-language/02-scripts-numerals.md` |
| `RES-CUL-013` | Humour, metaphor and colour symbolism do not translate reliably. | C | `culture-language/03-icons-translation.md` |
| `RES-CUL-014` | Names and personal data have script, order and honorific rules that a single "first/last" field violates. | B | `culture-language/04-dignity-privacy-limits.md` |
| `RES-CUL-015` | Localisation quality is a trust signal; a machine-translated safety message is a hazard. | C | `culture-language/03-icons-translation.md` |
| `RES-CUL-016` | A locale may be multilingual and a user may be multilingual within one session. | B | `culture-language/04-dignity-privacy-limits.md` |

### 4.11 Cross-cutting (PRI, DEP, INP, PRF, TIM)

| ID range | Domain | Count | File |
|---|---|---|---|
| `RES-PRI-001`–`012` | Platform prior art and what not to copy | 12 | `prior-art/` |
| `RES-DEP-001`–`011` | Depth semantics, light, parallax, failure | 11 | `depth/` |
| `RES-INP-001`–`014` | Pointer, touch, keyboard, remote, voice, latency | 14 | `input/` |
| `RES-PRF-001`–`012` | Thresholds, jank, power, measurement, budgets | 12 | `performance/` |
| `RES-TIM-001`–`009` | Ageing, durability, falsifiability, decade test | 9 | `timelessness/` |

The cross-cutting IDs are expanded in their domain files. They are not repeated here to
avoid a second owner for the same fact.

---

## 5. Envelope relevance matrix

`●` = the domain constrains this envelope; `○` = constrains it only through a shared
primitive; `—` = not a material constraint.

| Domain | Watch | Phone | Tablet | Desktop | TV | EV | Spaceship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|
| Perception | ● | ● | ● | ● | ● | ● | ● | ○ | ● | ● |
| Cognition | ● | ● | ● | ● | ● | ● | ● | ○ | ● | ● |
| Motor | ● | ● | ● | ● | ● | ● | ● | — | ● | ● |
| Emotion | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Trust | ● | ● | ● | ● | ○ | ● | ● | ● | ● | ● |
| Learning | ● | ● | ● | ● | ● | ○ | ● | ○ | ● | ● |
| Attention | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Safety | ○ | ○ | ○ | ○ | ○ | ● | ● | ○ | ○ | ○ |
| Accessibility | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Culture | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Prior art | ● | ● | ● | ● | ● | ● | ● | ○ | ● | ● |
| Depth | ○ | ● | ● | ● | ● | ● | ● | — | ● | ● |
| Input | ● | ● | ● | ● | ● | ● | ● | ○ | ● | ● |
| Performance | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Timelessness | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |

The EV and spaceship columns are not "phone with a bigger screen". Their safety rows are
normative and are expanded in `ux-principles/safety-critical/05-domain-requirements-and-limits.md`.

---

## 6. Evidence policy

1. **Primary first.** Standards, peer-reviewed papers, original books, official platform
   documentation. Vendor heuristics are prior art, not evidence about human outcomes.
2. **Two-source rule for normative claims.** A claim that becomes a `MUST` in the corpus
   needs either one grade-A source or two independent grade-B sources. A single grade-C
   source may produce a `SHOULD` and a test, not a `MUST`.
3. **Design hypotheses are labelled.** A claim with no direct human-outcome evidence is
   marked *Design hypothesis* and must name the test that would falsify it.
4. **No invented numbers.** Where a source reports a range, the range is quoted. Where a
   derivation is ours (for example, a frame budget from a refresh rate), it is marked as a
   derivation and shown.
5. **No source laundering.** A review is not a substitute for the study it reviews when the
   claim is specific. The register records which level was read.
6. **Contradiction is content.** A contested finding is reported with both sides and the
   design consequence of the uncertainty.

---

## 7. Gap register

These are real gaps. They are not hidden in prose.

| ID | Gap | Consequence | Owner | Deadline |
|---|---|---|---|---|
| `GAP-RES-01` | No Naledzi-specific empirical study exists. Every Naledzi implication is a hypothesis until tested. | All `MUST` claims rest on external evidence plus design argument. | UX Research Lead | Before `canon` |
| `GAP-RES-02` | No primary research with Naledzi's target disability communities. | Accessibility implications are standards-derived, not co-designed. | Accessibility Guild | Before envelope gate |
| `GAP-RES-03` | No reading study in the three primary Naledzi scripts. | Type and measure rules are Latin-derived. | Typography Guild | Before typography canon |
| `GAP-RES-04` | No vestibular user testing of parallax and spring motion. | Motion limits are conservative, not calibrated. | Motion Guild | Before motion canon |
| `GAP-RES-05` | No field data on notification tolerance in Naledzi contexts. | Budgets are proposed, not observed. | Shell Guild | Before notification canon |
| `GAP-RES-06` | No safety-case evidence for EV or spaceship envelopes. | Standards are minima; domain certification is external. | Safety Review Board | Before envelope canon |
| `GAP-RES-07` | Several key works are paywalled and were verified bibliographically, not read in full. | Specific page-level claims are avoided. | UX Research Lead | Ongoing |
| `GAP-RES-08` | Cross-cultural samples in the literature are WEIRD-heavy. | Cultural rules are framed as configuration, not universals. | UX Research Lead | Ongoing |
| `GAP-RES-09` | No longitudinal evidence for the decade test. | Timelessness claims are arguments, not results. | Canon Editor | 2036 review |
| `GAP-RES-10` | Vendor platform documentation is a moving target. | Prior-art claims carry an access date and are treated as snapshots. | UX Research Lead | Each corpus minor |

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-RES-001` | Every domain in §2 has a README, at least one principles file and a limits file, and every listed file exists. |
| `AC-RES-002` | Every principle ID in §4 appears in its named file with a source, evidence grade, Naledzi implication and acceptance test. |
| `AC-RES-003` | Every source cited in the subtree appears in `references/02-register.md` with a URL and the access date 2026-10-22. |
| `AC-RES-004` | No file contains `TODO`, `TBD`, "similar to", "and so on" or an uncited numeric claim about human behaviour. |
| `AC-RES-005` | Every `MUST` traced to research has either a grade-A source or two independent grade-B sources. |
| `AC-RES-006` | Every design hypothesis is labelled and has a falsification test. |
| `AC-RES-007` | The envelope matrix in §5 has no blank cell and each `●` is expanded in an envelope-relevant file. |
| `AC-RES-008` | A reader can start at any principle ID, reach its source and its acceptance test in at most two links. |

---

## 9. How this matrix is maintained

- A new principle gets a new ID in §4 and a paragraph in its domain file. It does not get
  appended to a list without a home.
- A refuted principle is marked `superseded` in its file and in this register; the ID is
  never reused.
- A new source is added to `references/02-register.md` first, with the date it was opened,
  then cited.
- If a domain file grows past one question, it is split and this matrix is updated in the
  same change.
- The matrix is not a summary of the corpus. It is the proof that the corpus has no blank
  cells.
