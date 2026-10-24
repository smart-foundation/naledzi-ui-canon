---
id: UX-PERCEPTION
title: Perception — Depth Cues, Motion, Change Blindness, Visual Search, Occlusion, Parallax
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-PERCEPTION-001, AC-UX-PERCEPTION-002, AC-UX-PERCEPTION-003]
---

# Perception

> What the eye and the visual system actually deliver, and what the screen must therefore
> do. Perception is the first filter: a fact that is not perceived is not a fact on screen.

## 1. Principle

The visual system does not transmit a photograph of the world. It constructs a scene from
independent cues — occlusion, relative size, relative density, cast shadow, motion parallax,
binocular disparity, accommodation — and binds them into objects. The strongest pictorial
cue is occlusion: one object hiding another tells the viewer that the hidden object is
behind. Cutting and Vishton (1995) found occlusion effective across the whole visible
range and dominant over relative size, which in turn dominates relative density. Cast
shadows are strong cues to spatial arrangement, especially when they move, and weak cues
to object shape (Mamassian, Knill and Kersten, 1998). Motion is perceived as continuous
when velocity is preserved across an interruption and as a new event when it restarts
(Flash and Hogan, 1985; see `03-motor.md`). Change that happens without a path is
perceived as replacement, not change, and the viewer must re-search the screen.

## 2. Evidence

### 2.1 Depth cues and their strength

- **Gibson, J. J. (1950).** *The Perception of the Visual World.* Houghton Mifflin.
  (URL: https://archive.org/details/perceptionofvisua00gibs ; accessed 23 October 2026.)
  Gibson's ecological approach: perception is of affordances in a structured environment;
  depth is not computed from a flat image but picked up from invariant structure. The
  implication for Naledzi is that depth must be consistent with the real structure of the
  surface — a shadow that does not match a real spatial relationship is a lie, not a cue.

- **Cutting, J. E. and Vishton, P. M. (1995).** "Perceiving layout and knowing
  distances: the integration, relative potency, and contextual use of different
  information about depth." In *Perception of Space and Motion*, W. Epstein and S.
  Rogers (eds.), Academic Press, pp. 69–117.
  (URL: https://doi.org/10.1016/B978-012240530-3/50005-5 ; accessed 23 October 2026.)
  Finding: occlusion dominates relative size, which dominates relative density, across
  the whole visible range. Limit: the ranking is for pictorial cues in static scenes;
  motion and binocular cues can override. Implication: Naledzi encodes hierarchy first by
  occlusion (what is in front actually occludes what is behind), then by size and density,
  never by shadow alone.

- **Mamassian, P., Knill, D. C. and Kersten, D. (1998).** "The perception of cast
  shadows." *Trends in Cognitive Sciences*, 2(8), pp. 288–295.
  (URL: https://doi.org/10.1016/S1364-6613(98)01204-2 ; accessed 23 October 2026.)
  Finding: cast shadows are strong cues to spatial arrangement, especially when they
  move; weak cues to object shape. Limit: shadow usefulness depends on a consistent
  light source and on the shadow moving with the object. Implication: Naledzi's single
  light model (`FOUND-DEPTH-001`..`003`) and moving shadows on drag; a static shadow
  that does not move with its object is decoration.

- **Howard, I. P. and Rogers, B. J. (2012).** *Perceiving in Depth, Volume 2: Stereoscopic
  Vision.* Oxford University Press.
  (URL: https://global.oup.com/academic/product/perceiving-in-depth-volume-2-9780199764150 ;
  accessed 23 October 2026.) Finding: binocular disparity and vergence are strong
  near-range cues; their strength falls with distance. Limit: not available on every
  display (spatial displays, some TVs). Implication: spatial envelopes may use true
  depth; flat envelopes must not depend on it; `FOUND-DEPTH` states a fallback.

### 2.2 Motion perception

- **Wertheimer, M. (1912).** "Experimentelle Studien über das Sehen von Bewegung."
  *Zeitschrift für Psychologie*, 61, pp. 161–265. (URL:
  https://archive.org/details/experimentellest00wert ; accessed 23 October 2026.)
  Finding: the phi phenomenon — apparent motion from discrete frames. Limit: frame rate
  and timing matter; below a threshold, motion is seen as discrete jumps. Implication:
  Naledzi motion is integrated continuously in the simulation and rendered at the
  display rate; discrete state jumps are never used to imply motion.

- **Johansson, G. (1973).** "Visual perception of biological motion and a model for its
  analysis." *Perception & Psychophysics*, 14(2), pp. 201–211.
  (URL: https://doi.org/10.3758/BF03212378 ; accessed 23 October 2026.) Finding: a
  handful of moving points is enough to convey a complex action; motion carries identity.
  Limit: tested with point-light displays, not full scenes. Implication: a moving control
  keeps its identity; an interrupted animation that restarts breaks identity and forces
  re-search.

- **Kahneman, D. (1973).** *Attention and Effort.* Prentice-Hall. (URL:
  https://www.worldcat.org/title/attention-and-effort/oclc/655548 ; accessed
  23 October 2026.) Finding: attention is a limited resource allocated to effortful
  tasks; automatic processes cost little. Implication: idle surfaces cost nothing
  (`LAW-004`); motion that is not explaining a change is a tax on attention and is
  forbidden.

### 2.3 Change blindness and visual search

- **Simons, D. J. and Levin, D. T. (1997).** "Change blindness." *Trends in Cognitive
  Sciences*, 1(7), pp. 261–267.
  (URL: https://doi.org/10.1016/S1364-6613(97)01080-2 ; accessed 23 October 2026.)
  Finding: large changes to a scene go unnoticed when they coincide with a blink, a
  saccade, a flash or a cut. Limit: the effect is strongest for changes outside the
  focus of attention. Implication: Naledzi MUST NOT rely on a user noticing a silent
  state change; every state change that matters is announced or motion-explained; a
  change that cannot be noticed is a defect, not a feature.

- **Rensink, R. A., O'Regan, J. K. and Clark, J. J. (1997).** "To see or not to see: the
  need for attention to perceive changes in scenes." *Psychological Science*, 8(5),
  pp. 368–373. (URL: https://doi.org/10.1111/j.1467-9280.1997.tb00427.x ; accessed
  23 October 2026.) Finding: attention is required to perceive change; without it, even
  large changes are missed. Implication: motion that explains change must be in the
  attended region or be announced; a change outside the current focus requires an
  explicit signal.

- **Treisman, A. M. and Gelade, G. (1980).** "A feature-integration theory of
  attention." *Cognitive Psychology*, 12(1), pp. 97–136.
  (URL: https://doi.org/10.1016/0010-0285(80)90005-5 ; accessed 23 October 2026.)
  Finding: basic features (colour, orientation, size) are detected in parallel; binding
  features into objects requires focused attention. Limit: the original feature set is
  contested and extended. Implication: a status that must be noticed quickly (error,
  safety) MUST be a basic feature — colour plus shape plus position — not a subtle
  combination; never rely on a conjunction of small cues for a critical signal.

- **Wolfe, J. M. (2021).** "Guided Search 6.0: an updated model of visual search."
  *Psychonomic Bulletin & Review*, 28, pp. 1060–1092.
  (URL: https://doi.org/10.3758/s13423-020-01859-9 ; accessed 23 October 2026.)
  Finding: visual search is guided by feature maps and scene structure; search is
  efficient when the target differs by a single feature. Limit: scene complexity and
  distractor similarity dominate. Implication: the primary action on a screen MUST be
  findable in under five seconds by a first-contact user (timelessness test §3.4);
  search displays MUST reduce distractors, not add chrome.

### 2.4 Occlusion and parallax

- **Gibson, E. J. (1969).** *Principles of Perceptual Learning and Development.*
  Appleton-Century-Crofts. (URL:
  https://www.worldcat.org/title/principles-of-perceptual-learning-and-development/oclc/35899 ;
  accessed 23 October 2026.) Finding: perceptual learning is differentiation of
  structure, not enrichment of impoverished input. Implication: Naledzi does not teach
  by adding overlays; it teaches by making structure legible.

- **Rogers, B. and Graham, M. (1979).** "Motion parallax as an independent cue for
  depth perception." *Perception*, 8(2), pp. 125–134.
  (URL: https://doi.org/10.1068/p080125 ; accessed 23 October 2026.) Finding: motion
  parallax alone, with head movement, gives compelling depth. Limit: requires real
  motion and a stable reference. Implication: parallax in Naledzi is tied to real motion
  (scroll, tilt, gesture) and is disabled under reduced motion and on envelopes where
  head tracking is unavailable; decorative parallax is forbidden (`FOUND-DEPTH-040`).

## 3. What this predicts for Naledzi

1. **Occlusion is truth.** If a surface is drawn in front, it is in front for
   hit-testing, focus, accessibility and input ownership in the same still (`LAW-005`,
   `FOUND-DEPTH-001`).
2. **Depth is carried by more than shadow.** Position, overlap, contrast and scale must
   also encode level, so hierarchy survives without shadow (`FOUND-DEPTH-002`).
3. **Motion explains change.** A sudden position change without a path is a replacement;
   the person loses identity and re-searches. Springs preserve velocity and identity.
4. **Change must be signalled.** Silent state changes are missed (change blindness);
   critical changes are announced or motion-explained.
5. **Critical signals are basic features.** Colour + shape + position, never a subtle
   conjunction, for error and safety.
6. **Parallax is real or absent.** No decorative parallax; parallax requires real motion
   and a reduced-motion alternative.

## 4. Limits and contested claims

- The cue-strength ranking (occlusion > size > density) is for static pictorial cues;
  motion, binocular and oculomotor cues can override. Naledzi does not assume the
  ranking holds on spatial displays.
- Change blindness magnitude varies with task load and expertise; experts miss less but
  still miss. Do not assume expert users notice silent changes.
- Motion perception thresholds (phi phenomenon) vary with display technology; the
  deterministic integration in `FOUND-MOTION-03` is the mitigation, not a claim of
  universal smoothness.

## 5. Where implemented (IDs)

- `FOUND-DEPTH-001`..`003`, `FOUND-DEPTH-040` — occlusion truth, elevation by more than
  shadow, parallax tied to real motion.
- `FOUND-MOTION-001`..`005` — motion explains change, target-based springs, settle and
  stop, interruptible, reduced-motion alternative.
- `LAW-005` — every visible state is a numbered still.
- `LAW-007` — depth communicates hierarchy.
- `LAW-008` — motion explains change.
- `LAW-009` — accessibility is structural.
- `LAW-011` — honesty over polish (`NOT REPORTED`).
- `UX-LAW-01` (this subtree).

## 6. Acceptance implications

- `AC-UX-PERCEPTION-001`: Removing all shadows from any reference screen leaves the
  elevation order readable from position, overlap, contrast and scale.
- `AC-UX-PERCEPTION-002`: Interrupting any animation at an arbitrary frame produces no
  visible jump and preserves velocity.
- `AC-UX-PERCEPTION-003`: Every critical state change (error, safety, denied) is either
  motion-explained in the attended region or announced; a silent critical change fails
  the audit.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-PERCEPTION-001` | Shadow removal leaves hierarchy readable (position, overlap, contrast, scale). |
| `AC-UX-PERCEPTION-002` | Animation interruption is jump-free and velocity-preserving. |
| `AC-UX-PERCEPTION-003` | No critical state change is silent or unannounced. |