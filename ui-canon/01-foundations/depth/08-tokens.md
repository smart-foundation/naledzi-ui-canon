---
id: FOUND-DEPTH-TOKENS-08
title: Depth Tokens
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-SPACE-01, FOUND-DEPTH-ELEV-02, FOUND-DEPTH-SHADOW-03, FOUND-DEPTH-PARALLAX-04, FOUND-DEPTH-OCCLUSION-05, FOUND-DEPTH-MATERIAL-06]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-200, AC-FOUND-DEPTH-201, AC-FOUND-DEPTH-202]
---

# Depth Tokens

> These are proposals. They are not minted in `03-framework/tokens/` and this file does not
> edit that directory. A value is legal only when the token owner adopts it and records the
> adoption in the shared token index.

---

## 1. Token contract

Every depth token obeys five rules:

1. **One meaning.** A token names one spatial fact, not a visual mood.
2. **One owner.** The shared token index owns the value. This file owns the proposal and the
   rule that makes it legal.
3. **One scale.** Values are expressed in CSS pixels at a reference density of 1 device pixel
   per CSS pixel, unless the token says otherwise.
4. **One fallback.** Every token that can be unavailable has a declared fallback in the same
   family.
5. **No aliases without a reason.** An alias must state why the second name exists. A second
   name for the same fact is a defect under `LAW-001`.

Token ID grammar: `TOK-DEPTH-<FAMILY>-<VARIANT>[-<STATE>]`.

---

## 2. Elevation scale

| Token | Proposal | Unit | Meaning | Fallback |
|---|---|---|---|---|
| `TOK-DEPTH-ELEV-0` | `0` | CSS px | Base plane | none |
| `TOK-DEPTH-ELEV-1` | `1` | CSS px | Raised unit belonging to the page | `0` plus outline |
| `TOK-DEPTH-ELEV-2` | `3` | CSS px | Anchored transient surface | `0` plus outline |
| `TOK-DEPTH-ELEV-3` | `8` | CSS px | Task-owning overlay | `0` plus scrim |
| `TOK-DEPTH-ELEV-4` | `16` | CSS px | System plane | `0` plus scrim and protected zone |

Rules:

- The elevation value is a **transform offset**, not a z-index. Z-order is derived from the
  semantic level, never from the number.
- The step ratios are approximately 1:3:8:16. A future density change may scale the set, but
  the order and the semantic meaning must not change.
- Elevation is not applied on the Z axis in a 2D compositor. It is expressed as a small
  2D translate plus shadow, tone and overlap. A compositor MAY use a real Z value internally
  if the result is identical to the declared still.
- On a spatial envelope, `TOK-DEPTH-ELEV-*` maps to a declared world distance in metres, not
  to CSS pixels. The mapping is in `10-envelopes.md`.

---

## 3. Shadow tokens

### 3.1 Light theme

| Token | Proposal | Use |
|---|---|---|
| `TOK-DEPTH-SHADOW-0` | `none` | E0 |
| `TOK-DEPTH-SHADOW-1-CONTACT` | `0 1px 2px rgba(10, 14, 20, 0.18)` | E1 contact |
| `TOK-DEPTH-SHADOW-1-AMBIENT` | `0 2px 6px rgba(10, 14, 20, 0.08)` | E1 ambient |
| `TOK-DEPTH-SHADOW-2-CONTACT` | `0 2px 4px rgba(10, 14, 20, 0.20)` | E2 contact |
| `TOK-DEPTH-SHADOW-2-AMBIENT` | `0 8px 20px rgba(10, 14, 20, 0.12)` | E2 ambient |
| `TOK-DEPTH-SHADOW-3-CONTACT` | `0 4px 8px rgba(10, 14, 20, 0.24)` | E3 contact |
| `TOK-DEPTH-SHADOW-3-AMBIENT` | `0 16px 40px rgba(10, 14, 20, 0.16)` | E3 ambient |
| `TOK-DEPTH-SHADOW-4-CONTACT` | `0 8px 16px rgba(10, 14, 20, 0.28)` | E4 contact |
| `TOK-DEPTH-SHADOW-4-AMBIENT` | `0 28px 64px rgba(10, 14, 20, 0.20)` | E4 ambient |

### 3.2 Dark theme

Dark shadows use a deeper neutral and higher opacity. The ambient layer is tighter than in
light theme so that it does not fog the plane.

| Token | Proposal |
|---|---|
| `TOK-DEPTH-SHADOW-1-CONTACT-DARK` | `0 1px 2px rgba(0, 0, 0, 0.24)` |
| `TOK-DEPTH-SHADOW-1-AMBIENT-DARK` | `0 2px 5px rgba(0, 0, 0, 0.18)` |
| `TOK-DEPTH-SHADOW-2-CONTACT-DARK` | `0 2px 4px rgba(0, 0, 0, 0.30)` |
| `TOK-DEPTH-SHADOW-2-AMBIENT-DARK` | `0 7px 18px rgba(0, 0, 0, 0.26)` |
| `TOK-DEPTH-SHADOW-3-CONTACT-DARK` | `0 4px 8px rgba(0, 0, 0, 0.36)` |
| `TOK-DEPTH-SHADOW-3-AMBIENT-DARK` | `0 14px 34px rgba(0, 0, 0, 0.32)` |
| `TOK-DEPTH-SHADOW-4-CONTACT-DARK` | `0 8px 16px rgba(0, 0, 0, 0.42)` |
| `TOK-DEPTH-SHADOW-4-AMBIENT-DARK` | `0 24px 56px rgba(0, 0, 0, 0.38)` |

### 3.3 High-contrast and monochrome

| Token | Proposal | Use |
|---|---|---|
| `TOK-DEPTH-SHADOW-FALLBACK` | `1px solid` role border | Replaces all shadows when high contrast is on |
| `TOK-DEPTH-SHADOW-FALLBACK-LEVEL-2` | `2px solid` role border | E2-E4 in high contrast |
| `TOK-DEPTH-SHADOW-INSET-1` | `inset 0 1px 0 rgba(255, 255, 255, 0.04)` | Optional top edge on dark E1 |
| `TOK-DEPTH-SHADOW-INSET-2` | `inset 0 1px 0 rgba(255, 255, 255, 0.06)` | Optional top edge on dark E2 |

High contrast does not use a translucent shadow at all. The outline must meet the non-text
contrast threshold in `color/04-contrast.md`.

### 3.4 Shadow ranges and tolerances

| Property | Range | Tolerance |
|---|---|---|
| Contact offset y | 1-8 px | plus or minus 1 px |
| Ambient offset y | 6-64 px | plus or minus 2 px |
| Contact blur | 2-16 px | plus or minus 1 px |
| Ambient blur | 6-64 px | plus or minus 4 px |
| Contact opacity | 0.18-0.42 | plus or minus 0.02 |
| Ambient opacity | 0.08-0.38 | plus or minus 0.02 |
| Offset x | 0 to 0.25 x offset y, viewer-left | fixed sign |

A renderer that cannot hit the tolerance must use the outline fallback rather than an
approximate shadow that breaks the light direction.

---

## 4. Scrim tokens

| Token | Light | Dark | Use |
|---|---|---|---|
| `TOK-DEPTH-SCRIM-0` | `0.00` | `0.00` | E0-E2 |
| `TOK-DEPTH-SCRIM-3` | `0.32` | `0.40` | E3 overlay |
| `TOK-DEPTH-SCRIM-4` | `0.48` | `0.56` | E4 system surface |
| `TOK-DEPTH-SCRIM-SAFETY` | `0.60` | `0.64` | Safety E4 |
| `TOK-DEPTH-SCRIM-COLOUR` | neutral 0 chroma, 6% toward the base hue | same | All scrims |

Rules:

- The scrim is a flat fill or a declared material. It is not a gradient by default.
- A gradient scrim MAY be used at an edge where content scrolls under a fixed bar. It must be
  declared as `TOK-DEPTH-SCRIM-EDGE-*` and must not cross a protected zone.
- Safety scrims are clipped around the protected zone. The operator sees no dimming of the
  critical indicator.
- Scrim opacity is measured against the surface behind it, not against white.

---

## 5. Parallax tokens

| Token | Proposal | Unit | Notes |
|---|---|---|---|
| `TOK-DEPTH-PARALLAX-MAX-2` | `4` | CSS px | E2 maximum displacement |
| `TOK-DEPTH-PARALLAX-MAX-3` | `6` | CSS px | E3 maximum displacement |
| `TOK-DEPTH-PARALLAX-SCALE-2` | `0.005` | ratio | Optional scale change |
| `TOK-DEPTH-PARALLAX-SCALE-3` | `0.0075` | ratio | Optional scale change |
| `TOK-DEPTH-PARALLAX-RATE-0` | `0.0` | ratio | Base and all text |
| `TOK-DEPTH-PARALLAX-RATE-2` | `0.4` | ratio | E2 |
| `TOK-DEPTH-PARALLAX-RATE-3` | `0.7` | ratio | E3 |
| `TOK-DEPTH-PARALLAX-SETTLE` | `120` | ms | Maximum time to rest |
| `TOK-DEPTH-PARALLAX-SENSOR-CUTOFF` | `1.5` | Hz | Low-pass filter for device motion |
| `TOK-DEPTH-PARALLAX-MAX-VIEWPORT` | `0.02` | ratio | No layer moves more than 2% of the viewport |

A rate above 0.7 is not a token. It is a design error.

---

## 6. Material tokens

| Token | Opacity | Blur | Edge | Legal levels |
|---|---|---|---|---|
| `TOK-DEPTH-MATERIAL-MATTE` | 1.00 | 0 | 1 px role border or none | E1-E4 |
| `TOK-DEPTH-MATERIAL-TRANSLUCENT-LIGHT` | 0.72 minimum | 0 or declared | 1 px role border | E2-E4 |
| `TOK-DEPTH-MATERIAL-TRANSLUCENT-DARK` | 0.78 minimum | 0 or declared | 1 px role border | E2-E4 |
| `TOK-DEPTH-MATERIAL-TRANSLUCENT-OPAQUE` | 1.00 | 0 | 1 px role border | E2-E4 fallback |
| `TOK-DEPTH-MATERIAL-EMISSIVE` | 1.00 | 0 | none | Indicators only |
| `TOK-DEPTH-MATERIAL-SAFETY` | 1.00 | 0 | 2 px safety border | E4 safety only |
| `TOK-DEPTH-MATERIAL-BLUR-DESKTOP` | n/a | 20 px maximum | n/a | E2-E4 |
| `TOK-DEPTH-MATERIAL-BLUR-PHONE` | n/a | 16 px maximum | n/a | E2-E4 |
| `TOK-DEPTH-MATERIAL-BLUR-SPATIAL` | n/a | 12 px maximum | n/a | E2-E4 |
| `TOK-DEPTH-MATERIAL-BLUR-REMOTE` | n/a | 12 px maximum | n/a | E2-E4 |

Emissive luminance proposals:

| Token | Light theme | Dark theme | Safety |
|---|---|---|---|
| `TOK-DEPTH-EMISSIVE-LUMINANCE-MAX` | 0.85 relative luminance | 0.65 | 0.95 |
| `TOK-DEPTH-EMISSIVE-LUMINANCE-MIN` | 0.25 | 0.15 | 0.35 |
| `TOK-DEPTH-EMISSIVE-FLASH-MAX` | 3 flashes per second, below 0.30 luminance change | same | same |

The flash limit follows the photosensitivity rule in `accessibility/04-vision.md`.

---

## 7. Focus dimming tokens

| Token | Proposal | Use |
|---|---|---|
| `TOK-DEPTH-DIM-TASK` | `0.10` | Non-active region in an active task |
| `TOK-DEPTH-DIM-MENU` | `0.15` | Invoking surface with an E2 menu open |
| `TOK-DEPTH-DIM-OVERLAY` | `TOK-DEPTH-SCRIM-3` | E3 |
| `TOK-DEPTH-DIM-SYSTEM` | `TOK-DEPTH-SCRIM-4` | E4 |
| `TOK-DEPTH-DIM-NEVER` | `0.00` | Focus ring, active text, critical indicators |

Dimming is applied to the composited layer, never by changing the token values of the surface.
A dimmed surface must not lose its own internal contrast.

---

## 8. Light tokens

| Token | Proposal | Notes |
|---|---|---|
| `TOK-DEPTH-LIGHT-KEY` | azimuth 20 degrees viewer-left, elevation 60 degrees | World-fixed; not mirrored |
| `TOK-DEPTH-LIGHT-AMBIENT` | 0.25 of key intensity, neutral | Prevents black shadows |
| `TOK-DEPTH-LIGHT-PENUMBRA` | 0.35 | Soft-edge ratio |
| `TOK-DEPTH-LIGHT-SHADOW-TINT` | 6% toward the cool base hue | Slightly cool neutral |

The key vector is not applied as a 3D transform in 2D envelopes. It is a constraint on the
shadow offset direction and the tonal edge.

---

## 9. Protected-zone tokens

| Token | Proposal | Use |
|---|---|---|
| `TOK-DEPTH-PROTECT-INSET` | `8` CSS px minimum | Gap between the protected zone and any app surface |
| `TOK-DEPTH-PROTECT-BORDER` | `2` CSS px safety border | Visible boundary in test builds |
| `TOK-DEPTH-PROTECT-SCRIM-CLIP` | `true` | The safety scrim is clipped around the zone |
| `TOK-DEPTH-PROTECT-ANIMATION` | `forbidden` | No transition may pass through the zone |

The protected zone's geometry is owned by the envelope, not by this token family. The tokens
declare the minimum gap and the rendering rules.

---

## 10. Token states and variants

Every visual depth token must declare all of the following variants where the variant is
meaningful:

| Variant | Required for | Behaviour |
|---|---|---|
| `default` | All | The base value |
| `dark` | Colour-bearing tokens | Deeper neutral, higher shadow opacity, higher tonal step |
| `high-contrast` | All shadows, scrims, borders | Outline substitute; scrim solid and stronger |
| `reduced-transparency` | Translucent materials | Opaque fallback |
| `reduced-motion` | Parallax | Disabled |
| `monochrome` | Shadows and scrims | Tone and outline; no hue |
| `safety` | Scrims, materials, protected zones | Theme-independent, glare-resistant |
| `remote` | Blur, parallax, shadows | Reduced or disabled by capability |

A missing variant is not a default. The token is incomplete, and a component that consumes it
must fall back to the outline or opaque variant.

---

## 11. Measurement

| Quantity | Instrument | Reference envelope | Pass condition |
|---|---|---|---|
| Elevation order | Still inspection plus five-person ranking | Desktop, watch, EV | Declared order in every reference |
| Shadow direction | Offset sign and ratio | Desktop | One sign and one ratio |
| Shadow cost | GPU timestamp or CPU trace | Watch and remote browser | Within `13-performance.md` |
| Scrim opacity | Pixel sample of the composited still | Desktop and phone | Within plus or minus 0.02 |
| Parallax displacement | Input-to-pixel measurement | Desktop and phone | At or below the token maximum |
| Parallax settle | High-speed capture at 240 Hz | Phone | At or below 120 ms |
| Material opacity | Pixel sample over a known backdrop | Desktop and phone | At or above the minimum |
| Protected-zone intersection | Geometry check on every still | EV and spaceship | Zero intersections |

---

## 12. Deprecation

- A depth token is deprecated only by a new token with a new meaning, never by silently
  changing the value of the old one.
- The old token remains valid for one major corpus version, with a deprecation note in
  `18-changelog.md`.
- A component that uses a deprecated token must be listed in the migration note.
- A value change that alters the still is a breaking change and requires an ADR.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-200` | Every depth value used by the four reference surfaces resolves to a token in this file; no literal shadow, scrim, parallax or blur value appears in a component spec. |
| `AC-FOUND-DEPTH-201` | Every token that has a dark, high-contrast, reduced-transparency or reduced-motion variant declares it; a script that enumerates required variants finds zero missing. |
| `AC-FOUND-DEPTH-202` | Sample the composited stills: shadow offsets share one direction and ratio, scrim opacity is within tolerance, and no parallax exceeds its maximum. |
