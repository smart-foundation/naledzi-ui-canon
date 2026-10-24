---
id: UX-MOTOR
title: Motor — Fitts's Law, Steering Law, Motor Control, Spring-like Movement, Gesture Handoff
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-PERCEPTION, UX-COGNITION]
supersedes: []
superseded_by: []
acceptance: [AC-UX-MOTOR-001, AC-UX-MOTOR-002, AC-UX-MOTOR-003]
---

# Motor

> How the body moves, points and gestures, and what that forces on target size, path
> length, edges, corners and gesture handoff.

## 1. Principle

Human movement is not a sequence of positions chosen in advance. It is the output of a
spring-like neuromuscular system that minimises jerk. Pointing time grows logarithmically
with the ratio of distance to target width (Fitts, 1954). Steering through a constrained
path grows with path length and inversely with path width (Accot and Zhai, 1997).
Edges and corners are infinitely large targets in one or two dimensions. Interrupted
movement must preserve velocity or it feels broken. Motion that explains change must
settle and stop.

## 2. Evidence

### 2.1 Fitts's law

- **Fitts, P. M. (1954).** "The information capacity of the human motor system in
  controlling the amplitude of movement." *Journal of Experimental Psychology*, 47(6),
  pp. 381–391. (URL: https://doi.org/10.1037/h0055392 ; accessed 23 October 2026.)
  Finding: movement time MT = a + b·log₂(2D/W), where D is distance to target centre
  and W is target width along the axis of motion. Limit: the original form is 1D;
  2D extensions (MacKenzie and Buxton, 1992) and the Shannon formulation (MacKenzie,
  1992) are used in practice. Implication: Naledzi targets must be as large as the
  layout allows; small targets cost time and error; the `D/W` ratio is the design
  variable.

- **MacKenzie, I. S. (1992).** "Fitts' law as a research and design tool in
  human-computer interaction." *Human-Computer Interaction*, 7, pp. 91–139. (URL:
  https://doi.org/10.1207/s15327051hci0701_3 ; accessed 23 October 2026.) Finding:
  the Shannon formulation ID = log₂(D/W + 1) improves fit and is the ISO 9241-9
  standard form. Limit: requires empirical fitting of a, b. Implication: Naledzi cites
  the Shannon form for any throughput measurement and targets ISO 9241-9 conformance.

- **ISO 9241-9:2000.** *Ergonomic requirements for office work with visual display
  terminals (VDTs) — Part 9: Requirements for non-keyboard input devices.* (URL:
  https://www.iso.org/standard/30030.html ; accessed 23 October 2026.) Finding: defines
  throughput (bits/s) using the Shannon form with adjustment for accuracy. Limit:
  written for desktop pointing devices; transfer to touch and remote is interpretation.
  Implication: Naledzi throughput claims are measured per ISO 9241-9 on the reference
  envelope.

- **Card, S. K., English, W. K. and Burr, B. J. (1978).** "Evaluation of mouse,
  rate-controlled isometric joystick, step keys, and text keys for text selection on a
  CRT." *Ergonomics*, 21(8), pp. 601–613. (URL:
  https://doi.org/10.1080/00140137808931762 ; accessed 23 October 2026.) Finding:
  mouse outperformed joystick and keys; the mouse's success was a major factor in its
  commercial adoption. Implication: pointer input is the high-throughput path on
  desktop; touch is the high-throughput path on phone; remote is the path on TV; each
  envelope's primary input is designed for its Fitts throughput.

### 2.2 Steering law

- **Accot, J. and Zhai, S. (1997).** "Beyond Fitts' law: models for trajectory-based
  HCI tasks." *Proceedings of CHI '97*, pp. 295–302. (URL:
  https://doi.org/10.1145/258549.258760 ; accessed 23 October 2026.) Finding: steering
  time through a tunnel of width W and length A is MT = a + b·(A/W). Limit: tunnel
  geometry must be straight or gently curved; sharp corners break the model.
  Implication: sliders, scrollbars, menu traversal and drag paths are steering tasks;
  their paths must be wide enough and free of sharp corners; a narrow or jagged path
  is a motor defect.

- **Accot, J. and Zhai, S. (2002).** "More than dotting the i's: foundations for
  crossing-based interfaces." *Proceedings of CHI '02*, pp. 73–80. (URL:
  https://doi.org/10.1145/503376.503390 ; accessed 23 October 2026.) Finding:
  crossing a boundary can be faster than pointing to a target; crossing-based
  interfaces are a legitimate primitive. Implication: Naledzi may use crossing for
  edge and corner actions where pointing is slower; crossing is an accelerator, not
  the only path.

### 2.3 Motor control and spring-like movement

- **Flash, T. and Hogan, N. (1985).** "The coordination of arm movements: an
  experimentally confirmed mathematical model." *Journal of Neuroscience*, 5(7),
  pp. 1688–1703. (URL: https://doi.org/10.1523/JNEUROSCI.05-07-01688.1985 ; accessed
  23 October 2026.) Finding: point-to-point arm movements follow a minimum-jerk
  trajectory, equivalent to a critically damped spring response to an equilibrium-point
  shift. Limit: the model is for planar arm movements; head, eye and finger movements
  differ. Implication: Naledzi motion is spring physics with velocity preservation
  (`FOUND-MOTION-001`..`005`); a fixed-duration curve that restarts on interruption
  is not a spring and is forbidden.

- **Hogan, N. (1984).** "An organizing principle for a class of voluntary movements."
  *Journal of Neuroscience*, 4(11), pp. 2745–2754. (URL:
  https://doi.org/10.1523/JNEUROSCI.04-11-02745.1984 ; accessed 23 October 2026.)
  Finding: the equilibrium-point hypothesis; movement is a shift of equilibrium, not a
  trajectory plan. Implication: target-based animation (current → target) matches the
  motor model; path-based animation does not and is not the default.

- **Woodworth, R. S. (1899).** "Accuracy of voluntary movement." *Psychological
  Review Monograph Supplements*, 3(3), i–114. (URL:
  https://doi.org/10.1037/h0092992 ; accessed 23 October 2026.) Finding: movement
  has an initial (ballistic, fast, imprecise) phase and a final (corrective, slow,
  precise) phase. Implication: a target that is acquired in the ballistic phase needs
  a large tolerance; a target acquired in the corrective phase needs precision
  support (snap, magnetism) — but only where declared.

### 2.4 Edges, corners and magic pixels

- **Fitts's law implications** (see §2.1 and Wikipedia "Fitts's law", "Implications for
  UI design"). (URL: https://en.wikipedia.org/wiki/Fitts%27s_law ; accessed 23 October
  2026.) Finding: placing targets on screen edges makes them infinitely large in one
  dimension; corners are infinitely large in two. Implication: Naledzi uses edges and
  corners for high-frequency, low-precision actions (close, start, back) on envelopes
  where a pointer is the primary input; on touch envelopes, edges are thumb-reach
  zones, not infinite targets, and the design must not assume infinity.

### 2.5 Gesture handoff

- **Beaudouin-Lafon, M. (2000).** "Instrumental interaction: an interaction model for
  designing post-WIMP user interfaces." *Proceedings of CHI '00*, pp. 446–453. (URL:
  https://doi.org/10.1145/332040.332473 ; accessed 23 October 2026.) Finding:
  interaction is mediated by instruments (pointers, tools); the instrument's state
  belongs to the user, not the system. Implication: gesture velocity belongs to the
  person's hand; on release it becomes the spring's initial velocity; the system does
  not reset it.

- **Oulasvirta, A., Dayama, N. R., Shiripour, M., John, M. and Karrenbauer, A. (2020).**
  "Combinatorial optimization of graphical user interface designs." *Proceedings of the
  IEEE*, 108(3), pp. 434–464. (URL: https://doi.org/10.1109/JPROC.2020.2969687 ;
  accessed 23 October 2026.) Finding: layout optimisation can improve motor
  performance; the gains are modest and depend on task. Limit: optimisation overfits
  to a task model. Implication: Naledzi does not auto-layout by optimisation; it
  uses declared rules; optimisation is a research tool, not a product mechanism.

## 3. What this predicts for Naledzi

1. **Targets obey Fitts's law.** Minimum target 24 × 24 CSS px at AA (WCAG 2.5.8),
   44 × 44 at AAA (WCAG 2.5.5); on touch envelopes, 44 × 44 is the floor.
2. **Edges and corners are infinite targets on pointer envelopes only.** On touch
   envelopes they are thumb zones.
3. **Steering paths are wide and smooth.** Sliders, scrollbars, menus, drag paths.
4. **Gesture velocity is preserved.** Release velocity becomes spring initial velocity;
   no reset (`FOUND-MOTION-004`).
5. **Motion settles and stops.** No infinite motion; idle is silent (`LAW-004`).
6. **Crossing is an accelerator, not the only path.** (`LAW-010` spirit.)

## 4. Limits and contested claims

- Fitts's law is for aimed movements; it does not cover continuous tracking or
  steering (use Accot–Zhai for those).
- Minimum target sizes from WCAG are for web content; their transfer to native OS
  controls is interpretation, but they are the best-evidenced numbers available and
  are adopted as floors.
- Motor control models (minimum-jerk) are for arm movements; finger, eye and head
  movements differ and are not covered here.

## 5. Where implemented (IDs)

- `UX-LAW-03`.
- `FOUND-MOTION-001`..`005`, `FOUND-MOTION-004` (gesture handoff).
- `LAW-008`, `LAW-004`, `LAW-010`.
- `06-envelopes/*` — primary input per envelope.
- `04-shell/gestures/` — global gesture grammar.

## 6. Acceptance implications

- `AC-UX-MOTOR-001`: Every interactive target in the reference set meets the
  envelope's minimum target size.
- `AC-UX-MOTOR-002`: Every steering path (slider, scrollbar, menu, drag) has width
  ≥ 8 px and no corner sharper than 90°.
- `AC-UX-MOTOR-003`: Gesture handoff preserves velocity within 5% in the reference
  measurement.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-MOTOR-001` | All targets meet envelope minimum size. |
| `AC-UX-MOTOR-002` | All steering paths meet width and corner rules. |
| `AC-UX-MOTOR-003` | Gesture handoff preserves velocity within 5%. |