---
id: FW-README
title: Framework — Composition, Tokens and Adaptation
kind: framework
entity: _framework
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [CANON-LAWS, CANON-TIMELESSNESS, DOC-SYSTEM, APP-STANDARD, FW-RUNTIME-SURFACE]
acceptance: [AC-FW-001, AC-FW-002, AC-FW-003]
---

# Framework — Composition, Tokens and Adaptation

> The framework is the grammar between an app's intent and a renderer's pixels. It owns
> composition, semantics, tokens and adaptation. It does not own the domain, the output, or
> the still.

---

## 1. What this subtree is

`03-framework/` specifies the **shared UI construction layer** used by every app, shell
surface and envelope in the Naledzi corpus. It answers five questions:

| Question | Directory |
|---|---|
| How does a frame get built, scheduled, measured, drawn and committed? | [`runtime/`](runtime/README.md) |
| What are the reusable parts, and what must each one do in every state? | [`components/`](components/README.md) |
| What are the named values from which every visual decision is made? | [`tokens/`](tokens/README.md) |
| How does a person find and invoke any command from anywhere? | [`palette/`](palette/README.md) |
| How does one composition become a watch, a phone, a TV, a car or a browser? | [`adaptivity/`](adaptivity/README.md) |
| How is the implementation written so it remains portable and honest? | [`rust/`](rust/README.md) |

The framework is **not** an app framework in the "batteries included" sense. It has no
domain model, no router policy, no persistence, no network stack and no window manager. It
is the smallest layer that makes two independently built apps behave identically.

---

## 2. Authority and boundaries

Three authorities meet here. They must not silently disagree.

| Fact | Authority | Framework's obligation |
|---|---|---|
| What the interface must mean and do | This corpus | Implement the normative statements; cite their IDs. |
| What a surface, buffer, event or capability actually is | `protocol/schemas/*.capnp` and the MirUI surface API | Consume the contract as given; never invent a field or an event. |
| What the current implementation does | The tree, with `file:line` | Record divergence as a gap, not as a design. |

The framework **MUST NOT** define a second scene graph, a second layout engine, a second
theme, a second scheduler or a second event loop. MirUI owns rendering, the ECS, flex
layout, text shaping, input delivery and damage submission. The framework owns:

1. the semantic component model and its state vocabulary;
2. the semantic token system and its resolution into MirUI styles;
3. composition rules (regions, panels, overlays, scroll and focus order);
4. the accessibility semantic tree and its adapter boundary;
5. adaptation rules that map available constraints to a composition;
6. the command model shared by the palette, shortcuts and menus.

### 2.1 The implementation baseline

The behavioural baseline for this subtree is the Smart UI Framework Specification v2.0
(21 October 2026, "Smart Foundation") where it does not conflict with this corpus. That
document is a **target specification**, not a claim about MirUI. MirUI 0.51.0 is the
current rendering substrate and is cited by `file:line` throughout `runtime/`. Where the
baseline requires something MirUI does not provide, the gap is named in
[`runtime/11-acceptance.md`](runtime/11-acceptance.md) and in the relevant component's
`08-failure.md`.

### 2.2 Verified substrate limits

The following are facts about MirUI 0.51.0 as vendored at
`~/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/mirui-0.51.0`. They are constraints,
not preferences.

| Limit | Evidence | Consequence |
|---|---|---|
| Flex layout only; no grid primitive | `src/ui/layout/node.rs:7`–`46` enumerates direction, wrap, justify, align and position; `src/ui/layout/flex.rs` is the only algorithm. | Grid-like layouts are composed from nested flex rows with declared tracks, or supplied by an app-owned layout pass. No hidden third engine. |
| No layout-level right-to-left mirroring | `src/ui/layout/node.rs:48`–`67` has `left` and `top` only; no `right`, `bottom`, `start` or `end`; no direction on `LayoutStyle`. | RTL is a framework adaptation pass plus text-level bidi (`src/ui/widgets/text.rs:51`). Mirroring is specified, not assumed. |
| No accessibility semantics in the substrate | Search of `src/` for accessibility roles, ARIA or semantic trees returns no API. | The framework owns the semantic tree and the host adapter; see [`runtime/07-focus-input-and-accessibility.md`](runtime/07-focus-input-and-accessibility.md). |
| Five widget states only | `src/ui/theme.rs:33` enumerates `Enabled`, `Disabled`, `Hovered`, `Pressed`, `Error`. | Selected, focused, expanded, busy and read-only are framework states composed on top; the framework does not pretend MirUI resolves them. |
| Damage is per-entity, not inherited | `src/ui/dirty.rs:1`–`8`; `mark_subtree_dirty` exists for global changes. | Every component declares its own damage; a parent style change must explicitly mark the subtree. |
| Full-frame diff exists as a diagnostic, not the model | `src/render/partial.rs:5` `dirty_rect` compares two framebuffers. | Used for verification and fallback only. Production damage is declared. |

---

## 3. The framework model

```
        app intent (domain state, commands, selection)
                              |
                    +---------v----------+
                    |  semantic model    |  component tree, roles, states, commands
                    +---------+----------+
                              |
             +----------------+----------------+
             |                                 |
     +-------v--------+                +-------v--------+
     | token resolver |                | adaptation     |  space class, density,
     | (semantic ->   |                | pass           |  input, text scale, RTL
     |  theme value)  |                +-------+--------+
     +-------+--------+                        |
             +----------------+----------------+
                              |
                    +---------v----------+
                    | MirUI composition  |  flex layout, text, widgets, animation
                    +---------+----------+
                              |
                    +---------v----------+
                    | surface + damage   |  declared rects, flush, commit
                    +---------+----------+
                              |
                    +---------v----------+
                    | output / still     |  local, remote, multi-output
                    +--------------------+
```

The semantic model is the single source for drawing **and** for accessibility. A component
that cannot state its role, name, value, state and actions is not finished. A visual
treatment that cannot be derived from tokens is not finished. A composition that cannot be
resolved for an output's actual constraints is not finished.

---

## 4. Design laws applied to the framework

These are binding restatements of [`../00-canon/02-design-laws.md`](../00-canon/02-design-laws.md)
in framework terms. They are normative here.

| ID | Rule |
|---|---|
| `FW-LAW-001` | One fact, one owner. A component reads domain state; it never keeps a second copy of it. A checkbox reflects a value; it does not own the value. |
| `FW-LAW-002` | Declared, not detected. A component marks the rects it changed. The framework never discovers damage by diffing output. |
| `FW-LAW-003` | Idle is silent. No component schedules a frame when nothing changed. An animation is the only legitimate source of self-scheduled frames, and it settles. |
| `FW-LAW-004` | Every visible state is a still. The component state, its hit region, its accessibility node and its damage rects are committed as one versioned fact. |
| `FW-LAW-005` | Accessibility is structural. The semantic tree is derived from the same component data that draws the pixels, never scraped from them. |
| `FW-LAW-006` | No raw visual value in app or component behaviour. Every colour, spacing, radius, elevation, duration and icon size resolves through a token. |
| `FW-LAW-007` | Authority is mandatory; policy is optional. The component validates its input and preserves the user's work; placement and arbitration remain replaceable. |
| `FW-LAW-008` | Honest absence. A missing value renders as `NOT REPORTED` with a reason; it is never replaced by a plausible default. |

---

## 5. Component derivation: primitives, not a widget catalogue

A component exists here only if it implements an **interaction primitive** that a timeless
human job requires. The derivation is:

```
human job -> interaction primitive -> semantic component -> rendering recipe
```

A device, a legacy app or a vendor catalogue is never the starting point. The test is in
[`../00-canon/01-timelessness-test.md`](../00-canon/01-timelessness-test.md).

### 5.1 The eight primitives

| Primitive | What the person does | Components that implement it |
|---|---|---|
| **Commit** | Cause one bounded effect now | button, icon-button, toggle-button, split-button, menu-button, link |
| **Enter** | Put a value into the system | text-field, text-area, search-field, number-field, secure-field, select, combo-box, checkbox, radio-group, switch, slider, date-time-field |
| **Locate** | Find a thing or a place | navigation-rail, navigation-list, breadcrumb, tree-view, section-set, segmented-control, command-palette |
| **Survey** | Compare many things | list, list-row, data-grid, card, badge |
| **Arrange** | Change the shape of the workspace | app-root, header-bar, tool-bar, split-view, panel, scroll-area |
| **Disclose** | Reveal secondary content without leaving | accordion, popover, menu, context-menu, tooltip, sheet |
| **Decide** | Resolve one blocking question | dialog, confirmation-prompt |
| **Report** | Know what the system is doing | status-message, banner, inline-error, progress-indicator, loading-placeholder, empty-state |

`panel`, `card` and `scroll-area` are containers; they have no command of their own but
carry layout, focus and accessibility obligations like any interactive part.

### 5.2 Rejected as components

The following were considered and rejected. They are recorded here so a later agent does not
re-add them by habit.

| Candidate | Rejection |
|---|---|
| Tab bar as a primitive | A tab bar is one rendering of **section-set**. The primitive is a set of peer sections, rendered as rail, tabs, segmented control, list or crown scroll. |
| Floating action button | Duplicates a visible primary action and occupies content. A primary action belongs to the action region. |
| Hamburger menu as default navigation | Hides all destinations on wide screens. Navigation adapts by space class; it does not collapse by habit. |
| Tooltip as the only explanation of an icon | Hover-only and inaccessible. An icon-only control MUST have an accessible name; a tooltip is supplementary. |
| Toast as the only error channel | Transient, easily missed, not focusable. Errors use inline-error or banner; status-message is for non-blocking confirmation. |
| Carousel | Hides content and competes for attention. Use a list, grid or explicit paging surface with declared controls. |
| Stepper/wizard chrome | A multi-step form is a flow, not a component. Progress and navigation are composed. |
| Skeleton as a permanent state | A placeholder MUST resolve or become an honest error. A skeleton that never resolves is a lie. |

### 5.3 The inventory

Fifty components, each with its own directory and the standard ten files. See
[`components/README.md`](components/README.md) for the file contract and the full table.

| Group | Components |
|---|---|
| Action (6) | button, icon-button, toggle-button, split-button, menu-button, link |
| Entry (12) | text-field, text-area, search-field, number-field, secure-field, select, combo-box, checkbox, radio-group, switch, slider, date-time-field |
| Structure (12) | app-root, header-bar, tool-bar, navigation-rail, navigation-list, section-set, segmented-control, split-view, panel, scroll-area, list, list-row |
| Data (6) | data-grid, card, tree-view, breadcrumb, accordion, badge |
| Overlay (8) | dialog, sheet, popover, menu, context-menu, tooltip, command-palette, confirmation-prompt |
| Feedback (6) | status-message, banner, inline-error, progress-indicator, loading-placeholder, empty-state |

`command-palette` is specified twice on purpose: [`palette/`](palette/README.md) owns its
model, ranking and command semantics; [`components/command-palette/`](components/command-palette/README.md)
owns its parts, states and input contract. Neither may contradict the other; the palette
subtree wins for ranking, the component subtree wins for structure.

---

## 6. The cross-cutting state vocabulary

Every interactive component declares all of the following. A state that cannot occur is
`n/a — <reason>`, never omitted.

| State | Meaning | Minimum obligation |
|---|---|---|
| default | Nothing special is true | Resting appearance, correct role and name |
| hover | A precise pointer is over the target | Visible but not required to understand the control |
| focus | The control owns keyboard focus | A visible focus indicator meeting 3:1 against adjacent colours |
| focus-visible | Focus arrived by keyboard/remote, not pointer | Same indicator; pointer focus MAY be quieter |
| pressed | An activation is in progress | Immediate feedback; cancel on pointer leave/escape |
| selected | The control represents a chosen item | Visual + semantic selected state, not colour alone |
| checked | A binary value is on | Visual + semantic checked state |
| expanded | Disclosed content is open | `aria-expanded` equivalent and a stable region id |
| disabled | The action cannot run now | Non-interactive, still named, reason available |
| read-only | The value is visible but not editable | Selectable and copyable; not announced as disabled |
| loading / pending | Work is in flight | Stable layout, no duplicate submission, cancel if cancellable |
| error / invalid | The value or operation failed | Message reachable, linked to the field, not colour alone |
| empty | There is no content to show | Explain why and what can be done |
| reduced motion | The person asked for less movement | Remove or shorten non-essential motion; keep state change |
| high contrast | The person asked for stronger separation | Boundaries and focus remain visible; no reliance on tint |
| 200% text | Text is enlarged to twice the base size | No clipping, no loss of function, reflow |
| RTL | The reading direction is right-to-left | Mirror layout and gesture direction; do not mirror icons with intrinsic direction |
| long content | Labels, values or lists exceed the nominal size | Declared truncation, wrapping or scrolling; full value reachable |
| remote / d-pad | Focus moves by discrete direction | Every action reachable; focus never trapped |
| screen reader | The semantic tree is the only output | Name, role, value, state, action and announcements are correct |

---

## 7. Composition rules

These apply to every component and app composition.

1. **One primary intent per frame.** A component may expose one primary action; secondary
   actions are quieter. A component never creates a second primary.
2. **Regions before widgets.** Apps compose the six regions of
   [`../05-apps/_standard/01-anatomy.md`](../05-apps/_standard/01-anatomy.md); components
   fill them. A component does not invent system chrome.
3. **Elevation is semantic.** `base`, `raised`, `floating`, `overlay`, `system` are the only
   levels. A component declares one and animates between them with a spring.
4. **Overlays are transient.** Dialog, sheet, popover, menu and palette trap focus only
   while modal; a non-modal popover does not steal focus.
5. **Focus order follows reading order** in the resolved direction, then visual order. It is
   declared per composition, not inferred from tree insertion order.
6. **Scroll is declared.** None, vertical, horizontal, two-axis or paged. Nested scrolling
   on the same axis is forbidden.
7. **Density changes rhythm, not architecture.** Compact, comfortable and spacious change
   spacing and secondary-action visibility; they never hide a primary action or a field.
8. **Text scale is not zoom.** At 200% text, containers reflow; the interface does not
   become a scaled screenshot.
9. **No component owns a fact.** A component may own transient presentation state (hover,
   press, open) and must not own domain state.
10. **No component talks to a peer by name.** Components compose through declared slots and
    commands; they do not reach into another component's internals.

---

## 8. How to read this subtree

1. [`runtime/README.md`](runtime/README.md) — the execution model and its verified limits.
2. [`tokens/README.md`](tokens/README.md) — naming, resolution and the complete token index.
3. [`adaptivity/README.md`](adaptivity/README.md) — space classes and composition rules.
4. [`components/README.md`](components/README.md) — the component contract and inventory.
5. [`palette/README.md`](palette/README.md) — the universal command surface.
6. [`rust/README.md`](rust/README.md) — implementation standards.
7. The component you need, then its `02-states.md`, `05-accessibility.md` and
   `09-acceptance.md` before writing code.

---

## 9. Sources

These sources are cited normatively in this subtree. Each was opened during authoring;
access date is 2026-10-22.

| Source | Use here |
|---|---|
| W3C, *Web Content Accessibility Guidelines (WCAG) 2.2*, W3C Recommendation, 12 December 2024, <https://www.w3.org/TR/WCAG22/> | Contrast, focus, target size, reflow, text scaling, motion. |
| W3C ARIA Authoring Practices Guide (APG), <https://www.w3.org/WAI/ARIA/apg/> | Role and keyboard patterns for composite components. |
| W3C Design Tokens Community Group, *Design Tokens Format Module 2025.10*, Final Community Group Report, 28 October 2025, <https://www.w3.org/community/reports/design-tokens/CG-FINAL-format-20251028/> | Token file format, `$type`, aliases, groups. |
| Fitts, P. M., "The information capacity of the human motor system in controlling the amplitude of movement", *Journal of Experimental Psychology* 47(6), 1954, pp. 381–391. | Target size and edge placement. |
| Miller, G. A., "The magical number seven, plus or minus two", *Psychological Review* 63(2), 1956, pp. 81–97. | Chunking limits in menus, palettes and forms. |
| Hick, W. E., "On the rate of gain of information", *Quarterly Journal of Experimental Psychology* 4(1), 1952, pp. 11–26. | Choice count and decision latency. |
| Nielsen, J., "Response Times: The 3 Important Limits", Nielsen Norman Group, 1993 (updated 2014), <https://www.nngroup.com/articles/response-times-3-important-limits/> | Feedback and progress thresholds. |
| Apple, *Human Interface Guidelines*, <https://developer.apple.com/design/human-interface-guidelines/> | Prior art for platform conventions; not authority. |
| Google, *Material Design 3*, <https://m3.material.io/> | Prior art for state layers and adaptive layout; not authority. |
| Microsoft, *Fluent 2 Design System*, <https://fluent2.microsoft.design/> | Prior art for accessible focus and density; not authority. |
| MirUI 0.51.0 source, crate registry path recorded in §2.2 | Runtime behaviour, cited by `file:line`. |

The Smart UI Framework Specification v2.0 (21 October 2026) is an internal baseline, not an
external source.

---

## 10. Open questions

| ID | Question | Owner | Needed by |
|---|---|---|---|
| `FW-Q-001` | Bundled font families are not yet selected or licensed. Until they are, the type tokens name roles and a fallback chain, not families. | Type Guild | Before first visual conformance run |
| `FW-Q-002` | The accessibility adapter's host contract does not exist in `protocol/schemas/`. The semantic tree in `runtime/07` is a framework proposal pending a wire contract. | Protocol Guild + Accessibility Guild | Before any screen-reader acceptance claim |
| `FW-Q-003` | MirUI has no grid primitive. Whether the framework supplies a track-composition helper or apps compose flex rows is undecided. Current rule: compose, do not fork the layout engine. | Framework Guild | Before `data-grid` implementation |
| `FW-Q-004` | RTL layout mirroring is a framework pass with no substrate support. The pass is specified; its performance cost is unmeasured. | Framework Guild + i18n | Before RTL conformance |
| `FW-Q-005` | The derived app portfolio (`05-apps/00-portfolio/`) was absent at authoring time. Component coverage is therefore justified by primitives and jobs, not by a confirmed app list. Re-check coverage when the portfolio lands. | Canon Editor | Portfolio review gate |

---

## 11. Acceptance

| ID | Requirement | Evidence |
|---|---|---|
| `AC-FW-001` | Every directory named in §1 exists and every declared file is present, or its absence is declared with a reason. | Tree audit against this README. |
| `AC-FW-002` | Every component in §5.3 has a directory with the ten standard files and no file is a stub. | Component manifest audit; word count and section audit. |
| `AC-FW-003` | No normative statement in this subtree names a raw colour, radius, duration or pixel value outside `tokens/`. | Grep for hex colours and numeric visual values outside `tokens/`; manual review of exceptions. |
| `AC-FW-004` | Every claim about MirUI behaviour cites `file:line` in the vendored 0.51.0 source. | Citation audit. |
| `AC-FW-005` | Every component declares all states in §6 or marks them `n/a` with a reason. | State-matrix audit across all fifty components. |
| `AC-FW-006` | Every component has a semantic role, accessible name rule, focus rule and announcement rule. | Accessibility audit. |
| `AC-FW-007` | Every component's acceptance file names at least one test that a second implementation could run. | Second-implementation review. |
| `AC-FW-008` | All open questions have an owner and a deadline. | Open-question audit. |
