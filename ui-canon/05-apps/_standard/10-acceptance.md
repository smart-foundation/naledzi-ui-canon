---
id: APP-ACCEPTANCE
title: App Acceptance
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Quality Guild
depends: [APP-STANDARD, APP-FLOW-SPEC, APP-A11Y]
acceptance: [AC-APP-STANDARD-015]
---

# App Acceptance

> An app is accepted when behaviour, appearance, accessibility, performance and
> reproducibility are proven — not when it looks finished in a screenshot.

---

## 1. The acceptance criterion

Every normative statement in an app directory has at least one AC:

```markdown
| ID | Requirement | Test | Evidence |
|---|---|---|---|
| `AC-CALC-001` | Digits append to the current operand. | Type 7, 8; display reads 78. | Still `CALC-READY-003`; test `calc_digits`. |
```

Rules:

- The ID is stable and unique across the suite.
- The requirement is observable by a user or a conformance harness.
- The test is a procedure a second team can run.
- The evidence is a still number, a transcript, a measurement or a test name.
- An AC that cannot fail is not an AC.

---

## 2. The five acceptance layers

### 2.1 Behavioural conformance

The app follows its state machine and flow rules.

- Every state and transition in `02-state-machine.md` is reachable and exits.
- Every flow's happy path, branch and error is reproducible.
- Every command has the same ID and outcome as specified.
- Undo, redo, save, discard, retry and cancel behave as specified.

**Harness.** A scripted driver sends the flow's inputs and asserts the named state, the
visible content and the commit sequence.

### 2.2 Visual truth

The screen matches the still contract.

- Layout regions, focus and elevation match the wireframe.
- Tokens are used; no literal visual values.
- Density modes render without content loss.
- Light, dark, high-contrast and reduced-transparency render correctly.
- A screenshot diff is allowed only after the still is verified structurally.

**Harness.** Numbered stills compared by region, token and focus — not by a raw pixel diff
alone.

### 2.3 Accessibility

- Every interactive element has role, name, state and action.
- The golden flow completes with keyboard only, screen reader only and no colour.
- Focus order matches the spec; focus is never lost.
- Text scales to 200% without loss.
- Reduced motion and reduced transparency are honored.
- The transcript matches the specified announcements.

**Harness.** A screen-reader transcript, a keyboard-only run and an automated semantic audit.

### 2.4 Performance

- The budgets in `07-performance.md` pass at p95 on the weakest envelope.
- Idle produces zero commits and zero background CPU.
- The degradation ladder is exercised and observable.
- No degradation hides a primary action or a warning.

**Harness.** The declared measurement tool; results recorded with date and device.

### 2.5 Reproducibility

A second implementation, in a different UI language, passes the same behavioural and
accessibility suite.

- The second implementation uses the same command IDs, state names, flow frames and
  wording.
- Visual differences are allowed only through tokens and declared presentation adapters.
- The second team may ask zero design questions to complete the golden flow.

**Harness.** The reproducibility trial in `11-reproducibility.md`.

---

## 3. Golden flows

Every app declares at least one **golden flow**: the shortest complete path that proves the
app's reason to exist.

A golden flow:

- starts from a cold launch;
- uses the primary input of each in-scope envelope;
- includes one non-happy branch;
- ends in a named postcondition;
- has a still for every frame;
- has an accessibility transcript;
- has a performance measurement.

The calculator's golden flow is `7 + 8 = 15`, then clear, then `15 × 3 = 45`. It is small
enough to run everywhere and rich enough to expose input, state, error and history.

---

## 4. The conformance suite

| Suite | What it proves | Runs on |
|---|---|---|
| `state` | Every state and transition | Harness, all envelopes |
| `flow` | Every frame and branch | Harness, per envelope |
| `semantics` | Roles, names, states, actions | Semantic audit + screen reader |
| `focus` | Focus order and restoration | Keyboard/remote harness |
| `visual` | Regions, tokens, density, themes | Still comparison |
| `perf` | Budgets and idle | Measurement harness |
| `resilience` | Crash, offline, denied, full disk, conflict | Fault injection |
| `repro` | Second implementation parity | Cross-team trial |

A release candidate must pass `state`, `flow`, `semantics`, `focus`, `perf` and
`resilience`. `visual` and `repro` are required for canon status.

---

## 5. The stranger test

Give the app directory to a competent team that has never seen the product.

They must be able to:

1. name the human need;
2. draw every frame;
3. implement the state machine;
4. wire every command;
5. pass the golden flow;
6. explain every error and recovery;
7. build the accessibility path;
8. meet the budget.

Every question they must ask is a defect in the directory. Record the questions; they are
the next revision.

---

## 6. The rare-case acceptance

The rare-case register in `09-failure.md` is tested, not just written.

- Inject each failure.
- Assert the named state.
- Assert data preservation.
- Assert the announced message.
- Assert the recovery or declared dead end.

A rare case that has never been run is a hypothesis.

---

## 7. The acceptance report

Every app's `11-acceptance.md` ends with:

```markdown
## Status

| Layer | Status | Evidence | Date |
|---|---|---|---|
| Behaviour | pass / fail / not run | <test run> | YYYY-MM-DD |
| Visual | pass / fail / not run | <still set> | YYYY-MM-DD |
| Accessibility | pass / fail / not run | <transcript> | YYYY-MM-DD |
| Performance | pass / fail / not run | <measurement> | YYYY-MM-DD |
| Reproducibility | pass / fail / not run | <trial> | YYYY-MM-DD |
| Rare cases | pass / fail / not run | <fault injection> | YYYY-MM-DD |
```

`not run` is honest. `pass` without evidence is a lie.

---

## 8. Acceptance for this standard

| ID | Test |
|---|---|
| `AC-APP-ACCEPT-001` | Every normative statement has an AC. |
| `AC-APP-ACCEPT-002` | Every app has a golden flow with stills and a transcript. |
| `AC-APP-ACCEPT-003` | Every in-scope envelope runs the golden flow. |
| `AC-APP-ACCEPT-004` | Every rare case is injected and asserted. |
| `AC-APP-ACCEPT-005` | A second implementation passes the behavioural suite. |
| `AC-APP-ACCEPT-006` | The acceptance report contains evidence, not claims. |
