---
id: FOUND-COLOR-INDEX
title: Color
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, CANON-DECISIONS, FOUND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-000]
children:
  - 01-color-model.md
  - 02-roles.md
  - 03-light-and-dark.md
  - 04-contrast.md
  - 05-color-vision.md
  - 06-data-and-charts.md
  - 07-tokens.md
  - 08-envelopes.md
  - 09-assistive.md
  - 10-performance.md
  - 11-failure.md
  - 12-timelessness.md
  - 13-references.md
  - 14-open-questions.md
  - 15-changelog.md
  - acceptance.md
---

# Color

> Colour is a semantic role, not a paint. Every colour in the system is a token with a
> meaning: surface, content, accent, success, warning, danger, focus, disabled, overlay.
> A colour that carries no meaning is decoration. A meaning that has no colour is
> invisible to colour-dependent users. Both are defects.

**Scope:** the colour model, the role system, light and dark modes, contrast, colour vision
deficiency, data visualisation palettes, tokens, per-envelope behaviour, assistive paths,
performance, failure, timelessness, and evidence.

**Non-goals:** component anatomy (belongs to `03-framework/`), shell layout (belongs to
`04-shell/`), app flows (belongs to `05-apps/`), glassmorphism (rejected by ADR-0004),
and per-component colour overrides (a component declares a role, the theme supplies the
value).

---

## 1. The human constant

Human colour perception is not a uniform sampling of wavelength. The eye's three cone
types (S, M, L) have overlapping sensitivity curves, and the brain's processing is
non-linear in both luminance and chrominance. Two consequences follow, and both shape
this foundation:

1. **Equal steps in RGB are not equal steps in perception.** A colour ramp built in
   sRGB looks uneven: the mid-tones cluster, the darks compress, the lights blow out.
   A perceptually uniform space (OKLab/OKLCH) is required for any ramp, gradient or
   elevation tint to look even.

2. **Colour vision deficiency affects roughly 8% of males and 0.5% of females.** The
   most common form (deuteranopia/protanopia) confuses red and green. A design that
   relies on red-vs-green alone excludes roughly one in twelve men. Colour must never be
   the only carrier of meaning (`LAW-009`, `FOUND-COLOR-050`).

These are not accessibility edge cases. They are the normal distribution of human vision.

---

## 2. The model in one page

```text
E4  system       safety warnings, critical indicators
     ^            high contrast, never colour alone
     |
E3  overlay      dialogs, sheets, palette
     ^            scrim 32%, focus trapped
     |
E2  floating     popovers, drag previews
     ^            shadow + offset, no scrim
     |
E1  raised       cards, list rows, panels
     ^            contact shadow + tonal separation
     |
E0  base         page plane, canvas, document
                  receives shadows; no shadow of its own
```

Every surface declares a role from the colour role table (`02-roles.md`). The theme
supplies the value for that role in the current light/dark/high-contrast mode. The
component never names a colour; it names a role.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-color-model.md](01-color-model.md) | What colour space, and why? |
| [02-roles.md](02-roles.md) | What are the semantic colour roles? |
| [03-light-and-dark.md](03-light-and-dark.md) | How do light and dark differ, and what is high contrast? |
| [04-contrast.md](04-contrast.md) | What are the contrast requirements? |
| [05-color-vision.md](05-color-vision.md) | How does the model serve colour-vision-deficient users? |
| [06-data-and-charts.md](06-data-and-charts.md) | What palettes are safe for data visualisation? |
| [07-tokens.md](07-tokens.md) | Which `TOK-COLOR-*` values are proposed? |
| [08-envelopes.md](08-envelopes.md) | How does colour behave per envelope? |
| [09-assistive.md](09-assistive.md) | What does a non-visual path receive instead of colour? |
| [10-performance.md](10-performance.md) | What does colour cost, and how does it degrade? |
| [11-failure.md](11-failure.md) | What happens when a colour cannot be produced? |
| [12-timelessness.md](12-timelessness.md) | Why does this survive display and decade change? |
| [13-references.md](13-references.md) | What is the evidence, with limits? |
| [14-open-questions.md](14-open-questions.md) | What is unresolved, owned, and due? |
| [15-changelog.md](15-changelog.md) | What changed? |
| [acceptance.md](acceptance.md) | How is the whole foundation proved? |

---

## 4. Dependency and ownership

| Fact | Owner | Consumers |
|---|---|---|
| Colour space and perceptual model | This foundation | Every ramp, gradient, elevation tint |
| Colour role definitions | This foundation | Components, shell, apps, themes |
| Contrast ratios | This foundation + WCAG 2.2 | Every component, every envelope |
| Colour values per theme | `03-framework/tokens/` (minted from this foundation) | Renderer, components |
| Colour-vision safety | This foundation | Data visualisation, status indicators, alerts |
| High-contrast overrides | This foundation + envelope constraints | Themes, accessibility settings |

The colour foundation does not own theme values. It owns the meaning of a role and the
constraints a value must satisfy. The theme supplies the value.

---

## 5. What is intentionally absent

| Item | Reason |
|---|---|
| A colour picker | `n/a — a colour picker is an app; this foundation defines roles, not tools.` |
| Per-component colour overrides | `n/a — a component declares a role; the theme supplies the value.` |
| RGB/hex literals in prose | `n/a — values live in `07-tokens.md` and are referenced by ID.` |
| Colour as the only carrier of meaning | `n/a — forbidden by `FOUND-COLOR-050` and `LAW-009`.` |
| A "brand colour" that overrides roles | `n/a — brand identity is expressed through the accent role, not by bypassing the role system.` |

---

## 6. The colour test

Every colour decision is tested three ways:

1. **Remove the colour.** Is the meaning still conveyed by shape, text, position, or
   pattern? If not, colour is the only carrier and the design fails for colour-vision-
   deficient users.
2. **Remove the shadow and depth.** Is the hierarchy still readable from contrast and
   position? If not, the design depends on a single cue.
3. **Apply a high-contrast theme.** Does every text, icon, and control meet the
   contrast floor? If not, the role values are wrong.

A design that fails any test is not finished.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-000` | Every file listed in `children` exists; every file in the directory is listed; no `TODO` or empty section. |
| `AC-FOUND-COLOR-001` | Every colour in the reference set is a token with a declared role; no literal colour values. |
| `AC-FOUND-COLOR-002` | All text meets WCAG 2.2 AA contrast (4.5:1 normal, 3:1 large) in light, dark, and high-contrast. |
| `AC-FOUND-COLOR-003` | No meaning is carried by colour alone; every colour-coded element has a non-colour equivalent. |
| `AC-FOUND-COLOR-004` | Colour ramps are perceptually even in OKLCH; verified by a ramp test. |
| `AC-FOUND-COLOR-005` | Data visualisation palettes pass deuteranopia, protanopia, and tritanopia simulation. |
