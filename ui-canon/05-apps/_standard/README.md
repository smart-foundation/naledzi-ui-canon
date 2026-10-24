---
id: APP-STANDARD
title: The App Standard
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Apps Guild
depends: [CANON-LAWS, CANON-TIMELESSNESS, DOC-SYSTEM]
acceptance: [AC-APP-STANDARD-001]
---

# The App Standard

> Every app in the Naledzi suite signs this contract. The domain changes. The grammar does
> not.

---

## 1. What an app is

An app is a **capability-scoped, stateful view of a domain**, presented through the shared
UI grammar. It is not a window. It is not a process. It is not a bundle of screens.

An app:

- owns its domain state and its buffer;
- declares its damage and commits stills;
- composes shared components and tokens;
- exposes its commands and navigation to the palette;
- declares the capabilities it needs and the ones it refuses;
- specifies every state and every flow before it is implemented;
- is reproducible by a different team in a different UI language.

An app does **not**:

- own the output, the status rail or the strip;
- draw system chrome;
- create a second scheduler, ECS or theme;
- keep a private copy of a fact owned by another service;
- receive a global raw pointer;
- invent a visual value outside the token system;
- require a pointer, a keyboard, a network or a colour to complete its core task.

---

## 2. The app directory

Every app is a directory following
[`../../00-canon/06-document-system.md`](../../00-canon/06-document-system.md):

```
<app>/
├── README.md              manifest, definition, tree, status
├── 01-purpose.md          human need, timelessness, non-goals
├── 02-model.md            domain model, data model, state model
├── 03-behaviour.md        normative rules, transitions, edge cases
├── 04-anatomy.md          regions, layers, persistent vs transient
├── 05-layout.md           composition per envelope, density, overflow
├── 06-input.md            pointer, touch, keyboard, remote, voice, gesture
├── 07-accessibility.md    semantics, focus order, announcements, adaptation
├── 08-performance.md      budgets, measurement, degradation ladder
├── 09-capabilities.md     required, optional, refused; observation rights
├── 10-failure.md          loading, empty, error, offline, denied, degraded
├── 11-acceptance.md       AC list, golden flows, conformance
├── 12-open-questions.md   unresolved, owner, deadline
├── 13-changelog.md
└── flows/
    ├── README.md
    └── NN-<flow>.md       one file per user flow, every frame drawn
```

A file may be `n/a — <reason>` only if the reason is declared in `README.md`. Silence is a
defect.

---

## 3. The universal grammar

### 3.1 Regions

Every app frame is composed of at most six regions. Regions may be collapsed, merged or
moved per envelope, but they are not invented.

| Region | Job | May be absent? |
|---|---|---|
| **Identity** | What app and context is this? | No, but it may be implicit on a single-app envelope |
| **Navigation** | Where am I, and how do I go back or across? | Yes, if there is nowhere to go |
| **Content** | The task itself | No |
| **Context** | Secondary information, inspector, list/detail peer | Yes |
| **Actions** | What can I do here? | Yes, if content is directly manipulable |
| **Status** | App-local progress, selection, sync, warnings | Yes, if the system rail carries it |

There is exactly one **primary intent** per frame. It is expressed by the content and, if
needed, one primary action. Secondary actions do not compete visually.

### 3.2 Depth

Every region and overlay declares its elevation:

| Level | Meaning | Examples |
|---|---|---|
| `base` | The content plane | document, list, canvas |
| `raised` | A panel attached to the content | inspector, sidebar, toolbar |
| `floating` | A temporary object above the content | card, popover, drag ghost |
| `overlay` | A transient task or decision | sheet, dialog, palette |
| `system` | OS-owned, never app-owned | status rail, strip, lock |

An app may not draw at `system`. It may not float without a reason. Elevation is semantic.

### 3.3 Density

Every app supports `compact`, `comfortable` and `spacious` densities through tokens. The
density changes spacing, type rhythm and the number of visible secondary actions. It never
hides a primary action or changes the information architecture.

### 3.4 States

Every app implements the universal state machine in
[`02-state-machine.md`](02-state-machine.md). A state that is not reachable is `n/a —
<reason>`.

### 3.5 Flows

Every app specifies its flows in `flows/`, one file per flow, every frame drawn in
Markdown. The format is [`03-flow-spec.md`](03-flow-spec.md).

---

## 4. The contract every app signs

An app is canon-conformant only when all of the following are true.

### Purpose

- The human need is stated in one sentence and predates computing.
- The timelessness score is recorded and ≥ 16, with no 0 on criteria 1–4.
- Non-goals are explicit.

### Model

- The domain model is stated without UI terms.
- Every state is named and reachable.
- Persistence, restore and crash behaviour are specified.
- No fact is duplicated from another owner.

### Behaviour

- Every rule is normative and has an ID.
- Every transition has a trigger and a guard.
- Every error has a recovery path or a declared dead end.
- Undo, confirmation and reversibility are specified.

### Anatomy and layout

- Regions and layers are declared.
- Every envelope in scope has a layout rule.
- Overflow, truncation, empty space and extreme content are specified.
- Density modes are specified.
- The wireframes in `flows/` match the layout rules.

### Input

- Every operation has a pointer/touch path, a keyboard path and a non-pointer path.
- Remote, voice and gesture paths are declared or explicitly `n/a — <reason>`.
- No operation is hover-only, right-click-only or long-press-only.
- Capture leases, drag and text input are specified.

### Accessibility

- Every component has a role, name, state and action.
- Focus order is specified per flow.
- Announcements for state changes and errors are specified.
- Reduced motion, reduced transparency, high contrast and text scaling are specified.
- A screen-reader transcript exists for at least one golden flow.
- Target size and colour independence pass.

### Performance

- A budget exists for the weakest supported envelope.
- The degradation ladder is ordered and explicit.
- Idle cost is zero or declared.
- Measurement method is stated.

### Capabilities

- Required, optional and refused capabilities are listed.
- Observation rights (thumbnails, capture, clipboard, location, microphone, camera) are
  explicit and revocable.
- The app behaves honestly when denied.

### Failure

- Loading, empty, error, offline, denied and degraded states are specified and drawn.
- Recovery, retry and data preservation are specified.
- The app never fakes success or data.

### Acceptance

- Every normative statement has an AC.
- At least one golden flow is end-to-end testable.
- A second implementation can pass the same AC suite.
- The "stranger test" passes: a competent team can implement from the directory alone.

---

## 5. The app's relationship to the system

```
┌──────────────────────────────────────────────────────────────┐
│ system                                                       │
│  authority · policy · executor · status rail · strip         │
│                                                              │
│  ┌────────────────────────────────────────────────────────┐  │
│  │ app                                                    │  │
│  │  domain state · MirUI ECS · components · tokens        │  │
│  │  buffer · damage · commit · commands · capabilities    │  │
│  └────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

- The app owns its buffer and declares its damage.
- The authority owns the still and validates the commit.
- The policy owns placement, focus and the strip.
- The executor owns presentation.
- The app never talks to the executor or the authority directly; it uses the contracted
  surface API.

---

## 6. The app matrix

The suite is not a pile of unrelated apps. It is a matrix of **jobs**:

| Job | Apps |
|---|---|
| Find and organize | files, search, store |
| Consume | video, music, photos, browser, maps, weather |
| Create | notes, camera, music studio, video editor |
| Communicate | mail, messages, calendar |
| Compute | calculator, terminal |
| Configure | settings, health, agent console |
| Ambient | clock, status, notifications |

Every app declares its job, its neighbours and the flows it shares with them. Shared flows
(drag a file into mail, open a photo in the editor, call a contact from messages) are
specified once in [`../../07-wireframes/cross-app/`](../../07-wireframes/cross-app/README.md)
and linked from both apps.

---

## 7. The standard's own acceptance

| ID | Requirement | Evidence |
|---|---|---|
| `AC-APP-STANDARD-001` | Every app directory has the required files or a declared absence. | Tree audit. |
| `AC-APP-STANDARD-002` | Every app has at least one flow with every frame drawn. | Flow audit. |
| `AC-APP-STANDARD-003` | Every app passes the stranger test. | Two independent implementations. |
| `AC-APP-STANDARD-004` | Every app's core flow works on watch, phone, desktop and TV (or declares an envelope exception). | Envelope matrix. |
| `AC-APP-STANDARD-005` | Every app's core flow works without a pointer and without colour. | Accessibility transcript. |

---

## 8. Files in this standard

| File | Question it answers |
|---|---|
| [`01-anatomy.md`](01-anatomy.md) | What are the parts of an app, and where do they live? |
| [`02-state-machine.md`](02-state-machine.md) | What states must every app have, and how does it move? |
| [`03-flow-spec.md`](03-flow-spec.md) | How is a user flow written and drawn? |
| [`04-envelope-adaptation.md`](04-envelope-adaptation.md) | How does one app become a watch app and a desktop app? |
| [`05-input.md`](05-input.md) | What is the universal input grammar? |
| [`06-accessibility.md`](06-accessibility.md) | How is accessibility structural, not bolted on? |
| [`07-performance.md`](07-performance.md) | What is an app's budget and degradation ladder? |
| [`08-capabilities.md`](08-capabilities.md) | What may an app touch, and how is it granted? |
| [`09-failure.md`](09-failure.md) | How does an app fail honestly? |
| [`10-acceptance.md`](10-acceptance.md) | How is an app proven? |
| [`11-reproducibility.md`](11-reproducibility.md) | How does a different team build the same app? |
| [`12-content-and-voice.md`](12-content-and-voice.md) | What does the app say, and how? |
| [`_template/`](_template/README.md) | The copy-only starting point. |
