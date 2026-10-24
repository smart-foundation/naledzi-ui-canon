---
id: FOUND-MOTION-REFS-13
title: Motion References
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, CANON-LAWS, ADR-0022]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-130, AC-FOUND-MOTION-131]
---

# Motion References

> Every claim about human motion in this foundation is traced here. A principle without a
> source is an opinion; an opinion in a foundation is a defect.

Access date for all web sources: **23 October 2026**.

---

## 1. Motor control and movement

### 1.1 Fitts (1954) — The information capacity of the human motor system

- **Citation:** Fitts, P. M. (1954). The information capacity of the human motor system
  in controlling the amplitude of movement. *Journal of Experimental Psychology*, 47(6),
  381–391.
- **URL:** https://www.cs.princeton.edu/courses/archive/fall08/cos436/FittsJEP1954.pdf
  (mirror; original journal page https://pubmed.ncbi.nlm.nih.gov/1402698/)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Pointing time grows logarithmically with distance
  and inversely with target size. This is why targets must be large enough and why a
  motion that travels a long distance takes longer to settle — the human motor system
  has a fixed information capacity (~10 bits/s).
- **Limits:** Laboratory pointing with a stylus on a fixed display; throughput depends on
  device, posture and fatigue; tremor and older adults are under-represented
  (RES-MOTOR limits).

### 1.2 Accot and Zhai (1997, 1999) — Steering law

- **Citation:** Accot, J. and Zhai, S. (1997). Beyond Fitts' law: models for
  trajectory-based HCI tasks. *Proceedings of ACM CHI 1997*, 295–302. (Extended in
  Accot & Zhai, 1999, *Proceedings of ACM CHI 1999*, 466–472.)
- **URL:** https://www.almaden.ibm.com/u/zhai/papers/steering/chi97.pdf
  (DOI http://doi.acm.org/10.1145/258549.258760; summary
  https://en.wikipedia.org/wiki/Steering_law)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Steering time through a tunnel of width W and length A
  is `T = a + b (A/W)`. Instantaneous speed is proportional to tunnel width. This is
  why drag-and-steer gestures (sliders, scrollbars, menu navigation) must be wide enough
  and why a spring that settles into a narrow target takes time.
- **Limits:** Derived almost purely mathematically from Fitts' law; surprisingly
  accurate but not calibrated to touch or remote input; lab tasks.

### 1.3 Flash and Hogan (1985) — Coordination of arm movements

- **Citation:** Flash, T. and Hogan, N. (1985). The coordination of arm movements: an
  experimentally confirmed mathematical model. *Journal of Neuroscience*, 5(7),
  1688–1703.
- **URL:** https://www.semanticscholar.org/paper/The-coordination-of-arm-movements%3A-an-confirmed-Flash-Hogan/7d8ac1ed3dc3fc96538372206da015e7dd4b251e
  (PubMed https://pubmed.ncbi.nlm.nih.gov/4020415/)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Point-to-point arm movements follow minimum-jerk
  trajectories, which are the response of a spring-like neuromuscular system to an
  equilibrium-point shift. This is the physical basis for `FOUND-MOTION-002`: motion is
  spring physics because human motion is spring-like.
- **Limits:** Single-joint and multi-joint reaching in a laboratory; does not cover
  whole-body or head movement; the equilibrium-point hypothesis is one of several motor
  control theories and remains contested.

---

## 2. Vestibular and motion sickness

### 2.1 Reason and Brand (1975) — Motion sickness

- **Citation:** Reason, J. T. and Brand, J. J. (1975). *Motion Sickness*. Academic Press.
- **URL:** https://en.wikipedia.org/wiki/Sensory_conflict_theory (overview of the theory)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Motion sickness arises from sensory conflict between
  visual, vestibular and proprioceptive signals about self-motion. This is why parallax
  and large-field motion are high-risk: they create optic flow without a matching body
  movement.
- **Limits:** The book is not open-access; the theory is a framework, not a calibrated
  prediction; susceptibility varies widely.

### 2.2 Oman (1990) — Synthesis and evaluation of sensory conflict theory

- **Citation:** Oman, C. M. (1990). Motion sickness: a synthesis and evaluation of the
  sensory conflict theory. *Canadian Journal of Physiology and Pharmacology*, 68(2),
  294–303.
- **URL:** https://cdnsciencepub.com/doi/10.1139/y90-044
  (PubMed https://pubmed.ncbi.nlm.nih.gov/2178753/)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** The neural mismatch between expected and actual
  sensory input is the trigger. This supports the model's decision to remove travel
  (not state change) under reduced motion.
- **Limits:** Review paper; does not provide device-specific thresholds.

### 2.3 Keshavarz, Riecke, Hettinger and Campos (2015) — Vection and VIMS

- **Citation:** Keshavarz, B., Riecke, B. E., Hettinger, L. J. and Campos, J. L.
  (2015). Vection and visually induced motion sickness: how are they related?
  *Frontiers in Psychology*, 6, 472.
- **URL:** https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2015.00472/full
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Vection and VIMS are related but not identical; strong
  vection can occur without sickness and sickness without strong vection. Therefore there
  is no single safe motion threshold, and susceptibility varies widely.
- **Limits:** Primarily laboratory VR studies; individual differences are large and not
  yet calibrated for flat screens.

---

## 3. Predictive processing

### 3.1 Clark (2013) — Whatever next?

- **Citation:** Clark, A. (2013). Whatever next? Predictive brains, situated agents, and
  the future of cognitive science. *Behavioral and Brain Sciences*, 36(3), 181–204.
- **URL:** https://www.fil.ion.ucl.ac.uk/~karl/Whatever%20next.pdf
  (PubMed https://pubmed.ncbi.nlm.nih.gov/23663408/)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Perception and action are driven by top-down
  prediction and bottom-up prediction error. Motion that is predictable (a spring that
  continues from its current velocity) is processed cheaply; motion that restarts
  generates a large prediction error and reads as a new event. This is the cognitive
  basis for velocity preservation (`FOUND-MOTION-004`).
- **Limits:** A theoretical framework with active debate; not all predictions are
  empirically confirmed; the neural implementation is contested.

### 3.2 Clark (2016) — Surfing Uncertainty

- **Citation:** Clark, A. (2016). *Surfing Uncertainty: Prediction, Action, and the
  Embodied Mind*. Oxford University Press.
- **URL:** https://philpapers.org/rec/CLASUP
  (review https://ndpr.nd.edu/reviews/surfing-uncertainty-prediction-action-and-the-embodied-mind/)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Extends predictive processing to action and attention;
  supports the idea that an interface that violates expectations (a jump, a restart)
  costs cognitive effort.
- **Limits:** Book-length argument; not a single experiment; contested in parts.

---

## 4. Accessibility and reduced motion

### 4.1 WCAG 2.2 — Animation from Interactions (2.3.3)

- **Citation:** W3C. (2023). *Web Content Accessibility Guidelines (WCAG) 2.2*,
  Success Criterion 2.3.3 Animation from Interactions (Level AAA).
- **URL:** https://www.w3.org/WAI/WCAG22/Understanding/animation-from-interactions.html
  (spec https://www.w3.org/TR/WCAG22/#animation-from-interactions)
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Motion animation triggered by interaction can be
  disabled unless it is essential. This is the basis for `FOUND-MOTION-220` and for
  honouring `prefers-reduced-motion`.
- **Limits:** Web-focused; Level AAA, not A; "essential" is a judgement call.

### 4.2 WCAG 2.2 — Three Flashes or Below Threshold (2.3.1)

- **Citation:** W3C. (2023). *Web Content Accessibility Guidelines (WCAG) 2.2*,
  Success Criterion 2.3.1 Three Flashes or Below Threshold (Level A).
- **URL:** https://www.w3.org/TR/WCAG22/#three-flashes-or-below-threshold
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Flashing above 3 Hz is a seizure risk. This is the
  basis for `FOUND-MOTION-240`.
- **Limits:** Thresholds are defined for web content; hardware displays may differ.

### 4.3 The A11Y Project — Understanding vestibular disorders

- **Citation:** The A11Y Project. (2020). Background: a primer to vestibular disorders.
- **URL:** https://www.a11yproject.com/posts/understanding-vestibular-disorders/
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Practical guidance on which motions trigger
  vestibular symptoms (parallax, zoom, spin, large-field motion) and on providing a
  reduced-motion mode. This is the basis for `FOUND-MOTION-200`.
- **Limits:** Community-authored guidance, not peer-reviewed research.

### 4.4 Apple reduced motion and vestibular accessibility

- **Citation:** Hocken, C. (2023). Apple, Reduce Motion and the battle for vestibular
  accessibility.
- **URL:** https://reverttosaved.com/2023/09/27/apple-reduce-motion-and-the-battle-for-vestibular-accessibility/
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** Documents that vestibular triggers vary between
  people and that a reduced-motion mode must be available and effective. Supports
  `FOUND-MOTION-210` (honour all channels).
- **Limits:** Journalistic; not a controlled study.

---

## 5. Determinism and integration

### 5.1 Gaffer on Games — Fix Your Timestep

- **Citation:** Fiedler, G. (2004). Fix Your Timestep!
- **URL:** https://gafferongames.com/post/fix_your_timestep/
- **Access date:** 23 October 2026.
- **What it predicts for Naledzi:** A fixed simulation timestep with an accumulator and
  render interpolation gives deterministic, refresh-rate-independent simulation. This is
  the basis for `03-determinism.md`.
- **Limits:** Written for game physics; UI springs are simpler, but the principle
  (fixed step, interpolated render) transfers directly.

---

## 6. Depth and parallax interaction (cross-reference)

Motion and depth share the parallax rules. The depth foundation owns parallax magnitude,
rates and the legal sources; motion owns the scheduling, the settle and the reduced-motion
removal.

- Depth reference: `01-foundations/depth/04-parallax.md` (FOUND-DEPTH-PARALLAX-04).
- Depth acceptance: `01-foundations/depth/07-acceptance.md`.

---

## 7. Evidence strength summary

| Claim | Strength | Source |
|---|---|---|
| Human motion is spring-like (minimum jerk) | Strong | Flash & Hogan 1985 |
| Pointing time follows Fitts' law | Strong | Fitts 1954; decades of replication |
| Steering time follows Accot-Zhai law | Moderate | Accot & Zhai 1997; derived from Fitts |
| Motion sickness from sensory conflict | Moderate-strong | Reason & Brand 1975; Oman 1990 |
| Vection and VIMS are not identical | Moderate | Keshavarz et al. 2015 |
| Predictive processing explains perception/action | Contested but influential | Clark 2013, 2016 |
| Reduced motion must be disableable | Strong (standard) | WCAG 2.3.3 |
| Flashing above 3 Hz is a seizure risk | Strong (standard) | WCAG 2.3.1 |
| Fixed timestep gives determinism | Strong (engineering) | Gaffer on Games 2004 |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-130` | Every principle in the motion foundation cites at least one source in this file with author, title, year, URL and access date. |
| `AC-FOUND-MOTION-131` | Every source listed here was opened and verified in this session; no invented numbers or quotes. |