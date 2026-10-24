---
id: FOUND-COLOR-LIGHTDARK
title: Light and Dark
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, FOUND-COLOR-INDEX, FOUND-COLOR-MODEL, FOUND-COLOR-ROLES]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-021, AC-FOUND-COLOR-022]
---

# Light and Dark

> Light and dark are not inversions. They are different colour worlds with different
> elevation logic, different contrast behaviour, and different emotional weight. Dark
> mode is not "light mode with the colours flipped." It is a separate design that
> shares the same roles.

---

## 1. The principle

A theme is a complete set of role values. Light mode and dark mode are two themes that
share the same role names but use different values. The component declares a role; the
theme resolves it. The component never knows which theme is active.

This means:

- **No `if (darkMode)` in components.** The component says `surface-base`; the theme
  says what `surface-base` is.
- **No colour inversion.** Inverting every colour produces a broken interface: shadows
  become highlights, elevation disappears, and contrast inverts unpredictably.
- **Elevation logic changes.** In light mode, raised surfaces are lighter (closer to
  the light source). In dark mode, raised surfaces are also lighter (closer to the
  viewer in a dark room). The direction is the same; the values differ.

---

## 2. How light and dark differ

| Property | Light mode | Dark mode |
|---|---|---|
| `surface-base` | Near-white (L ≈ 0.97) | Near-black (L ≈ 0.12) |
| `surface-raised` | Slightly lighter than base (+0.02 L) | Slightly lighter than base (+0.04 L) |
| `surface-floating` | Lighter still (+0.04 L) | Lighter still (+0.06 L) |
| `surface-overlay` | Lighter still (+0.06 L) | Lighter still (+0.08 L) |
| `content-primary` | Near-black (L ≈ 0.15) | Near-white (L ≈ 0.92) |
| `content-secondary` | Dark grey (L ≈ 0.40) | Light grey (L ≈ 0.70) |
| `content-tertiary` | Medium grey (L ≈ 0.55) | Medium grey (L ≈ 0.55) |
| `accent` | Saturated, mid-lightness | Saturated, slightly lighter |
| `shadow` | Dark, low opacity | Dark, higher opacity (shadows are more visible on dark backgrounds) |
| `scrim` | Dark, 32-60% opacity | Dark, 48-72% opacity (stronger scrim needed on dark backgrounds) |

The key insight: in both modes, raised surfaces are **lighter** than their base. This
preserves the elevation model (closer = lighter) in both lighting conditions. The
difference is the absolute lightness values, not the direction.

---

## 3. Dark mode is not a theme toggle

Dark mode is not "the user's preference." It is a response to the environment:

- **Low-light environments.** Dark mode reduces screen luminance, reducing eye strain
  and light pollution.
- **OLED displays.** Dark mode saves power on OLED (black pixels are off).
- **Night use.** Dark mode reduces melatonin suppression (though the effect is modest
  compared to brightness reduction).
- **User preference.** Some users simply prefer dark interfaces.

The OS provides both modes. The user chooses, or the system follows the ambient light
sensor (if available and consented). The choice is stored per-user, per-device.

---

## 4. High contrast

High-contrast mode is a third theme, not a variant of light or dark. It uses extreme
values:

| Property | High-contrast value |
|---|---|
| `surface-base` | Pure white (light) or pure black (dark) |
| `content-primary` | Pure black (light) or pure white (dark) |
| `accent` | High-saturation, high-contrast colour |
| `border-strong` | 3:1 minimum against surface |
| `shadow` | None (shadows reduce contrast) |
| `scrim` | None (scrim reduces contrast) |
| `surface-raised` | Same as `surface-base` (no elevation tint) |

High-contrast mode removes elevation tints, shadows, and translucency. Hierarchy is
carried by position, size, and contrast alone. This is `FOUND-DEPTH-002`: elevation
must be carried by more than shadow.

---

## 5. Reduced transparency

Reduced transparency (also called "reduce transparency" or "solid backgrounds") is a
separate setting that:

- Replaces translucent materials (sheets, sidebars, popovers) with opaque surfaces.
- Removes blur effects.
- Increases the opacity of scrims.
- Does not change the colour theme (light/dark/high-contrast remains).

This is important for users with vestibular disorders, motion sickness, or cognitive
load concerns. Translucency can make it hard to track what is in front of what.

Reduced transparency is **mandatory** on every envelope. It is not an afterthought.

---

## 6. The theme contract

A theme is a complete set of role values. It must:

1. **Define every role.** No role may be missing. A missing role means the component
   that uses it cannot render.
2. **Meet contrast constraints.** Every role value must satisfy the contrast
   requirements in `04-contrast.md`. A theme that fails is invalid.
3. **Declare its gamut.** sRGB, P3, or Rec. 2020.
4. **Declare its mode.** Light, dark, or high-contrast.
5. **Be swappable at runtime.** The user can change the theme without restarting the
   app. Components re-resolve their roles.
6. **Be composable.** A user can mix a light base with a high-contrast overlay, or a
   dark base with a reduced-transparency overlay. The system merges the themes by
   role, with the more specific theme winning.

---

## 7. The light/dark test

1. **Theme swap.** Switch from light to dark mid-task. Does every surface, text, icon,
   and control remain readable and correctly elevated? If not, a component has
   hardcoded a colour.
2. **High-contrast swap.** Switch to high contrast. Does every element remain visible
   and meet the contrast floor? If not, a role is missing or a value is wrong.
3. **Reduced transparency.** Enable reduced transparency. Do all translucent surfaces
   become opaque without losing content? If not, a surface depends on translucency
   for its layout.
4. **Automated audit.** Every role value in every theme is checked against the contrast
   constraints. Failures are reported.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-021` | Light, dark, and high-contrast themes all resolve every role to a valid value. |
| `AC-FOUND-COLOR-022` | Theme swap at runtime does not break any component's readability or elevation. |
| `AC-FOUND-COLOR-023` | High-contrast mode removes elevation tints, shadows, and translucency. |
| `AC-FOUND-COLOR-024` | Reduced transparency makes all translucent surfaces opaque without content loss. |
| `AC-FOUND-COLOR-025` | No component contains a `darkMode` conditional; all colour is via roles. |
