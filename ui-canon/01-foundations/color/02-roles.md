---
id: FOUND-COLOR-ROLES
title: Colour Roles
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, FOUND-COLOR-INDEX, FOUND-COLOR-MODEL]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-001, AC-FOUND-COLOR-011]
---

# Colour Roles

> A component never names a colour. It names a role. The theme supplies the value. This
> is what makes theming, high contrast, and accessibility possible: the component's
> intent ("this is a danger indicator") is separate from the visual value ("this is
> red #d32f2f").

---

## 1. The role system

Every colour in the system belongs to one of 24 roles. Roles are grouped by function:

### Surface roles (what is behind the content)

| Role | Meaning | Used by |
|---|---|---|
| `surface-base` | The page plane, the app background, the document canvas | Content region, canvas, map |
| `surface-raised` | A panel attached to the content | Inspector, sidebar, toolbar |
| `surface-floating` | A temporary object above the content | Card, popover, drag ghost |
| `surface-overlay` | A transient task or decision | Sheet, dialog, palette |
| `surface-system` | OS-owned, never app-owned | Status rail, strip, lock |
| `surface-disabled` | A disabled control's background | Disabled button, disabled field |
| `surface-selected` | A selected item's background | Selected row, selected card |
| `surface-hover` | A hovered item's background (where legal) | Hovered row, hovered button |

### Content roles (what is on the surface)

| Role | Meaning | Used by |
|---|---|---|
| `content-primary` | The main text, the hero content | Body text, headings, primary labels |
| `content-secondary` | Supporting text, metadata | Captions, timestamps, secondary labels |
| `content-tertiary` | De-emphasised text, placeholders | Placeholders, disabled text, hints |
| `content-inverse` | Text on a dark surface in light mode (or vice versa) | Text on a filled button, text on a badge |
| `content-disabled` | Disabled control text | Disabled button label, disabled field text |

### Semantic roles (what the colour means)

| Role | Meaning | Used by |
|---|---|---|
| `accent` | The brand/primary action colour | Primary button, link, focus ring, selected tab |
| `success` | A positive outcome | Success message, completed state, checkmark |
| `warning` | A condition that needs attention | Warning banner, caution indicator |
| `danger` | A destructive or error state | Error message, delete button, error field border |
| `info` | Neutral information | Info banner, tooltip, help text |

### Structural roles (borders, dividers, focus)

| Role | Meaning | Used by |
|---|---|---|
| `border-subtle` | A light separator between adjacent items | List divider, card border |
| `border-strong` | A visible boundary | Input field border, panel edge |
| `border-focus` | The focus ring | Focused control, focused row |
| `divider` | A full-width separator | Section divider, toolbar separator |
| `scrim` | A dimming layer behind an overlay | Sheet scrim, dialog scrim |
| `shadow` | A shadow colour (always with opacity) | Card shadow, floating shadow |

---

## 2. Role rules

### 2.1 A component declares a role, not a value

A button does not say "background: #1976d2". It says "background: accent". The theme
resolves `accent` to a value. This means:

- A component works in any theme (light, dark, high-contrast, custom).
- A component works in any envelope (the EV theme may use a different accent).
- A component's intent is readable from its role declaration.

### 2.2 Roles are semantic, not visual

`accent` means "the primary action colour." It does not mean "blue." A theme may set
`accent` to green, purple, or any colour that satisfies the contrast and accessibility
constraints. The component does not care.

### 2.3 Every role has a contrast constraint

Each role declares the minimum contrast it must achieve against the surfaces it appears
on. See `04-contrast.md`. A theme that sets a role value that fails the constraint is
invalid.

### 2.4 Roles are not optional

A component may not use a colour that is not a role. If a new visual need arises, a new
role is proposed (with a justification, a constraint, and an acceptance test), not a
one-off colour.

### 2.5 `content-inverse` is special

`content-inverse` is text that appears on a filled surface (e.g., white text on a blue
button). It must be the inverse of the surface's content role, and it must meet contrast
against the surface. It is not "always white" — in high-contrast mode it may be black
on white.

---

## 3. Role pairing

Roles are designed to be used in pairs:

| Surface role | Content role | Border role | Example |
|---|---|---|---|
| `surface-base` | `content-primary` | `border-subtle` | Page background with body text |
| `surface-raised` | `content-primary` | `border-strong` | Card with heading and body |
| `surface-floating` | `content-primary` | `border-subtle` | Popover with text |
| `surface-overlay` | `content-primary` | `border-strong` | Dialog with title and body |
| `surface-system` | `content-inverse` | `border-subtle` | Status rail on dark background |
| `surface-disabled` | `content-disabled` | `border-subtle` | Disabled button |
| `surface-selected` | `content-primary` | `border-focus` | Selected list row |

A component that uses a surface role without its paired content role is a defect. The
pairing ensures that text on any surface is readable.

---

## 4. The role test

1. **Read the component's role declarations.** Can you tell what each colour means
   without seeing the rendered output? If not, the roles are too vague.
2. **Swap the theme.** Does the component still look correct with a different accent
   colour? If not, the component has hardcoded a visual value.
3. **Apply high contrast.** Does every role resolve to a value that meets the contrast
   floor? If not, the role's constraint is wrong or the theme is invalid.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-011` | Every component declares colour roles, not colour values. |
| `AC-FOUND-COLOR-012` | Every role has a contrast constraint against its paired surfaces. |
| `AC-FOUND-COLOR-013` | No component uses a colour that is not a declared role. |
| `AC-FOUND-COLOR-014` | Role pairing is verified for every component in the reference set. |
| `AC-FOUND-COLOR-015` | High-contrast mode resolves every role to a valid value. |
