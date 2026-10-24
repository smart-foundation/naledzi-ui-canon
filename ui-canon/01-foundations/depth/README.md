---
id: FOUND-DEPTH-INDEX
title: Depth
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-GLOSSARY, CANON-DECISIONS, FOUND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-000]
children:
  - 01-space-and-light.md
  - 02-elevation.md
  - 03-shadows.md
  - 04-parallax.md
  - 05-occlusion-and-focus.md
  - 06-materials.md
  - 07-acceptance.md
  - 08-tokens.md
  - 09-rules.md
  - 10-envelopes.md
  - 11-adaptation.md
  - 12-assistive.md
  - 13-performance.md
  - 14-failure.md
  - 15-timelessness.md
  - 16-references.md
  - 17-open-questions.md
  - 18-changelog.md
---

# Depth

> Depth is the semantic use of space, light, occlusion, parallax and focus to express
> hierarchy. It is not a visual style. If removing a shadow changes no meaning, the shadow was
> decoration and does not belong in this model.

**Scope:** the visual model that every surface, component, shell layer and app composes
inside. It defines what is in front of what, why, and what happens when the answer cannot be
drawn.

**Non-goals:** glassmorphism, neumorphism, decorative 3D, fake perspective, drop shadows used
as ornament, and any depth effect that exists only to look modern.

---

## 1. The human constant

People perceive spatial layout from several independent cues. The strongest pictorial cue is
**occlusion**: one object hides another, and the hidden object is behind. Cutting and Vishton
(1995) found that occlusion remains effective across the whole visible range and dominates
relative size, which in turn dominates relative density. Cast shadows are strong cues to
spatial arrangement, especially when they move, and weak cues to object shape (Mamassian,
Knill and Kersten, 1998).

Naledzi turns those facts into a rule:

- **FOUND-DEPTH-001.** Occlusion MUST be truthful. If a surface is drawn in front, it is in
  front for hit-testing, focus, accessibility and input ownership in the same still.
- **FOUND-DEPTH-002.** Elevation MUST be carried by more than shadow. Position, overlap,
  contrast and scale MUST also encode the level, so the hierarchy survives when shadow is
  unavailable.
- **FOUND-DEPTH-003.** A shadow MUST indicate a real spatial relationship. A surface that
  casts a shadow MUST have a declared level above the surface that receives it.

The model therefore uses five levels, one light model, two shadow components, bounded
parallax, truthful occlusion and semantic focus dimming. The rest of this directory specifies
each part.

---

## 2. The model in one page

```text
E4  system      alerts, permission prompts, safety warnings, critical indicators
     ^          scrim 48-60%, never occluded by app content
     |
E3  overlay     dialogs, sheets, command palette, menus that own focus
     ^          scrim 32%, focus trapped, dismiss explicit
     |
E2  floating    popovers, tooltips, floating controls, drag previews
     ^          shadow + offset, no scrim, dismiss on outside action
     |
E1  raised      cards, list rows, grouped content, inline panels
     ^          contact shadow + tonal separation
     |
E0  base        the page plane, app background, canvas, map, document
                no shadow, no offset, receives shadows
```

The levels are semantic. A component does not choose a level because it looks better at that
level. It chooses the level that matches its interaction meaning, and the level supplies the
shadow, scrim, input and accessibility behaviour.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-space-and-light.md](01-space-and-light.md) | What space does the model assume, and where does light come from? |
| [02-elevation.md](02-elevation.md) | What are the five levels, what does each mean, and what may live there? |
| [03-shadows.md](03-shadows.md) | How is a shadow built, and what must it never do? |
| [04-parallax.md](04-parallax.md) | When may layers move relative to one another? |
| [05-occlusion-and-focus.md](05-occlusion-and-focus.md) | How is "in front" made truthful, and how is attention dimmed? |
| [06-materials.md](06-materials.md) | Which surface qualities are legal, and where? |
| [07-acceptance.md](07-acceptance.md) | How is the whole foundation proved? |
| [08-tokens.md](08-tokens.md) | Which `TOK-DEPTH-*` values are proposed? |
| [09-rules.md](09-rules.md) | What is the consolidated normative rule set? |
| [10-envelopes.md](10-envelopes.md) | How does each of the ten envelopes change the model? |
| [11-adaptation.md](11-adaptation.md) | What happens under reduced motion, reduced transparency, high contrast, 200% text and RTL? |
| [12-assistive.md](12-assistive.md) | What does a screen reader or non-visual path receive instead of depth? |
| [13-performance.md](13-performance.md) | What does depth cost, and how does it degrade? |
| [14-failure.md](14-failure.md) | What happens when shadow, blur, parallax or occlusion cannot be produced? |
| [15-timelessness.md](15-timelessness.md) | Why does this survive display and decade change? |
| [16-references.md](16-references.md) | What is the evidence, with limits? |
| [17-open-questions.md](17-open-questions.md) | What is unresolved, owned and due? |
| [18-changelog.md](18-changelog.md) | What changed? |

---

## 4. Dependency and ownership

| Fact | Owner | Consumers |
|---|---|---|
| Elevation level of a surface | The component or shell surface that composes it, declared in its spec | Policy, hit-testing, accessibility tree, shadow renderer |
| Light direction | This foundation | Every shadow token and material |
| Shadow recipe per level | `08-tokens.md`, minted by `03-framework/tokens/` | Renderer, components |
| Occlusion truth | Presentation authority (`LAW-005`) | Hit map, focus, accessibility, input |
| Focus dimming | Policy and this foundation | Shell, overlays |
| Critical-indicator protection | EV and spaceship envelope constraints plus this foundation | Safety surfaces |

The depth foundation does not own layout. It owns the meaning of a layer and the consequences
of placing something in front of something else.

---

## 5. What is intentionally absent

| Item | Reason |
|---|---|
| A 3D scene graph | `n/a — presentation truth is a numbered still, not a mutable scene (`LAW-005`).` |
| Per-component z-index values | `n/a — levels are semantic and owned by this foundation; a component declares a level, never a number.` |
| Glassmorphism as a default material | `n/a — rejected by ADR-0004; translucency is a scoped material in `06-materials.md`.` |
| Decorative parallax | `n/a — forbidden by `LAW-007` and `FOUND-DEPTH-040`. |
| Depth on audio-only output | `n/a — audio uses distance and loudness in `sound-haptics/01-audio-language.md`; visual depth has no meaning there.` |
| Per-envelope pixel values in prose | `n/a — values live in `08-tokens.md` and are referenced by ID.` |

---

## 6. The depth test

Every depth decision is tested three ways:

1. **Remove the shadow.** Is the hierarchy still readable from position, overlap, contrast and
   scale? If not, the design depends on a single cue and is fragile.
2. **Remove the colour.** Is "in front" still true from occlusion alone? If not, the occlusion
   boundary is ambiguous.
3. **Remove the visual layer.** Does the screen reader still receive the same hierarchy and
   the same protected warnings? If not, depth is carrying meaning that accessibility cannot
   derive.

A design that fails any test is not finished. It is not "a visual polish issue".

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-000` | Every file listed in `children` exists; every file in the directory is listed; no file contains `TODO` or an empty section. |
| `AC-FOUND-DEPTH-001` | For every screen in the reference set, removing all shadows leaves the elevation order readable from position, overlap, contrast and scale. |
| `AC-FOUND-DEPTH-002` | Occlusion order, hit-testing order, focus order and accessibility order agree for every overlay in the reference set. |
| `AC-FOUND-DEPTH-003` | No critical indicator is covered by any app surface at any frame of the safety reference flow. |
