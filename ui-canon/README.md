# The Naledzi UI Canon

> One corpus, one vocabulary, one source of design truth — from the first commit of a
> surface to the last frame of the calculator. Written before code, validated before
> implementation, maintained for as long as the OS exists.

**Status:** Living canon. Versioned. Normative unless a section is marked *Informative*.
**Scope:** Every human-facing surface of Naledzi: presentation truth, rendering, the UI
runtime, the shell, every app, every device envelope, every gesture, every word.
**Audience:** Humans and agents. If a sentence can be read two ways, it is a defect.

---

## 0. What this is

This is the **design source of truth** for the Naledzi interface. The OS may replace any
implementation; this corpus is how the replacement knows what it must remain.

It is not one document. It is a **tree of entities**. Every app, every component, every
device envelope, every rendering path, every user flow is a directory of small,
self-contained Markdown files. A reader who needs one answer reads one leaf file. A team
that needs to rebuild an app reads the app directory and its flows. Nothing important
lives only in a 400-page monolith.

The corpus is expected to be large. Size is not the risk. **Unstated decisions are the
risk.** A tree that is large because every leaf removes an ambiguity is doing its job.

The documentation system itself is normative:
[`00-canon/06-document-system.md`](00-canon/06-document-system.md). Every entity follows
it.

---

## 1. Authority and truth

Naledzi has three kinds of truth. They are not allowed to silently disagree.

| Kind | Authority | If it disagrees |
|---|---|---|
| **Wire truth** — what crosses a capability boundary | `protocol/schemas/*.capnp` | The contract wins; the document is wrong. |
| **Design truth** — what the interface must be | this corpus | The canon wins; the implementation is wrong. |
| **Current state** — what is actually built and proven | the tree, generated reports, `file:line` | The code wins; the document is stale and must be corrected. |

Rules:

1. **Normative** language (`MUST`, `MUST NOT`, `SHOULD`, `MAY`) is binding. *Informative*
   prose explains, and never overrides a normative statement.
2. Every normative statement has an identifier (`LAW-…`, `ARCH-…`, `APP-…`, `ENV-…`).
   Identifiers are stable. Prose may change; identifiers do not.
3. A decision that changes a normative statement is recorded in
   [`00-canon/04-decision-log.md`](00-canon/04-decision-log.md) before the statement is
   edited.
4. A specification that cannot be tested is not finished. Every normative section names
   its **acceptance evidence**.
5. Where this corpus and the contract disagree about a wire fact, the contract wins and
   the corpus is corrected in the same change.

---

## 2. The one goal

**Timelessness.**

Not novelty. Not fashion. Not a competitor's screenshot. A thing earns its place here
only if it still makes sense when the input device, the display, the form factor and the
decade have all changed.

The operational test is
[`00-canon/01-timelessness-test.md`](00-canon/01-timelessness-test.md). Everything — a
widget, a gesture, a shadow, a protocol field, a screen — passes that test or is removed.
"Everyone has one" is not a justification. "It has always been this way" is not a
justification. "It is beautiful" is not sufficient.

The second goal is **depth**: hierarchy made visible through space, light, occlusion and
motion — not through decoration. Depth is how a timeless interface stays legible as it
grows. Glassmorphism is a surface treatment; depth is a model of space. We build the
model.

---

## 3. The non-negotiables

Expanded in [`00-canon/02-design-laws.md`](00-canon/02-design-laws.md). Short form:

1. **One fact, one owner.** No second copy, no shadow authority, no "keep it in sync".
2. **Pixels never cross a contract boundary.** A boundary carries capabilities, buffers
   and declarations — not raw pixels and not global pointers.
3. **Declared, not detected.** The producer declares what changed. The system never diffs
   frames to discover dirt.
4. **Idle is silent.** No polling, no heartbeat redraws, no animation that exists to look
   alive.
5. **Every visible state is a numbered still.** Pixels, hit targets, accessibility,
   input ownership and buffer lifetime are one atomic, versioned fact.
6. **Authority is mandatory; policy is optional.** Validation and crash-safe truth are
   always present. Layout and arbitration are a replaceable app, absent on simple devices.
7. **Depth communicates hierarchy.** Elevation, shadow, parallax and occlusion have
   meaning. Nothing floats for decoration.
8. **Motion explains change.** A spring is an explanation of what moved and why, not a
   garnish. It settles and stops.
9. **Accessibility is structural.** It is derived from the same semantics that draw the
   screen, never scraped afterwards.
10. **No permanent chrome without a timeless job.** A dock, a bar, a tab strip or a
    floating button must answer "what does a human always need here?" on every envelope,
    or it does not exist.
11. **Honesty over polish.** Unsupported, denied, unknown and degraded states are shown
    as such. `NOT REPORTED` is a valid, premium answer.
12. **Design before code.** A slice may not be implemented until its gate is passed
    (`08-process/05-review-gates.md`).

---

## 4. The entity model

Every entity is a directory. Every directory has a `README.md` that is its index and
manifest. The files inside answer **one question each**. The same anatomy is used
everywhere, so a reader who learns one app can navigate every app.

```
<entity>/
├── README.md              index, front matter, definition, tree, links
├── 01-purpose.md          the human need; timelessness; non-goals
├── 02-model.md            concepts, data, state model
├── 03-behaviour.md        normative rules, transitions, edge cases
├── 04-anatomy.md          parts, regions, layers
├── 05-layout.md           responsive composition per envelope
├── 06-input.md            pointer, touch, keyboard, remote, voice, gesture
├── 07-accessibility.md    semantics, focus, announcements, reduced motion
├── 08-performance.md      budgets and measurements
├── 09-capabilities.md     what it may touch; what it must never touch
├── 10-failure.md          error, degraded, offline, denied, recovery
├── 11-acceptance.md       testable criteria and golden evidence
├── 12-open-questions.md   unresolved decisions with owners
├── 13-changelog.md        version history and supersessions
└── flows/                 one file per user flow; every frame drawn in Markdown
    ├── README.md
    ├── 01-<flow>.md
    └── ...
```

Not every entity needs every file. The manifest in `README.md` declares which files
exist and which are intentionally absent (`n/a — reason`). A missing file without a
declared reason is a defect.

See [`00-canon/06-document-system.md`](00-canon/06-document-system.md) for the exact
front matter, identifiers, statuses and review rules.

---

## 5. The tree

```
docs/ui-canon/
├── README.md
├── 00-canon/
│   ├── README.md
│   ├── 00-manifesto.md
│   ├── 01-timelessness-test.md
│   ├── 02-design-laws.md
│   ├── 03-glossary.md
│   ├── 04-decision-log.md
│   ├── 05-anti-patterns.md
│   └── 06-document-system.md
├── 01-foundations/
│   ├── README.md
│   ├── depth/                 space, light, elevation, shadow, parallax, occlusion
│   ├── motion/                spring physics, choreography, determinism
│   ├── typography/            type system, scales, scripts, numerals
│   ├── color/                 roles, light/dark, contrast, color science
│   ├── iconography/           Solar set + Naledzi glyphs + rendering pipeline
│   ├── sound-haptics/         audio cues, haptics, silence
│   └── accessibility/         structure, focus, assistive tech, adaptation
├── 02-architecture/
│   ├── README.md
│   ├── presentation/          stills, commit, authority, policy, executor
│   ├── rendering/             paths, damage, buffers, fences, GPU, CPU, composition
│   ├── protocol/              capabilities, roles, discovery, schema evolution
│   ├── runtime/               services, lifecycles, envelopes
│   ├── security/              revocation, secure surfaces, observation rights
│   └── performance/           budgets, measurement, regressions
├── 03-framework/
│   ├── README.md
│   ├── runtime/               MirUI, ECS, scheduler, layout, text, damage
│   ├── components/            one directory per component
│   ├── tokens/                color, type, space, depth, motion, icon, radius
│   ├── palette/               command palette, search, actions
│   ├── adaptivity/            envelope archetypes, responsive rules
│   └── rust/                  modern Rust, no_std, allocation, style
├── 04-shell/
│   ├── README.md
│   ├── model/                 what the shell is and is not
│   ├── strip/                 the depth card reel (navigation + launch)
│   ├── status-rail/           adaptive, UX-owned indicator rail
│   ├── notifications/         delivery, priority, history
│   ├── spaces/                workspaces, focus, switcher
│   ├── gestures/              the global gesture grammar
│   └── lock/                  lock screen, session, identity
├── 05-apps/
│   ├── _standard/             the contract every app signs
│   ├── calculator/            ← exemplar tree, fully specified
│   ├── files/
│   ├── video/
│   ├── music/
│   ├── photos/
│   ├── browser/
│   ├── notes/
│   ├── calendar/
│   ├── mail/
│   ├── messages/
│   ├── camera/
│   ├── terminal/
│   ├── settings/
│   ├── clock/
│   ├── weather/
│   ├── maps/
│   ├── health/
│   ├── store/
│   └── agent-console/
├── 06-envelopes/
│   ├── _standard/
│   ├── watch/
│   ├── phone/
│   ├── tablet/
│   ├── desktop/
│   ├── tv/
│   ├── ev/
│   ├── iot/
│   └── remote-browser/
├── 07-wireframes/
│   ├── README.md
│   ├── 00-standard.md
│   ├── shells/                desktop, phone, watch, tv, ev
│   └── cross-app/             first-run, palette, permissions, drag, offline
├── 08-process/
│   ├── README.md
│   ├── 01-agentic-workflow.md
│   ├── 02-roles.md
│   ├── 03-research-protocol.md
│   ├── 04-spec-protocol.md
│   ├── 05-review-gates.md
│   ├── 06-implementation-protocol.md
│   ├── 07-acceptance-gates.md
│   ├── 08-roadmap.md
│   ├── 09-changelog.md
│   └── 10-open-questions.md
└── 09-research/
    ├── README.md
    ├── prior-art/
    ├── depth/
    ├── apps/
    ├── input/
    ├── performance/
    ├── timelessness/
    └── references/
```

---

## 6. How to read the corpus

If you are new, read in this order:

1. [`00-canon/00-manifesto.md`](00-canon/00-manifesto.md) — why this exists.
2. [`00-canon/01-timelessness-test.md`](00-canon/01-timelessness-test.md) — how a thing
   earns its place.
3. [`00-canon/02-design-laws.md`](00-canon/02-design-laws.md) — the binding laws.
4. [`00-canon/06-document-system.md`](00-canon/06-document-system.md) — how the corpus is
   structured.
5. [`01-foundations/depth/README.md`](01-foundations/depth/README.md) — the visual model.
6. [`01-foundations/motion/README.md`](01-foundations/motion/README.md) — the motion model.
7. [`02-architecture/presentation/README.md`](02-architecture/presentation/README.md) —
   how a still becomes visible.
8. [`05-apps/_standard/README.md`](05-apps/_standard/README.md) — how an app is specified.
9. [`08-process/01-agentic-workflow.md`](08-process/01-agentic-workflow.md) — how the
   corpus is built and kept true.

Then go to the entity you own.

---

## 7. Conformance

A UI implementation is **canon-conformant** when:

- every normative identifier it claims is implemented has a passing acceptance test;
- every screen it ships maps to a flow in an entity's `flows/` directory;
- every component it uses exists in `03-framework/components/`;
- every colour, spacing, radius, shadow, spring and type value comes from a token in
  `03-framework/tokens/`;
- every interactive element has a semantic role and an accessibility path;
- every state — loading, empty, error, offline, denied, degraded — is specified and
  rendered;
- every device envelope it targets has a directory in `06-envelopes/` and its differences
  are declared, not improvised.

An app is **reproducible** when a different team, using a different UI language, can
implement the same app spec and pass the same behavioural conformance suite. Visual
appearance may differ only through tokens and declared presentation adapters; behaviour,
hierarchy, focus order, wording and state transitions may not.

---

## 8. Versioning and change

- Semantic versioning: `MAJOR.MINOR.PATCH`.
- `MAJOR` changes a normative identifier's meaning or removes it.
- `MINOR` adds normative material or an identifier.
- `PATCH` clarifies without changing meaning.
- Every change lands with a changelog entry and, if it changes a decision, an ADR.
- Superseded documents are not deleted. They are marked `Superseded by …` and kept,
  because the reason a design was rejected is part of the design.

**Current version:** `0.1.0` — first canon tranche. The tree is complete as a structure;
leaf content is being filled by the agent workflow. See
[`08-process/08-roadmap.md`](08-process/08-roadmap.md).

---

## 9. Relationship to existing documents

This corpus is the **UI** source of truth. It does not replace:

- `docs/NALEDZI.md` — what the OS is.
- `docs/DESIGN.md` — the complete system specification and current-state audit.
- `protocol/schemas/*.capnp` — the wire contract.
- `docs/ux-design.md` — the console/TUI design system, authoritative for the text
  interface until folded in here.
- `docs/SMART-PROTOCOL.md` — protocol architecture.

Where an older document covers the same ground, this corpus links to it and states which
is authoritative. No document is silently overridden.

---

## 10. The rule for contributors

> Do not add a screen. Add a **need**, a **flow**, a **state machine** and a **test** —
> then the screen is the residue.

If you cannot state the human need in one sentence, the screen is not ready. If you
cannot name the state transition it performs, the interaction is not ready. If you cannot
describe how it fails, it is not ready. If it only makes sense on one device, it is not
timeless. If it needs a paragraph of explanation to be usable, it is not finished.

---

## Addendum A — 2026-10-22: derived portfolio, full surfaces, append-only

This addendum extends §5 and does not delete it. The tree in §5 remains as the first
structural sketch; the programme has since expanded.

### A.1 The app list in §5 is illustrative, not canon

No app is admitted because a legacy OS ships one. The portfolio is derived from timeless
human jobs, envelope capabilities and real UX research in
[`05-apps/00-portfolio/`](05-apps/00-portfolio/README.md). The calculator remains the
**reproducibility exemplar** — a small, unforgiving proof of the app standard — not a
mandate that every device ships a calculator. The shell, framework, envelopes and
wireframes compose around jobs and the derived portfolio, never a hardcoded list.

### A.2 Expanded subtrees

The following are now first-class and are being filled out in full:

- [`01-foundations/experience/`](01-foundations/experience/README.md) — the felt
  experience: personas, emotion, confidence, calm, trust, onboarding, error recovery, rare
  cases, culture, attention, safety and stress.
- [`02-architecture/ecosystem/`](02-architecture/ecosystem/README.md) — the connected
  multi-device system: discovery, pairing, continuity, handoff, shared clipboard, remote
  output/input, sync and conflict, identity and trust, notifications across devices, window
  continuity, zero-copy limits and failure.
- [`04-shell/fullscreen/`](04-shell/fullscreen/README.md) — fullscreen and immersive
  behaviour per envelope: what hides, what remains, how to exit, notifications, focus,
  gestures, multi-window and safety zones.
- [`04-shell/lifecycle/`](04-shell/lifecycle/README.md) — boot, first run, login, session,
  update, recovery, power/thermal, shutdown and restart.
- [`04-shell/shortcuts/`](04-shell/shortcuts/README.md) — the global shortcut registry,
  per-envelope bindings, conflict resolution and discoverability.
- [`05-apps/settings/`](05-apps/settings/README.md) — the full Settings surface: every
  pane a person needs to run the OS, not a vendor tree.
- [`06-envelopes/spaceship/`](06-envelopes/spaceship/README.md) — deterministic timing,
  redundancy, alarms, procedures, high workload, gloves, glare and non-rectangular
  displays.
- [`06-envelopes/spatial/`](06-envelopes/spatial/README.md) — AR/VR/neural spatial
  interfaces as a first-class envelope.
- [`07-wireframes/modes/spacious/`](07-wireframes/modes/spacious/README.md) — spacious
  density frames, not a skin.
- [`07-wireframes/cross-device/`](07-wireframes/cross-device/README.md) — pairing,
  handoff, clipboard, notification sync, cast and remote input frames.
- [`07-wireframes/shortcuts/`](07-wireframes/shortcuts/README.md) — shortcut maps and
  palette frames per envelope.
- [`08-process/02-completeness-contract.md`](08-process/02-completeness-contract.md) —
  no layer cut, no summarised flow, no assumed device.
- [`08-process/03-append-only-protocol.md`](08-process/03-append-only-protocol.md) —
  add, do not overwrite; supersede, do not delete.
- [`09-research/ux-principles/`](09-research/ux-principles/README.md) — the real research
  base: perception, cognition, motor control, emotion, trust, learning, attention,
  safety-critical human factors, accessibility, culture and sources.

### A.3 The completeness rule

Size is not the risk; a cut layer is. A file may be long. A flow may have many frames. An
envelope may have many rare cases. The corpus expands until every question is answered.
See [`08-process/02-completeness-contract.md`](08-process/02-completeness-contract.md).

### A.4 The append-only rule

Shared documents are append-only. New direction is a new file or a dated addendum.
Superseded material is marked and kept. See
[`08-process/03-append-only-protocol.md`](08-process/03-append-only-protocol.md).

### A.5 Device scope

The same OS runs on watch, phone, tablet, desktop, TV, EV, spaceship, IoT, spatial and
remote browser. Devices are peers. Phone and PC run the same OS and are connected by
designed UX: pairing, handoff, shared clipboard, notification sync, continue-on-another-
device, remote output and remote input. The EV and spaceship are not skins; they have
protected zones, deterministic timing, redundancy and procedure-first failure. See
[`06-envelopes/`](06-envelopes/README.md) and
[`02-architecture/ecosystem/`](02-architecture/ecosystem/README.md).
