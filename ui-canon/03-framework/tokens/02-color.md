---
id: FW-TOKENS-COLOR
title: "Colour tokens: complete table"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-COLOR-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-COLOR-001]
---

# Colour tokens

> Every colour in the system is a semantic token. The component names a role; the theme
> supplies the value. Primitive palette values are not referenced by components.

---

## 1. How to read this table

Columns: **Token ID** (canonical reference), **MirUI ColorToken** (substrate enum, where
applicable), **Semantic role**, **Value source / range**, **Per-envelope notes**,
**Accessibility constraint**.

Value source: `theme.capnp ThemeColors` field or a derived tint. Primitive ramps are owned by
the theme service and are not listed here (they are not tokens).

## 2. Surface and content tokens

| Token ID | MirUI ColorToken | Semantic role | Value source | Per-envelope | Accessibility |
|---|---|---|---|---|---|
| `TOK-COLOR-BACKGROUND` | (derived) | The page plane behind everything | `surface` base or true black on OLED profiles | OLED: true black; LCD: near-black surface | Contrast floor against on-surface |
| `TOK-COLOR-SURFACE` | `Surface` | Default container surface | `ThemeColors.surface` | Watch: higher contrast; EV: matte | ≥ 3:1 against adjacent surfaces |
| `TOK-COLOR-SURFACE-VARIANT` | `SurfaceVariant` | Secondary surface (cards, panels) | `ThemeColors.surfaceVariant` | — | ≥ 3:1 against surface |
| `TOK-COLOR-SURFACE-RAISED` | (derived) | Raised panel (inspector, sidebar) | surface + elevation tint | — | Must not reduce text contrast |
| `TOK-COLOR-ON-SURFACE` | `OnSurface` | Primary text/icons on surface | `ThemeColors.onSurface` | High-contrast: pure black/white | ≥ 4.5:1 (3:1 large) vs surface |
| `TOK-COLOR-ON-SURFACE-VARIANT` | `OnSurfaceVariant` | Secondary text/icons | `ThemeColors.onSurfaceVariant` | — | ≥ 4.5:1 vs surface-variant |
| `TOK-COLOR-ON-SURFACE-MUTED` | (derived) | Tertiary/quiet text | on-surface at reduced alpha | — | ≥ 3:1 vs surface |
| `TOK-COLOR-OUTLINE` | `Outline` | Borders, dividers (rare) | `ThemeColors.outline` | — | ≥ 3:1 vs adjacent |
| `TOK-COLOR-OUTLINE-VARIANT` | (derived) | Subtle separator | outline at reduced alpha | — | ≥ 3:1 in high contrast |

## 3. Accent / attention tokens

| Token ID | MirUI ColorToken | Semantic role | Value source | Per-envelope | Accessibility |
|---|---|---|---|---|---|
| `TOK-COLOR-PRIMARY` | `Primary` | Attention ink: focused/active element only | `ThemeColors.primary` | High-contrast: system accent | ≥ 3:1 vs surface; never sole carrier |
| `TOK-COLOR-ON-PRIMARY` | `OnPrimary` | Content on primary | `ThemeColors.onPrimary` | — | ≥ 4.5:1 vs primary |
| `TOK-COLOR-SECONDARY` | `Secondary` | Secondary emphasis (selected, toggle on) | `ThemeColors.secondary` | — | ≥ 3:1 vs surface |
| `TOK-COLOR-ON-SECONDARY` | `OnSecondary` | Content on secondary | `ThemeColors.onSecondary` | — | ≥ 4.5:1 vs secondary |
| `TOK-COLOR-TERTIARY` | `Tertiary` | Tertiary emphasis (less common) | `ThemeColors.tertiary` | — | ≥ 3:1 vs surface |
| `TOK-COLOR-ON-TERTIARY` | `OnTertiary` | Content on tertiary | `ThemeColors.onTertiary` | — | ≥ 4.5:1 vs tertiary |

Note: `primary` is the *attention ink* (focus), not a brand colour (ui-layer-mirui.md Lock 3).
Branding uses `ThemeVariantKind.brand`.

## 4. Status tokens

| Token ID | MirUI ColorToken | Semantic role | Value source | Per-envelope | Accessibility |
|---|---|---|---|---|---|
| `TOK-COLOR-SUCCESS` | `Success` | Success state | `ThemeColors.success` (added) | — | ≥ 3:1 vs surface; not colour alone |
| `TOK-COLOR-WARNING` | (proposed) | Warning state | `ThemeColors.warning` (added) | EV: high salience | ≥ 3:1; icon + text |
| `TOK-COLOR-ERROR` | `Error` | Error/invalid state | `ThemeColors.error` | — | ≥ 3:1; icon + text |
| `TOK-COLOR-INFO` | (proposed) | Informational state | `ThemeColors.info` (added) | — | ≥ 3:1; not colour alone |
| `TOK-COLOR-DISABLED` | (derived) | Disabled content | on-surface at reduced alpha | — | ≥ 3:1 in high contrast |
| `TOK-COLOR-FOCUS-RING` | (derived) | Focus indicator | primary or outline | — | ≥ 3:1 vs adjacent (WCAG 2.2 SC 2.4.13) |

## 5. Overlay and shadow tokens

| Token ID | MirUI ColorToken | Semantic role | Value source | Per-envelope | Accessibility |
|---|---|---|---|---|---|
| `TOK-COLOR-SCRIM-OVERLAY` | (derived) | Modal scrim (E3) | black at 32% | — | Content behind remains readable if non-modal |
| `TOK-COLOR-SCRIM-SYSTEM` | (derived) | System scrim (E4) | black at 48–60% | — | Protected zones never occluded |
| `TOK-COLOR-SHADOW` | `Shadow` | Shadow colour | `ThemeColors.shadow` | — | Shadow is supplementary (FOUND-DEPTH-002) |

## 6. Custom

| Token ID | MirUI ColorToken | Semantic role | Value source | Per-envelope | Accessibility |
|---|---|---|---|---|---|
| `TOK-COLOR-CUSTOM-*` | `Custom(&'static str)` | App-defined role | App theme extension | — | Must meet contrast floors |

## 7. Accessibility constraints (summary)

- All text meets WCAG 2.2 AA: 4.5:1 normal, 3:1 large (`FOUND-COLOR` acceptance).
- No meaning carried by colour alone (`FOUND-COLOR-050`).
- High-contrast theme overrides all tokens to meet floors.
- Colour-vision deficiency: status uses icon + text + pattern, not colour alone.

## 8. Envelope notes

- Watch: higher contrast, fewer tones, larger type.
- EV/spaceship: high-contrast, glance-safe, protected zones.
- OLED profiles: true black background; LCD: near-black surface (material is void, Lock 3).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-COLOR-001` | Every colour in the reference set is one of the tokens above; no literal colour values in components. |
| `AC-FW-TOK-COLOR-002` | All tokens meet contrast floors in light/dark/high-contrast. |
| `AC-FW-TOK-COLOR-003` | `success`/`warning`/`info` added to `theme.capnp ThemeColors` (2 crates recompile). |