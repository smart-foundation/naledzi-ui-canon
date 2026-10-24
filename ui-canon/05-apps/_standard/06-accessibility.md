---
id: APP-A11Y
title: Structural Accessibility
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Accessibility Guild
depends: [APP-STANDARD, LAW-009]
acceptance: [AC-APP-STANDARD-011]
---

# Structural Accessibility

> Accessibility is not a mode. It is the same model, exposed. If the semantic tree is not
> derived from the thing that draws the screen, it is already stale.

---

## 1. The principle

Every component declares:

- **role** — what it is;
- **name** — what it is called;
- **description** — what it does, when the name is not enough;
- **value** — its current value, if any;
- **state** — selected, checked, expanded, busy, disabled, invalid;
- **actions** — what can be done to it;
- **geometry** — its bounds in the output's coordinate space;
- **relationships** — label, description, error, controls, owns, flows-to.

These are not added after rendering. They are the same data the component uses to draw.
They ride the numbered still (`LAW-005`, `LAW-009`).

---

## 2. Roles

Use the platform's semantic roles, mapped to the contract's accessibility vocabulary. The
canonical set:

`application`, `window`, `dialog`, `sheet`, `alert`, `status`, `toolbar`, `menu`, `menuitem`,
`button`, `toggle`, `link`, `text`, `heading`, `paragraph`, `list`, `listitem`, `table`,
`row`, `cell`, `tree`, `treeitem`, `textfield`, `searchfield`, `combobox`, `checkbox`,
`radio`, `radiogroup`, `slider`, `progressbar`, `tablist`, `tab`, `tabpanel`, `separator`,
`image`, `canvas`, `video`, `audio`, `group`.

Rules:

- A `div` with a click handler is not a button. Use the role and the keyboard behaviour.
- A heading is a heading, not bold text.
- A list is a list, not a stack of divs.
- A table has rows, columns and headers, or it is a grid with a declared navigation model.
- A canvas exposes its interactive children as semantic nodes, not a single opaque image.

---

## 3. Focus

### 3.1 Focus order

Every flow specifies the focus order. It follows reading order and task order, not DOM order
by accident.

- Focus starts at the primary content or the first meaningful control.
- Focus never starts on a destructive action.
- Focus is visible on keyboard and remote; it is not hidden for aesthetics.
- Focus traps only in modal layers; non-modal layers do not trap.
- Focus returns to the invoking control when a layer closes.
- Focus is never lost when content changes; if the focused item disappears, focus moves to
  the nearest logical survivor and the move is announced.

### 3.2 Focus and scrolling

- Focusing an off-screen item scrolls it into view without jumping the page.
- A sticky header never covers the focused item.
- A focused item is never behind the on-screen keyboard.

### 3.3 Focus and envelopes

- Watch: crown focus, one item at a time.
- TV: directional focus, always visible, with a clear path back.
- EV: focus is secondary to safety; critical indicators are not in the focus ring.
- Spaceship: focus is explicit and never times out silently.

---

## 4. Announcements

| Event | Announcement | Priority |
|---|---|---|
| Screen/app opened | "Calculator, ready" | polite |
| Content loaded | "12 results" | polite |
| Empty | "No files. Create a file." | polite |
| Error | "Could not save. Storage is full. Free space and try again." | assertive |
| Denied | "Camera access denied. Allow it in Settings." | assertive |
| Selection changed | "3 selected" | polite |
| Progress | "Saving, 40 percent" at meaningful intervals | polite |
| Operation complete | "Saved" | polite |
| Destructive confirmation | "Delete 3 files? This cannot be undone." | assertive |
| Warning | "Battery low. 5 percent." | assertive |
| Safety alert | the full alert, repeated per protocol | assertive |

Rules:

- Do not announce every tick. Announce meaningful changes.
- Do not interrupt the user for polite events during typing or speech.
- Assertive announcements are reserved for errors, safety and destructive decisions.
- Every icon-only control has a name.
- Every error message is announced with its resolution.
- A status change that is visual-only is a defect.

---

## 5. Adaptation

### 5.1 Vision

- Text scaling to 200% without loss of content or function.
- High-contrast mode; contrast ≥ 4.5:1 for text, ≥ 3:1 for large text and UI.
- Colour is never the only carrier of meaning.
- Focus ring is visible in every theme and material.
- Reduced transparency: materials become opaque.
- Reduced motion: springs become short fades or instant; parallax is disabled.

### 5.2 Motor

- Target size ≥ 44×44 CSS px (or the envelope's declared equivalent) for touch.
- No path requires precise timing, rapid repeated input or a drag as the only option.
- Switch access: every action is reachable by sequential focus and activation.
- Sticky keys / one-handed operation supported.
- Capture leases do not require holding a button for an unbounded time.

### 5.3 Hearing

- Every audio cue has a visual equivalent.
- Captions and transcripts for media.
- Visual and haptic alarms in safety envelopes.
- No critical information is audio-only.

### 5.4 Cognitive

- Plain language; one idea per sentence.
- Consistent placement and naming.
- Progressive disclosure; no memory-only steps.
- Errors name the fix.
- Time limits are adjustable or absent.
- No flashing above 3 Hz.

### 5.5 Speech and language

- Screen reader works in every locale.
- RTL layout mirrors structure, not icons that encode direction.
- Non-Latin scripts render with correct shaping.
- Numerals and dates are localized for display; canonical for storage.

---

## 6. The transcript

Every app provides at least one **screen-reader transcript** for a golden flow:

```text
> Open Calculator
Calculator, ready. Display: 0. Focus: 7.
> 7
7
> plus
Plus.
> 8
8
> equals
15. Focus: equals.
```

The transcript is an acceptance artifact, not documentation decoration. It proves the flow
is possible without sight.

---

## 7. Common failures

- A clickable `div` with no role, no keyboard handler and no name.
- A custom control that does not implement the keyboard behaviour of its role.
- A modal that does not trap focus, or a non-modal that does.
- A focus ring removed "because it looks bad".
- An icon-only button with no accessible name.
- A toast that is not announced.
- A colour-only error state.
- A canvas with no semantic children.
- A drag-only reorder with no keyboard alternative.
- A time limit with no extension.
- A screen reader announcement on every animation frame.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-APP-A11Y-001` | Every interactive element has a role, name, state and action. |
| `AC-APP-A11Y-002` | Every flow has a focus order and a transcript. |
| `AC-APP-A11Y-003` | The core flow completes with keyboard only. |
| `AC-APP-A11Y-004` | The core flow completes with a screen reader. |
| `AC-APP-A11Y-005` | The core flow completes without colour. |
| `AC-APP-A11Y-006` | Text scales to 200% without loss. |
| `AC-APP-A11Y-007` | Reduced motion, reduced transparency and high contrast are honored. |
| `AC-APP-A11Y-008` | No critical information is audio-only or visual-only. |
| `AC-APP-A11Y-009` | Target sizes meet the envelope's minimum. |
| `AC-APP-A11Y-010` | No flashing above 3 Hz; no unavoidable time limit. |
