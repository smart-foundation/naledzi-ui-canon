---
id: UX-SAFETY-CRITICAL
title: Safety-Critical — Situation Awareness, Human Factors, Workload, Fatigue, Error, Procedures, Alarm Design
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-ATTENTION, UX-EMOTION]
supersedes: []
superseded_by: []
acceptance: [AC-UX-SAFETY-001, AC-UX-SAFETY-002, AC-UX-SAFETY-003]
---

# Safety-Critical

> How people perform under stress, workload and danger, and what that forces on the EV
> and spaceship envelopes: situation awareness, procedure-first displays, bounded
> motion, protected zones, redundancy.

## 1. Principle

Safety-critical performance is different from office performance. Under high workload,
attention narrows, working memory shrinks, and people follow procedures rather than
reason. Displays must be simple, redundant and stable. Critical indicators never animate
through occlusion and never move. Motion is bounded and non-overshooting. Alarms are
prioritised and never cry wolf. The human is the last line of defence, and the system
must keep them in the loop without overwhelming them.

## 2. Evidence

### 2.1 Situation awareness

- **Endsley, M. R. (1995).** "Toward a theory of situation awareness in dynamic
  systems." *Human Factors*, 37(1), pp. 32–64. (URL:
  https://doi.org/10.1518/001872095779049543 ; accessed 23 October 2026.) Finding:
  situation awareness (SA) has three levels — perception, comprehension, projection;
  SA is lost when perception fails or when workload exceeds capacity. Implication:
  Naledzi safety displays must make critical state perceivable first (level 1), then
  comprehensible (level 2), then projectable (level 3); no level may be skipped.

- **Endsley, M. R. (2017).** "Direct measurement of situation awareness: validity
  and use of SAGAT." In *Situational Awareness*, (ed.) M. R. Endsley, pp. 129–155.
  (URL: https://doi.org/10.4324/9781315088842 ; accessed 23 October 2026.) Finding:
  SAGAT (Situation Awareness Global Assessment Technique) freezes the display and
  queries the operator; it is the standard SA measure. Implication: Naledzi safety
  acceptance tests use a SAGAT-style freeze-and-query method.

### 2.2 Human factors standards

- **FAA (2016).** *Human Factors Design Standard (HF-STD-001B).* Federal Aviation
  Administration. (URL: https://hf.tc.faa.gov/hfstd/ ; accessed 23 October 2026.)
  Finding: comprehensive human-factors requirements for aviation displays, controls,
  lighting, anthropometry and environment. Implication: Naledzi EV and spaceship
  envelopes cite HF-STD-001 as the baseline for control placement, lighting and
  anthropometry; deviations are recorded as ADRs.

- **NASA (2022).** *NASA Space Flight Human-System Standard (NASA-STD-3001), Volume 1:
  Crew Health and Volume 2: Human Factors, Habitability, and Environmental Health.*
  (URL: https://standards.nasa.gov/standard/nasa/nasa-std-3001-vol-2 ; accessed
  23 October 2026.) Finding: human-factors requirements for spacecraft displays,
  controls, workload, fatigue and emergency procedures. Implication: spaceship
  envelope follows NASA-STD-3001 Vol. 2 for display legibility, reach, workload and
  fatigue; critical alarms are redundant (visual + audio + haptic).

- **MIL-STD-1472H (2020).** *Department of Defense Design Criteria Standard: Human
  Engineering.* (URL: https://quicksearch.dla.mil/qsDocDetails.aspx?ident_number=212376 ;
  accessed 23 October 2026.) Finding: detailed human-engineering criteria for
  displays, controls, anthropometry, lighting, noise and vibration. Implication:
  Naledzi cites MIL-STD-1472 for control sizing, reach envelopes and display
  legibility in high-vibration environments (EV, spaceship).

- **NHTSA (2013).** *Visual-Manual NHTSA Driver Distraction Guidelines for
  In-Vehicle Electronic Devices.* (URL:
  https://www.nhtsa.gov/sites/nhtsa.gov/files/811926.pdf ; accessed 23 October
  2026.) Finding: tasks that take eyes off the road for more than 2 seconds are
  unsafe; total task time should be ≤ 12 seconds. Implication: EV envelope tasks
  that require visual attention are bounded to ≤ 2 s glances and ≤ 12 s total; the
  passenger/driver split is mandatory.

- **SAE (2021).** *SAE J3016: Taxonomy and Definitions for Terms Related to Driving
  Automation Systems for On-Road Motor Vehicles.* (URL:
  https://www.sae.org/standards/content/j3016_202104/ ; accessed 23 October 2026.)
  Finding: levels of driving automation 0–5. Implication: Naledzi EV UI adapts to
  the automation level; at level 0–2 the driver is responsible and the UI is
  driver-focused; at higher levels the UI shifts to passenger/monitoring.

- **ARINC 661 (2018).** *Cockpit Display System Interfaces to User Systems.* (URL:
  https://www.aviation-ia.com/standards/arinc661 ; accessed 23 October 2026.)
  Finding: defines widgets and rendering for avionics displays; separation of
  display system from application. Implication: Naledzi's "pixels never cross a
  contract boundary" (`LAW-002`) and declared damage (`LAW-003`) are consistent
  with ARINC 661's separation; the spaceship envelope cites it for widget semantics.

### 2.3 Workload and fatigue

- **Hart, S. G. and Staveland, L. E. (1988).** "Development of NASA-TLX (Task Load
  Index): results of empirical and theoretical research." In *Human Mental Workload*,
  P. A. Hancock and N. Meshkati (eds.), Elsevier, pp. 139–183. (URL:
  https://doi.org/10.1016/S0166-4115(08)62386-9 ; accessed 23 October 2026.)
  Finding: NASA-TLX measures six workload dimensions (mental, physical, temporal,
  performance, effort, frustration). Implication: Naledzi safety acceptance tests
  measure workload with NASA-TLX; a safety flow that scores above the declared
  threshold fails.

- **Wickens, C. D. (2008).** "Multiple resources and mental workload." *Human
  Factors*, 50(3), pp. 449–455. (URL:
  https://doi.org/10.1518/001872008X288394 ; accessed 23 October 2026.) Finding:
  workload is multidimensional; tasks competing for the same resource interfere.
  Implication: Naledzi safety displays avoid simultaneous demands on the same
  channel (e.g., visual tracking + visual reading); redundant channels are used.

### 2.4 Error and procedures

- **Reason, J. (1990).** *Human Error.* Cambridge University Press. (URL:
  https://www.cambridge.org/core/books/human-error/ ; accessed 23 October 2026.)
  Finding: errors are slips (execution) and mistakes (planning); latent conditions
  enable them. Implication: Naledzi reduces slips by clear, stable controls and
  reduces mistakes by clear system image and reversible actions.

- **Degani, A. and Wiener, E. L. (1993).** "Cockpit checklists: concepts, design,
  and use." *Human Factors*, 35(2), pp. 345–359. (URL:
  https://doi.org/10.1177/001872089303500209 ; accessed 23 October 2026.)
  Finding: checklists work when they are short, specific and used as a memory aid,
  not a substitute for skill. Implication: Naledzi procedure displays are short,
  specific and step-confirmed; no long scrolling checklist during high workload.

### 2.5 Alarm design

- **Patterson, R. D. (1982).** *Guidelines for Auditory Warning Systems on Civil
  Aircraft.* CAA Paper 82017. (URL:
  https://www.caa.co.uk/publications ; accessed 23 October 2026.) Finding: alarms
  must be distinguishable, localisable and prioritised; too many alarms cause
  confusion. Implication: Naledzi alarm sounds are prioritised and distinguishable;
  three priority tiers maximum; see `sound-haptics`.

- **Edworthy, J. and Hellier, E. (2006).** "Alarms and human behaviour:
  implications for medical alarms." *British Journal of Anaesthesia*, 97(1),
  pp. 12–17. (URL: https://doi.org/10.1093/bja/ael114 ; accessed 23 October 2026.)
  Finding: alarm design must match urgency; false alarms erode response. Implication:
  Naledzi alarms match urgency to priority; false alarms are a defect
  (`UX-ATTENTION` §2.4).

## 3. What this predicts for Naledzi

1. **Situation awareness is designed.** Perceive → comprehend → project.
2. **Safety displays are simple, redundant, stable.** No motion through occlusion;
   critical indicators never move.
3. **Bounded, non-overshooting motion only.** ζ ≥ 1 in safety envelopes.
4. **Procedure-first under high workload.** Short, specific, step-confirmed.
5. **Workload is measured.** NASA-TLX in acceptance.
6. **Alarms are prioritised and accurate.** Three tiers; no cry-wolf.
7. **EV tasks bound to glances (≤ 2 s) and total (≤ 12 s).** NHTSA.
8. **Spaceship follows NASA-STD-3001; EV follows HF-STD-001 and MIL-STD-1472.**

## 4. Limits and contested claims

- Safety research is aviation/medical/military; transfer to consumer OS is
  interpretation and must be validated in simulator testing.
- SA measurement (SAGAT) has methodological critics; it is the best available
  standard and is adopted.

## 5. Where implemented (IDs)

- `UX-LAW-08`.
- `LAW-007`, `LAW-008`, `LAW-011`.
- `06-envelopes/ev/`, `06-envelopes/spaceship/`.
- `01-foundations/motion/05-safety-motion.md`.
- `01-foundations/depth/` — protected zones.

## 6. Acceptance implications

- `AC-UX-SAFETY-001`: Critical indicators are never occluded at any frame of the
  safety reference flow.
- `AC-UX-SAFETY-002`: EV visual tasks meet the NHTSA glance (≤ 2 s) and total
  (≤ 12 s) bounds.
- `AC-UX-SAFETY-003`: Spaceship alarm set is redundant (visual + audio + haptic)
  and prioritised.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-SAFETY-001` | Critical indicators never occluded. |
| `AC-UX-SAFETY-002` | EV tasks within NHTSA bounds. |
| `AC-UX-SAFETY-003` | Spaceship alarms redundant and prioritised. |