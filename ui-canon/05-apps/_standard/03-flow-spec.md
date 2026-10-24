---
id: APP-FLOW-SPEC
title: Flow Specification
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Apps Guild
depends: [APP-STANDARD, APP-STATE-MACHINE, DOC-SYSTEM]
acceptance: [AC-APP-STANDARD-008]
---

# Flow Specification

> A flow is the unit of design. A screen is a frame inside it. If every frame, branch and
> error is not written down, the app is not specified.

---

## 1. What a flow is

A flow is a sequence of **named frames** that takes one actor from a starting condition to a
completed goal. It includes:

- the entry points;
- the happy path, frame by frame;
- every branch;
- every error and its recovery;
- the exit and the postcondition;
- the accessibility path;
- the performance notes;
- the acceptance criteria.

A flow is not a mood board. It is a behavioural specification that a second team can
implement and a machine can test.

---

## 2. File format

```
<app>/flows/
├── README.md
├── 01-<flow>.md
├── 02-<flow>.md
└── ...
```

`flows/README.md` is the index: flow ID, goal, entry points, envelopes, status. A flow that
is not linked from the index is an orphan and a defect.

A flow file starts with:

```yaml
---
id: FLOW-CALC-01
title: Calculator — basic calculation
kind: flow
entity: calculator
status: canon
normative: true
envelopes: [watch, phone, tablet, desktop, tv, ev]
frames: 7
acceptance: [AC-CALC-001, AC-CALC-002]
---
```

---

## 3. Required sections

Every flow file contains, in this order:

```markdown
## 1. Goal
One sentence. The user's outcome, not the app's feature.

## 2. Actors and preconditions
Who, with what capabilities, starting from what state.

## 3. Entry points
Every way to reach Frame 1. Deep links, gestures, palette commands, cross-app intents.

## 4. Happy path
### Frame 1 — <name>
```text
<wireframe>
```
- **State:** the app state and substate.
- **Focus:** where focus starts.
- **Content:** what is true and visible.
- **Action:** what the user does.
- **Transition:** to which frame, under which condition.
- **Announce:** what assistive tech says.

... every frame ...

## 5. Branches
Every alternative path, named, with its own frame sequence.

## 6. Errors and recovery
Every error state, its cause, its message, its recovery or declared dead end.

## 7. Exit and postcondition
Where the user ends, what is saved, what is undone, what is left behind.

## 8. Accessibility path
The same flow with no pointer, no colour, and a screen reader. Focus order and
announcements.

## 9. Performance notes
The frames where latency matters, the budget, the degradation.

## 10. Acceptance
The AC IDs and the evidence.
```

---

## 4. Frame rules

### 4.1 Every frame is complete

A frame shows the whole relevant screen, not a fragment. If a sheet is open, the frame shows
the sheet and the dimmed base. If a keyboard is open, it shows the reduced content area. If
a toast is present, it shows the toast.

### 4.2 Every frame has a name

The name describes the state, not the picture: "Frame 3 — Amount entered, invalid operator",
not "Frame 3 — calculator screen".

### 4.3 Every frame has a focus

Focus is a first-class element. It is named even when it is not visible (touch). The
screen-reader focus and the keyboard focus are both stated.

### 4.4 Every frame has one action

The frame says what the user does next. If there are several, the frame is a branch point
and the branches are enumerated.

### 4.5 Every transition is a sentence

"Transition: on `=`, if the expression is valid, go to Frame 5. If invalid, go to Frame 6."
No arrows without conditions.

### 4.6 Every branch is enumerated

"Etc.", "and so on", "similar for other cases" are defects. If there are 12 keypad keys,
the frame says "any digit appends to the current operand" and the rule is normative. If the
branch changes the state machine, it gets a frame.

### 4.7 Every error has a recovery or a declared dead end

An error without a recovery is acceptable only if it explicitly says "no recovery; the user
must leave the app" and why.

### 4.8 Every frame is envelope-aware

If a frame differs by envelope, either:

- the flow declares one frame and the layout section defines the per-envelope rendering; or
- the flow declares separate frames for the envelopes that change the *behaviour*.

Visual differences alone do not create a frame. Behavioural differences do.

---

## 5. Wireframe grammar

Wireframes are Markdown code blocks. They are schematic, not pixel-perfect. The grammar is
in [`../../07-wireframes/00-standard.md`](../../07-wireframes/00-standard.md). Short
version:

```text
┌──────────────────────────────────────────────┐
│ IDENTITY   title                    ⋯        │
├──────────────────────────────────────────────┤
│ CONTENT                                      │
│                                              │
│  [ 7 ] [ 8 ] [ 9 ] [ ÷ ]                    │
│  [ 4 ] [ 5 ] [ 6 ] [ × ]                    │
│  [ 1 ] [ 2 ] [ 3 ] [ − ]                    │
│  [ 0 ] [ . ] [ = ] [ + ]                    │
│                                              │
├──────────────────────────────────────────────┤
│ ACTIONS   [ Clear ]            [ History ]   │
└──────────────────────────────────────────────┘
```

Rules:

- Use one box per screen region.
- Mark focus with `▸` and the focused element with `[▸ label]`.
- Mark disabled with `(label)` or `[label]†` and explain in the frame.
- Mark destructive with `!` and explain.
- Mark elevation with a note, not ASCII art shadows.
- Mark overflow with `⋯`.
- Mark a sheet as a nested box labeled `SHEET`.
- Keep width ≤ 80 columns for portability.
- Never rely on colour alone. Use labels and symbols.

---

## 6. The "every frame" rule

"Every frame the app can have" means every **state that changes what the user can see or
do**, including:

- first run;
- loading with content and without;
- ready with content;
- empty;
- every error class;
- offline;
- denied;
- degraded;
- selection;
- editing with dirty and clean;
- dragging;
- each overlay;
- each confirmation;
- each success;
- each exit path;
- each envelope-specific behaviour change.

It does **not** mean every possible data value. Data variation is handled by content rules
and examples, not by a frame per value.

---

## 7. Flow quality test

A flow is ready for `canon` when a stranger can:

1. reproduce every frame from the text;
2. name every state and transition;
3. implement the flow without asking a question;
4. run the acceptance criteria;
5. use the flow with a keyboard, a screen reader and no colour;
6. point to the error recovery for every failure.

If any answer is no, the flow is `review`.

---

## 8. The flow and the state machine

The flow must use the states from
[`02-state-machine.md`](02-state-machine.md). If a flow needs a state that does not exist,
the state machine is extended first, with an ADR. Flows do not invent private states.

---

## 9. The flow and the app directory

A flow may reference:

- components by ID (`COMP-BUTTON`);
- tokens by ID (`TOK-SPRING-ENTER`);
- capabilities by ID (`CAP-FILES-READ`);
- laws by ID (`LAW-008`).

A flow may not embed a component's full specification. It composes.

---

## 10. Acceptance

| ID | Test |
|---|---|
| `AC-APP-FLOW-001` | Every flow has every required section. |
| `AC-APP-FLOW-002` | Every frame has a wireframe, state, focus, action and transition. |
| `AC-APP-FLOW-003` | Every branch and error is enumerated. |
| `AC-APP-FLOW-004` | Every flow has an accessibility path. |
| `AC-APP-FLOW-005` | A stranger can implement the flow from the file alone. |
| `AC-APP-FLOW-006` | The flow uses only states from the universal machine. |
