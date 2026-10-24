---
id: CANON-TIMELESSNESS
title: The Timelessness Test
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-MANIFESTO]
acceptance: [AC-DOC-002]
---

# The Timelessness Test

> A widget, a gesture, a shadow, a protocol field or a whole screen is admitted only if it
> survives this test. The test is scored, not felt.

---

## 1. The two questions

Before scoring, answer these in one sentence each. If either answer is weak, stop.

**Q1 — The human question.** What need does this serve that existed before computers?
Communication, memory, navigation, creation, comparison, safety, status, play, care,
belonging. If the need only exists because the interface exists ("users need a dock to
launch apps"), the thing is a workaround, not a primitive.

**Q2 — The change question.** What happens to this when the input, display and form factor
change? If the answer is "it breaks and we add a special case per device", it is not
timeless. If the answer is "the same model, a different executor", it is.

---

## 2. The scorecard

Each criterion is scored **0, 1 or 2**.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| 1 | **Human need** | Exists only because of the interface | Useful but shallow | Serves a need older than computing |
| 2 | **Input independence** | Requires one input device | Works on two, awkward on others | Pointer, touch, keyboard, remote and voice have a native path |
| 3 | **Display independence** | Requires a large rectangle | Degrades with loss | Works from watch to wall to non-rectangle; the model survives |
| 4 | **Envelope independence** | Needs a device-specific fork | Has declared exceptions | Same behaviour; layout adapts by rule |
| 5 | **Decade independence** | Rides a fashion | Neutral | Would be legible and useful in 100 years |
| 6 | **Learnability** | Needs a manual or a hidden gesture | Discoverable after hint | Understandable on first contact, without a tutorial |
| 7 | **Accessibility** | Visual/pointer only | Partial alternative | Full path for keyboard, screen reader, switch, voice, reduced motion |
| 8 | **Proportional cost** | Costs when idle or scales with screen | Bounded but wasteful | Costs in proportion to change; idle is silent |
| 9 | **Failure clarity** | Fails silently | Reports an error | Names the failure, the cause and the recovery |
| 10 | **Composability** | Monolithic | Can be embedded with caveats | Composes with the rest of the grammar without special cases |

**Maximum: 20.**

### Admission

- **Canon:** score ≥ 16, and no 0 on criteria 1–4.
- **Review:** score 12–15. It may be kept as a layer, but not as a foundation.
- **Reject:** score < 12, or any 0 on 1–4.

A score of 20 is rare and not required. A score of 18 with a declared weakness is better
than a dishonest 20.

---

## 3. The tests behind the score

### 3.1 The input swap

Describe the interaction with a pointer. Now with touch. Now with a keyboard only. Now with
a TV remote (five buttons). Now with voice. Now with gaze or a neural input.

If any path requires a different **model** (not a different binding), score ≤ 1 on criterion
2. If any path is impossible, score 0.

### 3.2 The display swap

Describe it at 40 mm (watch), 150 mm (phone), 300 mm (tablet), 600 mm (laptop), 1.5 m (TV),
across a car cabin, and on a non-rectangular or spatial display.

If it needs a different information architecture per size, it is not adaptive, it is
several products. Score ≤ 1 on criterion 3.

### 3.3 The decade swap

Remove the current fashion. Remove the current framework. Remove the current screen
technology. Does the thing still make sense? If it only works because "that is how apps
look now", score 0 on criterion 5.

### 3.4 The first-contact test

Show it to someone who has never seen the OS. Can they discover the primary action in
under five seconds without a tooltip, a coach mark or a manual? If not, score ≤ 1 on
criterion 6.

### 3.5 The idle test

Leave it alone for an hour. Measure CPU, GPU, wakeups, messages and battery. If it costs
anything, score ≤ 1 on criterion 8. If it redraws to look alive, score 0.

### 3.6 The failure test

Deny a capability, kill a service, disconnect the network, fill the disk, remove the
output. Does the thing explain itself and recover? If it lies or freezes, score 0 on
criterion 9.

### 3.7 The stranger test

Hand the file to a competent team that has never spoken to you. Can they implement it
without asking a question? If not, the **specification** is not timeless, regardless of the
idea. Fix the spec before scoring again.

---

## 4. Worked examples

These are decisions, not suggestions. They are recorded in the decision log.

### 4.1 The dock — **transform**

| Criterion | Score | Why |
|---|---|---|
| Human need | 1 | Switching and launching are real, but the dock conflates them |
| Input independence | 1 | Pointer-native; awkward on watch, TV, car |
| Display independence | 0 | Assumes a wide, permanent strip |
| Envelope independence | 1 | Hides on small screens, which is an admission |
| Decade independence | 1 | A 2001 convention, not a human invariant |
| Learnability | 1 | Icons must be memorized |
| Accessibility | 1 | Usually reachable, often poorly labelled |
| Proportional cost | 1 | Permanent chrome, but cheap |
| Failure clarity | 1 | Usually silent |
| Composability | 1 | Competes with every other bottom-edge affordance |
| **Total** | **9** | **Reject as a foundation.** |

**Outcome:** the *need* (switch, resume, launch) is kept. The *form* is transformed into
the **strip**: summon-only, live stills, depth cards, no permanent chrome
([`../04-shell/strip/`](../04-shell/strip/README.md)).

### 4.2 Tabs — **transform**

| Criterion | Score | Why |
|---|---|---|
| Human need | 2 | Comparing parallel things is ancient |
| Input independence | 2 | Works with pointer, keyboard, touch, remote |
| Display independence | 1 | Horizontal strip fails on narrow screens |
| Envelope independence | 1 | Needs a different pattern on watch/TV |
| Decade independence | 1 | The tab *shape* is a 1994 artifact |
| Learnability | 2 | Immediately understood |
| Accessibility | 1 | Usually a tablist; often incomplete |
| Proportional cost | 2 | Cheap |
| Failure clarity | 2 | Visible state |
| Composability | 1 | Fights with navigation and split views |
| **Total** | **15** | **Review: keep the need, not the chrome.** |

**Outcome:** the parallel-view need becomes a **Section Set** primitive: a labelled,
keyboard-navigable set of peers with a spatial model that can be a horizontal rail on
desktop, a segmented control on phone, a crown-scroll on watch, and a list on TV. The
"tab" is one rendering of the primitive, not the primitive.

### 4.3 The command palette — **keep**

| Criterion | Score | Why |
|---|---|---|
| Human need | 2 | Naming what you want is older than menus |
| Input independence | 2 | Keyboard, voice, touch, remote, pointer all natural |
| Display independence | 2 | One field and a list |
| Envelope independence | 2 | Same model everywhere; layout adapts |
| Decade independence | 2 | A search field is not a fashion |
| Learnability | 2 | "Type what you want" |
| Accessibility | 2 | A text field and a list are the most accessible UI |
| Proportional cost | 2 | Opens on demand; idle is free |
| Failure clarity | 2 | No results is a state, not a crash |
| Composability | 2 | A universal surface |
| **Total** | **20** | **Canon.** |

**Outcome:** the palette is a foundation, not a feature. Every app exposes its actions to
it ([`../03-framework/palette/`](../03-framework/palette/README.md)).

### 4.4 Glassmorphism — **reject as a foundation**

| Criterion | Score | Why |
|---|---|---|
| Human need | 0 | No need; a surface fashion |
| Input independence | 2 | Irrelevant to input |
| Display independence | 1 | Expensive and unreadable on low-end/outdoor |
| Envelope independence | 0 | Fails on watches, TVs, cars, low-power |
| Decade independence | 0 | A 2013–2021 trend |
| Learnability | 1 | Adds no affordance |
| Accessibility | 0 | Destroys contrast and legibility |
| Proportional cost | 0 | Blur is expensive, often full-screen |
| Failure clarity | 1 | Hides what is behind |
| Composability | 1 | Conflicts with depth and contrast |
| **Total** | **6** | **Reject as foundation.** |

**Outcome:** translucency is allowed only as a **declared transient material** for a
specific layer (e.g., a system sheet over protected content), with contrast guarantees and
a performance budget. It is not the visual language. Depth is.

### 4.5 The numbered still — **keep**

| Criterion | Score | Why |
|---|---|---|
| Human need | 2 | "What am I looking at?" is ancient |
| Input independence | 2 | Input is bound to the same truth |
| Display independence | 2 | One truth per output; outputs are peers |
| Envelope independence | 2 | Same commit on every device |
| Decade independence | 2 | Describes visibility, not pixels |
| Learnability | 2 | Invisible when correct |
| Accessibility | 2 | Semantics ride the same commit |
| Proportional cost | 2 | Declared damage; idle silent |
| Failure clarity | 2 | Named rejections |
| Composability | 2 | Everything else builds on it |
| **Total** | **20** | **Canon.** |

**Outcome:** the presentation foundation
([`../02-architecture/presentation/`](../02-architecture/presentation/README.md)).

---

## 5. The transform rule

A score of 12–15 does not mean "delete". It means **keep the need, replace the form**.

Write down:

1. the need the thing serves;
2. the assumptions that failed;
3. the primitive that survives the assumptions;
4. the per-envelope renderings of that primitive;
5. the evidence that the new form is better.

If you cannot do all five, the thing is rejected, not transformed.

---

## 6. The rejection log

Every rejected idea is recorded in
[`05-anti-patterns.md`](05-anti-patterns.md) with its score and the reason. A rejected idea
that keeps returning without new evidence is a process defect, not a design debate.

---

## 7. The rule for agents

An agent MUST NOT introduce a new primitive, component, gesture or chrome without:

- a scored entry in this format;
- an entry in the decision log;
- an acceptance criterion;
- a per-envelope statement.

An agent MAY propose. An agent MAY NOT canonise by writing confident prose.
