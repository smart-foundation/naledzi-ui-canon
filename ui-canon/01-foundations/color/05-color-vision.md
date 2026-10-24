---
id: FOUND-COLOR-VISION
title: Colour Vision
kind: foundation
entity: color
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, FOUND-COLOR-INDEX, FOUND-COLOR-ROLES, FOUND-COLOR-CONTRAST]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-COLOR-018, AC-FOUND-COLOR-026]
---

# Colour Vision

> Colour vision deficiency affects roughly 8% of males and 0.5% of females. The most
> common form (deuteranopia/protanopia) confuses red and green. A design that relies on
> red-vs-green alone excludes roughly one in twelve men. This is not an edge case. It is
> the normal distribution of human vision.

---

## 1. The types

| Type | Prevalence (males) | Prevalence (females) | Confused colours | Cause |
|---|---|---|---|---|
| **Deuteranopia** | ~1% | ~0.01% | Red/green | Missing M (medium) cone |
| **Deuteranomaly** | ~5% | ~0.35% | Red/green (mild) | Shifted M cone sensitivity |
| **Protanopia** | ~1% | ~0.01% | Red/green | Missing L (long) cone |
| **Protanomaly** | ~1% | ~0.02% | Red/green (mild) | Shifted L cone sensitivity |
| **Tritanopia** | ~0.001% | ~0.001% | Blue/yellow | Missing S (short) cone |
| **Tritanomaly** | ~0.01% | ~0.01% | Blue/yellow (mild) | Shifted S cone sensitivity |
| **Achromatopsia** | ~0.003% | ~0.003% | All colour | No functioning cones |
| **Acquired** | variable | variable | Variable | Disease, medication, aging, glare |

Total red-green deficiency: ~8% of males, ~0.5% of females. This is the most common
form and the one most designs fail to account for.

---

## 2. The rule

**`FOUND-COLOR-050`. Colour MUST NOT be the only carrier of meaning.** Every
colour-coded element must have a non-colour equivalent: shape, text, position, pattern,
or icon. This is `LAW-009` (accessibility is structural) applied to colour.

This means:

- A red error message must also have an error icon and the word "error" (or equivalent).
- A green success indicator must also have a checkmark and the word "success."
- A chart that uses red and green must also use different line styles, markers, or
  labels.
- A status indicator that uses colour must also use shape or text.
- A selected item that uses a colour highlight must also use a checkmark or bold text.

---

## 3. What counts as "carried by colour"

| Pattern | Colour-only? | Fix |
|---|---|---|
| Red text saying "Error" | No — text carries the meaning | None needed |
| Red dot with no label | Yes — colour is the only carrier | Add an icon or label |
| Green checkmark + "Success" text | No — icon and text carry the meaning | None needed |
| Chart with red and green lines, no markers | Yes — colour is the only differentiator | Add different line styles or markers |
| Selected row highlighted in blue | Yes — colour is the only indicator | Add a checkmark or bold text |
| Status badge: red "Failed", green "Passed" | No — text carries the meaning | None needed (but verify contrast) |
| Traffic light: red/yellow/green with no labels | Yes — colour is the only carrier | Add text labels or shapes |

---

## 4. Design patterns that survive colour vision deficiency

### 4.1 Shape + colour

Every status, state, or category that uses colour must also use a distinct shape:

| Status | Colour | Shape | Text |
|---|---|---|---|
| Success | Green | Checkmark | "Success" or "Passed" |
| Warning | Yellow/amber | Triangle | "Warning" or "Caution" |
| Error | Red | Circle with X or octagon | "Error" or "Failed" |
| Info | Blue | Circle with i | "Info" or "Note" |
| Neutral | Grey | Dash or empty circle | "Pending" or "Not set" |

### 4.2 Pattern + colour (for charts and data)

Charts must use patterns (dashed lines, different markers, hatching) in addition to
colour. A chart that is readable in greyscale is a chart that survives colour vision
deficiency.

### 4.3 Position + colour

In a list or grid, the position of an item can carry meaning that colour would otherwise
carry. A "selected" item is at the top, bold, and has a checkmark — not just blue.

---

## 5. Testing

### 5.1 Simulation

Every screen is tested with a colour vision deficiency simulator. The standard
simulations are:

- Deuteranopia (most common)
- Protanopia
- Tritanopia
- Achromatopsia (greyscale — the ultimate test)

Tools: browser DevTools colour vision simulation, or dedicated tools (Color Oracle,
Sim Daltonism).

### 5.2 The greyscale test

Convert every screen to greyscale. If any meaning is lost, the design relies on colour
alone. This is the simplest and most effective test.

### 5.3 The shape test

Remove all colour (make everything the same grey). Are all statuses, states, and
categories still distinguishable by shape, text, or position? If not, the design fails.

---

## 6. Data visualisation

Data visualisation is the hardest case for colour vision deficiency because charts often
use colour as the primary differentiator. Rules:

- **Maximum 6-8 colours** in a single chart. More is unreadable for everyone.
- **Use a colourblind-safe palette.** The Wong palette (2011) is the standard:
  black, orange, sky blue, bluish green, yellow, blue, vermillion, reddish purple.
- **Always add non-colour differentiators:** line style (solid, dashed, dotted),
  markers (circle, square, triangle, diamond), or labels.
- **Never use red and green as the only differentiators.**
- **Provide a text alternative.** Every chart must have a data table or a summary
  that conveys the same information.
- **Test in greyscale.** If the chart is unreadable in greyscale, it fails.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-COLOR-018` | No meaning is carried by colour alone; every colour-coded element has a non-colour equivalent. |
| `AC-FOUND-COLOR-026` | Every screen passes deuteranopia, protanopia, tritanopia, and achromatopsia simulation. |
| `AC-FOUND-COLOR-027` | Every screen is readable in greyscale. |
| `AC-FOUND-COLOR-028` | Every chart uses a colourblind-safe palette and non-colour differentiators. |
| `AC-FOUND-COLOR-029` | Every chart has a text alternative (data table or summary). |
| `AC-FOUND-COLOR-030` | Colour vision testing is part of the acceptance suite, not a manual afterthought. |
