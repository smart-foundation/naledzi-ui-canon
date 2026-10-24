---
id: UX-RESEARCH-INDEX
title: UX, Usability and Timelessness Research
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, PROC-COMPLETENESS, PROC-APPEND-ONLY, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-RESEARCH-000, AC-UX-RESEARCH-001, AC-UX-RESEARCH-002]
children:
  - 01-perception.md
  - 02-cognition.md
  - 03-motor.md
  - 04-emotion.md
  - 05-trust.md
  - 06-learning.md
  - 07-attention.md
  - 08-safety-critical.md
  - 09-accessibility.md
  - 10-culture-language.md
  - 11-usability-research.md
  - 12-timelessness.md
  - 13-spacious.md
  - 14-sources.md
  - 15-implications.md
  - 16-open-questions.md
  - 17-changelog.md
---

# UX, Usability and Timelessness Research

> UX is everything. UX is part of timelessness. Usability research and UX rules govern
> timeless design. This subtree is the research foundation that every foundation, component,
> shell, envelope and app in the Naledzi corpus must cite when it makes a claim about a
> person. It is normative: a design that contradicts a principle stated here fails unless an
> ADR records a scoped exception with evidence.

**Scope.** Human perception, cognition, motor control, emotion, trust, learning, attention,
safety-critical behaviour, accessibility, culture and language, usability research method,
timelessness, and spacious density. Plus the full bibliography and a traceability table from
principle to Naledzi law and implementation.

**Non-goals.** Marketing personas, mood boards, platform-specific heuristics presented as
universal, and any principle without a source, a limit and an implication.

---

## 1. How this subtree binds

1. **UX-RESEARCH-RULE-01.** Every claim about human behaviour in any corpus file MUST cite
   a file in this subtree or a source in `14-sources.md`. A vendor heuristic alone is not
   enough (master brief §5).
2. **UX-RESEARCH-RULE-02.** Every principle stated here MUST carry: the principle in one
   sentence; the source (author, title, year, URL, access date); evidence strength and
   limits; what it predicts for Naledzi; where it is implemented (IDs); where it is
   contradicted or uncertain.
3. **UX-RESEARCH-RULE-03.** Evidence is distinguished from interpretation. A finding is the
   source's; an implication is ours. The two are never merged.
4. **UX-RESEARCH-RULE-04.** Spacious is a **density mode**, not a theme. It changes spacing,
   visible action count and hierarchy calmness. It does not change meaning, colour, depth
   semantics or motion grammar. See `13-spacious.md` and
   `07-wireframes/modes/spacious/`.
5. **UX-RESEARCH-RULE-05.** Spacious degrades to compact by rule, never by opinion. See
   `13-spacious.md` §3.
6. **UX-RESEARCH-RULE-06.** No principle is admitted without a real, opened source. A
   search-result snippet is not a source (master brief §5.5).
7. **UX-RESEARCH-RULE-07.** Where evidence is thin, cultural or contested, the principle is
   marked as such in `16-open-questions.md` and in the traceability table.

---

## 2. Directory map

| File | Question it answers |
|---|---|
| [01-perception.md](01-perception.md) | How does the person perceive depth, motion, change and occlusion, and what does that force on the screen? |
| [02-cognition.md](02-cognition.md) | How does attention, memory and decision-making constrain what we show and how many choices we offer? |
| [03-motor.md](03-motor.md) | How does the body move, point and gesture, and what target sizes and paths does that require? |
| [04-emotion.md](04-emotion.md) | What should the person feel, and how is each feeling produced and tested? |
| [05-trust.md](05-trust.md) | How is trust in the system built, calibrated and repaired? |
| [06-learning.md](06-learning.md) | How does a person learn the system, and how does expertise change the interface? |
| [07-attention.md](07-attention.md) | What is the attention budget, and what may interrupt it? |
| [08-safety-critical.md](08-safety-critical.md) | How do people perform under stress, workload and danger, and what does that force on safety envelopes? |
| [09-accessibility.md](09-accessibility.md) | How is the system usable by every sense, input and ability? |
| [10-culture-language.md](10-culture-language.md) | How does culture and language change meaning, dignity and layout? |
| [11-usability-research.md](11-usability-research.md) | How do we know any of this is true: method, metrics, ethics? |
| [12-timelessness.md](12-timelessness.md) | Why do designs age, and what primitives survive? |
| [13-spacious.md](13-spacious.md) | What is spacious density, and how does it degrade? |
| [14-sources.md](14-sources.md) | Full bibliography with URLs and access dates. |
| [15-implications.md](15-implications.md) | Traceability: principle → Naledzi law/decision → implementation → acceptance. |
| [16-open-questions.md](16-open-questions.md) | Unresolved questions, owners, deadlines. |
| [17-changelog.md](17-changelog.md) | Creation record. |

---

## 3. The UX laws (derived)

These are the binding UX rules derived from the research in this subtree. They are restated
here so an implementer does not have to read every file to know the shape.

- **UX-LAW-01 (Perception).** Occlusion is the dominant depth cue; depth MUST be encoded by
  more than shadow; change MUST be signalled by motion, not by a silent replacement.
- **UX-LAW-02 (Cognition).** Working memory holds roughly four chunks; a screen MUST NOT
  require holding more than four unrelated items; choice count grows logarithmically in
  cost; chunking and progressive disclosure are mandatory.
- **UX-LAW-03 (Motor).** Targets obey Fitts's law; edges and corners are infinite targets;
  minimum target size is 24 × 24 CSS px at AA (WCAG 2.5.8) and 44 × 44 at AAA; steering
  tasks (menus, sliders) follow the Accot–Zhai steering law.
- **UX-LAW-04 (Emotion).** The default feeling is calm confidence; stress raises cognitive
  load and narrows attention; the system MUST reduce demand under stress and never blame.
- **UX-LAW-05 (Trust).** Trust is calibrated, not maximised; the system MUST be honest
  about automation, provenance and uncertainty; reversibility is mandatory.
- **UX-LAW-06 (Learning).** Recognition over recall; consistency over novelty; progressive
  disclosure; the first success MUST happen without a manual.
- **UX-LAW-07 (Attention).** Attention is finite and owned by the person; interruptions
  cost; quiet hours and notification budgets are mandatory; safety overrides are the only
  exception.
- **UX-LAW-08 (Safety).** Under high workload, displays must be simple, redundant and
  procedure-first; critical indicators never animate through occlusion; bounded motion only.
- **UX-LAW-09 (Accessibility).** Accessibility is structural and derived; the system
  targets WCAG 2.2 AA as a floor, with AAA where the envelope permits; motion sickness is
  a first-class constraint.
- **UX-LAW-10 (Culture).** No single culture is the default; dignity is not optional;
  localisation is structural, not a translation pass.
- **UX-LAW-11 (Research).** Claims about people require evidence; usability is measured,
  not asserted; inclusive recruitment is mandatory.
- **UX-LAW-12 (Timelessness).** A primitive survives only if it scores ≥ 16 on the
  timelessness test with no zero on criteria 1–4.
- **UX-LAW-13 (Spacious).** Spacious is a density mode; it increases spacing, reduces
  visible actions and calms hierarchy; it degrades to compact by declared rule.

---

## 4. Ownership and acceptance

**Owner.** UX, Timelessness, Spacious Design and Usability Research Lead.

**Consumers.** Every foundation, component, shell surface, app, envelope and wireframe in
the corpus. In particular `01-foundations/experience/`, `01-foundations/accessibility/`,
`03-framework/adaptivity/`, `04-shell/notifications/`, `06-envelopes/ev/`,
`06-envelopes/spaceship/` and `07-wireframes/`.

**Acceptance.**

| ID | Test |
|---|---|
| `AC-UX-RESEARCH-000` | Every file listed in `children` exists; no file contains `TODO`, an empty heading or "similar to". |
| `AC-UX-RESEARCH-001` | Every principle in files 01–13 carries a source, evidence strength, limit, Naledzi prediction, implementation IDs and acceptance implication. |
| `AC-UX-RESEARCH-002` | The traceability table in `15-implications.md` has no blank cell for any law in `00-canon/02-design-laws.md`. |
| `AC-UX-RESEARCH-003` | A stranger can find, for any Naledzi law, the research principle behind it and the file that implements it. |