---
id: APP-ENVELOPE-ADAPTATION
title: Envelope Adaptation
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Apps Guild
depends: [APP-ANATOMY, APP-STANDARD]
acceptance: [AC-APP-STANDARD-009]
---

# Envelope Adaptation

> One app, many devices. The need and the grammar stay. The composition changes. Content is
> never lost; it is re-flowed, collapsed, paged or moved to a peer region.

---

## 1. The adaptation ladder

When space, input or power changes, adapt in this order. Do not skip a step.

1. **Re-flow** — change the arrangement of the same regions and content.
2. **Collapse** — move secondary content into a sheet, popover or section.
3. **Page** — split content into sequential frames with explicit navigation.
4. **Peer** — move secondary content to a companion surface (phone ↔ watch, desktop ↔
   phone).
5. **Declare** — if a feature truly cannot exist, declare the envelope exception with a
   reason and a degraded alternative.

Never adapt by shrinking text below legibility, hiding a primary action, or silently
removing a feature.

---

## 2. The region matrix

`●` present · `◐` collapsible/conditional · `○` absent · `↗` moves to a peer

| Region | Watch | Phone | Tablet | Desktop | TV | EV | Spaceship | IoT | Remote |
|---|---|---|---|---|---|---|---|---|---|
| Identity | ● (1 line) | ● | ● | ● | ● (10-foot) | ● (zone) | ● | ○ | ● |
| Navigation | ◐ | ● | ● | ● | ● | ◐ | ● | ○ | ● |
| Content | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| Context | ○ | ◐ (sheet) | ◐ (panel) | ● | ○ | ◐ | ● | ○ | ◐ |
| Actions | ◐ (1) | ● | ● | ● | ● (focus) | ● | ● | ○ | ● |
| Status | ◐ | ● | ● | ● | ◐ | ● (critical) | ● | ● | ◐ |

Rules:

- `○` is allowed only when the region is genuinely unnecessary, not when it is inconvenient.
- `◐` must have a declared trigger and a declared return path.
- `↗` must preserve the content and the selection.
- `system` regions are never app-owned, on any envelope.

---

## 3. Per-envelope rules

### Watch

- One primary region. Context becomes a vertical card or a sheet.
- Navigation is a crown-scroll or a single back affordance.
- Actions: one primary, the rest in a crown menu or voice.
- No hover. No right-click. No multi-window.
- Text: minimum legible size at 40 mm; short labels; no dense tables.
- Every flow must work with one hand and a crown.

### Phone

- One content column; context as a bottom sheet.
- Back is a system gesture and a visible affordance.
- Actions in a bottom action region within thumb reach.
- Keyboard-aware layout; no content behind the keyboard.
- Split view on large phones; never a squeezed tablet layout.

### Tablet

- Two-pane list/detail; context as a side panel or popover.
- Pointer and keyboard supported as first-class.
- Drag and drop between apps.
- Multitasking; the app may be one of several surfaces.

### Desktop

- Multi-window; the app may have several surfaces.
- Menu / action region; the palette is the primary accelerator.
- Hover is allowed as an enhancement, never the only path.
- Keyboard is first-class; focus is visible.
- The strip and status rail are system-owned.

### TV

- 10-foot layout: large type, high contrast, focus-driven.
- Directional pad is primary; pointer is optional.
- No hover. No long text entry unless a keyboard is available.
- Back always exits or goes up one level; never traps.
- Loading and errors readable from 3 m.

### EV

- Zone-based: cluster, centre stack, HUD, rear camera.
- Critical indicators have protected zones; apps never cover them.
- No app may obscure a warning.
- Touch targets are larger; glare and vibration are assumed.
- Voice and physical controls are first-class.
- The app's `busy` state must never block a critical zone.

### Spaceship

- Deterministic timing; no unbounded animation.
- Redundancy: the app must state what happens when a display or service is lost.
- Every value has a source, a timestamp and a validity state.
- Alarms have priority and a silenced-in-error rule.
- The app must be usable with gloves, glare and high workload.
- Failure includes a procedure, not just a message.

### IoT

- Often one surface, no input, or a single button.
- The app must state its idle behaviour and its update cadence.
- No infinite retry; backoff with a ceiling.
- Headless mode is a declared state, not an accident.

### Remote browser

- Structured stills/deltas; no whole-screen VNC by default.
- Offline and reconnect are normal states.
- Input is host-authorised; the browser never gains ambient authority.
- Accessibility maps to the browser's semantic tree where possible.

---

## 4. What never changes

Across every envelope:

- the human need;
- the domain model;
- the state machine;
- the command IDs;
- the wording of errors and confirmations (translated, not rewritten);
- the accessibility semantics;
- the data ownership and capability rules;
- the acceptance criteria for behaviour.

If one of these changes, it is a different app, not an adaptation.

---

## 5. The envelope exception

When a feature cannot exist on an envelope, record it:

```markdown
### ENV-EXCEPTION-<APP>-<NN>
- **Envelope:** watch
- **Feature:** multi-column table
- **Why:** 40 mm width; no legible column set
- **Alternative:** card list with a detail sheet
- **Content preserved:** yes, all fields reachable
- **Approved by:** <role>
- **Date:** YYYY-MM-DD
```

An exception without an alternative is a scope cut. A scope cut must be approved, recorded
and visible in the app's status.

---

## 6. Adaptation test

For each envelope in scope:

1. Can the core flow be completed?
2. Is every primary action reachable?
3. Is every piece of content reachable, even if re-flowed?
4. Does the input path work with that envelope's primary input?
5. Does the performance budget pass?
6. Is the accessibility path intact?
7. Is the safety rule respected (EV, spaceship)?

If any answer is no, the adaptation is not done.
