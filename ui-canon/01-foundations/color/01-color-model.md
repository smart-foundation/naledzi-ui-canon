---
id: FOUND-COLOR-MODEL
title: The Colour Model
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, FOUND-COLOR-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-004, AC-FOUND-COLOR-006]
---

# The Colour Model

> The colour space is a decision, not a default. A colour ramp built in sRGB looks uneven
> because sRGB is not perceptually uniform. The model must use a space where equal steps
> look equal, where lightness is independent of hue, and where wide-gamut displays are
> served without breaking narrow-gamut ones.

---

## 1. The problem with sRGB

sRGB is a display-referred encoding. Its transfer function (gamma ~2.2) was designed to
match CRT phosphor response, not human perception. Consequences for design:

- **Uneven ramps.** A 10-step grey ramp in sRGB has visible banding in the darks and
  compression in the lights. The steps are not perceptually equal.
- **Hue-dependent lightness.** Yellow in sRGB is much lighter than blue at the same
  numeric value. A "uniform" ramp shifts lightness as hue changes.
- **Gamut mismatch.** sRGB covers ~35% of the visible spectrum. Modern displays
  (P3, Rec. 2020) can show more. Designing in sRGB and mapping to P3 either clips
  colours or wastes the display's capability.

sRGB remains the interchange format (web, images, screenshots) but is not the design
space.

---

## 2. The chosen model: OKLab / OKLCH

Naledzi uses **OKLab** (Björn Ottosson, 2020) as its perceptual working space, with
**OKLCH** (polar form) for design-time manipulation.

Properties that matter:

| Property | Why it matters |
|---|---|
| **Perceptual uniformity** | Equal steps in L (lightness) look equal across hues. Ramps are even. |
| **Hue independence** | Changing hue does not change lightness. A "blue at L=0.5" and "yellow at L=0.5" have the same perceived brightness. |
| **Chroma independence** | Saturation (C) can be adjusted without shifting lightness. |
| **Wide gamut** | OKLab can represent any colour in any gamut; gamut mapping is a separate, explicit step. |
| **Monotonic** | Lightness increases monotonically. Darkening a colour always makes it darker. |

OKLCH polar form (L, C, H) is used for design-time work: "lighter by 0.1, more saturated
by 0.05, rotated 30°." OKLab Cartesian form (L, a, b) is used for computation:
interpolation, blending, gamut mapping.

---

## 3. The colour pipeline

```text
Design-time (OKLCH)  →  Computation (OKLab)  →  Gamut mapping  →  Encoding (sRGB/P3/Rec.2020)
```

1. **Design.** A token is specified in OKLCH: `L=0.65, C=0.15, H=250`. This is the
   canonical value.
2. **Compute.** Interpolations, blends, and elevation tints are computed in OKLab.
3. **Gamut map.** If the colour falls outside the target display's gamut, it is mapped
   to the nearest in-gamut colour by reducing chroma (not lightness). Lightness is
   preserved; only saturation suffers.
4. **Encode.** The final value is encoded in the display's native colour space (sRGB
   for standard displays, Display P3 for wide-gamut, Rec. 2020 for HDR).

The pipeline ensures that a token looks the same (within gamut limits) on every display,
and that no colour is silently clipped.

---

## 4. Gamut mapping rules

- **Preserve lightness.** A colour that is out of gamut is mapped by reducing chroma
  until it fits. Lightness never changes. A "dark blue" stays dark; it just becomes
  less saturated.
- **Preserve hue.** Hue is preserved as long as possible. Only when chroma reduction
  alone cannot fit the gamut does hue shift slightly, and then only toward the nearest
  in-gamut hue.
- **Never clip.** Silent clipping (truncating an RGB channel) produces hue shifts and
  banding. Gamut mapping is always explicit and always chroma-reducing.
- **Declare the gamut.** Every theme declares its target gamut (sRGB, P3, or Rec. 2020).
  A theme that targets P3 on an sRGB display degrades gracefully: colours are gamut-
  mapped to sRGB, and the result is recorded as a degraded state.

---

## 5. The achromatic case

Grey is not "no colour." Grey is a colour with zero chroma. In OKLCH, grey is
`C=0, H=undefined`. The lightness scale from black (L=0) to white (L=1) is the
foundation of every elevation tint, every disabled state, and every scrim.

Rules:

- **Grey ramps are perceptually even.** A 10-step grey ramp in OKLCH has equal
  perceptual steps. No banding, no compression.
- **Elevation tints use lightness, not grey.** A raised surface is slightly lighter
  than its base in light mode and slightly lighter in dark mode (see
  `03-light-and-dark.md`). The tint is an OKLCH lightness shift, not a grey overlay.
- **Disabled states use reduced chroma and reduced lightness contrast.** A disabled
  control is not greyed out; it is desaturated and low-contrast, following the role
  system.

---

## 6. Colour and elevation

Depth uses lightness to communicate elevation (see `01-foundations/depth/02-elevation.md`).
In light mode, raised surfaces are slightly lighter than the base. In dark mode, raised
surfaces are slightly lighter than the base (they do not get darker). This is because
in a dark environment, a lighter surface reads as "closer" (the light source is above
and in front).

The colour model supports this by providing a lightness-shift token per elevation level:

| Elevation | Light mode lightness shift | Dark mode lightness shift |
|---|---|---|
| E0 base | 0 | 0 |
| E1 raised | +0.02 | +0.04 |
| E2 floating | +0.04 | +0.06 |
| E3 overlay | +0.06 | +0.08 |
| E4 system | +0.08 | +0.10 |

These shifts are applied in OKLCH and are perceptually even. They are defined in
`01-foundations/depth/08-tokens.md` and minted in `03-framework/tokens/`.

---

## 7. The colour test

1. **Ramp test.** A 10-step ramp from black to white in the chosen colour space must
   show no visible banding. Verified by a visual inspection and a ΔE2000 step-size
   analysis (each step within ±2 of the mean).
2. **Hue test.** A ramp from blue to yellow at constant lightness must look equally
   bright throughout. No "yellow is lighter" effect.
3. **Gamut test.** Every token value must be representable in sRGB without clipping.
   Wide-gamut values are recorded as degraded on sRGB displays.
4. **Contrast test.** Every text/background pair must meet the contrast floor
   (see `04-contrast.md`).

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-006` | Colour ramps are perceptually even in OKLCH; ΔE2000 step sizes within ±2 of the mean. |
| `AC-FOUND-COLOR-007` | Hue ramps at constant lightness show no lightness shift. |
| `AC-FOUND-COLOR-008` | All token values are representable in sRGB without clipping; wide-gamut values are declared. |
| `AC-FOUND-COLOR-009` | Gamut mapping preserves lightness; chroma reduction is explicit and never silent. |
| `AC-FOUND-COLOR-010` | Elevation tints are applied in OKLCH and are perceptually even. |
