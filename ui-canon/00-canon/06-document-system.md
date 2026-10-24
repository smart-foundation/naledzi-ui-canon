# The Document System

**ID:** `DOC-SYSTEM`
**Status:** Canon
**Normative:** yes
**Version:** 0.1.0
**Owner:** Canon Editor

> This file defines how the corpus is written. A document that does not follow it is a
> draft, not canon.

---

## 1. Why a document system

The failure mode of a large design corpus is not length. It is **inconsistency**: the same
thing described two ways, the same decision re-litigated in five files, a reader unable
to tell which sentence is binding, and an agent unable to find the one file it needs.

The system below prevents that. It is deliberately boring. Boring structure is what lets
the content be ambitious.

Three rules dominate everything else:

1. **One question per file.** A leaf file answers one question completely. If it answers
   two, split it.
2. **One owner per fact.** A fact is stated once. Everywhere else links to it.
3. **Complete at the leaf, navigable from the root.** A reader can enter at any leaf and
   understand it without reading the whole tree, then follow links upward.

---

## 2. Entity kinds

Every directory in the corpus is one of these kinds. The kind determines the required
files.

| Kind | Directory | Examples |
|---|---|---|
| `canon` | `00-canon/` | manifesto, laws, glossary, decision log |
| `foundation` | `01-foundations/<name>/` | depth, motion, typography, iconography |
| `architecture` | `02-architecture/<name>/` | presentation, rendering, protocol, security |
| `framework` | `03-framework/<name>/` | runtime, components, tokens, adaptivity |
| `component` | `03-framework/components/<name>/` | button, card, field, list, rail |
| `shell` | `04-shell/<name>/` | model, strip, status-rail, notifications |
| `app` | `05-apps/<name>/` | calculator, files, video, music |
| `envelope` | `06-envelopes/<name>/` | watch, phone, desktop, ev |
| `wireframes` | `07-wireframes/<name>/` | shells, cross-app |
| `process` | `08-process/` | workflow, roles, gates, roadmap |
| `research` | `09-research/<name>/` | prior-art, depth, apps, input |
| `flow` | `<entity>/flows/` | one file per user flow |
| `template` | any `_template/` | copy-only, never canon |

A directory MUST have a `README.md`. The README is the manifest: it declares the kind,
the status, the files that exist, the files that are intentionally absent, and the
parent/children links.

---

## 3. Naming

- Directories: `kebab-case`, lowercase, no spaces. `status-rail`, not `StatusRail`.
- Files: `NN-kebab-case.md`, two-digit numeric prefix for reading order.
  `03-behaviour.md`.
- `README.md` is always the index. `flows/README.md` is the flow index.
- No dates in filenames. Dates belong in front matter and changelogs.
- No version numbers in filenames. The corpus is versioned as a whole.
- No `final`, `new`, `old`, `v2`, `misc`, `notes` in filenames. Those words hide decay.
  Superseded material is marked in front matter, not renamed into a junk drawer.

---

## 4. Front matter

Every Markdown file except `README.md` and flow files starts with this block. Values are
YAML. Unknown keys are a defect.

```yaml
---
id: APP-CALC-BEHAVIOUR-01
title: Calculator Behaviour
kind: app
entity: calculator
status: canon            # draft | review | canon | superseded | deprecated
normative: true
version: 0.1.0
owner: Apps Guild
depends: [APP-CALC-MODEL-01, LAW-004, LAW-008]
supersedes: []
superseded_by: []
acceptance: [AC-CALC-001, AC-CALC-002]
---
```

| Key | Meaning |
|---|---|
| `id` | Stable identifier. Never reused. See §5. |
| `title` | Human title. May change. |
| `kind` | Entity kind from §2. |
| `entity` | The owning directory name. |
| `status` | Lifecycle state. See §6. |
| `normative` | `true` if it contains binding requirements. |
| `version` | Version of this file, matching the corpus minor. |
| `owner` | The role accountable. See `08-process/02-roles.md`. |
| `depends` | IDs this file assumes. Used for review order. |
| `supersedes` | IDs this file replaces. |
| `superseded_by` | Set when retired. The file is kept. |
| `acceptance` | Acceptance criteria IDs that prove it. |

`README.md` files use the same block plus a `children:` list. Flow files use the same
block plus `flow:` and `frames:`.

---

## 5. Identifiers

The grammar is:

```
<AREA>-<ENTITY>-<TOPIC>-<NN>
```

- `AREA`: `LAW`, `DOC`, `ARCH`, `REND`, `PROTO`, `SEC`, `PERF`, `FW`, `COMP`, `TOK`,
  `SHELL`, `APP`, `ENV`, `FLOW`, `AC`, `ADR`, `RESEARCH`.
- `ENTITY`: short entity name (`CALC`, `PRESENT`, `BUTTON`, `WATCH`).
- `TOPIC`: short topic (`BEHAVIOUR`, `MODEL`, `LAYOUT`, `A11Y`, `PERF`, `CAP`).
- `NN`: two digits, stable.

Examples: `LAW-004`, `ARCH-PRESENT-COMMIT-02`, `APP-CALC-FLOW-03`,
`COMP-BUTTON-STATE-05`, `ENV-WATCH-LAYOUT-02`, `AC-CALC-007`, `ADR-0004`.

Rules:

- An identifier is minted once and never reused, even if the content is deleted. A deleted
  requirement is marked `withdrawn` in the changelog, not recycled.
- A requirement that changes meaning gets a new identifier and the old one is marked
  `superseded_by`.
- Acceptance criteria IDs (`AC-…`) are the unit of proof. A normative statement without
  an `AC-` is a wish.

---

## 6. Status lifecycle

```
draft ──► review ──► canon ──► superseded
  │          │          │
  └──────────┴──────────┴──► deprecated
```

| Status | Meaning | May be implemented? |
|---|---|---|
| `draft` | Being written. Incomplete. Open questions allowed. | No. |
| `review` | Complete enough for critique. At least two reviewers. | No. |
| `canon` | Approved. Binding. | Yes, at the appropriate gate. |
| `superseded` | Replaced. Kept for history. | No new work. |
| `deprecated` | Withdrawn without replacement. | No. |

A file moves to `canon` only when: its acceptance criteria exist, its dependencies are
`canon` or `review`, and its review gate passed (`08-process/05-review-gates.md`).

---

## 7. Required files by kind

The manifest declares absences. `n/a — <reason>` is valid. Silence is not.

### `app`

```
README.md
01-purpose.md          the human need; timelessness argument; non-goals
02-model.md            domain model, state model, data model
03-behaviour.md        normative rules, transitions, edge cases
04-anatomy.md          regions, layers, persistent vs transient
05-layout.md           composition per envelope; min/max; overflow
06-input.md            pointer, touch, keyboard, remote, voice, gesture
07-accessibility.md    semantics, focus order, announcements, reduced motion
08-performance.md      budgets, measurements, degradation
09-capabilities.md     capabilities required; capabilities refused
10-failure.md          loading, empty, error, offline, denied, degraded, recovery
11-acceptance.md       AC list, golden flows, reproducibility
12-open-questions.md   unresolved, with owner and deadline
13-changelog.md        history
flows/                 one file per flow, every frame drawn
```

### `component`

```
README.md
01-anatomy.md
02-behaviour.md
03-states.md
04-tokens.md
05-input.md
06-accessibility.md
07-motion.md
08-acceptance.md
```

### `envelope`

```
README.md
01-constraints.md      physical, input, performance, safety
02-layout.md           regions, safe areas, reach, orientation
03-input.md            the device's input grammar
04-shell.md            what the shell is on this envelope
05-app-adaptation.md   how apps change; what never changes
06-performance.md      budget and degradation ladder
07-failure.md          crash, loss, thermal, power, offline
08-acceptance.md
```

### `architecture`, `framework`, `shell`, `foundation`

```
README.md
01-model.md or 01-<topic>.md
... one file per question
NN-acceptance.md
NN-timelessness.md
```

### `flow`

```
<entity>/flows/NN-<name>.md
```

A flow file contains: goal, actors, preconditions, entry points, the frame sequence (every
frame drawn in Markdown), branches, errors, exit, accessibility path, performance notes,
and acceptance criteria. See §10.

### `research`

```
README.md
01-questions.md
02-findings.md
03-sources.md
04-implications.md
```

---

## 8. Writing style

- **Plain first.** A smart sixteen-year-old should follow the sentence. Jargon is allowed
  only after the glossary defines it, and only when the precise word is shorter than the
  plain phrase.
- **Normative sentences are short.** One requirement per sentence. `MUST`, `MUST NOT`,
  `SHOULD`, `MAY` in caps.
- **No weasel words.** "Generally", "typically", "as appropriate", "where possible" are
  banned in normative text. A requirement either holds or names its condition.
- **No false universals.** "Always", "never", "all devices" must be literally true or
  scoped.
- **State the failure.** Every behaviour file has a failure section. If it cannot fail,
  say why.
- **Name the evidence.** "Fast" is not a requirement. "Settles within 320 ms at p95 on
  the reference watch" is.
- **No screenshots as the only spec.** Images may illustrate; Markdown frames and text
  must carry the requirement.
- **No hidden decisions.** If two options were considered, record the rejected one in the
  decision log with the reason.

---

## 9. Linking and index rules

- Every file is linked from its directory `README.md`. Orphans are defects.
- Links are relative and point to the file, not a heading, unless the heading is stable.
- A fact is stated once. Other files link to it with a short reason:
  `See [ARCH-PRESENT-COMMIT-02](../02-architecture/presentation/02-commit.md).`
- Cross-entity links are allowed and encouraged. Circular links are allowed; circular
  **dependencies** in front matter are not.
- The root `README.md` links every top-level area. Each area README links every child.
- A "see also" section is not a substitute for a dependency. If a requirement depends on
  another, put it in `depends`.

---

## 10. Flow and wireframe standard

A flow is a sequence of **frames**. A frame is a complete screen state, not a sketch.
Every frame in Markdown uses the wireframe grammar in
`07-wireframes/00-standard.md`.

Minimum content of a flow file:

```markdown
---
id: FLOW-CALC-03
title: Calculator — history recall
kind: flow
entity: calculator
status: canon
normative: true
frames: 5
acceptance: [AC-CALC-012]
---

## Goal
## Actors and preconditions
## Entry points
## Frame sequence
### Frame 1 — <name>
```text
<wireframe>
```
State: <what is true>
Focus: <where focus is>
Action: <what the user does>
Transition: <to which frame, under which condition>
## Branches
## Errors and recovery
## Exit
## Accessibility path
## Performance notes
## Acceptance
```

Rules:

- Every frame has a name, a wireframe, a focus location, and an exit transition.
- Every branch is enumerated. "Etc." is a defect.
- Every error has a recovery path or an explicit dead end with an explanation.
- The flow is written for the **behaviour**, not for one visual implementation. Tokens and
  components are referenced by ID, not by pixel values.
- A frame that only exists on one envelope is marked with the envelope.
- If a flow needs animation to be understood, the animation is specified as a transition
  between frames, with spring token, duration bounds and reduced-motion alternative.

---

## 11. Traceability

Every app and shell entity carries a traceability table in `11-acceptance.md`:

| Need | Flow | Components | Tokens | AC |
|---|---|---|---|---|
| Calculate a sum | `FLOW-CALC-01` | `COMP-BUTTON`, `COMP-DISPLAY` | `TOK-*` | `AC-CALC-001` |

Rules:

- A need without a flow is an unmet need.
- A flow without components is not implementable.
- A component without tokens is not themeable.
- A token without a foundation law is decoration.
- An AC without a test is a claim.

This table is how a second team reproduces the app exactly: the need, the behaviour, the
parts, the values, and the proof.

---

## 12. Anti-duplication

- If two files state the same rule, one is wrong. Choose the owner, link from the other.
- If two apps need the same behaviour, it belongs in `03-framework/` or `05-apps/_standard/`,
  not copied into both.
- If two envelopes need the same adaptation, it belongs in the envelope standard.
- If a token value appears in prose, it is stale. Reference the token.
- If a component is described in an app file, the app file may only describe its
  **composition**, never re-specify the component.

---

## 13. Review gates for a document

A document is `canon` only when a reviewer can answer yes to all of:

1. **Need:** the human need is stated in one sentence and is older than the technology.
2. **Scope:** what it does and does not do is explicit.
3. **Behaviour:** every state and transition is named, including failure.
4. **Evidence:** every normative claim has an acceptance criterion.
5. **Timelessness:** it passes the test in `00-canon/01-timelessness-test.md`.
6. **Depth:** if it draws, its place in the depth model is declared.
7. **Access:** keyboard, pointer, touch, remote and assistive paths are stated.
8. **Performance:** a budget exists and is measurable.
9. **Reproducibility:** a different team could implement it without asking a question.
10. **Links:** it is reachable from its parent and links its dependencies.

A "no" is a `review` status, not a debate.

---

## 14. Adding an entity

Checklist for a new app, component, envelope or pipeline:

1. Create the directory and `README.md` from `_template/`.
2. Mint the entity ID and add it to the parent README.
3. Write `01-purpose.md` first. If the need is not timeless, stop.
4. Write the model and behaviour before the layout.
5. Write the flows, every frame, before the components.
6. Reference existing components and tokens. Do not invent values.
7. Write the failure and accessibility sections before acceptance.
8. Write acceptance criteria that a machine could run.
9. Put open questions in `12-open-questions.md` with an owner. Do not hide them in prose.
10. Submit to the review gate. Only then set `status: canon`.

---

## 15. The corpus index

The root README is hand-maintained. A generated index (`canon.index.json`) MAY be added
later for agents and tooling. If generated, it is derived, never edited, and never
authoritative. The Markdown is the source.

---

## 16. Versioning the corpus

- The corpus version lives in the root README and in `08-process/09-changelog.md`.
- A change to a normative identifier is a `MAJOR` change.
- A new entity or requirement is `MINOR`.
- Clarification is `PATCH`.
- Every PR that changes canon updates the changelog in the same change.
- Superseded files stay. The tree is allowed to grow; it is not allowed to lie.
