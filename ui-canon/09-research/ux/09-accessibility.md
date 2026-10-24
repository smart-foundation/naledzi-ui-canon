---
id: UX-ACCESSIBILITY
title: Accessibility — WCAG 2.2, WAI-ARIA, Vestibular, Colour Vision, Motor, Cognitive, Switch/Voice
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-ACCESSIBILITY-001, AC-UX-ACCESSIBILITY-002, AC-UX-ACCESSIBILITY-003]
---

# Accessibility

> Accessibility is structural, derived from the same semantics that draw the screen.
> It is not a parallel tree, not a retrofit, not an audit at the end.

## 1. Principle

Accessibility is a property of the model, not of the pixels. WCAG 2.2 is the floor; WAI-ARIA
supplies the role/name/state/action vocabulary; ISO 9241 supplies the ergonomics. Vestibular
disorders make motion sickness a first-class constraint. Colour-vision deficiency makes
colour a redundant carrier. Motor impairment makes target size and switch access mandatory.
Cognitive accessibility makes plain language and predictable behaviour mandatory. Switch
and voice access make every function reachable without a pointer.

## 2. Evidence

### 2.1 Standards

- **W3C (2024).** *Web Content Accessibility Guidelines (WCAG) 2.2.* W3C Recommendation,
  12 December 2024. (URL: https://www.w3.org/TR/WCAG22/ ; accessed 23 October 2026.)
  Finding: four principles (perceivable, operable, understandable, robust); testable
  success criteria at levels A, AA, AAA; new in 2.2: focus not obscured, dragging
  movements, target size (minimum), consistent help, redundant entry, accessible
  authentication. Implication: Naledzi targets WCAG 2.2 AA as a floor on all
  envelopes; AAA where the envelope permits; the new criteria are adopted (target size
  minimum, focus not obscured, dragging movements).

- **W3C (2023).** *WAI-ARIA 1.2.* W3C Recommendation. (URL:
  https://www.w3.org/TR/wai-aria-1.2/ ; accessed 23 October 2026.) Finding: roles,
  states and properties for accessible rich internet applications; the vocabulary
  for name/role/value. Implication: Naledzi's accessibility snapshot uses the
  WAI-ARIA role vocabulary; every component declares role, name, state, actions
  (`LAW-009`).

- **ISO 9241-171:2008.** *Ergonomics of human-system interaction — Part 171:
  Guidance on software accessibility.* (URL: https://www.iso.org/standard/39080.html ;
  accessed 23 October 2026.) Finding: software accessibility guidance covering
  vision, hearing, motor, speech and cognition. Implication: Naledzi cites ISO 9241-171
  for the non-web (native) accessibility requirements that WCAG does not cover.

- **ISO 9241-11:2018.** *Ergonomics of human-system interaction — Part 11:
  Usability: Definitions and concepts.* (URL: https://www.iso.org/standard/63500.html ;
  accessed 23 October 2026.) Finding: usability is effectiveness, efficiency and
  satisfaction in a specified context. Implication: Naledzi acceptance tests measure
  all three, not just completion.

### 2.2 Vestibular and motion sickness

- **Reason, J. T. and Brand, J. J. (1975).** *Motion Sickness.* Academic Press. (URL:
  https://www.worldcat.org/title/motion-sickness/oclc/1399292 ; accessed 23 October
  2026.) Finding: motion sickness arises from sensory conflict between visual,
  vestibular and proprioceptive signals. Implication: Naledzi reduced-motion mode
  removes parallax, travel and large-area motion; it is mandatory, not optional, and
  is the default for users who declare motion sensitivity.

- **Bos, J. E., Bles, W. and Groen, E. L. (2008).** "A theory on visually induced
  motion sickness." *Displays*, 29(2), pp. 47–57. (URL:
  https://doi.org/10.1016/j.displa.2007.09.002 ; accessed 23 October 2026.)
  Finding: visually induced motion sickness is driven by large-field visual motion
  and by display lag. Implication: Naledzi avoids large-field motion and keeps
  latency low; reduced-motion removes travel entirely.

- **W3C (2024).** WCAG 2.3.3 *Animation from Interactions* (AAA). (URL:
  https://www.w3.org/TR/WCAG22/#animation-from-interactions ; accessed 23 October
  2026.) Finding: motion triggered by interaction can be disabled unless essential.
  Implication: Naledzi reduced-motion is a system setting that removes travel while
  preserving the state change (WCAG 2.3.3, `FOUND-MOTION-005`).

### 2.3 Colour vision

- **Birch, J. (2012).** "Worldwide prevalence of red-green color deficiency."
  *Journal of the Optical Society of America A*, 29(3), pp. 313–320. (URL:
  https://doi.org/10.1364/JOSAA.29.000313 ; accessed 23 October 2026.) Finding:
  ~8% of males and ~0.5% of females have red-green deficiency. Implication: colour
  is never the only carrier of meaning (`WCAG 1.4.1`); shape, label and position
  accompany it.

- **Simunovic, M. P. (2010).** "Colour vision deficiency." *Eye*, 24, pp. 747–755.
  (URL: https://doi.org/10.1038/eye.2009.251 ; accessed 23 October 2026.)
  Finding: colour-vision deficiency is common and heterogeneous; design must not
  assume a single deficient palette. Implication: Naledzi provides a colour-vision
  mode and never relies on hue alone; contrast is measured, not assumed.

### 2.4 Motor impairment

- **Wobbrock, J. O., Myers, B. A. and Kuo, Y.-L. (2009).** "Ability-based design."
  *Communications of the ACM*, 52(6), pp. 55–61. (URL:
  https://doi.org/10.1145/1516046.1516063 ; accessed 23 October 2026.) Finding:
  design should adapt to the user's abilities, not assume a standard body.
  Implication: Naledzi supports switch, voice, eye-gaze and head-tracking inputs;
  target sizes and timeouts adapt.

- **WCAG 2.5.8 (2024).** *Target Size (Minimum)* (AA): 24 × 24 CSS px. (URL:
  https://www.w3.org/TR/WCAG22/#target-size-minimum ; accessed 23 October 2026.)
  Finding: minimum target size reduces error for motor-impaired users. Implication:
  Naledzi adopts 24 × 24 px as the AA floor and 44 × 44 px (2.5.5) as the AAA
  floor on touch envelopes.

### 2.5 Cognitive accessibility

- **W3C (2021).** *Making Content Usable for People with Cognitive and Learning
  Disabilities (COGA).* W3C Working Group Note. (URL:
  https://www.w3.org/TR/coga-usable/ ; accessed 23 October 2026.) Finding: plain
  language, predictable behaviour, forgiveness, focus, and support for memory and
  attention. Implication: Naledzi uses plain language in errors and help; behaviour
  is predictable (`WCAG 3.2.3`, `3.2.4`); no time pressure without adjustment
  (`WCAG 2.2.1`).

- **W3C (2024).** WCAG 3.3.7 *Redundant Entry* and 3.3.8 *Accessible
  Authentication*. (URL: https://www.w3.org/TR/WCAG22/ ; accessed 23 October 2026.)
  Finding: do not ask for the same information twice; do not rely on cognitive
  tests for authentication. Implication: Naledzi never re-asks for information
  already entered in the same flow; authentication supports password managers and
  passkeys.

### 2.6 Switch and voice

- **W3C (2023).** WAI-ARIA Authoring Practices Guide (APG). (URL:
  https://www.w3.org/WAI/ARIA/apg/ ; accessed 23 October 2026.) Finding: patterns
  for keyboard, screen-reader and switch access. Implication: Naledzi components
  follow APG patterns for focus order, roving tabindex and announcements.

## 3. What this predicts for Naledzi

1. **WCAG 2.2 AA is the floor** on every envelope.
2. **Accessibility is structural** (`LAW-009`): derived from the same model that
   draws the screen; no parallel tree.
3. **Reduced motion is mandatory** and removes travel while preserving the state
   change.
4. **Colour is never the only carrier** (shape + label + position).
5. **Target sizes:** 24 × 24 px (AA), 44 × 44 px (AAA on touch).
6. **Switch, voice, eye-gaze and head-tracking** are first-class inputs.
7. **Plain language and predictable behaviour** in errors and help.
8. **No redundant entry; no cognitive tests for auth.**

## 4. Limits and contested claims

- WCAG is web-oriented; transfer to native OS controls is interpretation, but
  WCAG 2.2 is the best-evidenced, most testable standard available and is adopted.
- Vestibular research is largely clinical; the reduced-motion default is a
  conservative, low-risk choice.

## 5. Where implemented (IDs)

- `UX-LAW-09`.
- `LAW-009`.
- `01-foundations/accessibility/` (foundation).
- `01-foundations/experience/` (this subtree).
- `07-wireframes/modes/spacious/` — spacious helps motor and cognitive
  accessibility.

## 6. Acceptance implications

- `AC-UX-ACCESSIBILITY-001`: All reference screens pass WCAG 2.2 AA automated
  checks.
- `AC-UX-ACCESSIBILITY-002`: Reduced-motion mode removes travel while the state
  change remains visible or announced.
- `AC-UX-ACCESSIBILITY-003`: Full golden flow completes with keyboard only and with
  a screen reader.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-ACCESSIBILITY-001` | WCAG 2.2 AA automated pass. |
| `AC-UX-ACCESSIBILITY-002` | Reduced motion preserves state change. |
| `AC-UX-ACCESSIBILITY-003` | Keyboard and screen-reader flow pass. |