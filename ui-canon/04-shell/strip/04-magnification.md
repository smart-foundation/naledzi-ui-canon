---
id: SHELL-STRIP-MAGNIFICATION
title: Strip Magnification
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-040, AC-SHELL-STRIP-041]
---

# Strip Magnification

> One spring. Proximity-based. Focus-aware. Reduced-motion-aware. Magnification explains
> which card is selected; it is not decoration.

---

## 1. The model

Magnification is a single named spring (`SPRING-STRIP-MAGNIFY`) that scales the card under
the pointer/focus and its neighbours by proximity. It is target-based, velocity-preserving
and settles.

Parameters (proposed, owned by `motion/06-tokens.md`):

- response: declared spring response,
- damping: declared (underdamped enough to feel alive, bounded),
- maximum scale: declared per envelope (e.g., 1.5× on desktop, 1.2× on phone),
- proximity falloff: cards beyond N positions are not scaled.

---

## 2. Proximity

- The card under the pointer/focus gets maximum scale.
- Neighbours within the proximity radius get a scaled factor that falls off by distance.
- Cards beyond the radius are at base scale.
- The proximity radius is declared per envelope (narrower on small screens).

---

## 3. Focus

- On pointer envelopes, magnification follows the pointer.
- On non-pointer envelopes (TV, remote, keyboard), magnification follows focus.
- On touch, magnification follows the finger while dragging; on release it settles to the
  focused card.
- The focused card is always magnified (even without pointer) so the selection is visible.

---

## 4. Reduced motion

- Under reduced motion, travel is removed: the selected card gets a static scale (or no
  scale, with a focus ring instead) and neighbours do not animate.
- The state change (which card is selected) remains visible.
- No infinite or decorative motion.

---

## 5. Safety and performance

- Magnification never occludes a safety indicator.
- Magnification runs only while the strip is visible; hidden strip costs zero.
- The spring settles; no continuous scheduling.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-040` | Magnification uses one named spring; interruptible without jump; settles. |
| `AC-SHELL-STRIP-041` | Reduced motion removes travel while selection stays visible. |
| `AC-SHELL-STRIP-042` | Magnification costs zero when the strip is hidden. |
| `AC-SHELL-STRIP-043` | Focused card is always magnified on non-pointer envelopes. |