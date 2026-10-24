---
id: FOUND-DEPTH-PARALLAX-04
title: Parallax
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-SPACE-01, FOUND-MOTION-INDEX, LAW-007, LAW-008]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-040, AC-FOUND-DEPTH-041, AC-FOUND-DEPTH-042]
---

# Parallax

> Parallax is evidence of distance. If nothing is actually moving, there is no distance to
> evidence. A parallax that follows a decoration is a lie that also makes people ill.

---

## 1. What parallax is for

Parallax is the relative movement of layers when the viewpoint or the device moves. It tells
the person which surfaces are nearer and which are farther. In Naledzi it has exactly three
legal sources:

| Source | Envelope | What moves | What it explains |
|---|---|---|---|
| **Pointer position** | Desktop, tablet with pointer | E2-E3 layers relative to the E0/E1 plane | The floating layer sits above the page |
| **Device motion** | Phone, tablet | E2-E3 layers by a few pixels | The raised layer is in front of the page |
| **Head position** | Spatial | World-locked layers and content | True distance and comfort |

No other source is legal. Scroll is not a parallax source; it moves the world plane, which is
a different relationship. Audio is not a parallax source. A video playing behind the UI is not
a parallax source.

- **FOUND-DEPTH-110.** Parallax MUST be driven by a real change in viewpoint or device
  orientation. It MUST NOT be driven by time, scroll, audio level, or a decorative loop.
- **FOUND-DEPTH-111.** Parallax MUST be applied only to E2-E3 layers, or to declared world
  layers in a spatial envelope. E0, E1, text and critical indicators MUST NOT parallax.
- **FOUND-DEPTH-112.** Parallax MUST be disabled when reduced motion is requested, when the
  device reports a vestibular-sensitive setting, or when the envelope is EV or spaceship.

---

## 2. Magnitude

The effect is small. It exists to separate planes, not to create a 3D ride.

| Level | Maximum displacement | Maximum scale change | Notes |
|---|---|---|---|
| E2 | 4 CSS px | 0.5% | A menu may shift slightly with pointer |
| E3 | 6 CSS px | 0.75% | A sheet may shift slightly with device tilt |
| Spatial world layer | Declared per scene | Declared per scene | Comfort budget in `accessibility/08-vestibular.md` |

Rules:

- Displacement is measured at the layer's centre, not at its edge.
- The maximum is reached at the edge of the input range, not exceeded at the centre.
- Scale change is optional; displacement alone is enough.
- No layer may move more than 2% of the viewport in any axis.
- No two layers may move in opposite directions in a way that suggests they are separating
  from a shared parent. Nearer layers move more; farther layers move less; the base does not
  move.

- **FOUND-DEPTH-120.** The parallax response MUST be monotonic with the input. A pointer that
  moves right must not make a layer move left.
- **FOUND-DEPTH-121.** The response MUST be bounded. There is no unbounded follow, no
  rubber-band beyond the maximum and no acceleration after the input stops.
- **FOUND-DEPTH-122.** Parallax MUST settle to rest within 120 ms after the input stops. It
  MUST NOT continue to drift.

---

## 3. Depth ordering

The model uses at most three parallax rates in one view:

| Rate | Layer | Meaning |
|---|---|---|
| 0.0 | E0/E1 and all text | The reference plane |
| 0.4 | E2 | Nearer than the page |
| 0.7 | E3 | Nearer than E2 |

A rate above 0.7 is not legal. A fourth rate would make the ordering ambiguous and the motion
noisy.

- **FOUND-DEPTH-130.** The rate MUST be declared per layer, not inferred from its shadow.
- **FOUND-DEPTH-131.** A layer's rate MUST NOT change while it is visible. A rate change is a
  level transition and must be treated as one.
- **FOUND-DEPTH-132.** Text MUST stay at rate 0.0 even when it sits inside a parallaxing
  layer; the layer moves, the text moves with it as a rigid body, and the text itself does not
  receive an additional offset.

---

## 4. Input mapping

The pointer and device mappings are deliberately simple:

```text
pointer_norm = clamp((pointer - viewport_centre) / (viewport_size / 2), -1, +1)
offset = pointer_norm * max_displacement * rate
```

- The mapping is linear. A curve would make the response unpredictable and hard to test.
- The centre is the current viewport centre, not the screen centre.
- The mapping uses the primary pointer. A second pointer does not add a second parallax.
- On a device with no pointer and no usable motion sensor, parallax is absent, not faked.

- **FOUND-DEPTH-140.** A pointer that leaves the viewport MUST NOT leave the layer at an
  extreme. The layer returns to rest or holds at the last bounded value, as declared.
- **FOUND-DEPTH-141.** Device motion MUST be filtered so that hand tremor does not produce
  visible jitter. The filter's cutoff MUST be declared in the token file.
- **FOUND-DEPTH-142.** If the motion sensor is unavailable or permission is denied, the
  envelope MUST fall back to no parallax and MUST NOT show a permission prompt solely for a
  decorative effect.

---

## 5. Reduced motion and vestibular safety

Parallax is one of the highest-risk effects for vestibular discomfort because it creates
optic flow without a corresponding body movement.

- Under reduced motion, parallax is removed entirely. The layer does not move; the level is
  still communicated by shadow, tone and position.
- Under reduced transparency, parallax may remain if the layer is opaque; if the layer is
  translucent, parallax is removed because the moving background compounds the effect.
- In a spatial envelope, parallax is real and cannot be removed without removing depth. The
  comfort budget instead limits acceleration, field of view and duration, and provides a
  fixed-reference mode. See `accessibility/08-vestibular.md`.

- **FOUND-DEPTH-150.** Reduced motion MUST remove parallax, not merely reduce it.
- **FOUND-DEPTH-151.** A spatial scene MUST provide a fixed-reference mode that disables
  world-locked motion for the person while preserving the scene's information.
- **FOUND-DEPTH-152.** No parallax may be applied to a critical indicator, a warning, a
  reading surface or a text block.

---

## 6. Failure

| Failure | Result | Required behaviour |
|---|---|---|
| Pointer device disappears mid-gesture | Layer stuck at an offset | Return to rest over the declared settle time; do not jump |
| Motion sensor noisy | Jitter | Filter; if still noisy, disable parallax and keep the level |
| Sensor permission denied | No parallax | Draw the static level; do not prompt |
| Frame rate drops | Parallax stutters | Reduce or disable parallax before dropping the whole frame budget |
| Reduced motion toggled while visible | Effect must stop | Stop at the current offset, then settle to rest within 120 ms; do not snap |
| Spatial tracking lost | Scene jumps | Hold the last stable pose, show a tracking-loss state if it persists, and offer a fixed-reference mode |

---

## 7. What this model refuses

- Parallax on scroll.
- Parallax on hover for a card that is not floating.
- Parallax that continues after the pointer stops.
- Parallax on text.
- Parallax on a safety warning.
- A "3D tilt" card that follows the cursor.
- A background video that moves at a different rate from the foreground.
- A parallax effect that cannot be disabled.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-040` | Move the pointer from centre to each edge. Only E2/E3 layers move, displacement never exceeds the token maximum, and the response is monotonic. |
| `AC-FOUND-DEPTH-041` | Enable reduced motion while a layer is displaced. The layer settles to rest within 120 ms and does not snap. |
| `AC-FOUND-DEPTH-042` | On a phone with the motion sensor denied, no parallax occurs and no permission prompt is shown. |
| `AC-FOUND-DEPTH-043` | In the EV and spaceship reference flows, no parallax occurs on any surface. |
