---
id: UX-COGNITION
title: Cognition — Attention, Working Memory, Cognitive Load, Hick's Law, Chunking, Mental Models, Predictive Processing
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-PERCEPTION]
supersedes: []
superseded_by: []
acceptance: [AC-UX-COGNITION-001, AC-UX-COGNITION-002, AC-UX-COGNITION-003]
---

# Cognition

> The limits of attention, memory and decision-making, and what they force on the number
> of choices, the amount of state and the shape of every screen.

## 1. Principle

Human cognition is bounded. Working memory holds a small number of chunks; attention is
allocated, not unlimited; decision time grows logarithmically with the number of
alternatives; cognitive load is the sum of intrinsic, extraneous and germane load; and
the brain is a prediction machine that updates on error. A design that ignores these
limits taxes the person and produces errors, not productivity.

## 2. Evidence

### 2.1 Working memory and chunking

- **Miller, G. A. (1956).** "The magical number seven, plus or minus two: some limits
  on our capacity for processing information." *Psychological Review*, 63(2), pp. 81–97.
  (URL: https://doi.org/10.1037/h0043158 ; accessed 23 October 2026.) Finding: short-term
  memory span is about seven items, but the unit is the *chunk*, and chunk size varies
  with expertise. Limit: the "7 ± 2" is a span for simple items; complex material is far
  smaller. Implication: Naledzi MUST NOT require holding more than four unrelated items
  in working memory at once; chunking and visual grouping are mandatory; expert users
  chunk more and need less chrome.

- **Cowan, N. (2001).** "The magical number 4 in short-term memory: a reconsideration
  of mental storage capacity." *Behavioral and Brain Sciences*, 24(1), pp. 87–114.
  (URL: https://doi.org/10.1017/S0140525X01003922 ; accessed 23 October 2026.)
  Finding: the focus of attention holds about four chunks; the larger Miller number
  includes activated long-term memory. Limit: four is an upper bound for unchunked,
  unfamiliar material. Implication: the Naledzi working-memory budget is **four chunks**
  on a first-contact screen; four is the hard ceiling, not seven.

- **Baddeley, A. D. and Hitch, G. (1974).** "Working memory." In *The Psychology of
  Learning and Motivation*, Vol. 8, G. H. Bower (ed.), Academic Press, pp. 47–89.
  (URL: https://doi.org/10.1016/S0079-7421(08)60452-1 ; accessed 23 October 2026.)
  Finding: working memory has separable components — phonological loop, visuospatial
  sketchpad, central executive, episodic buffer. Limit: the model is revised (Baddeley
  2000) but the separation holds. Implication: a screen that demands both verbal and
  spatial rehearsal at once competes for separate resources; either combine them into
  one channel or remove one demand; voice and visual must not fight.

- **Chase, W. G. and Simon, H. A. (1973).** "Perception in chess." *Cognitive
  Psychology*, 4(1), pp. 55–81. (URL: https://doi.org/10.1016/0010-0285(73)90004-2 ;
  accessed 23 October 2026.) Finding: experts chunk positions into meaningful units;
  novices see individual pieces. Implication: progressive disclosure and grouping must
  serve novices first; expert shortcuts are accelerators, never the only path
  (`LAW-010` spirit, `06-learning.md`).

### 2.2 Attention

- **Kahneman, D. (1973).** *Attention and Effort.* Prentice-Hall. (URL:
  https://www.worldcat.org/title/attention-and-effort/oclc/655548 ; accessed 23 October
  2026.) Finding: attention is a limited pool allocated to effortful tasks; automatic
  processes cost little. Implication: the default state of a Naledzi surface is
  low-demand; effort is spent only on the person's task, never on operating the OS.

- **Broadbent, D. E. (1958).** *Perception and Communication.* Pergamon. (URL:
  https://www.worldcat.org/title/perception-and-communication/oclc/558330 ; accessed
  23 October 2026.) Finding: selective attention filters input; unattended information
  is largely lost. Implication: a notification that arrives while the person is focused
  elsewhere is not perceived as content; it must be queued or summarised, not forced.

- **Posner, M. I. (1980).** "Orienting of attention." *Quarterly Journal of
  Experimental Psychology*, 32(1), pp. 3–25. (URL:
  https://doi.org/10.1080/00335558008248231 ; accessed 23 October 2026.) Finding:
  attention can be cued exogenously (bottom-up) or endogenously (top-down); exogenous
  cues are fast and involuntary. Implication: motion and animation are exogenous cues
  and capture attention whether wanted or not; they are therefore budgeted and never
  decorative (`LAW-004`, `LAW-020`).

### 2.3 Cognitive load

- **Sweller, J. (1988).** "Cognitive load during problem solving: effects on learning."
  *Cognitive Science*, 12(2), pp. 257–285. (URL:
  https://doi.org/10.1207/s15516709cog1202_4 ; accessed 23 October 2026.) Finding:
  cognitive load has three components — intrinsic (task), extraneous (design) and
  germane (learning). Extraneous load should be minimised. Limit: the theory was
  developed in instructional contexts; transfer to UI is interpretation. Implication:
  Naledzi minimises extraneous load: no redundant chrome, no duplicated information,
  no decoration that is not structure; every element must earn its place
  (`LAW-010`).

- **Sweller, J., Ayres, P. and Kalyuga, S. (2011).** *Cognitive Load Theory.*
  Springer. (URL: https://doi.org/10.1007/978-1-4419-8126-4 ; accessed 23 October
  2026.) Finding: expertise reverses the assistance effect — what helps a novice hinders
  an expert. Implication: progressive disclosure and adaptive density; spacious mode for
  novices and high-stress, compact for experts by choice, never by assumption.

### 2.4 Decision time and choice

- **Hick, W. E. (1952).** "On the rate of gain of information." *Quarterly Journal of
  Experimental Psychology*, 4(1), pp. 11–26. (URL:
  https://doi.org/10.1080/17470215208416600 ; accessed 23 October 2026.) Finding:
  choice reaction time grows logarithmically with the number of alternatives. Implication:
  doubling the number of options does not double the decision time, but it does add cost;
  beyond about seven items, grouping or search is required; the palette is the timeless
  answer to large choice sets.

- **Hyman, R. (1953).** "Stimulus information as a determinant of reaction time."
  *Journal of Experimental Psychology*, 45(3), pp. 188–196. (URL:
  https://doi.org/10.1037/h0056940 ; accessed 23 October 2026.) Finding: reaction time
  is linear in the information (entropy) of the choice set, not in the count. Implication:
  equal-probability, well-grouped options cost less than a long ungrouped list of the
  same length.

- **Landauer, T. K. and Nachbar, D. W. (1985).** "Selection from alphabetic and numeric
  menu trees using a touch screen: breadth, depth, and task complexity." *Proceedings of
  CHI '85*, pp. 73–78. (URL: https://doi.org/10.1145/317456.317470 ; accessed
  23 October 2026.) Finding: for known targets, breadth beats depth up to about eight
  items; for unknown targets, search beats both. Implication: Naledzi menus are broad
  and shallow when the target is known, and searchable (palette) when it is not; deep
  trees are a defect.

### 2.5 Mental models and predictive processing

- **Norman, D. A. (1988).** *The Design of Everyday Things.* Basic Books. (URL:
  https://www.worldcat.org/title/design-of-everyday-things/oclc/17693014 ; accessed
  23 October 2026.) Finding: people act on a mental model of the system; mismatches
  between the model and the system produce errors; affordances and signifiers make the
  model visible. Implication: Naledzi's grammar (Section Set, strip, palette) must be
  self-evident on first contact; hidden gestures are not the only path (`LAW-010`,
  shortcuts are accelerators).

- **Norman, D. A. (2013).** *The Design of Everyday Things* (revised edition). Basic
  Books. (URL: https://www.worldcat.org/title/design-of-everyday-things/oclc/851388459 ;
  accessed 23 October 2026.) Finding: conceptual models, system image and Gulf of
  Execution/Evaluation. Implication: every state change must be visible enough to
  close the Gulf of Evaluation; `NOT REPORTED` is an honest system image.

- **Clark, A. (2013).** "Whatever next? Predictive brains, situated agents, and the
  future of cognitive science." *Behavioral and Brain Sciences*, 36(3), pp. 181–204.
  (URL: https://doi.org/10.1017/S0140525X12000477 ; accessed 23 October 2026.)
  Finding: the brain is a prediction machine; perception is the resolution of
  prediction error. Implication: a screen that violates the person's prediction (a
  control that moves without reason, a state that changes silently) produces surprise
  and distrust; motion must be explainable so prediction succeeds.

- **Friston, K. (2010).** "The free-energy principle: a unified brain theory?"
  *Nature Reviews Neuroscience*, 11(2), pp. 127–138. (URL:
  https://doi.org/10.1038/nrn2787 ; accessed 23 October 2026.) Finding: organisms
  minimise surprise (free energy); learning updates the generative model. Implication:
  consistency is not aesthetic preference; it is the mechanism by which the person's
  model stays accurate; inconsistency costs learning on every encounter.

### 2.6 Prospective memory and interruption

- **McDaniel, M. A. and Einstein, G. O. (2007).** *Prospective Memory: An Overview and
  Synthesis of an Emerging Field.* Sage. (URL:
  https://www.worldcat.org/title/prospective-memory/oclc/70292200 ; accessed
  23 October 2026.) Finding: remembering to do something later is fragile and depends
  on cues; interruptions destroy it. Implication: an interruption that loses the
  person's place is a defect; resumption must restore context (`07-attention.md`).

## 3. What this predicts for Naledzi

1. **Four-chunk ceiling.** No first-contact screen requires holding more than four
   unrelated items (`UX-LAW-02`).
2. **Choice cost is logarithmic.** Group, search, or use the palette; never a long flat
   list.
3. **Breadth over depth for known targets; search for unknown.**
4. **Extraneous load is a defect.** Every element must earn its place (`LAW-010`).
5. **Expertise reverses assistance.** Progressive disclosure and adaptive density.
6. **Consistency is cognitive, not aesthetic.** The grammar is one (`LAW-013`).
7. **Predictions must succeed.** Motion and state changes must be explainable
   (`LAW-008`, `LAW-011`).
8. **Interruptions restore context.** Resumption is a designed behaviour.

## 4. Limits and contested claims

- The four-chunk limit is for unchunked, unfamiliar material; experts chunk more. Do
  not design for the expert at the expense of the novice.
- Cognitive load theory's transfer to UI is interpretation, not direct evidence; the
  implications are design hypotheses marked as such.
- Hick's law exceptions exist (verbal response to familiar stimuli, saccades); do not
  apply it to skilled, automatic actions.
- Predictive processing is a theoretical framework with strong support but ongoing
  debate about its scope; treat as a guiding model, not a proven mechanism.

## 5. Where implemented (IDs)

- `UX-LAW-02`, `UX-LAW-06`, `UX-LAW-07`.
- `LAW-010`, `LAW-013`, `LAW-018`.
- `FOUND-EXPERIENCE` (this subtree, `01-foundations/experience/`).
- `03-framework/palette/` — the timeless answer to large choice sets.
- `04-shell/notifications/` — attention budget and queuing.

## 6. Acceptance implications

- `AC-UX-COGNITION-001`: No first-contact screen in the reference set requires holding
  more than four unrelated items in working memory.
- `AC-UX-COGNITION-002`: Every menu with more than eight items is either grouped into
  ≤ 8 groups or searchable via the palette.
- `AC-UX-COGNITION-003`: Extraneous load audit: removing any non-structural element
  from a reference screen does not reduce task completion.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-COGNITION-001` | Four-chunk ceiling holds on every first-contact screen. |
| `AC-UX-COGNITION-002` | Menus > 8 items are grouped or searchable. |
| `AC-UX-COGNITION-003` | No non-structural element is load-bearing for task completion. |