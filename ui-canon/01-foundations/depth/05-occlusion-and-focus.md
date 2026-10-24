---
id: FOUND-DEPTH-OCCLUSION-05
title: Occlusion and Focus
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-ELEV-02, FOUND-DEPTH-SHADOW-03, LAW-005, LAW-009]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-050, AC-FOUND-DEPTH-051, AC-FOUND-DEPTH-052]
---

# Occlusion and Focus

> Occlusion is the strongest depth cue and the most dangerous one. If the drawing says one
> thing and the hit map says another, the person is living in a broken space.

---

## 1. Occlusion is truth

Occlusion is not a rendering effect. It is the statement that a surface is in front of
another. In Naledzi that statement is atomic with four other facts in the same still:

1. the pixels;
2. the hit map;
3. the accessibility snapshot;
4. input ownership and buffer lifetime.

- **FOUND-DEPTH-160.** If surface A occludes surface B, then A MUST receive pointer input
  over the shared region, B MUST NOT receive it, and the accessibility tree MUST present A as
  covering B.
- **FOUND-DEPTH-161.** A pass-through region MUST be declared explicitly. A visual hole with
  no input pass-through, or an input pass-through with no visual hole, is a defect.
- **FOUND-DEPTH-162.** Occlusion order MUST be a total order for any two surfaces that
  overlap. Ambiguous overlap (neither in front) is forbidden.
- **FOUND-DEPTH-163.** An occluded critical indicator is a safety defect, not a visual bug.

The authority validates occlusion as part of the commit. A commit whose declared order
disagrees with its hit map is rejected with a named rejection, not corrected silently.

---

## 2. Scrims

A scrim is a dimming layer that separates a modal surface from the content behind it. It is
part of the depth model, not a translucent decoration.

| Level | Scrim opacity (light) | Scrim opacity (dark) | Input | Content behind |
|---|---|---|---|---|
| E2 | 0% | 0% | Not blocked | Fully interactive |
| E3 | 32% | 40% | Blocked | Visible but inert |
| E4 | 48% | 56% | Blocked | Visible but inert |
| Safety E4 | 60% | 64% | Blocked except declared controls | Critical indicators remain legible and are never dimmed |

Rules:

- The scrim colour is a neutral token, never a brand colour.
- The scrim does not blur the content behind it unless the material is declared and the
  performance budget allows it (`06-materials.md`).
- The scrim must preserve enough contrast for the person to recognise what is behind it. It
  is a separation, not an erasure.
- The scrim must not dim a critical indicator. In safety envelopes the scrim is clipped around
  the protected zone.

- **FOUND-DEPTH-170.** An E3 or E4 surface MUST have a scrim or an equivalent declared
  separation that blocks input.
- **FOUND-DEPTH-171.** A scrim MUST NOT be used without an input block. A visual dim with live
  controls underneath is a lie.
- **FOUND-DEPTH-172.** A scrim MUST NOT reduce the contrast of text or a critical indicator
  below its threshold.
- **FOUND-DEPTH-173.** A scrim MUST be removed in the same still as the modal surface is
  dismissed. A lingering scrim is a ghost input blocker.

---

## 3. Focus dimming

Focus dimming reduces the prominence of surfaces outside the active task. It is a depth cue
and an attention cue. It is weaker than a scrim and does not block input by itself.

| Context | Dimming | What is dimmed | What is never dimmed |
|---|---|---|---|
| Active task within a page | 0-10% | Non-active regions of the same page | Text being read, critical indicators, focus ring |
| E2 menu open | 0-15% | The invoking surface and its siblings | The menu, the focus ring, critical indicators |
| E3 dialog open | 32-40% scrim | Everything behind the dialog | The dialog, critical indicators |
| E4 system alert | 48-60% scrim | Everything behind the alert | The alert, critical indicators, protected zones |
| Safety condition | 0% on the protected zone | Nothing inside the zone | The entire protected zone |

- **FOUND-DEPTH-180.** Focus dimming MUST NOT be the only indication of the active surface.
  The surface must also have a focus ring, a title, a scrim or a position change.
- **FOUND-DEPTH-181.** Focus dimming MUST NOT dim the focus ring, the active surface's text or
  any critical indicator.
- **FOUND-DEPTH-182.** Focus dimming MUST NOT change the hit map. A dimmed surface that is
  still interactive must remain visibly interactive enough to be understood.
- **FOUND-DEPTH-183.** Dimming MUST be reversible in the same still as focus moves. There is
  no frame in which both the old and the new surface are fully dimmed.

---

## 4. Focus order and occlusion

Visual order and focus order are different things, but they must not contradict.

- The focus order follows the reading order of the active level.
- When an E3 surface opens, focus moves into it and is trapped until it closes.
- When an E4 system surface appears, focus moves to it even if an E3 surface was active. The
  E3 surface keeps its internal focus so it can resume.
- When a surface is occluded but still in the accessibility tree (for example, a background
  page behind a dialog), it MUST be marked inert, not merely visually dimmed.
- A screen reader MUST NOT be able to reach an occluded control.

- **FOUND-DEPTH-190.** An occluded surface MUST be inert in the accessibility tree unless it
  is declared as a background reference with no interactive descendants.
- **FOUND-DEPTH-191.** Focus MUST move into a new E3/E4 surface in the same still in which it
  becomes visible.
- **FOUND-DEPTH-192.** Returning from an overlay MUST restore focus to the element that
  invoked it, or to a declared fallback if that element no longer exists.

---

## 5. Protected zones

A protected zone is a region of the output that no app surface may occlude, dim, blur or
animate through.

- The zone is declared by the envelope (EV, spaceship, and any envelope with a certified
  safety indicator).
- The zone has a level of E4 for the whole time the condition holds.
- The zone may contain multiple indicators; their internal order is declared by the envelope.
- The zone is part of the system plane, not an app overlay.
- The zone survives app crash, policy restart and executor fallback. If the system cannot draw
  it, the redundant indicator must be used.

- **FOUND-DEPTH-200.** A protected zone MUST be listed in the envelope's constraints with a
  rectangle or shape, a priority order and a redundant indicator.
- **FOUND-DEPTH-201.** No transition may pass a surface through a protected zone. The zone is
  a hole in the animation space, not a layer above it.
- **FOUND-DEPTH-202.** A remote or recorded output MUST preserve the protected zone or declare
  that the safety indicator is unavailable.

---

## 6. Debugging occlusion

The model provides a deterministic debug view, not a heuristic:

| View | What it shows | Who may enable it |
|---|---|---|
| Depth order | Each surface's declared level and order | Developers, with a developer capability |
| Hit map | The actual input regions, including pass-through | Developers and accessibility testers |
| Focus order | The ordered focusables per level | Developers and accessibility testers |
| Protected zones | The declared safety regions | Safety reviewers, always available in test builds |

The debug view is not a product feature. It must not be reachable by an app without a
capability, and it must not alter the still it inspects.

---

## 7. Failure

| Failure | Result | Required behaviour |
|---|---|---|
| Occlusion and hit map disagree | Clicks land on the wrong surface | Reject the commit; keep the previous still; report the culprit |
| Scrim remains after dismiss | Input blocked by an invisible layer | Remove the scrim in the same still; if it persists, the authority must reject the next commit and surface a recovery state |
| Focus trapped in a closed surface | Keyboard cannot reach the page | Move focus to the invoker or fallback; announce the recovery |
| Critical indicator occluded | Warning invisible | Safety failure; fall back to the redundant indicator and record the event |
| Protected zone shape changes | App content covers it | Recompute the zone before layout; reject any surface that intersects it |
| Accessibility tree not inert | Screen reader reads hidden content | Mark the subtree inert in the same still as the scrim |

---

## 8. What this model refuses

- A visual overlay with live controls underneath.
- A scrim that does not block input.
- A dimmed page that a screen reader can still traverse.
- A modal that does not move focus.
- A tooltip that steals focus.
- A warning that can be covered by a notification.
- A protected zone that is only a convention in the design file.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-050` | For every overlapping pair in the reference set, the declared order, hit map, focus order and accessibility order agree in the same still. |
| `AC-FOUND-DEPTH-051` | Open and close an E3 dialog. The scrim, input block, focus trap and inert background appear and disappear in the same stills. |
| `AC-FOUND-DEPTH-052` | In the EV safety flow, the protected zone is never intersected by an app surface, and the redundant indicator is exercised when the primary is unavailable. |
| `AC-FOUND-DEPTH-053` | A pass-through region is declared and both the visual hole and the input pass-through agree. |
