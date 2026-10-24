---
id: UX-SPACIOUS
title: Spacious — Spacious as Density Mode, Not Theme
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-COGNITION, UX-EMOTION, UX-ACCESSIBILITY]
supersedes: []
superseded_by: []
acceptance: [AC-UX-SPACIOUS-001, AC-UX-SPACIOUS-002, AC-UX-SPACIOUS-003]
---

# Spacious

> Spacious is a density mode, not a theme. It increases spacing, reduces visible
> actions and calms hierarchy. It degrades to compact by rule. It is not an aesthetic
> preference and not a separate product.

## 1. Principle

Density is a property of the layout, not of the visual language. Spacious mode changes
how much is shown and how far apart, never what is shown or what it means. It is
motivated by cognitive load (fewer visible actions reduce extraneous load), by motor
accessibility (larger targets and spacing), by stress (calmer hierarchy), and by
accessibility (larger touch targets, more whitespace for low vision). It degrades to
compact when space is insufficient, by a declared rule, never by opinion.

## 2. Evidence

### 2.1 Cognitive load and density

- **Sweller, J. (1988).** "Cognitive load during problem solving: effects on
  learning." *Cognitive Science*, 12(2), pp. 257–285. (URL:
  https://doi.org/10.1207/s15516709cog1202_4 ; accessed 23 October 2026.)
  Finding: extraneous load should be minimised. Implication: fewer visible actions
  reduce extraneous load; spacious mode is a load-reduction tool, not a style.

- **Tullis, T. S. (1983).** "The formatting of alphanumeric displays: a review and
  analysis." *Human Factors*, 25(6), pp. 657–682. (URL:
  https://doi.org/10.1177/001872088302500604 ; accessed 23 October 2026.)
  Finding: density and layout affect search time and error; moderate density is
  optimal; extreme density hurts. Implication: spacious mode targets a moderate,
  calm density; compact mode targets a higher density for experts; both are bounded.

### 2.2 Motor accessibility and spacing

- **WCAG 2.5.8 (2024).** *Target Size (Minimum)* (AA): 24 × 24 CSS px. (URL:
  https://www.w3.org/TR/WCAG22/#target-size-minimum ; accessed 23 October 2026.)
  Finding: minimum target size reduces error. Implication: spacious mode increases
  target size and spacing beyond the minimum, improving motor accessibility; compact
  mode must still meet the minimum.

- **Fitts, P. M. (1954).** (as in `03-motor.md`.) Finding: larger targets reduce
  movement time. Implication: spacious mode's larger targets reduce motor cost;
  this is the motor justification for spacious.

### 2.3 Stress and calm

- **Weiser, M. and Brown, J. S. (1997).** "The coming age of calm technology." In
  *Beyond Calculation*, Springer, pp. 75–85. (URL:
  https://doi.org/10.1007/978-1-4612-0685-9_6 ; accessed 23 October 2026.)
  Finding: calm technology informs without demanding. Implication: spacious mode
  reduces visual demand, supporting calm.

- **Hancock, P. A. and Warm, J. S. (1989).** "A dynamic model of stress and
  sustained attention." *Human Factors*, 31(5), pp. 519–537. (URL:
  https://doi.org/10.1177/001872088903100503 ; accessed 23 October 2026.)
  Finding: stress degrades attention. Implication: under stress, spacious mode is
  the safer default; the system may switch to spacious under high workload (with
  user control).

### 2.4 Visual accessibility

- **Legge, G. E. and Bigelow, C. A. (2011).** "Does print size matter for reading?
  A review of findings from vision science and typography." *Journal of Vision*,
  11(5), art. 8. (URL: https://doi.org/10.1167/11.5.8 ; accessed 23 October 2026.)
  Finding: larger text and spacing improve reading for low vision. Implication:
  spacious mode's larger spacing supports low-vision users; 200% text is a tested
  case.

## 3. What spacious changes (and what it does not)

**Changes:**
- Larger spacing between elements (space tokens scaled up).
- Fewer visible actions (progressive disclosure; secondary actions behind "more").
- Calmer hierarchy (fewer competing elements; larger primary action).
- Larger targets and hit areas.
- Reduced information density per screen (paging or scrolling instead of crowding).

**Does not change:**
- Meaning, colour, depth semantics, motion grammar, icon set, typography family,
  copy, or information architecture.
- The set of functions available (all remain reachable).
- The state machine or the flow.

## 4. Degradation: spacious → compact

Spacious degrades to compact by rule, never by opinion:

1. **Space rule.** If the available space cannot fit the spacious layout at the
   declared minimums (target size, spacing, text), compact is used.
2. **Envelope rule.** Compact is the default on envelopes where space is scarce
   (watch, phone, EV glance, IoT). Spacious is the default where space is ample
   (desktop, tablet in landscape, TV) and is opt-in elsewhere.
3. **User rule.** The user may choose spacious or compact in Settings; the choice
   persists per device and per app where applicable.
4. **Stress rule.** Under declared high-workload conditions (EV driving, spaceship
   emergency), spacious is forced for safety regardless of user choice.
5. **No content loss.** Degradation re-flows, collapses or pages content; it never
   removes a function. Overflow goes to the palette, a sheet, or a scroll.

## 5. What this predicts for Naledzi

1. **Spacious is a density mode.** (`UX-LAW-13`, master brief.)
2. **Spacing, visible actions, hierarchy calmness change; meaning does not.**
3. **Degradation is by rule.** Space, envelope, user, stress.
4. **No content loss.** Re-flow, collapse, page, or move to a peer.
5. **Spacious helps cognition, motor, stress and low vision.**

## 6. Limits and contested claims

- Optimal density is task- and user-dependent; the spacious/compact split is a
  pragmatic two-tier, not a claim of optimality.
- Stress-triggered spacious switching must be validated; false positives (switching
  when not needed) annoy experts.

## 7. Where implemented (IDs)

- `UX-LAW-13`.
- `01-foundations/experience/` — felt experience.
- `03-framework/adaptivity/` — density.
- `07-wireframes/modes/spacious/` — spacious frames.

## 8. Acceptance implications

- `AC-UX-SPACIOUS-001`: Spacious and compact render the same functions; only
  density differs.
- `AC-UX-SPACIOUS-002`: Degradation from spacious to compact preserves all
  functions (no content loss).
- `AC-UX-SPACIOUS-003`: Stress rule forces spacious in the safety reference flow.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-SPACIOUS-001` | Same functions, different density. |
| `AC-UX-SPACIOUS-002` | Degradation preserves functions. |
| `AC-UX-SPACIOUS-003` | Stress forces spacious. |