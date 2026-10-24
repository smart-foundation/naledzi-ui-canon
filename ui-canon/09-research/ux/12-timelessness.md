---
id: UX-TIMELESSNESS
title: Timelessness — Why Designs Age, Durable Primitives, Falsifiability
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-TIMELESSNESS-001, AC-UX-TIMELESSNESS-002, AC-UX-TIMELESSNESS-003]
---

# Timelessness

> Why designs age, what primitives survive, and how to falsify a design claim.

## 1. Principle

Designs age because they ride fashion, because they depend on a specific input or
display, because they conflate need with form, and because they are not tested against
change. Durable primitives are those that serve a need older than computing, that work
across input, display and envelope, and that survive the removal of current fashion.
Falsifiability: a design claim is scientific only if it can be proved wrong by a test.
A claim that cannot be tested is not a design, it is an opinion.

## 2. Evidence

### 2.1 Why designs age

- **Norman, D. A. (1998).** *The Invisible Computer.* MIT Press. (URL:
  https://www.worldcat.org/title/invisible-computer/oclc/37398113 ; accessed 23 October
  2026.) Finding: technology that does not fit human needs ages; the interface should
  be invisible. Implication: Naledzi admits only primitives that serve a
  pre-computing need.

- **Cooper, A. (1999).** *The Inmates Are Running the Asylum.* Sams. (URL:
  https://www.worldcat.org/title/inmates-are-running-the-asylum/oclc/41024079 ;
  accessed 23 October 2026.) Finding: software is designed by engineers for
  engineers; goal-directed design starts from user goals. Implication: Naledzi
  derives apps from timeless human jobs, not from legacy app lists.

- **Alexander, C. (1977).** *A Pattern Language: Towns, Buildings, Construction.*
  Oxford University Press. (URL:
  https://www.worldcat.org/title/pattern-language/oclc/3117330 ; accessed 23 October
  2026.) Finding: patterns are solutions to problems in a context, with forces and a
  resolution; they are discovered, not invented. Implication: Naledzi's design
  primitives (Section Set, strip, palette, numbered still) are patterns with stated
  forces and resolutions; a primitive without forces is not admitted.

- **Alexander, C. (1979).** *The Timeless Way of Building.* Oxford University Press.
  (URL: https://www.worldcat.org/title/timeless-way-of-building/oclc/4822688 ;
  accessed 23 October 2026.) Finding: the timeless way is the quality without a name;
  it comes from patterns that fit. Implication: timelessness is not a style; it is
  the absence of friction between form and need.

### 2.2 Durable primitives

- **Norman, D. A. (2013).** *The Design of Everyday Things* (revised). Basic Books.
  (URL: https://www.worldcat.org/title/design-of-everyday-things/oclc/851388459 ;
  accessed 23 October 2026.) Finding: conceptual models survive; specific
  implementations do not. Implication: Naledzi specifies models, not pixels; the
  model survives the implementation.

- **Tognazzini, B. (2003).** "Principles of interaction design." *AskTog.* (URL:
  https://asktog.com/atc/principles-of-interaction-design/ ; accessed 23 October
  2026.) Finding: a set of interaction principles (anticipation, autonomy,
  colour-blindness, consistency, defaults, efficiency, ...) that have survived
  decades. Implication: Naledzi's principles are drawn from research, not from
  vendor lists, but the overlap is acknowledged.

### 2.3 Falsifiability

- **Popper, K. R. (1959).** *The Logic of Scientific Discovery.* Basic Books. (URL:
  https://www.worldcat.org/title/logic-of-scientific-discovery/oclc/474861 ; accessed
  23 October 2026.) Finding: a theory is scientific only if it is falsifiable.
  Implication: every Naledzi design claim must state the test that would prove it
  wrong; an untestable claim is not admitted.

- **Nielsen, J. (1993).** *Usability Engineering.* Academic Press. (URL:
  https://www.worldcat.org/title/usability-engineering/oclc/27614242 ; accessed
  23 October 2026.) Finding: usability goals are stated as measurable quantities
  before design. Implication: Naledzi ACs are written before implementation
  (`LAW-012`).

## 3. The timelessness test (summary)

From `00-canon/01-timelessness-test.md`: a primitive is admitted only if it scores
≥ 16 on the ten-criterion scorecard with no zero on criteria 1–4. A score of 12–15
means transform (keep the need, replace the form). Below 12, or a zero on 1–4,
means reject. Every primitive in Naledzi has a scored entry.

## 4. What this predicts for Naledzi

1. **Needs are ancient.** Communication, memory, navigation, creation, comparison,
   safety, status, play, care, belonging.
2. **Form is disposable.** The model survives the implementation.
3. **Primitives are scored.** No admission without a scorecard.
4. **Claims are falsifiable.** Every AC states the test that would fail it.
5. **Rejected ideas are recorded.** `05-anti-patterns.md` and the rejection log.

## 5. Limits and contested claims

- Timelessness is a hypothesis about the future; it cannot be proved, only tested
  against current change. The scorecard is a heuristic, not a law of nature.
- Alexander's pattern language is contested in architecture; its transfer to UI is
  interpretation.

## 6. Where implemented (IDs)

- `UX-LAW-12`.
- `CANON-TIMELESSNESS` — the timelessness test.
- `00-canon/05-anti-patterns.md` — rejection log.
- `08-process/` — review gates.

## 7. Acceptance implications

- `AC-UX-TIMELESSNESS-001`: Every primitive has a scored entry in the timelessness
  format.
- `AC-UX-TIMELESSNESS-002`: Every AC states the test that would fail it.
- `AC-UX-TIMELESSNESS-003`: No primitive is admitted on fashion alone.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-TIMELESSNESS-001` | Every primitive scored. |
| `AC-UX-TIMELESSNESS-002` | Every AC is falsifiable. |
| `AC-UX-TIMELESSNESS-003` | No fashion-only primitives. |