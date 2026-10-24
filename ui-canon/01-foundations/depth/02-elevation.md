---
id: FOUND-DEPTH-ELEV-02
title: Elevation
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-SPACE-01, LAW-007, LAW-010]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-020, AC-FOUND-DEPTH-021, AC-FOUND-DEPTH-022]
---

# Elevation

> A level is a promise about interaction, not a shadow size. If a surface says E3, it owns
> focus, it blocks what is behind it, and it can be dismissed.

---

## 1. The five levels

| Level | Token | Name | Interaction meaning | May contain | Must not contain |
|---|---|---|---|---|---|
| E0 | `TOK-DEPTH-ELEV-0` | Base | Inline content and the page plane. No focus trap. | Text, media, lists, canvases, maps, forms | A modal, a system alert, a floating control |
| E1 | `TOK-DEPTH-ELEV-1` | Raised | A grouped unit that belongs to the page but is visually separable. | Cards, list rows, inline panels, tiles | A focus-owning overlay |
| E2 | `TOK-DEPTH-ELEV-2` | Floating | A transient surface anchored to a trigger or pointer. | Popovers, tooltips, menus, drag previews | A surface that must block the whole app |
| E3 | `TOK-DEPTH-ELEV-3` | Overlay | A surface that temporarily owns the task and blocks the content behind it. | Dialogs, sheets, command palette, full-screen pickers | A safety warning that must survive app failure |
| E4 | `TOK-DEPTH-ELEV-4` | System | The system speaking: alerts, permission prompts, critical indicators, safety warnings. | Alerts, permission prompts, safety banners, protected indicators | App content, decorative panels, advertising |

The levels are ordered by **interaction authority**, not by visual size. E4 is not "bigger"
than E3; it is outside app control.

---

## 2. Level assignment rules

- **FOUND-DEPTH-050.** Every surface MUST declare exactly one level. A surface that changes
  level during an interaction MUST declare the transition and its trigger.
- **FOUND-DEPTH-051.** A surface MUST NOT be placed at a level above its interaction
  authority. A tooltip is E2 even if it looks large. A modal is E3 even if it looks small.
- **FOUND-DEPTH-052.** A child surface MUST be at the same level or one level above its
  parent, never below it. A popover inside a dialog may be E3 or E4; it may not be E2.
- **FOUND-DEPTH-053.** E3 and E4 MUST block pointer and focus access to everything below
  them, except for declared pass-through regions. A visual scrim without input blocking is a
  lie.
- **FOUND-DEPTH-054.** E4 MUST be rendered by the system plane, not by an app surface. An app
  may request an E4 alert through a capability; it may not draw one itself.
- **FOUND-DEPTH-055.** E0 MUST NOT cast a shadow. The base plane receives shadows; it does
  not have one.
- **FOUND-DEPTH-056.** A surface MUST NOT use elevation to indicate selection, emphasis or
  brand. Selection is a state; emphasis is typography and colour; brand is identity. Elevation
  is hierarchy.

---

## 3. What each level feels like

### E0 — Base

The page plane. It is where reading and direct manipulation happen. It has no shadow and no
offset. It may be textured, but the texture must not compete with text. E0 is the reference
against which every other level is measured.

Removal consequence: if E0 is removed, there is no page. It is the floor of the model.

### E1 — Raised

A card or row that belongs to the page but is a unit. It is raised by a contact shadow, a
small tonal separation and, where useful, a 1 px boundary. It does not block the page; the
person can still scroll the page around it.

Removal consequence: if E1 is removed, grouped content collapses into undifferentiated
lists. The grouping must then be carried by spacing and headings; if it cannot be, the
grouping was not real.

### E2 — Floating

A transient surface that is anchored to something. A menu, a tooltip, a popover, a drag
preview. It is above the page but not modal: the person can dismiss it by moving away,
pressing Escape, or acting outside it. It must not steal focus unless it contains a control
that requires focus.

Removal consequence: if E2 is removed, anchored actions must move inline or into a sheet.
That is a real layout change, not a shadow change.

### E3 — Overlay

A surface that temporarily owns the task. A dialog, a sheet, a command palette, a picker. It
has a scrim, a focus trap, an explicit dismiss path and a return focus target. It must be
interruptible by the system (an incoming call, a safety alert) without losing its state.

Removal consequence: if E3 is removed, the task must become a full-screen state or an inline
expansion. The choice changes navigation history and back behaviour, so it must be specified.

### E4 — System

The system speaking. An alert, a permission prompt, a critical indicator, a safety warning.
It is not owned by the app, cannot be covered by app content, and must remain legible under
glare, vibration and reduced vision. It may interrupt. It must be dismissible only by a
declared action; a safety warning may not be dismissible while the condition holds.

Removal consequence: if E4 is removed, the system has no way to tell the truth about a
condition that the app cannot hide. That is a safety failure, not a visual one.

---

## 4. Level transitions

A surface may change level. The change must be a state transition, not an animation trick.

| From | To | Trigger | Behaviour |
|---|---|---|---|
| E1 | E2 | The person opens an anchored menu | The menu appears at E2; the E1 surface stays put; focus moves into the menu |
| E2 | E3 | The person chooses "expand" | The anchored surface becomes modal; focus is trapped; a scrim appears |
| E3 | E4 | A safety condition occurs | The system alert appears above the dialog; the dialog stays but loses input; focus moves to the alert |
| E3 | E1 | The person closes the dialog | Focus returns to the invoking E1 or E0 element; the scrim is removed in the same still |
| E4 | E3 | The condition clears and the person dismisses | Focus returns to the previous E3 surface if it still exists; otherwise to a declared fallback |

- **FOUND-DEPTH-060.** A level transition MUST preserve the underlying surface's state. A
  dialog that closes because an alert appeared must reopen with the same content and focus.
- **FOUND-DEPTH-061.** A level transition MUST NOT animate through a state in which the
  destination is invisible while the source is gone. There is always a still in which one of
  them is present.
- **FOUND-DEPTH-062.** Focus MUST move with the level. An E3 surface that appears without
  focus moving into it is a trap for keyboard and screen-reader users.

---

## 5. Elevation and the safety envelopes

EV and spaceship add one constraint: **critical indicators are E4 and protected**.

- A critical indicator has a protected zone declared in the envelope. No app surface, sheet,
  dialog, notification or animation may occupy that zone.
- A critical indicator never rises from below another surface. It is always present at E4, or
  it is absent with an explicit "not reported" state.
- A warning may not be dismissed by a gesture that also dismisses an app surface.
- A warning may not use a spring that overshoots into another element.

- **FOUND-DEPTH-070.** In EV and spaceship envelopes, a critical indicator MUST occupy a
  declared protected zone at E4 for the whole time the condition holds.
- **FOUND-DEPTH-071.** A critical indicator MUST NOT be occluded, blurred, dimmed or moved by
  any app transition.
- **FOUND-DEPTH-072.** If the protected zone cannot be drawn (display failure, non-rectangular
  cut-out, remote degradation), the system MUST fall back to the declared redundant indicator
  (audio, haptic, secondary display) and state which indicator is unavailable.

---

## 6. Anti-patterns

| Anti-pattern | Why it fails | Correct model |
|---|---|---|
| Every card has a different shadow | Shadow becomes decoration and loses meaning | One E1 recipe; group with spacing and headings |
| A modal with no scrim | Occlusion and input blocking disagree | E3 with scrim and focus trap |
| A tooltip at E4 | App content pretends to be the system | E2 tooltip; E4 only for system messages |
| A drawer that is sometimes E2 and sometimes E3 | The interaction meaning changes without a state change | Declare the transition and its trigger |
| A "floating action button" at E4 | Permanent chrome with system authority | E2 if transient, E1 if part of the page; justify permanence under `LAW-010` |
| A safety warning inside an app card | The app can cover its own warning | E4 protected zone, system-owned |

---

## 7. Measurement

Elevation is verified by four independent observations:

1. **Occlusion:** the higher surface hides the lower one at the shared boundary.
2. **Shadow:** the shadow falls on the lower surface, in the declared direction.
3. **Tone:** the higher surface differs from the lower one by the declared tonal step.
4. **Interaction:** the higher surface receives input first and owns focus according to its
   level.

A surface that satisfies three of four is non-conformant. The four observations are recorded
in the same still (`LAW-005`).

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-020` | For every surface in the reference set, exactly one level is declared and the four observations agree. |
| `AC-FOUND-DEPTH-021` | Open an E2 menu, expand it to E3, trigger an E4 safety alert, clear it, and close the dialog. Focus and underlying state are preserved at every step. |
| `AC-FOUND-DEPTH-022` | In the EV reference flow, no app surface intersects the protected zone at any frame; the indicator remains at E4 and is announced. |
| `AC-FOUND-DEPTH-023` | A tooltip declared at E4 is rejected by the conformance check. |
