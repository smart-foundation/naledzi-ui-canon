---
id: FOUND-DEPTH-MATERIAL-06
title: Materials
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-ELEV-02, FOUND-DEPTH-SHADOW-03, ADR-0004, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-060, AC-FOUND-DEPTH-061, AC-FOUND-DEPTH-062]
---

# Materials

> A material is a declared surface quality: matte, translucent, emissive or safety. It is a
> token, not an arbitrary style. Translucency is a tool for a transient layer, never the
> foundation of the interface.

---

## 1. The four materials

| Material | Token | What it does | Where it is legal | Where it is forbidden |
|---|---|---|---|---|
| **Matte** | `TOK-DEPTH-MATERIAL-MATTE` | Opaque, low-reflection surface | Everywhere, and the default | Nowhere |
| **Translucent** | `TOK-DEPTH-MATERIAL-TRANSLUCENT` | Lets the layer behind show through, with or without blur | E2-E4 transient surfaces only | E0, E1, body text, safety indicators, large backgrounds |
| **Emissive** | `TOK-DEPTH-MATERIAL-EMISSIVE` | Emits light as a signal | Indicators, status lamps, safety signals, small accents | Large surfaces, body text backgrounds, decoration |
| **Safety** | `TOK-DEPTH-MATERIAL-SAFETY` | High-contrast, glare-resistant, non-transparent | EV, spaceship, critical indicators | App content, decorative surfaces |

A material changes three things and only three things: opacity, blur and edge treatment. It
does not change elevation, light direction or interaction meaning.

- **FOUND-DEPTH-210.** Every surface MUST declare exactly one material. The default is matte.
- **FOUND-DEPTH-211.** Translucency MUST NOT be used on E0 or E1. The page and its content are
  opaque so that text contrast is stable.
- **FOUND-DEPTH-212.** A translucent surface MUST have an opaque fallback with the same role
  and the same content.
- **FOUND-DEPTH-213.** Emissive material MUST NOT be used to decorate. It is a signal, and a
  signal that is always on stops being a signal.

---

## 2. Translucency

Translucency is allowed only when the layer is transient and the person benefits from seeing
the context behind it: a menu over a canvas, a sheet over a photo, a heads-up control over a
map. It is not allowed merely to look modern.

### 2.1 Requirements

- The surface must have a minimum opacity of 72% in light themes and 78% in dark themes, or a
  declared backdrop treatment that preserves text contrast.
- The content on the surface must meet the colour foundation's contrast thresholds against
  the **worst-case** backdrop, not the average.
- The surface must have a 1 px edge or tonal boundary so that it is distinguishable from the
  content behind it.
- The surface must not blur a critical indicator, a safety warning or a moving hazard.
- The surface must not create a "frosted" effect on text-heavy content.

### 2.2 Blur

Blur is optional and expensive. It is a separate capability from opacity.

| Envelope | Backdrop blur | Maximum radius | Fallback |
|---|---|---|---|
| Desktop, tablet | Allowed | 20 CSS px | Opaque material |
| Phone | Allowed | 16 CSS px | Opaque material |
| Watch | Forbidden | n/a | Opaque material |
| TV | Forbidden | n/a | Opaque material |
| EV | Forbidden | n/a | Opaque safety material |
| Spaceship | Forbidden | n/a | Opaque safety material |
| IoT | Forbidden | n/a | Opaque material |
| Spatial | Allowed, budgeted | 12 CSS px equivalent | Opaque material |
| Remote browser | Allowed, user-declared | 12 CSS px equivalent | Opaque material |

- **FOUND-DEPTH-220.** Backdrop blur MUST be disabled on watch, TV, EV, spaceship and IoT.
- **FOUND-DEPTH-221.** Blur MUST NOT be applied to a surface that contains body text unless
  the contrast is re-measured against the blurred result.
- **FOUND-DEPTH-222.** Blur MUST be skipped, not faked, when the capability is absent. A
  semi-transparent rectangle with no blur is a legal fallback; a fake noise texture is not.

---

## 3. Reduced transparency

The operating system exposes a reduced-transparency preference. It is binding.

- When reduced transparency is on, every translucent surface becomes opaque.
- The surface keeps its level, its shadow, its position and its content.
- The blur is removed. The edge and tonal boundary remain.
- Any visual effect that depends on seeing through the surface (a map under a panel, a photo
  under a sheet) must be replaced by a declared solid colour or a smaller panel that does not
  cover the content.
- The preference must apply to system surfaces and app surfaces alike.

- **FOUND-DEPTH-230.** Reduced transparency MUST make every surface opaque, without removing
  information or changing the interaction.
- **FOUND-DEPTH-231.** Reduced transparency MUST NOT be implemented by simply raising opacity
  to 99%; the surface must be fully opaque and the blur must be removed.
- **FOUND-DEPTH-232.** A translucent material MUST be tested at both settings; a surface that
  is only legible with blur is non-conformant.

---

## 4. Emissive material

Emissive material is light as a signal. It is used for:

- status lamps (recording, live, charging, connected);
- safety indicators that must be visible in glare;
- a small accent that marks the active item;
- a night-mode clock or a low-light indicator.

It is not used for:

- large background panels;
- text backgrounds;
- decorative gradients;
- "premium" glow around cards;
- a substitute for a shadow.

- **FOUND-DEPTH-240.** An emissive surface MUST have a defined on, off and degraded state.
- **FOUND-DEPTH-241.** An emissive surface MUST NOT be the only carrier of a state. It must be
  paired with a label, an icon or an announcement.
- **FOUND-DEPTH-242.** Emissive luminance MUST be bounded so that it does not cause glare in a
  dark environment. The bound is declared per envelope in `10-envelopes.md`.
- **FOUND-DEPTH-243.** An emissive signal MUST NOT flash above the photosensitivity threshold.

---

## 5. Safety material

Safety material is a matte, high-contrast, glare-resistant surface for critical indicators.

- It has no translucency and no blur.
- It uses the safety palette and the safety type roles.
- It has a solid boundary and a protected zone.
- It does not inherit app theming. A theme cannot change its contrast.
- It is tested at 1 m and 4 m viewing distances on the EV and spaceship envelopes.
- It is tested under direct sunlight, low light and vibration.

- **FOUND-DEPTH-250.** Safety material MUST be theme-independent. App or user theming MUST NOT
  alter its colours, type or contrast.
- **FOUND-DEPTH-251.** Safety material MUST pass its contrast and legibility tests in every
  declared lighting condition.
- **FOUND-DEPTH-252.** Safety material MUST NOT be used for non-safety content, because doing
  so dilutes the signal.

---

## 6. Material and elevation

Material and elevation are orthogonal, but not independent:

| Level | Matte | Translucent | Emissive | Safety |
|---|---|---|---|---|
| E0 | Default | Forbidden | Forbidden | Forbidden |
| E1 | Default | Forbidden | Small indicator only | Forbidden |
| E2 | Allowed | Allowed | Small indicator only | Forbidden |
| E3 | Allowed | Allowed | Indicator only | Forbidden |
| E4 | Allowed | Allowed, except safety | Indicator or signal | Allowed |

A surface cannot use translucency to appear higher than its declared level. A translucent E2
menu is still E2; its input and focus behaviour do not become modal.

---

## 7. Failure

| Failure | Result | Required behaviour |
|---|---|---|
| Blur capability absent | Surface is transparent but unblurred | Use the opaque fallback; do not fake blur |
| Backdrop is a live video | Text contrast fluctuates | Use the opaque fallback or a declared scrim behind the text |
| Reduced transparency toggled | Surface must become opaque | Apply in the same still; keep layout and level |
| Emissive output miscalibrated | Signal too bright or too dim | Clamp to the declared luminance range; show a calibration state if the panel reports it |
| Safety material themed by an app | Contrast drops | Reject the theme; safety material is not themeable |
| Translucent surface over a critical indicator | Indicator obscured | Clip the surface around the protected zone or make it opaque |

---

## 8. What this model refuses

- A translucent page background.
- A blurred panel behind body text.
- A glass card with no hierarchy meaning.
- A neon glow around a button.
- A "frosted" safety warning.
- A material that changes the level.
- A material that only works on a high-end GPU.
- A theme that changes the safety palette.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-060` | Every surface in the reference set declares one material; E0/E1 surfaces are opaque. |
| `AC-FOUND-DEPTH-061` | Enable reduced transparency. Every translucent surface becomes opaque, blur is removed, layout and level are unchanged. |
| `AC-FOUND-DEPTH-062` | Place body text on every allowed translucent material over the worst-case backdrop; contrast passes in both polarities. |
| `AC-FOUND-DEPTH-063` | On watch, TV, EV, spaceship and IoT, no backdrop blur is scheduled; the opaque fallback is used. |
| `AC-FOUND-DEPTH-064` | A theme change does not alter the safety material's colours, type or contrast. |
