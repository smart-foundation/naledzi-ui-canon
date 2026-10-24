---
id: FOUND-MOTION-REDUCED-04
title: Reduced Motion
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-SPRINGS-01, FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX, LAW-008, LAW-009, LAW-020]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-040, AC-FOUND-MOTION-041, AC-FOUND-MOTION-042, AC-FOUND-MOTION-043]
---

# Reduced Motion

> Reduced motion is not "less pretty". It is the difference between an interface a person
> can use and one that makes them sick. The state change survives; only the travel is
> removed.

---

## 1. Why motion can harm

Motion on a screen that does not match the body's vestibular signals produces a sensory
conflict. Reason and Brand's sensory conflict theory (1975) proposes that motion sickness
arises when visual, vestibular and proprioceptive signals disagree about self-motion;
Oman (1990) synthesised and evaluated that theory and identified the neural mismatch
between expected and actual sensory input as the trigger. Visually induced motion
sickness (VIMS) is the screen-specific variant: the eyes report motion that the inner ear
does not, and the result is nausea, dizziness, headache and, in severe cases,
disorientation lasting hours.

Keshavarz, Riecke, Hettinger and Campos (2015) reviewed the relationship between
vection (the illusion of self-motion) and VIMS and found that the two are related but not
identical: strong vection can occur without sickness, and sickness can occur without
strong vection. The practical consequence is that **there is no single safe motion
threshold**; susceptibility varies widely between people and within a person across days
(RES-A11Y-020). A design that is comfortable for the median user can disable another.

The triggers that the literature identifies as highest risk are:

- **Parallax** — relative motion of layers without a corresponding body movement
  (depth owns this; motion owns the removal).
- **Large-field motion** — a full-screen pan, zoom or rotation.
- **Spin and rotation** — any rotation of the view plane.
- **Zoom** — scale changes that suggest approach or retreat.
- **Autoplaying or looping motion** — motion that continues without the person's action.
- **Flashing above 3 Hz** — seizure risk, WCAG 2.3.1.

- **FOUND-MOTION-200.** Parallax, large-field motion, spin and zoom MUST be removable
  independently of other motion. They are the highest-risk effects.
- **FOUND-MOTION-201.** Looping or autoplaying motion MUST NOT exist in this model at
  all (`LAW-004`, `FOUND-MOTION-003`).

---

## 2. The preference

Reduced motion is requested through one of three channels, and the motion engine honours
all three:

1. **System setting** — the OS-level "reduce motion" toggle (macOS/iOS Reduce Motion,
   Windows "Show animations in Windows", Android "Remove animations", GNOME "Reduce
   motion").
2. **Media query** — `prefers-reduced-motion: reduce` (WCAG 2.3.3, Level AAA).
3. **Vestibular-sensitive setting** — an explicit "I am motion-sensitive" toggle that the
   person can set independently of the system setting, because some OS settings are
   global and coarse.

The three are OR-combined: if any is set, reduced motion applies. The setting is read at
session start and on change; a change mid-session applies to the next motion, and any
in-flight motion settles and is not restarted.

- **FOUND-MOTION-210.** Reduced motion MUST be honoured from all three channels
  (system, media query, explicit toggle). Honouring only one is forbidden.
- **FOUND-MOTION-211.** A change to the reduced-motion setting mid-session MUST apply to
  the next motion. An in-flight motion MUST settle and not be restarted with new
  parameters.
- **FOUND-MOTION-212.** The setting MUST be readable by the motion engine as an explicit
  input, not inferred from the frame rate or the device (`LAW-019`).

---

## 3. What reduced motion removes and what survives

The rule is: **remove travel, keep the state change.** A reduced-motion user must still
know that a dialog opened, that a list item was deleted, that a value changed. What
disappears is the journey, not the fact.

| Motion | Default | Reduced motion |
|---|---|---|
| Enter of a dialog/sheet | `SPRING-ENTER` (scale + position) | Opacity fade (120 ms) or instant |
| Exit | `SPRING-EXIT` | Opacity fade (80 ms) or instant |
| Shared element | Geometry spring | Cross-fade between source and destination |
| Stagger | Sequential entry | All items together, opacity fade |
| Gesture settle | `SPRING-SETTLE` | `SPRING-REDUCED` (near-instant snap) |
| Scroll momentum | `SPRING-SCROLL` | No momentum; position snaps to target |
| Parallax | Present (depth) | Removed entirely |
| Value tick (number changing) | Spring on the value | Instant update; no spring |
| Focus move | Instant (never sprung) | Instant (unchanged) |
| Safety indicator state change | `SPRING-SAFETY` | `SPRING-SAFETY` (unchanged; safety motion is not reduced) |

Rules:

- **FOUND-MOTION-220.** Reduced motion MUST remove travel while preserving the state
  change. Removing the state change is forbidden (`WCAG 2.3.3`).
- **FOUND-MOTION-221.** A reduced-motion alternative MUST be a declared substitute, not
  the absence of any feedback. "Nothing happens" is not an alternative.
- **FOUND-MOTION-222.** Safety motion (`SPRING-SAFETY`) MUST NOT be reduced. A safety
  indicator that stops moving under reduced motion is a defect, because the state change
  is the information.
- **FOUND-MOTION-223.** Under reduced motion, `SPRING-REDUCED` (ω ≈ 60 rad/s, ζ = 1.0)
  is used where a spring is still needed for correctness (settle detection, layout). It
  settles within one frame on a 60 Hz display.

---

## 4. Vestibular safety in the model

The model's own rules already remove most high-risk motion:

- No decorative parallax (`FOUND-DEPTH-110`, `FOUND-MOTION-001`).
- No looping or autoplaying motion (`FOUND-MOTION-201`).
- No rotation of the view plane (`FOUND-MOTION-130` on critical indicators; view-plane
  rotation is not a legal motion anywhere).
- Parallax limited to E2-E3 and a few pixels (`FOUND-DEPTH-111`, `FOUND-DEPTH-120`).
- Parallax disabled under reduced motion (`FOUND-DEPTH-150`).

What remains is to ensure that the motion that *is* legal is also safe:

- **FOUND-MOTION-230.** A single motion MUST NOT move more than 25% of the viewport in
  any axis. Larger travel MUST be split into a scroll (which the person controls) or a
  page change.
- **FOUND-MOTION-231.** A motion MUST NOT change both position and scale simultaneously
  by more than the declared thresholds (4 px displacement and 0.5% scale; see
  `FOUND-DEPTH-120`). Combined large travel and scale is the highest-risk combination.
- **FOUND-MOTION-232.** A motion that the person did not trigger (system-initiated) MUST
  be shorter and smaller than one the person triggered. System-initiated motion is capped
  at `SPRING-REDUCED` parameters.
- **FOUND-MOTION-233.** No element MUST flash, blink or strobe. A state change that needs
  emphasis uses a single, non-repeating pulse with a declared duration, never a loop.

---

## 5. Seizure safety

WCAG 2.3.1 (Level A) forbids flashing more than three times per second. This is a
hard floor, not a guideline.

- **FOUND-MOTION-240.** No surface, indicator or animation MUST flash above 3 Hz. A
  violation is a safety defect, not an accessibility nit.
- **FOUND-MOTION-241.** An emissive or colour-cycling indicator (safety or otherwise)
  MUST have a declared, non-looping pulse rate below 3 Hz, or be static.
- **FOUND-MOTION-242.** A system that cannot determine whether a motion is flashing MUST
  treat it as flashing and disable it.

---

## 6. Testing reduced motion

1. Enable each of the three channels in turn. Verify reduced motion applies.
2. Run the reference flows. Verify every motion is either removed or substituted per the
   table in §3.
3. Verify that every state change still occurs and is visible or announced.
4. Verify that no motion exceeds the §4 thresholds even in default mode.
5. Verify that safety motion is unchanged under reduced motion.

- **FOUND-MOTION-250.** Reduced motion MUST be testable by toggling a single setting
  without rebuilding. A motion that can only be disabled by recompiling is
  non-conformant.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-040` | Enable reduced motion via each of the three channels; motion reduces per §3 on every reference surface. |
| `AC-FOUND-MOTION-041` | With reduced motion on, every state change in the reference flows still occurs and is visible or announced. |
| `AC-FOUND-MOTION-042` | No motion in default mode exceeds the §4 thresholds (25% viewport travel, combined thresholds). |
| `AC-FOUND-MOTION-043` | Safety motion is unchanged under reduced motion; safety indicators still animate their declared state changes. |
| `AC-FOUND-MOTION-044` | No surface flashes above 3 Hz in any mode; verified by frame capture. |