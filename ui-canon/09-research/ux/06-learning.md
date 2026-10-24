---
id: UX-LEARNING
title: Learning — Novice-Expert, Progressive Disclosure, Transfer, Consistency, Recognition over Recall
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-COGNITION, UX-MOTOR]
supersedes: []
superseded_by: []
acceptance: [AC-UX-LEARNING-001, AC-UX-LEARNING-002, AC-UX-LEARNING-003]
---

# Learning

> How a person learns the system, how expertise changes the interface, and why
> recognition beats recall.

## 1. Principle

People learn by doing, not by reading. Novices need recognition, guidance and
forgiveness; experts need speed, shortcuts and density. Progressive disclosure reveals
complexity only when needed. Consistency lets knowledge transfer from one part of the
system to another. Recognition (seeing the right thing) is easier than recall (remembering
it). The first success must happen without a manual.

## 2. Evidence

### 2.1 Novice-expert differences

- **Chi, M. T. H., Glaser, R. and Farr, M. J. (eds.) (1988).** *The Nature of
  Expertise.* Lawrence Erlbaum. (URL:
  https://www.worldcat.org/title/nature-of-expertise/oclc/17206453 ; accessed 23 October
  2026.) Finding: experts chunk and pattern-match; novices reason from first
  principles. Implication: Naledzi groups and labels for novices; experts get
  accelerators and density; neither is the only path.

- **Ericsson, K. A., Krampe, R. T. and Tesch-Römer, C. (1993).** "The role of
  deliberate practice in the acquisition of expert performance." *Psychological Review*,
  100(3), pp. 363–406. (URL: https://doi.org/10.1037/0033-295X.100.3.363 ; accessed
  23 October 2026.) Finding: expertise is built by deliberate practice with feedback,
  not by exposure. Implication: Naledzi must give feedback on every action (visible,
  announced) so practice can occur; silent actions cannot be learned.

### 2.2 Progressive disclosure

- **Nielsen, J. (2006).** "Progressive disclosure." *Nielsen Norman Group.* (URL:
  https://www.nngroup.com/articles/progressive-disclosure/ ; accessed 23 October 2026.)
  Finding: show only what is needed for the current task; reveal advanced options on
  demand. Limit: requires knowing what is "needed"; misjudgement hides essentials.
  Implication: Naledzi's default view is the simple one; advanced controls are in
  Settings or behind an explicit "more"; the primary action is never hidden.

- **Tidwell, J. (2010).** *Designing Interfaces* (2nd ed.). O'Reilly. (URL:
  https://www.oreilly.com/library/view/designing-interfaces-2nd/9781449379704/ ;
  accessed 23 October 2026.) Finding: progressive disclosure patterns (staged
  disclosure, wizard, palette) reduce initial complexity. Implication: Naledzi uses
  staged disclosure and the palette as the universal "more"; no multi-step wizard
  without a skip path.

### 2.3 Transfer and consistency

- **Norman, D. A. (1988).** *The Design of Everyday Things.* Basic Books. (URL:
  https://www.worldcat.org/title/design-of-everyday-things/oclc/17693014 ; accessed
  23 October 2026.) Finding: consistency lets the user transfer knowledge; one
  grammar across the system. Implication: `LAW-013` — one vocabulary, one grammar;
  domain differences do not justify grammar differences.

- **Nielsen, J. and Molich, R. (1990).** "Heuristic evaluation of user interfaces."
  *Proceedings of CHI '90*, pp. 249–256. (URL:
  https://doi.org/10.1145/97243.97281 ; accessed 23 October 2026.) Finding: ten
  heuristics, including consistency and standards, recognition rather than recall,
  help and documentation. Implication: Naledzi's heuristics are these, grounded in
  research; vendor heuristics alone are not enough (master brief §5).

### 2.4 Recognition over recall

- **Norman, D. A. (1988).** (as above.) Finding: recognition is easier than recall;
  visible options beat memorised commands. Implication: shortcuts are accelerators,
  never the only path (`LAW-010` spirit); the palette lists actions by name.

- **Shneiderman, B. (1982).** "The future of interactive systems and the emergence
  of direct manipulation." *Behaviour & Information Technology*, 1(3), pp. 237–256.
  (URL: https://doi.org/10.1080/01449298208914450 ; accessed 23 October 2026.)
  Finding: direct manipulation — continuous representation, physical actions,
  rapid reversible incremental feedback — improves learning and retention.
  Implication: Naledzi direct manipulation wherever possible; effects are visible
  immediately.

### 2.5 Onboarding

- **Carroll, J. M. and Rosson, M. B. (1987).** "Paradox of the active user." In
  *Interfacing Thought: Cognitive Aspects of Human-Computer Interaction*, J. M.
  Carroll (ed.), MIT Press, pp. 80–111. (URL:
  https://www.worldcat.org/title/interfacing-thought/oclc/15082260 ; accessed
  23 October 2026.) Finding: users skip manuals and learn by doing, even when reading
  would be faster. Implication: Naledzi onboarding is learn-by-doing; no forced
  tour; the first success happens in under a minute.

## 3. What this predicts for Naledzi

1. **Recognition over recall.** Visible options, labelled actions, palette by name.
2. **Progressive disclosure.** Simple default; advanced on demand.
3. **Consistency.** One grammar (`LAW-013`).
4. **First success without a manual.** First-contact test.
5. **Feedback on every action.** Silent actions cannot be learned.
6. **Shortcuts are accelerators.** Never the only path.

## 4. Limits and contested claims

- Progressive disclosure can hide essentials if the designer misjudges need; must be
  validated per flow.
- Expertise effects are domain-specific; a person can be expert in one app and novice
  in another; density must be per-app and per-person, not global.

## 5. Where implemented (IDs)

- `UX-LAW-06`.
- `LAW-010`, `LAW-013`, `LAW-018`.
- `01-foundations/experience/04-onboarding.md`.
- `03-framework/palette/`.

## 6. Acceptance implications

- `AC-UX-LEARNING-001`: First-contact user completes the golden flow of the
  calculator exemplar without a manual or tour.
- `AC-UX-LEARNING-002`: Every action in the reference set produces visible or
  announced feedback.
- `AC-UX-LEARNING-003`: Shortcuts are never the only path to any function.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-LEARNING-001` | Golden flow completes without manual/tour. |
| `AC-UX-LEARNING-002` | Every action has feedback. |
| `AC-UX-LEARNING-003` | No shortcut-only functions. |