---
id: FOUND-DEPTH-SHADOW-03
title: Shadows
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-SPACE-01, FOUND-DEPTH-ELEV-02, LAW-007, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-030, AC-FOUND-DEPTH-031, AC-FOUND-DEPTH-032]
---

# Shadows

> A shadow is a statement that one surface is above another. It is not a border, a glow, a
> brand texture or a way to make a rectangle look expensive.

---

## 1. The two components

Every shadow in Naledzi is built from two layers. A single blurred rectangle is not a shadow;
it is a smudge.

| Component | Job | Behaviour |
|---|---|---|
| **Contact** | Shows that the surface is resting on or close to its parent | Tight, darker, small offset, low blur |
| **Ambient** | Shows that the surface is raised into the space | Wide, lighter, larger offset, high blur, low opacity |

The contact layer carries the "is it touching?" question. The ambient layer carries the "how
far above?" question. Removing either changes the meaning:

- Without contact, the surface floats in a void and the eye cannot tell where it lands.
- Without ambient, the surface looks like a printed border and the level is ambiguous.

- **FOUND-DEPTH-080.** A raised surface (E1-E4) MUST have both a contact and an ambient
  shadow, or a declared high-contrast outline substitute.
- **FOUND-DEPTH-081.** A shadow MUST fall on a surface that is declared below the casting
  surface. A shadow over empty background is a lie about the parent.
- **FOUND-DEPTH-082.** A shadow MUST NOT be used as a border, a focus indicator, a selection
  indicator or a divider.

---

## 2. The recipes

The values below are proposals. The authoritative values are `TOK-DEPTH-SHADOW-*` in
`08-tokens.md`; this table explains the shape of each recipe.

| Level | Contact | Ambient | Visual result |
|---|---|---|---|
| E0 | none | none | Flat page plane |
| E1 | `0 1px 2px`, 18% black | `0 2px 6px`, 8% black | A card that sits on the page |
| E2 | `0 2px 4px`, 20% black | `0 8px 20px`, 12% black | A menu that hovers above a trigger |
| E3 | `0 4px 8px`, 24% black | `0 16px 40px`, 16% black | A sheet that separates from the page |
| E4 | `0 8px 16px`, 28% black | `0 28px 64px`, 20% black | A system alert that owns the nearest plane |

Rules for the recipe:

- Offset grows with level; blur grows faster than offset.
- Opacity grows more slowly than blur, so higher levels feel softer, not dirtier.
- The contact layer never disappears on a raised surface, even when the ambient layer is
  reduced for performance.
- In dark themes, shadow opacity is increased and the ambient layer is kept tight, because a
  black shadow on a dark plane is weak; tonal separation is also increased so the level does
  not depend on a barely visible shadow. A grey shadow that reads as fog is a defect.
- In high contrast, shadows are replaced by outlines. The outline is not a shadow and must
  not be described as one.

---

## 3. Geometry

### 3.1 Offset

- The key light is above and slightly left, so the shadow offset has a small positive x and a
  positive y (downward).
- The offset MUST be the same direction for every surface in one output.
- The offset MUST NOT be mirrored for RTL.
- The offset MUST NOT follow the pointer, the device tilt or the scroll position.

### 3.2 Penumbra

Mamassian, Knill and Kersten (1998) found that a penumbra around a cast shadow strengthens the
depth percept. Naledzi therefore uses a soft edge, not a hard one:

- E1 penumbra is narrow (2-6 px).
- E2-E4 penumbra widens with level.
- The penumbra MUST be smooth enough that a 1 px sampling artefact is not visible.
- The penumbra MUST NOT be so wide that the shadow reads as a glow.

### 3.3 Shape

- The shadow follows the silhouette of the casting surface, including its corner radius.
- A shadow MUST NOT be a rectangle behind a rounded surface.
- A shadow MUST NOT be drawn inside the casting surface's own bounds, except for an inset
  shadow that is explicitly a different token (`TOK-DEPTH-SHADOW-INSET-*`).
- A shadow on a non-rectangular or cut-out display MUST be clipped to the visible region; it
  must not bleed into a bezel or a camera cut-out.

---

## 4. Colour

| Theme | Shadow hue | Opacity range | Notes |
|---|---|---|---|
| Light | Neutral, 2-6 degrees toward blue | 8-28% | Never pure black; a blue-grey shadow reads as air |
| Dark | Neutral, 2-6 degrees toward blue | 24-48% | Lower opacity than light, because the surrounding is already dark |
| High contrast | None | n/a | Outline substitute |
| Monochrome | Neutral | 10-30% | Tone and outline carry the level |
| Safety (EV, spaceship) | Neutral | 12-32% | Shadows must not reduce the contrast of a warning |

- **FOUND-DEPTH-090.** A shadow MUST NOT use a saturated colour. A coloured shadow is a
  second light source.
- **FOUND-DEPTH-091.** A shadow MUST NOT reduce the contrast of text or a critical indicator
  below the colour foundation's thresholds.
- **FOUND-DEPTH-092.** A shadow that falls across text MUST be treated as a background change
  and re-checked for contrast; it is not exempt because it is "only a shadow".

---

## 5. Motion of shadows

Shadows may change when a surface changes level. They may not animate for their own sake.

- When a surface rises from E1 to E2, the contact shadow tightens and the ambient shadow
  widens over the same spring as the surface's position change.
- When a surface falls, the reverse happens.
- A shadow MUST NOT lag behind its surface by more than one frame at 60 Hz.
- A shadow MUST NOT be animated while the surface is at rest.
- A shadow MUST NOT pulse, breathe or follow a cursor.

- **FOUND-DEPTH-100.** Shadow motion MUST be coupled to a real level transition. A shadow
  that animates without a level change is decorative motion and violates `LAW-008`.
- **FOUND-DEPTH-101.** A shadow MUST reach its final recipe in the same still as the surface
  reaches its final position. A late shadow makes the surface look like it is still moving.

---

## 6. Performance shape

Shadows are expensive when they are blurred every frame. The model requires them to be
**pre-rendered or cached**:

- E1-E4 shadows are nine-patch assets or SDF evaluations, not per-frame Gaussian blurs.
- A blurred backdrop is a material cost, not a shadow cost; it is budgeted separately in
  `06-materials.md`.
- A moving surface may translate a cached shadow; it may not re-blur it every frame.
- On a constrained envelope, the ambient layer may be dropped first; the contact layer stays.
- On a CPU-only path, the whole shadow may be replaced by a 1 px outline plus tonal
  separation.

The budget is in `13-performance.md`.

---

## 7. Failure

| Failure | What the person sees | Required behaviour |
|---|---|---|
| Shadow asset missing | A raised surface with no shadow | Apply the tonal/outline fallback; keep the level; log a non-fatal asset miss |
| Shadow renderer unsupported | All surfaces flat | Apply the high-contrast outline fallback to every raised surface; do not remove the level |
| Shadow clipped by a scissor bug | A hard edge through the shadow | The surface is still usable; the defect is visible; report it through the renderer's rejection channel |
| Shadow too dark on a dark theme | A grey halo | Reduce opacity and increase tonal separation; the token variant for dark must be used |
| Shadow crosses a safety indicator | The indicator loses contrast | The shadow is clipped away from the protected zone; the indicator wins |
| Shadow cache exhausted | New shadows appear late or not at all | Fall back to outline; do not allocate unbounded memory |

The first two are normal degraded states. The third and fifth are defects. The sixth is a
resource failure that must be bounded, not an invitation to drop frames.

---

## 8. What this model refuses

- A shadow under a flat surface.
- A shadow that is the same size as the surface with no offset.
- A shadow with a hard edge and no penumbra.
- A coloured glow called a shadow.
- A shadow that changes direction between components.
- A shadow that moves with the pointer.
- A shadow used to indicate focus.
- A shadow so strong that text on the surface fails contrast.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-030` | For each level E1-E4, the rendered surface has a contact layer, an ambient layer and a tonal separation; removing the shadow still leaves the level readable. |
| `AC-FOUND-DEPTH-031` | Switch to dark theme. Shadow opacity drops, tonal separation rises, and no text or indicator drops below its contrast threshold. |
| `AC-FOUND-DEPTH-032` | Animate a surface from E1 to E2. The shadow recipe and the surface position reach their final values in the same still. |
| `AC-FOUND-DEPTH-033` | Disable the shadow renderer. Every raised surface still has a visible level via outline or tone, and no error dialog appears. |
| `AC-FOUND-DEPTH-034` | A component with a shadow direction different from the reference is rejected. |
