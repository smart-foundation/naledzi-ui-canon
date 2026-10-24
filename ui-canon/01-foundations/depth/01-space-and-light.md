---
id: FOUND-DEPTH-SPACE-01
title: Space and Light
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-INDEX, LAW-007, ADR-0004]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-010, AC-FOUND-DEPTH-011, AC-FOUND-DEPTH-012]
---

# Space and Light

> One space, one light, one set of consequences. A second light model is a second truth.

---

## 1. The space

The interface is a **shallow stage**, not a room and not a 3D world. Its depth range is the
range in which a person can point at something without moving their head. That is roughly
personal and action space, not vista space.

The model has three planes:

| Plane | What it contains | Depth behaviour |
|---|---|---|
| **World plane** | The content the person is working on: document, canvas, map, media, list | Scrolls or pans; may be larger than the viewport; is always E0 unless a region is explicitly raised |
| **View plane** | The app frame, navigation, controls, panels | Sits at a fixed distance from the person; may contain E1-E3 layers |
| **System plane** | Alerts, permission prompts, safety warnings, critical indicators | Always nearest; cannot be pushed back by app content |

The world plane can move under the view plane. The view plane can raise a floating element.
The system plane never participates in app composition. These are the only three spatial
relationships an app may assume.

- **FOUND-DEPTH-010.** An app MUST NOT invent a fourth spatial plane. Panels, sheets,
  sidebars and inspectors are compositions of E0-E3 inside the view plane.
- **FOUND-DEPTH-011.** The system plane MUST be outside app layout. An app cannot reserve,
  cover or reorder it.
- **FOUND-DEPTH-012.** Scroll and pan MUST move content in the world plane without changing
  the elevation of the view plane.

---

## 2. Why the stage is shallow

A deep stage invites effects that are expensive and ambiguous: objects flying toward the
viewer, strong perspective, large parallax, depth-of-field. None of them improves hierarchy
for a text-and-control interface, and all of them fail on a watch, a car in sunlight or a
remote browser.

The model therefore uses **orthographic composition with small cues**:

- overlap and occlusion do the ordering;
- a small vertical offset and shadow do the raising;
- a scrim does the modal separation;
- contrast and scale reinforce the level;
- parallax is bounded to a few pixels and is optional.

No perspective projection is applied to ordinary UI. A spatial envelope may use real
stereoscopic depth, but it must obey the comfort rules in `10-envelopes.md` and
`accessibility/08-vestibular.md`.

---

## 3. The light model

One key light. One ambient term. Fixed in world space.

| Property | Value | Reason |
|---|---|---|
| Key direction | From above, 20 degrees toward the viewer's left, 60 degrees from the surface | Produces a contact shadow that reads as "resting on" rather than "floating in a void" |
| Key softness | Soft, with a visible penumbra | Penumbra strengthens the depth percept (Mamassian et al., 1998) |
| Ambient direction | Uniform from above | Prevents pure-black shadows and keeps dark-theme edges readable |
| Shadow colour | Neutral, slightly cool, never pure black | Pure black reads as a hole, not a shadow |
| Number of lights | One | A second light produces a second shadow direction and a second truth |
| Mirroring | Never mirrored for RTL | Light is physical; mirroring it makes every shadow disagree with every other shadow in a mixed-direction layout |

- **FOUND-DEPTH-020.** Every shadow in one output MUST share the same key direction. A
  component MUST NOT flip the light to suit its local composition.
- **FOUND-DEPTH-021.** RTL MUST NOT mirror the light direction. It mirrors reading order,
  alignment and directional glyphs, not physics.
- **FOUND-DEPTH-022.** A material MAY change shadow opacity and softness. It MUST NOT change
  the key direction.
- **FOUND-DEPTH-023.** In a stereoscopic or world-locked envelope, the light may be anchored
  to the environment instead of the viewer. The anchor MUST be declared once and remain
  stable while the person moves.

The key direction is a token: `TOK-DEPTH-LIGHT-KEY`. The ambient term is
`TOK-DEPTH-LIGHT-AMBIENT`. Their values are proposed in `08-tokens.md`.

---

## 4. Tonal separation

Shadow is not the only way light separates surfaces. A raised surface also differs from its
parent in **tone**:

| Level | Light theme | Dark theme | High contrast |
|---|---|---|---|
| E1 | +2% lightness over base | +3% lightness over base | 1 px outline |
| E2 | +4% | +5% | 2 px outline |
| E3 | +6% | +7% | 2 px outline plus scrim |
| E4 | +8% | +9% | 2 px outline plus scrim |

The exact values are proposals in `08-tokens.md`; the rule is that tonal separation MUST be
present and MUST be measurable. It is the fallback when shadow is removed, unsupported or
suppressed by high contrast.

- **FOUND-DEPTH-030.** Every raised surface MUST have a tonal separation from its parent of at
  least the value declared for its level, or a declared outline where tonal separation would
  break contrast.
- **FOUND-DEPTH-031.** Tonal separation MUST NOT be the only cue. It is one of the four cues
  in `FOUND-DEPTH-002`.
- **FOUND-DEPTH-032.** A surface MUST NOT use a lighter tone to fake elevation without also
  declaring the elevation. Tone is a consequence, not a licence.

---

## 5. Perspective and scale

Ordinary UI does not use perspective. Two exceptions are allowed and both are declared:

1. **Spatial envelope.** World-locked content may use real perspective because the display is
   stereoscopic and the person's head provides the viewpoint. Comfort limits apply.
2. **A declared preview.** A 3D object viewer, map tilt or media canvas may use perspective
   inside its own content region. The chrome around it remains orthographic. The preview MUST
   have a flat fallback.

- **FOUND-DEPTH-040.** A 2D envelope MUST NOT apply perspective transforms to interface
  chrome. A card that tilts toward the pointer is decorative depth and is forbidden.
- **FOUND-DEPTH-041.** A content preview that uses perspective MUST provide a flat, north-up
  or front-on view at the same information content.
- **FOUND-DEPTH-042.** Scale change MUST NOT be used as the only signal of elevation. A
  smaller card is not automatically farther away.

---

## 6. Light and failure

The model can fail in four ways:

| Failure | Visible result | Required response |
|---|---|---|
| Shadow renderer unavailable | Flat surfaces, hierarchy ambiguous | Apply tonal separation and outlines from the token fallback; do not silently drop the level |
| Blur or translucency unavailable | Material falls back to opaque | Use the opaque material variant with the same role; keep the level |
| Light direction flipped by a component | Two shadow directions in one output | Reject the commit in review; the component is non-conformant |
| Output with no colour (e-ink, monochrome, braille) | Tone and shadow collapse | Use outline, position and overlap; announce level semantically where it matters |

The first two are normal degraded states, not errors. They must be drawn without a spinner
and without an apology. The third is a defect. The fourth is a first-class output mode.

---

## 7. What this model refuses

- A second light for "highlighting" a card.
- A shadow with no surface above the receiver.
- A floating element with no interaction meaning.
- A blur that makes text unreadable in order to look premium.
- A perspective tilt that follows the pointer.
- A dark theme that removes all shadows and relies on glow.
- A light theme that uses pure black shadows.
- An elevation that changes with scroll position.

Each refusal is a test case in `07-acceptance.md`.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-010` | In a reference screen with three nested surfaces, exactly one light direction is observable and every shadow agrees with it. |
| `AC-FOUND-DEPTH-011` | Switch the interface to RTL. Shadow directions are unchanged; reading order, alignment and directional glyphs are mirrored. |
| `AC-FOUND-DEPTH-012` | Disable the shadow renderer. Every level remains distinguishable by tone, outline, position or overlap, and the screen reports no error. |
| `AC-FOUND-DEPTH-013` | A component that applies a pointer-following tilt to a card is rejected by the conformance check. |
