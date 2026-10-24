---
id: FOUND-COLOR-CONTRAST
title: Contrast
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, FOUND-COLOR-INDEX, FOUND-COLOR-ROLES]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-002, AC-FOUND-COLOR-016]
---

# Contrast

> Contrast is not a preference. It is a measurement. A colour pair either meets the
> floor or it does not. There is no "close enough."

---

## 1. The standards

Naledzi follows **WCAG 2.2** (W3C, October 2023) for contrast requirements, with the
following additions:

| Level | Standard | Requirement | Naledzi policy |
|---|---|---|---|
| AA | WCAG 2.2 §1.4.3 | 4.5:1 for normal text, 3:1 for large text (≥18pt or ≥14pt bold) | **Mandatory** for all text |
| AA | WCAG 2.2 §1.4.11 | 3:1 for non-text UI components and graphical objects | **Mandatory** for all interactive elements |
| AAA | WCAG 2.2 §1.4.6 | 7:1 for normal text, 4.5:1 for large text | **Target** for body text in comfortable/spacious density |
| AAA | WCAG 2.2 §1.4.13 | Content on hover/focus is dismissible, hoverable, persistent | **Mandatory** for all tooltips and popovers |

---

## 2. What counts as text

| Element | Contrast requirement | Notes |
|---|---|---|
| Body text | 4.5:1 (AA), 7:1 (AAA target) | Against its surface role |
| Large text (≥18pt or ≥14pt bold) | 3:1 (AA), 4.5:1 (AAA target) | Against its surface role |
| Placeholder text | 4.5:1 | Placeholders are text; they must be readable |
| Disabled text | 3:1 minimum | Disabled is de-emphasised but still legible |
| Icon (meaningful) | 3:1 | Against its surface role |
| Icon (decorative) | No requirement | Decorative icons are not interactive |
| Focus ring | 3:1 | Against adjacent colours |
| Border (input field) | 3:1 | Against its surface |
| Link text | 4.5:1 | Plus a non-colour indicator (underline or icon) |
| Error text | 4.5:1 | Plus a non-colour indicator (icon or position) |

---

## 3. Contrast measurement

Contrast is measured as the **relative luminance ratio** between two colours, computed
in the sRGB colour space per WCAG 2.1 §1.4.3. The formula:

```
contrast = (L1 + 0.05) / (L2 + 0.05)
```

where L1 is the relative luminance of the lighter colour and L2 is the relative
luminance of the darker colour.

Relative luminance is computed from the sRGB RGB values:

```
L = 0.2126 * R + 0.7152 * G + 0.0722 * B
```

where R, G, B are the linearised (gamma-decoded) channel values.

**Important:** contrast is measured in sRGB, not in OKLCH. OKLCH is for design; sRGB
is for measurement. A colour that is perceptually even in OKLCH may still fail contrast
in sRGB if the theme values are wrong.

---

## 4. Per-role contrast constraints

Every role declares its contrast requirement against the surfaces it appears on:

| Role | Against | Minimum | Target |
|---|---|---|---|
| `content-primary` | `surface-base`, `surface-raised`, `surface-floating`, `surface-overlay` | 4.5:1 | 7:1 |
| `content-secondary` | same | 4.5:1 | 4.5:1 |
| `content-tertiary` | same | 3:1 | 4.5:1 |
| `content-inverse` | filled surface (accent, danger, etc.) | 4.5:1 | 4.5:1 |
| `content-disabled` | `surface-disabled` | 3:1 | 3:1 |
| `accent` | `surface-base` | 3:1 (as UI component) | 4.5:1 (as text) |
| `success` | `surface-base` | 3:1 | 4.5:1 |
| `warning` | `surface-base` | 3:1 | 4.5:1 |
| `danger` | `surface-base` | 3:1 | 4.5:1 |
| `info` | `surface-base` | 3:1 | 4.5:1 |
| `border-subtle` | adjacent surface | 1.5:1 | 3:1 |
| `border-strong` | adjacent surface | 3:1 | 3:1 |
| `border-focus` | adjacent surface | 3:1 | 3:1 |
| `divider` | adjacent surface | 1.5:1 | 3:1 |
| `scrim` | `surface-base` (behind) | 3:1 (scrim must not make text unreadable) | — |

A theme that sets a role value that fails its constraint is **invalid**. The theme
cannot be applied.

---

## 5. High contrast

High-contrast mode is not "more contrast." It is a different theme that:

- Uses pure black and pure white (or the envelope's declared extreme values) for
  text and backgrounds.
- Removes subtle borders, shadows, and gradients that reduce contrast.
- Increases focus ring thickness and contrast.
- Uses colour only for semantic meaning (success/warning/danger), never for decoration.
- Preserves the role system: every role still exists, but its value is pushed to an
  extreme.

High-contrast mode is **mandatory** on every envelope. It is not an afterthought.

---

## 6. Contrast and envelopes

| Envelope | Additional contrast requirements |
|---|---|
| Watch | Minimum 4.5:1 for all text at 40 mm viewing distance; high contrast is the default in direct sunlight |
| Phone | Standard WCAG AA; high contrast available; outdoor readability mode (increased contrast + reduced transparency) |
| Tablet | Standard WCAG AA |
| Desktop | Standard WCAG AA; high contrast available |
| TV | Minimum 4.5:1 for all text at 3 m viewing distance; high contrast available |
| EV | Minimum 4.5:1 at 70 cm viewing distance; glare-resistant (no pure white on black in direct sunlight); high contrast is the default in motion |
| Spaceship | Minimum 4.5:1 under all lighting conditions; redundancy (colour + shape + position); high contrast available |
| IoT | Minimum 4.5:1 for any displayed text |
| Spatial | Minimum 4.5:1; comfort (no high-contrast extremes that cause visual fatigue in VR) |
| Remote browser | Standard WCAG AA; inherits the host display's capabilities |

---

## 7. The contrast test

1. **Automated audit.** Every text/background pair is measured programmatically.
   Failures are reported with the measured ratio and the required ratio.
2. **Manual review.** Automated tools miss context (e.g., text on a gradient, text on
   an image). A manual review covers every screen in the reference set.
3. **High-contrast verification.** Every screen is rendered in high-contrast mode and
   visually inspected.
4. **Envelope verification.** Every screen is verified at the envelope's viewing
   distance and lighting conditions.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-016` | All text meets WCAG 2.2 AA contrast in light, dark, and high-contrast. |
| `AC-FOUND-COLOR-017` | All non-text UI components meet 3:1 contrast. |
| `AC-FOUND-COLOR-018` | No colour is the only carrier of meaning. |
| `AC-FOUND-COLOR-019` | High-contrast mode resolves every role to a valid value. |
| `AC-FOUND-COLOR-020` | Contrast is verified at each envelope's viewing distance. |
