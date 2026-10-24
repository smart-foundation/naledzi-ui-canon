---
id: FW-TOKENS-THEME
title: "Theme: single authority, modes, custom themes"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-COLOR-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-THEME-001]
---

# Theme

> One theme authority: the theme service (`theme.capnp`). The framework consumes tokens;
> it does not own theme values. No second theme, no shadow theme (LAW-001).

---

## 1. Single authority

- FW-THEME-001. The theme service is the only source of theme values. Apps and components
  never embed a theme.
- FW-THEME-002. Theme changes arrive as token updates and trigger `mark_subtree_dirty`
  (runtime/05-damage.md).

## 2. Modes

| Mode | Use |
|---|---|
| Light | Default in bright environments |
| Dark | Default in dim; void + grey ladder + one vibrant accent (Lock 3) |
| High contrast | Stronger separation; meets floors |
| Monochrome | Colour-independent |
| Colourful / brand | `ThemeVariantKind` for branding |

- FW-THEME-003. Light/dark/high-contrast are modes of one theme, not separate themes.
- FW-THEME-004. High contrast overrides all tokens to meet floors; never reduces
  information.

## 3. Custom themes

- FW-THEME-005. Custom themes are data (`ThemeVariantKind.custom`), validated against
  contrast floors before application.
- FW-THEME-006. An invalid custom theme is rejected with a reason; the previous theme
  remains active.
- FW-THEME-007. Custom themes cannot bypass the role system (no "brand colour override").

## 4. Per-envelope variants

- Watch: larger type, higher contrast, fewer tones.
- EV/spaceship: high-contrast, glance-safe, protected zones.
- Desktop: dense.

## 5. Attention-ink semantics

`primary` is the focus ink, painted only on the focused element. Branding uses
`ThemeVariantKind.brand`. No schema change; convention + token value.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-THEME-001` | Switching light/dark/high-contrast re-themes without restart and re-commits damage. |
| `AC-FW-TOK-THEME-002` | Invalid custom theme is rejected with reason; previous theme stays. |