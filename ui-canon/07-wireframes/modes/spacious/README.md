---
id: WF-SPACIOUS-INDEX
title: Spacious Density Mode — Wireframes and Frames
kind: wireframe
entity: spacious
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, PROC-COMPLETENESS, PROC-APPEND-ONLY, UX-RESEARCH-INDEX, UX-SPACIOUS, FOUND-EXPERIENCE-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, FOUND-COLOR-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-WF-SPACIOUS-000, AC-WF-SPACIOUS-001, AC-WF-SPACIOUS-002, AC-WF-SPACIOUS-003]
children:
  - 01-principles.md
  - 02-frames.md
  - 03-adaptation.md
  - 04-acceptance.md
---

# Spacious Density Mode — Wireframes

> Spacious is a **density mode**, not a theme. It changes spacing, the number of visible
> actions and the calmness of the hierarchy. It does not change meaning, colour roles,
> depth semantics, motion grammar, the state machine, the wording or the acceptance
> criteria. A screen in spacious density and the same screen in compact density are the
> same state, drawn at different density. If they differ in behaviour, one of them is
> wrong.

**Scope.** The spacious rendering of every OS frame — boot, home, app, settings, palette,
notifications, fullscreen and the rare-case set — across the seven envelopes that can
legitimately run spacious density: watch, phone, tablet, desktop, TV, EV and spaceship.
IoT, spatial and remote-browser envelopes follow the same rules but are specified in
their own envelope directories and linked here.

**Non-goals.** A skin, a theme, a "large print" mode, a separate information
architecture, or any frame that exists only because spacious "looks calmer". If a frame
cannot be derived from the compact frame by the adaptation rules in `03-adaptation.md`,
it is not spacious, it is a fork, and it is rejected.

---

## 1. What spacious is

Spacious is one of two density modes in Naledzi. The other is **compact**. Density is a
property of a **surface at a moment**, not of a device and not of a person. A phone in
spacious density and the same phone in compact density are the same phone; the person
switches density, or the system switches it by rule, and nothing else changes.

Spacious exists because some moments reward fewer, larger, calmer things on screen:
reading, reviewing, one-handed use, fatigue, low vision, glare, vibration, high stress,
and any moment where the cost of a mis-tap is high. Compact exists because some moments
reward density: high throughput, expert use, multi-window, small screens. Neither is
the default for a device. Both are available on every device, and the system chooses by
rule and by declaration, never by fashion.

---

## 2. Directory map

| File | Question it answers |
|---|---|
| [01-principles.md](01-principles.md) | What is spacious, what changes, what never changes, and how does it degrade? |
| [02-frames.md](02-frames.md) | What does every OS frame look like in spacious density, on every envelope? |
| [03-adaptation.md](03-adaptation.md) | How does spacious adapt per envelope, and how does it overflow to compact? |
| [04-acceptance.md](04-acceptance.md) | How is spacious proved? |

---

## 3. Dependency and ownership

| Fact | Owner | Consumers |
|---|---|---|
| Spacious token set (spacing, target size, visible-action count) | This subtree + `03-framework/tokens/` | Components, shell, apps, envelopes |
| Density selection (spacious vs compact) | System settings + envelope rules + this subtree | Shell, apps, framework adaptivity |
| Degradation rule (spacious → compact) | This subtree | Envelope adaptation, settings |
| Spacious frames | This subtree | Wireframe consumers, implementers |
| Calm hierarchy rules | This subtree + `01-foundations/depth/` | Components, shell |

This subtree does not own colour, depth levels, motion tokens, typography scales or
component anatomy. It owns the density at which those things are composed.

---

## 4. The density contract

1. **WF-SPACIOUS-001.** Spacious MUST be selectable per surface and per session, and
   MUST be reversible without data loss or state change.
2. **WF-SPACIOUS-002.** Spacious MUST NOT change the state machine, the command IDs, the
   error wording, the accessibility semantics or the acceptance criteria of any screen.
3. **WF-SPACIOUS-003.** Spacious MUST increase spacing, reduce the number of visible
   actions and calm the hierarchy, in that priority order.
4. **WF-SPACIOUS-004.** Spacious MUST NOT hide a primary action. An action that is
   primary in compact is primary in spacious; it is simply larger and more isolated.
5. **WF-SPACIOUS-005.** Spacious MUST degrade to compact by the declared rules in
   `03-adaptation.md`, never by opinion, never silently.
6. **WF-SPACIOUS-006.** Spacious MUST preserve every piece of content. Content that
   does not fit is re-flowed, collapsed into a sheet, paged, or moved to a peer surface
   — never dropped.
7. **WF-SPACIOUS-007.** Spacious MUST meet or exceed the compact mode's accessibility
   floor (WCAG 2.2 AA; 24 × 24 CSS px targets at AA, 44 × 44 at AAA) and MUST NOT
   reduce contrast, focus visibility or screen-reader completeness.
8. **WF-SPACIOUS-008.** Under safety envelopes (EV, spaceship), spacious MUST NOT
   override protected zones, bounded motion or procedure-first rules. Safety wins over
   density.

---

## 5. What is intentionally absent

| Item | Reason |
|---|---|
| A separate spacious theme | `n/a — spacious is a density mode; colour and depth semantics are unchanged (LAW-007, LAW-019).` |
| A spacious-only component set | `n/a — components adapt by density token; there is no parallel catalogue (LAW-013).` |
| A spacious-only information architecture | `n/a — content and commands are identical; only composition changes.` |
| Pixel values in prose | `n/a — values live in `03-framework/tokens/` and are referenced by ID.` |
| Spacious frames for IoT, spatial and remote-browser | `n/a — those envelopes specify their own density in `06-envelopes/`; this subtree links them and states the shared rule.` |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-000` | Every file listed in `children` exists; no file contains `TODO`, an empty heading or "similar to". |
| `AC-WF-SPACIOUS-001` | Every frame in `02-frames.md` is drawn as ASCII, names state, focus, action, transition and announcement, for all seven envelopes. |
| `AC-WF-SPACIOUS-002` | Every spacious frame can be derived from the compact frame by the rules in `01-principles.md` and `03-adaptation.md`; no forked information architecture. |
| `AC-WF-SPACIOUS-003` | Spacious degrades to compact by declared rule with no content loss, verified per envelope. |
| `AC-WF-SPACIOUS-004` | Spacious meets the accessibility floor and does not reduce contrast, focus visibility or screen-reader completeness. |