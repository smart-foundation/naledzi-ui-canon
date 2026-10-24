---
id: PROC-COMPLETENESS
title: The Completeness Contract
kind: process
entity: process
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [PROC-MASTER-BRIEF, CANON-TIMELESSNESS, DOC-SYSTEM]
acceptance: [AC-PROC-COMPLETE-001]
---

# The Completeness Contract

> Size is not the risk. A cut layer is the risk. A summarised flow is the risk. An assumed
> device is the risk. This contract exists so no agent can make the corpus look finished by
> leaving things out.

---

## 1. The rule

**Complete, not concise.**

A file may be 40 lines or 600 lines. What matters is that it answers its one question
completely. If the question is "how does the EV centre stack behave in every driving
state?", the answer includes every state, every warning, every input, every failure and
every frame. It is not a paragraph and a diagram.

The following are defects:

- a flow that says "and so on";
- a state machine that omits a reachable state;
- a device section that says "similar to phone";
- a settings pane that lists categories without their controls, defaults, scopes and
  failure behaviour;
- an app directory with empty files or `TODO`;
- a research file with a principle but no source, limit or implication;
- a component with no disabled, loading, error, focus or reduced-motion state;
- a wireframe set that shows only the happy path;
- a layer that exists because a legacy OS had one, without a responsibility argument.

The following are **not** defects:

- a large corpus;
- many small files;
- a long file that answers one large question;
- repetition of a shared rule by reference, if the reference is explicit;
- an open question with an owner and a deadline.

---

## 2. Minimum artifacts per entity

### 2.1 Canon, foundations, architecture, framework, shell, envelope

Every entity directory contains, or declares `n/a — reason` for:

```text
README.md
01-purpose.md
02-model.md
03-behaviour.md
04-anatomy.md
05-layout.md
06-input.md
07-accessibility.md
08-performance.md
09-capabilities.md
10-failure.md
11-acceptance.md
12-open-questions.md
13-changelog.md
flows/ (if the entity has user-facing states)
```

A large entity may split any file into a subdirectory of one-question files. For example:

```text
03-behaviour/
├── README.md
├── 01-state-machine.md
├── 02-transitions.md
├── 03-edge-cases.md
├── 04-recovery.md
└── 05-concurrency.md
```

Splitting is encouraged when a file would answer more than one question. Collapsing is
forbidden when it would hide a state, a branch or a failure.

### 2.2 App

Every app directory contains the full standard plus:

```text
flows/
├── README.md
├── 01-first-run.md
├── 02-golden-flow.md
├── 03-<second flow>.md
├── ...
├── errors/
│   ├── README.md
│   ├── 01-<error>.md
│   └── ...
└── envelopes/
    ├── README.md
    ├── watch.md
    ├── phone.md
    ├── tablet.md
    ├── desktop.md
    ├── tv.md
    ├── ev.md
    ├── spaceship.md
    ├── iot.md
    ├── spatial.md
    └── remote-browser.md
```

Each flow file has every frame, every branch, every error, the accessibility path, the
performance notes and the acceptance.

### 2.3 Wireframe set

Every device envelope has, at minimum:

```text
boot
first-run / onboarding
lock / unlock
home / idle
app frame
app fullscreen
app switcher / strip
notifications
quick settings / control centre
settings root
settings pane (one file per pane)
search / palette
multi-window / split / spatial
permission prompt
error / offline / degraded
update / recovery
shutdown / restart
safety state (EV, spaceship)
rare case set
```

Every screen is drawn as a frame. "Similar to phone" is not a frame.

### 2.4 Settings

Every pane contains:

- the user question it answers;
- every control, its default, range and scope;
- dependencies between controls;
- what changes immediately vs after restart;
- what is per-device vs per-user vs per-app;
- the denied/locked/unsupported states;
- the reset path;
- the accessibility path;
- the search keywords;
- the acceptance.

A settings pane that is a list of labels without behaviour is a stub.

### 2.5 Research

Every research file contains:

- the principle, stated precisely;
- the sources (author, title, year, URL, access date);
- the evidence strength and limits;
- what it predicts for Naledzi;
- where it is implemented (IDs);
- where it is contradicted or uncertain;
- acceptance implications.

---

## 3. Coverage matrices

These matrices are the audit. A blank cell is a defect unless it is explicitly `n/a —
reason`.

### 3.1 Devices × OS surfaces

Rows: watch, phone, tablet, desktop, TV, EV, spaceship, IoT, spatial, remote browser.
Columns: boot, first-run, lock, home, app, fullscreen, switcher, notifications, quick
settings, settings, search/palette, permission, error, update, shutdown, safety.

Every cell is either a frame file or a declared absence.

### 3.2 Apps × states

Rows: every admitted app in `05-apps/00-portfolio/`.
Columns: unavailable, loading, ready, empty, error, offline, denied, degraded, closing,
plus ready substates idle/busy/editing/selecting/dragging/presenting.

Every cell is specified and, where visible, drawn.

### 3.3 Flows × frames

Every flow has:

- entry points;
- happy path;
- every branch;
- every error;
- every envelope behaviour difference;
- exit and postcondition;
- accessibility path;
- performance notes;
- acceptance.

No flow is "covered by another flow" unless the shared flow is linked and the difference is
declared.

### 3.4 Settings × controls

Every setting has:

- label and description;
- default;
- range/options;
- scope (global/user/device/app);
- effect timing;
- dependencies;
- locked/denied state;
- reset;
- search keywords;
- accessibility;
- acceptance.

### 3.5 Architecture × paths

Every presentation path: scanout, plane, GPU blit, CPU fallback, remote, headless.
Every buffer state: free, writing, committed, acquired, displayed, released, revoked.
Every failure: allocation, format, fence timeout, device loss, policy crash, authority
restart, remote disconnect.

### 3.6 Components × states

Every component: default, hover (where legal), focus, pressed, selected, disabled, loading,
error, empty, read-only, reduced motion, high contrast, 200% text, RTL, long content,
remote/d-pad, screen reader.

### 3.7 Research × domains

Perception, cognition, motor, emotion, trust, learning, attention, safety-critical,
accessibility, culture, prior art, performance, timelessness. Each domain has sources,
limits, implications and traceability.

---

## 4. The completeness audit

Before a subtree is marked `canon`, a reviewer runs:

1. **Tree audit** — every required directory and file exists or declares absence.
2. **Stub audit** — no `TODO`, no empty section, no "similar to".
3. **State audit** — every state in the matrix is reachable, testable and drawn.
4. **Flow audit** — every frame has wireframe, focus, action, transition, announcement.
5. **Device audit** — every device × surface cell is present or declared absent.
6. **Research audit** — every principle has a source, a limit and an implication.
7. **Layer audit** — every layer has a responsibility, an owner, a boundary and a removal
   consequence.
8. **App audit** — every admitted app has the full standard, not a sample.
9. **Rare-case audit** — every rare case in the register is specified and tested.
10. **Reproducibility audit** — a stranger can implement the golden flow without asking a
    design question.

An audit that finds a missing cell fails the subtree. It does not pass with a note.

---

## 5. How to expand without padding

- **Split by question.** If a file needs two headings that answer different questions, split
  it.
- **Split by envelope.** A phone layout and an EV layout are different questions.
- **Split by state.** Loading, empty, error, denied and degraded are different frames.
- **Split by rare case.** Each rare case has its own behaviour, message and recovery.
- **Split by evidence.** A principle and its source list can be separate files.
- **Do not repeat a shared rule.** Link to it and state the local consequence.
- **Do not invent content to fill a template.** If a section is genuinely not applicable,
  write `n/a — reason` and move on.

Expansion is not verbosity. It is the removal of ambiguity.

---

## 6. Agent instruction

When an agent is assigned a subtree, it MUST:

- read this contract and `00-master-brief.md`;
- build the coverage matrix for its subtree before writing;
- write every cell or declare its absence;
- not stop at a sample;
- report the matrix, the missing cells and the open questions;
- ask for more capacity rather than compress the design.

An agent that returns a "representative sample" has not completed the assignment.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-PROC-COMPLETE-001` | Every required file exists or declares `n/a — reason`. |
| `AC-PROC-COMPLETE-002` | No stub, `TODO` or "similar to" remains. |
| `AC-PROC-COMPLETE-003` | Every matrix cell is filled or explicitly absent. |
| `AC-PROC-COMPLETE-004` | Every flow has every frame and branch. |
| `AC-PROC-COMPLETE-005` | Every device surface has a frame or a declared absence. |
| `AC-PROC-COMPLETE-006` | Every setting has behaviour, scope and failure. |
| `AC-PROC-COMPLETE-007` | Every research principle has a source, limit and implication. |
| `AC-PROC-COMPLETE-008` | A second team can implement without a design question. |
