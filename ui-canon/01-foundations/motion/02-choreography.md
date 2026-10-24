---
id: FOUND-MOTION-CHOREO-02
title: Choreography
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-SPRINGS-01, FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX, LAW-005, LAW-008, ADR-0005]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-020, AC-FOUND-MOTION-021, AC-FOUND-MOTION-022, AC-FOUND-MOTION-023]
---

# Choreography

> Choreography is the order in which things change, not the curve they follow. The curve is a
> spring. The order is a contract: what enters first, what leaves last, what waits, and what
> never moves.

---

## 1. Principles

1. **One cause, one motion.** A single user action produces one coherent motion. If three
   things move for one reason, they move together, not in sequence.
2. **Continuity of identity.** A surface that is the same object in two states moves
   between them; it is not removed and re-added. Removal plus addition reads as replacement.
3. **No hidden predecessor.** A surface that will appear does not animate in from a place
   the person cannot see, unless that place is its real origin (a menu from its trigger).
4. **Settle before the next.** A sequence of motions waits for the previous to settle, or
   declares an overlap. An undeclared overlap is a race.
5. **Interruptibility everywhere.** Every choreography in this file is interruptible at any
   frame with velocity preservation (`01-springs.md` §5).

---

## 2. Enter

An enter brings a new surface into the visible set. It always has an origin, a target and a
spring.

### 2.1 Enter origin

| Surface | Origin | Motion |
|---|---|---|
| Dialog (E3) | Centre of the viewport, scaled 0.96, opacity 0 | `SPRING-ENTER` on scale and opacity; centre fixed |
| Sheet (E3) | Bottom edge (or declared edge), full width, offset by its height | `SPRING-ENTER` on position; opacity 1 immediately |
| Popover (E2) | Its trigger's anchor point | `SPRING-ENTER` on position and opacity; scale 0.98→1 |
| Menu (E2) | Its trigger's anchor point | `SPRING-ENTER` on position and opacity |
| Toast (E2) | Top or bottom edge per envelope | `SPRING-ENTER` on position; opacity fades in |
| New list row | The row's final position, opacity 0 | `SPRING-ENTER` on opacity only; no travel |

Rules:

- **FOUND-MOTION-070.** An enter MUST have a declared origin. An enter that fades in from
  nowhere is forbidden.
- **FOUND-MOTION-071.** An enter MUST NOT move the underlying surface. The base stays;
  only the new surface moves.
- **FOUND-MOTION-072.** An enter of an E3 surface MUST add its scrim in the same still as
  the surface appears (`FOUND-DEPTH-173`). No frame with scrim and no surface, or surface
  and no scrim.
- **FOUND-MOTION-073.** An opacity-only enter (no travel) is the default under reduced
  motion.

### 2.2 Enter frames

```text
Frame 1 — idle (surface absent)
+--------------------------------------+
|  base content                        |
|                                      |
|                                      |
+--------------------------------------+

Frame 2 — enter begins (origin visible)
+--------------------------------------+
|  base content                        |
|            +--------+                |
|            | dialog |  (scale 0.96,  |
|            | (dim)  |   opacity 0.6)  |
|            +--------+                |
|  scrim 32%                           |
+--------------------------------------+

Frame 3 — settling
+--------------------------------------+
|  base content (dimmed)               |
|            +--------+                |
|            | dialog |  (scale 0.99,  |
|            |        |   opacity 0.9)  |
|            +--------+                |
+--------------------------------------+

Frame 4 — settled, at rest
+--------------------------------------+
|  base content (dimmed)               |
|            +--------+                |
|            | dialog |  (scale 1.00)   |
|            |        |                 |
|            +--------+                |
+--------------------------------------+
```

---

## 3. Exit

An exit removes a surface. It is the reverse of enter, with two differences: it is faster
(`SPRING-EXIT`), and the underlying surface's state is preserved across it.

Rules:

- **FOUND-MOTION-080.** An exit MUST animate to a declared destination (origin or off-screen
  edge), not simply fade.
- **FOUND-MOTION-081.** An exit MUST preserve the underlying surface's state. The base does
  not re-flow during an exit.
- **FOUND-MOTION-082.** An E3 exit MUST remove the scrim in the same still as the surface
  leaves.
- **FOUND-MOTION-083.** If an exit is interrupted by a new enter of the same kind, the new
  surface takes over from the current position and velocity (retarget), and the old surface
  is removed without its own exit animation.

### 3.1 Exit frames

```text
Frame 1 — settled dialog
+--------------------------------------+
|  base content (dimmed)               |
|            +--------+                |
|            | dialog |                |
|            +--------+                |
+--------------------------------------+

Frame 2 — exit begins
+--------------------------------------+
|  base content                        |
|            +--------+                |
|            | dialog |  (scale 0.98,  |
|            |        |   opacity 0.7)  |
|            +--------+                |
|  scrim fading                        |
+--------------------------------------+

Frame 3 — exit ends, surface gone
+--------------------------------------+
|  base content                        |
|                                      |
|                                      |
+--------------------------------------+
```

---

## 4. Gesture handoff

A gesture (drag, swipe, pinch) owns a surface while the pointer or touch is down. On
release, ownership transfers to a spring with velocity preservation. This is the single
most tested motion in the corpus.

### 4.1 Handoff sequence

```text
Frame 1 — gesture active (pointer down)
+--------------------------------------+
|  list                                |
|  [row A]  <- held, follows finger    |
|  [row B]                             |
+--------------------------------------+
   spring suspended; surface follows input

Frame 2 — release detected
+--------------------------------------+
|  list                                |
|  [row A]  (x = finger x, v = release |
|            velocity, target = rest)   |
|  [row B]                             |
+--------------------------------------+
   velocity measured over last 80 ms

Frame 3 — spring integrating
+--------------------------------------+
|  list                                |
|  [row A]  -> moving toward rest      |
|  [row B]                             |
+--------------------------------------+

Frame 4 — settled at rest
+--------------------------------------+
|  list                                |
|  [row A]                             |
|  [row B]                             |
+--------------------------------------+
```

Rules:

- **FOUND-MOTION-090.** A gesture MUST suspend the spring while active; the spring MUST NOT
  integrate underneath a held surface (`01-springs.md` §5.2).
- **FOUND-MOTION-091.** On release, the spring's initial velocity MUST be the measured
  release velocity (filtered, 80 ms window), not zero and not a constant.
- **FOUND-MOTION-092.** The target on release MUST be the declared resting position for
  that surface, or the nearest snap point for a paging gesture.
- **FOUND-MOTION-093.** If the release velocity exceeds the declared throw threshold, the
  target becomes the next snap point in the direction of travel (a flick), and the spring
  uses `SPRING-SCROLL`. Below the threshold, it returns to the current snap point with
  `SPRING-SETTLE`.
- **FOUND-MOTION-094.** A gesture that is cancelled (system gesture, focus loss, safety
  alert) MUST hand off with `v = 0` and return to the last stable position. This is the
  only case where zero velocity on handoff is permitted, and it must be logged.

---

## 5. Shared element

A shared element is one object that exists in two states (for example a thumbnail that
opens into a full image). It moves between them rather than being replaced.

### 5.1 Shared-element sequence

```text
Frame 1 — source state (thumbnail in list)
+--------------------------------------+
|  [thumb]  title                      |
|  [thumb]  title                      |
+--------------------------------------+

Frame 2 — transition begins (element lifts)
+--------------------------------------+
|                                      |
|        +------------------+          |
|        |   (growing)      |          |
|        +------------------+          |
|  (source fades)                      |
+--------------------------------------+

Frame 3 — settling at destination
+--------------------------------------+
|                                      |
|   +------------------------------+   |
|   |        full image            |   |
|   +------------------------------+   |
+--------------------------------------+

Frame 4 — destination state (element at rest)
+--------------------------------------+
|                                      |
|   +------------------------------+   |
|   |        full image            |   |
|   |        caption               |   |
|   +------------------------------+   |
+--------------------------------------+
```

Rules:

- **FOUND-MOTION-100.** A shared element MUST animate its geometry (position, size) with a
  single named spring per property, all started on the same frame.
- **FOUND-MOTION-101.** The source surface MUST fade out and the destination surface MUST
  fade in, timed so that at least one of them is visible in every frame
  (`FOUND-DEPTH-061`).
- **FOUND-MOTION-102.** A shared element MUST NOT be implemented as remove-then-add. The
  same instance (or its declared proxy) carries the geometry.
- **FOUND-MOTION-103.** If the destination is not ready when the transition is requested,
  the element animates to a declared placeholder position and holds; it does not wait
  invisible.

---

## 6. Stagger

Stagger is the sequential entry of a list of related surfaces. It is the one place where
motion is deliberately sequential rather than simultaneous.

Rules:

- **FOUND-MOTION-110.** Stagger MUST be used only for a list of related items entering
  together. It MUST NOT be used for unrelated surfaces.
- **FOUND-MOTION-111.** The stagger delay between items MUST be a token (`TOK-MOTION-STAGGER-*`),
  in the range 20–60 ms. A delay above 60 ms reads as a slow machine, not a design.
- **FOUND-MOTION-112.** Each item uses `SPRING-ENTER`. The spring parameters do not change
  per item; only the start time does.
- **FOUND-MOTION-113.** Stagger MUST be cancelled if the list changes before it completes:
  new items join at the end, removed items stop, and the remaining items do not re-stagger.
- **FOUND-MOTION-114.** Under reduced motion, stagger is removed: all items appear together
  (opacity fade only, or instantly).

### 6.1 Stagger frames

```text
Frame 1 — list entering (item 1 visible)
+--------------------------------------+
|  [item 1]                            |
|                                      |
|                                      |
+--------------------------------------+

Frame 2 — item 2 enters (40 ms later)
+--------------------------------------+
|  [item 1]                            |
|  [item 2] (opacity 0.6)              |
|                                      |
+--------------------------------------+

Frame 3 — item 3 enters
+--------------------------------------+
|  [item 1]                            |
|  [item 2]                            |
|  [item 3] (opacity 0.6)              |
+--------------------------------------+

Frame 4 — all settled
+--------------------------------------+
|  [item 1]                            |
|  [item 2]                            |
|  [item 3]                            |
+--------------------------------------+
```

---

## 7. Interrupt

An interrupt changes the target or cancels the motion before it has settled. The rule is
uniform: preserve velocity, continue from the current position.

### 7.1 Interrupt cases

| Case | Trigger | Result |
|---|---|---|
| New target | A new state replaces the old | Retarget; `x`, `v` preserved |
| Gesture grab | Pointer down on a moving surface | Spring suspended; surface follows input; velocity measured |
| State change | The surface's state changes (loading → ready) | Cross-fade or content swap with `SPRING-MOVE`; position spring continues |
| Safety alert | A critical indicator appears | Non-safety motion yields; safety motion runs; previous motion resumes or cancels per envelope |
| Focus change | Focus moves to another surface | The previous surface's motion continues to settle; no cancellation |
| Removal | The surface is removed | `SPRING-EXIT` from current position and velocity |

Rules:

- **FOUND-MOTION-120.** An interrupt MUST NOT reset `x` or `v`. The only exception is a
  cancelled gesture (`FOUND-MOTION-094`).
- **FOUND-MOTION-121.** An interrupt MUST NOT introduce a frame in which the surface is
  at neither the old nor the new target. The integration step is continuous.
- **FOUND-MOTION-122.** A motion that is interrupted and then re-targeted to its original
  target MUST resume as if uninterrupted, modulo the elapsed time. There is no "restart"
  penalty.
- **FOUND-MOTION-123.** When two motions conflict (for example an enter and an exit on the
  same slot), the later one wins and the earlier is cancelled with velocity preservation
  into the new target.

---

## 8. What never moves

Some surfaces never animate, because motion would obscure meaning or violate safety:

- Critical indicators and protected-zone content (EV, spaceship).
- Text blocks and reading surfaces during a layout change (the container moves; the text
  does not re-flow mid-motion).
- The status rail's safety indicators.
- Focus rings (they follow focus instantly; a lagging focus ring is a defect).
- Any surface under reduced motion that is not essential.

- **FOUND-MOTION-130.** A critical indicator MUST NOT animate its position, size or
  opacity except for a declared state change that is itself the information (for example
  a value ticking). Travel is forbidden.
- **FOUND-MOTION-131.** A focus ring MUST track focus in the same still. A spring on a
  focus ring is forbidden.
- **FOUND-MOTION-132.** Text MUST NOT animate its glyphs. Container motion is allowed;
  glyph motion is not.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-020` | Interrupt each choreography (enter, exit, shared element, stagger, gesture) at three arbitrary frames; no jump is visible and velocity is continuous. |
| `AC-FOUND-MOTION-021` | A shared-element transition keeps at least one of source or destination visible in every frame. |
| `AC-FOUND-MOTION-022` | A flick above the throw threshold pages; a release below it returns to the current snap point; both match reference recordings. |
| `AC-FOUND-MOTION-023` | Under reduced motion, stagger is removed and all items appear together; enter/exit reduce to opacity or instant. |