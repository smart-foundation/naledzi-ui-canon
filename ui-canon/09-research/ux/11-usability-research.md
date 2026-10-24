---
id: UX-USABILITY-RESEARCH
title: Usability Research — Formative/Summative Testing, Think-Aloud, Task Metrics, Field Studies, Simulator Testing, Inclusive Recruitment, Ethics
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-USABILITY-001, AC-UX-USABILITY-002, AC-UX-USABILITY-003]
---

# Usability Research

> How we know any of this is true. Method, metrics, recruitment, ethics. Usability is
> measured, not asserted.

## 1. Principle

A claim about people requires evidence. Formative research shapes the design before it
is built; summative research proves it after. Think-aloud reveals the mental model.
Task metrics (time, errors, completion) are objective. Field studies catch what the lab
misses. Simulator testing is mandatory for safety envelopes. Inclusive recruitment is
mandatory: a sample that excludes disabled, older, non-dominant-language and
low-literacy users is not a sample. Ethics is not optional.

## 2. Evidence

### 2.1 Formative and summative

- **Nielsen, J. (1993).** *Usability Engineering.* Academic Press. (URL:
  https://www.worldcat.org/title/usability-engineering/oclc/27614242 ; accessed
  23 October 2026.) Finding: usability engineering is a systematic process with
  measurable goals; discount methods (heuristic evaluation, think-aloud) are cheap and
  effective. Implication: Naledzi uses discount methods early and formal tests late;
  every feature has a usability goal.

- **Rubin, J. and Chisnell, D. (2008).** *Handbook of Usability Testing: How to Plan,
  Design, and Conduct Effective Tests* (2nd ed.). Wiley. (URL:
  https://www.wiley.com/en-us/Handbook+of+Usability+Testing-p-9780470185483 ;
  accessed 23 October 2026.) Finding: usability testing is a planned, repeatable
  process with defined tasks, metrics and analysis. Implication: Naledzi usability
  tests are documented with tasks, metrics and analysis; a test without a metric is
  not a test.

- **Dumas, J. S. and Redish, J. C. (1999).** *A Practical Guide to Usability
  Testing.* Intellect. (URL:
  https://www.worldcat.org/title/practical-guide-to-usability-testing/oclc/41046976 ;
  accessed 23 October 2026.) Finding: practical guidance on planning, conducting and
  reporting usability tests. Implication: Naledzi usability reports follow a standard
  template (task, metric, result, recommendation).

### 2.2 Think-aloud

- **Ericsson, K. A. and Simon, H. A. (1993).** *Protocol Analysis: Verbal Reports as
  Data* (revised ed.). MIT Press. (URL:
  https://mitpress.mit.edu/9780262550230/protocol-analysis/ ; accessed 23 October
  2026.) Finding: concurrent think-aloud captures the mental process; retrospective
  captures reconstruction. Implication: Naledzi formative tests use concurrent
  think-aloud to capture the mental model; retrospective is used for emotion.

### 2.3 Task metrics

- **ISO 9241-11:2018.** *Usability: Definitions and concepts.* (URL:
  https://www.iso.org/standard/63500.html ; accessed 23 October 2026.) Finding:
  usability = effectiveness, efficiency, satisfaction in a specified context.
  Implication: every AC measures all three where applicable.

- **Sauro, J. and Lewis, J. R. (2016).** *Quantifying the User Experience: Practical
  Statistics for User Research* (2nd ed.). Morgan Kaufmann. (URL:
  https://www.elsevier.com/books/quantifying-the-user-experience/sauro/978-0-12-802308-2 ;
  accessed 23 October 2026.) Finding: task metrics (completion, time, errors) and
  standardised questionnaires (SUS, UMUX) are the standard. Implication: Naledzi
  uses SUS/UMUX-Lite for satisfaction and task metrics for effectiveness/efficiency;
  a score without a baseline is not a score.

### 2.4 Field studies

- **Blomberg, J., Giacomi, J., Mosher, A. and Swenton-Wall, P. (1993).** "Ethnographic
  field methods and their relation to design." In *Participatory Design: Principles
  and Practices*, D. Schuler and A. Namioka (eds.), Erlbaum, pp. 123–155. (URL:
  https://www.worldcat.org/title/participatory-design/oclc/26218390 ; accessed
  23 October 2026.) Finding: field studies reveal context that the lab cannot. Implication:
  Naledzi rare cases and envelope designs are validated in field studies where
  possible (EV in cars, spaceship in simulators).

### 2.5 Simulator testing

- **FAA (2016).** *HF-STD-001B.* (URL: https://hf.tc.faa.gov/hfstd/ ; accessed
  23 October 2026.) Finding: simulator testing is required for safety-critical
  interfaces. Implication: EV and spaceship envelopes are tested in simulators with
  realistic workload.

### 2.6 Inclusive recruitment

- **Henry, S. L. (2007).** *Just Ask: Integrating Accessibility Throughout Design.*
  (URL: https://www.uiaccess.com/justask/ ; accessed 23 October 2026.) Finding:
  accessibility must be integrated throughout design, with disabled users recruited
  throughout. Implication: Naledzi usability tests recruit disabled, older,
  non-dominant-language and low-literacy users as a matter of course, not as a
  separate "accessibility test".

- **Lazar, J., Feng, J. H. and Hochheiser, H. (2017).** *Research Methods in
  Human-Computer Interaction* (2nd ed.). Morgan Kaufmann. (URL:
  https://www.elsevier.com/books/research-methods-in-human-computer-interaction/lazar/978-0-12-805390-4 ;
  accessed 23 October 2026.) Finding: HCI research methods including recruitment,
  ethics and analysis. Implication: Naledzi research follows standard HCI method
  and reports limitations.

### 2.7 Ethics

- **ACM (2018).** *ACM Code of Ethics and Professional Conduct.* (URL:
  https://www.acm.org/code-of-ethics ; accessed 23 October 2026.) Finding: ethical
  obligations for computing professionals. Implication: Naledzi research follows the
  ACM code; no dark patterns, no deceptive recruitment, informed consent.

- **Belmont Report (1979).** *Ethical Principles and Guidelines for the Protection
  of Human Subjects of Research.* (URL: https://www.hhs.gov/ohrp/regulations-and-policy/belmont-report/index.html ;
  accessed 23 October 2026.) Finding: respect for persons, beneficence, justice.
  Implication: Naledzi research adheres to these principles.

## 3. What this predicts for Naledzi

1. **Usability is measured.** Task metrics + satisfaction; baseline required.
2. **Formative before summative.** Discount methods early.
3. **Think-aloud for mental models.**
4. **Field studies for context.**
5. **Simulator testing for safety.**
6. **Inclusive recruitment mandatory.**
7. **Ethics is not optional.**

## 4. Limits and contested claims

- Discount methods (heuristic evaluation) have variable reliability; they are a
  screen, not a proof. Formal testing is required for canon.
- Usability metrics from web contexts transfer to native OS with caution.

## 5. Where implemented (IDs)

- `UX-LAW-11`.
- `01-foundations/experience/10-acceptance.md`.
- `08-process/` — review gates.

## 6. Acceptance implications

- `AC-UX-USABILITY-001`: Every admitted feature has a usability goal and a test.
- `AC-UX-USABILITY-002`: Inclusive recruitment is documented for every study.
- `AC-UX-USABILITY-003`: Safety envelopes are tested in simulators.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-USABILITY-001` | Every feature has a usability goal and test. |
| `AC-UX-USABILITY-002` | Inclusive recruitment documented. |
| `AC-UX-USABILITY-003` | Safety envelopes simulator-tested. |