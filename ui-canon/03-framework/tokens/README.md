---
id: FW-TOKENS-INDEX
title: "Tokens: naming, resolution, complete index"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-README, CANON-LAWS, FOUND-COLOR-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOKENS-000]
children:
  - 01-principles.md
  - 02-color.md
  - 03-typography.md
  - 04-space.md
  - 05-radius.md
  - 06-depth-and-shadow.md
  - 07-motion.md
  - 08-material.md
  - 09-icon.md
  - 10-density.md
  - 11-breakpoints-and-sizes.md
  - 12-z-and-elevation.md
  - 13-theme.md
  - 14-acceptance.md
---

# Tokens

> Tokens are the only legal visual values (FW-LAW-006). Every colour, spacing, radius,
> elevation, duration and icon size resolves through a token. No raw visual value in app or
> component behaviour.

---

## 1. What this subtree specifies

The token system: principles, the complete colour token table, typography, space, radius,
depth/shadow, motion, material, icon, density, breakpoints/sizes, z/elevation, and theme
resolution. Tokens are minted from the foundations (`01-foundations/*`) and resolved into
MirUI styles by the adapter.

## 2. Naming

Token IDs: `TOK-<GROUP>-<NAME>` (e.g. `TOK-COLOR-SURFACE`). Component and app code
references tokens by ID, never by value. Aliases are allowed (design-tokens format
`$type`, aliases, groups).

## 3. Resolution

```
foundation (meaning + constraints) -> token (named value) -> theme (per mode) -> MirUI style
```

- The foundation owns meaning and constraints.
- The token owns the named value and its type.
- The theme supplies the value per light/dark/high-contrast/custom.
- The component references the token; it never names a colour.

## 4. Directory map

| File | Question |
|---|---|
| [01-principles.md](01-principles.md) | Tokens are the only legal visual values; semantic vs primitive; versioning. |
| [02-color.md](02-color.md) | Complete colour token table. |
| [03-typography.md](03-typography.md) | Type tokens. |
| [04-space.md](04-space.md) | Space tokens. |
| [05-radius.md](05-radius.md) | Radius tokens. |
| [06-depth-and-shadow.md](06-depth-and-shadow.md) | Depth/shadow tokens. |
| [07-motion.md](07-motion.md) | Motion tokens (TOK-MOTION-*). |
| [08-material.md](08-material.md) | Material tokens. |
| [09-icon.md](09-icon.md) | Icon tokens. |
| [10-density.md](10-density.md) | Density tokens. |
| [11-breakpoints-and-sizes.md](11-breakpoints-and-sizes.md) | Breakpoints and sizes. |
| [12-z-and-elevation.md](12-z-and-elevation.md) | Z and elevation tokens. |
| [13-theme.md](13-theme.md) | Single authority, modes, custom themes. |
| [14-acceptance.md](14-acceptance.md) | Acceptance. |

## 5. Versioning

- Tokens are versioned with the framework. A token rename is a breaking change requiring
  a migration note.
- Deprecated tokens remain resolvable for one major version, then are removed.
- New tokens are additive (LAW-014).

## 6. Open questions

| ID | Question | Owner | Needed by |
|---|---|---|---|
| FW-TOK-Q-001 | Bundled font families not selected/licensed. Type tokens name roles + fallback chain. | Type Guild | First visual conformance run |
| FW-TOK-Q-002 | Custom theme validation rules (contrast floor enforcement). | Foundations + Framework | Custom theme support |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOKENS-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-FW-TOKENS-001` | No raw visual value outside `tokens/` (grep audit). |
| `AC-FW-TOKENS-002` | Every token has a type, default, and resolution path. |