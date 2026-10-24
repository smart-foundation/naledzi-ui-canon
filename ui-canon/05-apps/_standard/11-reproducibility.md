---
id: APP-REPRODUCIBILITY
title: Reproducibility
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [APP-STANDARD, APP-ACCEPTANCE, DOC-SYSTEM]
acceptance: [AC-APP-STANDARD-016]
---

# Reproducibility

> A different team, in a different UI language, on a different toolkit, must be able to build
> the same app and produce the same experience. Not the same pixels — the same behaviour,
> hierarchy, focus, wording and states.

---

## 1. The test

Two independent teams receive:

- the app directory;
- the component library index;
- the token set;
- the flow spec;
- the acceptance suite.

They may not talk to the original designers. They may not read the original implementation.

Both implementations must pass the same **behavioural and accessibility** suite. Their
visuals may differ only through:

- tokens (colour, type, space, radius, depth, motion);
- declared presentation adapters (e.g., a different native text stack);
- envelope-specific rendering.

They may not differ in:

- command IDs or outcomes;
- state names or transitions;
- flow frames or focus order;
- wording of actions, errors, confirmations;
- information hierarchy;
- capability or data rules.

---

## 2. What makes an app reproducible

### 2.1 Behaviour is separated from presentation

The spec names **what** happens, not **how it is drawn**.

- "Selecting a row marks it and reveals the row actions" — not "the row turns blue".
- "The sheet rises from the bottom edge" — not "translateY(-24px) with cubic-bezier".
- "The error appears at the field and focus moves to it" — not "a red border".

Presentation is then bound by tokens and component contracts.

### 2.2 Semantic IDs

Every entity has a stable ID:

- app: `APP-CALC`
- screen/frame: `CALC-FRAME-004`
- state: `CALC-STATE-READY`
- component instance: `CALC-DISPLAY`, `CALC-KEY-7`
- command: `CMD-CALC-CLEAR`
- capability: `CAP-FILES-READ`
- token: `TOK-COLOR-SURFACE-RAISED`
- AC: `AC-CALC-001`

IDs are stable across implementations. A test targets an ID, not a coordinate.

### 2.3 One owner per fact

- The app owns its domain state.
- The framework owns layout, focus and damage tracking.
- The authority owns the still.
- The policy owns placement.
- The theme owns tokens.

A second implementation renders the same facts through the same owners. It does not
duplicate a fact to make drawing easier.

### 2.4 Components are contracts

A component spec defines:

- anatomy;
- states;
- behaviour;
- keyboard/remote/voice behaviour;
- accessibility semantics;
- tokens it consumes;
- what it must never do.

The second implementation may build the component differently, but it must honour the
contract.

### 2.5 Flows are executable prose

Every frame has a state, a focus, an action and a transition. The second team can turn the
flow into a test without guessing.

### 2.6 Wording is part of behaviour

The same action has the same label; the same error has the same structure. Translation is
allowed; paraphrase is not.

---

## 3. Non-negotiables and freedoms

| Non-negotiable | Free |
|---|---|
| Command ID and outcome | Visual style of the control |
| State machine and transitions | Animation curve, within motion tokens |
| Frame order and focus order | Exact pixel position, within layout rules |
| Information hierarchy | Density rendering, within density rules |
| Wording and tone | Translation and locale form |
| Accessibility semantics | Assistive-tech implementation |
| Capability and data rules | Storage engine and sync mechanism |
| Error structure | Error surface (inline/banner/sheet) if the flow allows |
| Target size and contrast | Shape, radius, elevation within tokens |

If an implementation needs a new freedom, it proposes a token, a component variant or an
ADR. It does not fork the behaviour.

---

## 4. The reproducibility checklist

Before an app is marked `canon`:

- [ ] The human need is one sentence.
- [ ] The timelessness score passes.
- [ ] Every state is named and reachable.
- [ ] Every flow has every frame, branch and error.
- [ ] Every frame has a wireframe, focus, action and transition.
- [ ] Every command has an ID, a label, a shortcut (or `n/a`) and a visible path.
- [ ] Every word is specified or has a voice rule.
- [ ] Every component is referenced by ID; no private grammar.
- [ ] Every value is a token; no literals.
- [ ] Every interactive element has role, name, state and action.
- [ ] Every envelope in scope has a layout and input path.
- [ ] Every failure has a message, a recovery and a data-preservation rule.
- [ ] Every AC has a test and evidence.
- [ ] A stranger can run the golden flow without asking a design question.
- [ ] A second implementation passes the behavioural suite.

---

## 5. The calculator proof

The calculator is the exemplar because it is small and unforgiving:

- its state is tiny, so any ambiguity shows;
- its input is universal, so every envelope can test it;
- its errors are arithmetic and input errors, easy to inject;
- its accessibility is simple but not trivial;
- its visuals are token-bound and depth-driven;
- its golden flow runs on a watch, a phone, a desktop and a TV.

If two teams cannot build the same calculator from the directory, no larger app is
reproducible. The calculator is the corpus's unit test.

---

## 6. Failure of reproducibility

A reproducibility failure is a design defect, not an implementation defect, when:

- the second team must ask what a state means;
- two flows contradict each other;
- a component's behaviour is implied but not written;
- a visual value is required but not tokenized;
- an error has no recovery;
- an accessibility path is missing;
- the same word means two things.

Record the question, fix the directory, re-run the trial. Do not "clarify in review"; review
is not a durable artifact.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-APP-REPRO-001` | The directory yields zero design questions in a cold implementation trial. |
| `AC-APP-REPRO-002` | Both implementations pass the same behavioural suite. |
| `AC-APP-REPRO-003` | Both implementations pass the same accessibility transcript. |
| `AC-APP-REPRO-004` | Visual differences are explainable by tokens or declared adapters. |
| `AC-APP-REPRO-005` | Every command, state, frame and AC has a stable ID. |
| `AC-APP-REPRO-006` | No spec sentence depends on a screenshot to be understood. |
