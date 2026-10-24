---
id: PROC-MASTER-BRIEF
title: Master Brief for Corpus Agents
kind: process
entity: process
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-LAWS, CANON-TIMELESSNESS, DOC-SYSTEM, APP-STANDARD]
acceptance: [AC-PROC-BRIEF-001]
---

# Master Brief for Corpus Agents

> Read this before writing a single file. It is the contract between the Canon Editor and
> every agent working on the Naledzi UI corpus.

---

## 1. Mission

Build the **canonical, timeless UI/UX design corpus** for Naledzi OS: a tree of Markdown
entity directories that specifies the entire human-facing system, across every device
envelope, in enough detail that different teams can implement the same experience in
different UI languages and get the same behaviour, hierarchy, focus, wording and states.

The corpus is **design truth**. It is written before implementation and survives any
implementation. It is not marketing, not a mood board, and not a code dump.

The OS is one system across phones, PCs, tablets, watches, TVs, cars, spacecraft, IoT,
spatial displays and remote browsers. Devices are peers. Nothing knows another service by
name: everything resolves by **role**, speaks a **Cap'n Proto contract**, passes
**capabilities**, and uses **zero-copy** where the platform allows. The UX of connection —
pairing, handoff, shared clipboard, notification sync, continue-on-another-device, remote
output — is designed, not implied.

---

## 2. The non-negotiables

Read the full laws in `../00-canon/02-design-laws.md`. Short form:

1. One fact, one owner. No shadow authority.
2. Pixels never cross a contract boundary. Capabilities, buffers and declarations do.
3. Declared, not detected. Producers declare damage; the system never diffs frames.
4. Idle is silent. No polling, no heartbeat redraws, no fake aliveness.
5. Every visible state is a numbered still: pixels, hit map, accessibility, input ownership
   and buffer lifetime are one atomic, versioned fact.
6. Authority is mandatory; policy is optional.
7. Depth communicates hierarchy: elevation, shadow, parallax, occlusion, focus dimming. Not
   glassmorphism.
8. Motion explains change: spring physics, velocity preservation, settle-and-stop.
9. Accessibility is structural, derived from the same semantics that draw the screen.
10. No permanent chrome without a timeless job. The strip replaces the dock.
11. Honesty over polish. `NOT REPORTED` is a valid answer.
12. Design before code. Gates precede implementation.

Additional binding decisions:

- **Tabs are not the primitive.** The primitive is a **Section Set**, rendered as a rail,
  segmented control, crown-scroll or list.
- **Spacious is a density mode**, not a theme.
- **Safety envelopes** (EV, spaceship) use bounded, non-overshooting motion; critical
  indicators have protected zones and never animate through occlusion.
- **Shortcuts are accelerators, never the only path.**
- **Real UX research is normative** for principles. Vendor heuristics alone are not enough.
- **Every entity is a directory**; one question per file; every flow drawn frame by frame.
- **Solar icons** are the base icon language; Naledzi glyphs cover OS-specific concepts.
  Icons are semantic names, never file paths.
- **Local-first; remote is a peer.** Offline is a normal state.
- **The remote browser is an executor**, not VNC.
- **GPU and CPU are paths of one model**, with declared fallback.
- **The palette is a foundation**, not an optional app.
- **Fullscreen is a declared behaviour**, not a hidden mode: it must specify what happens to
  the status rail, strip, notifications, gestures, focus, multi-window and safety zones.

---

## 3. The document system

Read `../00-canon/06-document-system.md` in full. Summary:

Every entity directory:

```text
<entity>/
├── README.md              index, front matter, definition, tree, status
├── 01-purpose.md          human need, timelessness, non-goals
├── 02-model.md            concepts, data, state model
├── 03-behaviour.md        normative rules, transitions, edge cases
├── 04-anatomy.md          regions, layers, parts
├── 05-layout.md           composition per envelope, density, overflow
├── 06-input.md            pointer, touch, keyboard, remote, voice, gesture
├── 07-accessibility.md    semantics, focus, announcements, adaptation
├── 08-performance.md      budgets, measurement, degradation
├── 09-capabilities.md     required, optional, refused
├── 10-failure.md          failure, rare cases, recovery
├── 11-acceptance.md       ACs, golden flows, evidence
├── 12-open-questions.md   unresolved, owner, deadline
├── 13-changelog.md
└── flows/
    ├── README.md
    └── NN-<flow>.md
```

Not every entity needs every file, but absence must be declared as `n/a — reason` in the
README. A missing file without a reason is a defect.

Every file starts with YAML front matter:

```yaml
---
id: <STABLE-ID>
title: <Title>
kind: <canon|foundation|architecture|framework|shell|app|envelope|wireframe|process|research|component|token>
entity: <entity-slug>
status: <draft|review|canon|superseded>
normative: <true|false>
version: 0.1.0
owner: <Guild or role>
depends: [<IDs>]
acceptance: [<AC IDs>]
---
```

Use stable IDs. Use normative language (`MUST`, `MUST NOT`, `SHOULD`, `MAY`) for binding
rules. Mark explanatory prose *Informative*. Every normative section has acceptance evidence.

### 3.1 No inherited inventory

Nothing is admitted because "operating systems have it". This applies to apps, shell
surfaces, framework components, settings panes, gestures and layers.

- **Apps** are derived from timeless human jobs in `05-apps/00-portfolio/`. The output is a
  portfolio with a rationale, a timelessness score, an envelope map and a rejection list.
  A name that sounds like a legacy app may survive only if the job survives and the
  composition is re-derived.
- **Shell surfaces** are derived from what a person always needs on an envelope. If a
  surface has no job on a watch or a spacecraft, it does not exist there.
- **Components** are derived from interaction primitives, not from a widget catalogue.
- **Settings panes** are derived from what the person can actually change, not from a
  vendor's settings tree.
- **Layers** must justify their responsibility. A layer that only exists because a legacy
  stack had one is removed.

The portfolio and the layer model are reviewed before app implementation. An agent that
finds itself writing "because that is how phones do it" has found a defect, not a
requirement.

---

## 4. Quality bar

A file is acceptable only if:

- It answers **one question** completely.
- It contains decisions, not a list of options. Options belong in an ADR.
- It names the envelope, input, state or failure it affects.
- It is specific enough that two teams would build the same behaviour.
- It includes the rare case, not just the happy path.
- It cites research or evidence where it makes a claim about human behaviour.
- It uses en-GB prose ("colour", "behaviour", "organisation") but keeps IDs and code in
  ASCII.
- It is **complete, not concise**. There is no line cap. A file expands until its one
  question is fully answered, every state is named, every branch is enumerated and every
  rare case is covered. Split by question rather than compressing.
- It does not silently contradict another file. If it must, it records the conflict in
  `12-open-questions.md`.

Read and obey `02-completeness-contract.md`. A "representative sample" is not a deliverable.
A summary of a flow is not a flow. A device that says "similar to phone" is a defect.

**No stubs.** A heading with "TODO" is not a deliverable. If something is genuinely
unknown, write the question, the owner and the decision deadline.

---

## 5. Research rules

Research agents MUST:

1. Run **real web searches** and fetch real pages. Do not invent studies, numbers, quotes or
   principles.
2. Prefer primary sources: standards bodies (W3C/WCAG, ISO, FAA, NASA, NHTSA, SAE, MIL-STD),
   peer-reviewed papers, original books, official platform documentation, vendor design
   systems.
3. For every principle, record:
   - the principle in one sentence;
   - the source (author, title, year, URL, access date);
   - what it predicts for Naledzi;
   - where it is implemented in this corpus (IDs);
   - the limits: where the evidence is thin, cultural, or contested.
4. Distinguish **evidence** from **interpretation**. A design implication is ours; the
   finding is the source's.
5. Never cite a source you did not actually open. A search result snippet is not a source.
6. Include a `references/` file with full citations and access dates.
7. If a web search tool is unavailable, say so in the report and use only sources already in
   the repo; do not fabricate.

Suggested source base (not exhaustive):

- Perception: Gestalt psychology (Wertheimer, Koffka, Köhler); depth cues (Gibson;
  Cutting & Vishton); motion perception.
- Cognition: Miller (1956); Baddeley & Hitch working memory; Sweller cognitive load; Hick
  (1952); Kahneman attention; Norman (1988, 2013); Clark predictive processing.
- Motor: Fitts (1954); Accot & Zhai steering law; human motor control (Flash & Hogan);
  spring-like movement; end-effector control.
- Decision and trust: prospect theory (Kahneman & Tversky); automation trust (Parasuraman &
  Riley; Lee & See); alarm fatigue (Cvach); situation awareness (Endsley).
- Safety-critical: FAA HF-STD-001; NASA-STD-3001; MIL-STD-1472; NHTSA driver distraction
  guidelines; SAE J3016; ISO 26262 where relevant; ARINC 661.
- Accessibility: WCAG 2.2; WAI-ARIA; ISO 9241; vestibular disorders and motion sickness
  literature; colour vision deficiency; switch access.
- Typography: Bringhurst; legibility research (Tinker; Dyson); screen reading; variable
  fonts.
- Platform prior art: Apple HIG, Material, Fluent, GNOME HIG, KDE HIG, Fuchsia, Wayland,
  Android SurfaceFlinger, iOS Core Animation, Vulkan, DRM/KMS, DMA-BUF.
- Protocol: Cap'n Proto documentation; capability-based security (Dennis & Van Horn;
  Miller, "Robust Composition").
- Rust: the Rust Book, Rustonomicon, Rust API Guidelines, `no_std` embedded guidance,
  recent release notes.

Use the real URL and access date in the citation. If a claim is contested, say so.

---

## 6. The full tree

The corpus is being built out to this shape. Agents own disjoint subtrees.

**The app list below is illustrative, not canon.** No app is admitted because a legacy OS
has one. The portfolio is derived in `05-apps/00-portfolio/` from timeless human jobs, the
envelope's capabilities and the UX research. The calculator is retained as a
**reproducibility exemplar** — a small, unforgiving proof that the standard works — not as a
mandate that every device must ship a calculator. Agents must not hardcode app names into
the shell, framework, envelopes or wireframes; they compose around **jobs** and the derived
portfolio.

```text
docs/ui-canon/
├── README.md
├── 00-canon/                  constitution, laws, glossary, ADRs, anti-patterns, doc system
├── 01-foundations/
│   ├── depth/                 light, elevation, shadow, parallax, occlusion
│   ├── motion/                springs, choreography, determinism, reduced motion
│   ├── typography/            type system, scales, scripts, numerals
│   ├── color/                 roles, light/dark, contrast, colour science
│   ├── iconography/           Solar + Naledzi glyphs, weights, rendering
│   ├── sound-haptics/         audio cues, haptics, silence
│   ├── accessibility/         structure, focus, assistive tech, adaptation
│   └── experience/            felt experience, personas, emotion, onboarding, rare cases
├── 02-architecture/
│   ├── presentation/          stills, commit, authority, policy, executor
│   ├── rendering/             paths, damage, buffers, fences, GPU/CPU, composition
│   ├── protocol/              capabilities, roles, discovery, schema evolution
│   ├── runtime/               services, lifecycles, envelopes
│   ├── security/              revocation, secure surfaces, observation rights
│   ├── performance/           budgets, measurement, regressions
│   └── ecosystem/             pairing, continuity, handoff, clipboard, remote, sync
├── 03-framework/
│   ├── runtime/               MirUI, ECS, scheduler, layout, text, damage
│   ├── components/            one directory per component
│   ├── tokens/                colour, type, space, depth, motion, icon, radius
│   ├── palette/               command palette, search, actions, voice
│   ├── adaptivity/            envelope archetypes, responsive rules, density
│   └── rust/                  modern Rust, no_std, allocation, style
├── 04-shell/
│   ├── model/                 what the shell is and is not
│   ├── fullscreen/            fullscreen behaviour, immersive mode, system UI
│   ├── strip/                 the depth card reel
│   ├── status-rail/           adaptive indicator rail
│   ├── notifications/         delivery, priority, history
│   ├── spaces/                workspaces, focus, switcher
│   ├── gestures/              global gesture grammar
│   ├── lock/                  lock screen, session, identity
│   ├── lifecycle/             boot, first-run, login, update, recovery, shutdown
│   └── shortcuts/             global shortcut registry and per-envelope bindings
├── 05-apps/
│   ├── _standard/             the contract every app signs
│   ├── calculator/            exemplar, fully specified
│   ├── settings/              full system settings
│   ├── files/ notes/ terminal/ clock/
│   ├── video/ music/ photos/ camera/ browser/
│   ├── mail/ messages/ calendar/ maps/ weather/ health/
│   └── store/ agent-console/
├── 06-envelopes/
│   ├── _standard/
│   ├── watch/ phone/ tablet/ desktop/ tv/
│   ├── ev/ spaceship/ iot/ spatial/ remote-browser/
├── 07-wireframes/
│   ├── 00-standard.md
│   ├── shells/                full OS frames per device
│   ├── modes/spacious/        spacious frames
│   ├── cross-app/             palette, permissions, drag, offline, rare cases
│   ├── cross-device/          pairing, handoff, clipboard, notification sync, cast
│   └── shortcuts/             shortcut maps and palettes per envelope
├── 08-process/
│   ├── agentic workflow, roles, research protocol, spec protocol,
│   ├── review gates, implementation protocol, acceptance gates,
│   └── roadmap, changelog, open questions
└── 09-research/
    ├── ux-principles/         perception, cognition, motor, emotion, trust, learning,
    │                          attention, safety-critical, accessibility, culture, sources
    ├── prior-art/             platforms, depth, input, apps
    ├── depth/ motion/ input/ performance/ timelessness/
    └── references/            full bibliography
```

---

## 7. Specific asks from the product owner

These are requirements, not suggestions:

0. **The app portfolio is derived, not inherited.** `05-apps/00-portfolio/` must state the
   timeless human jobs, the admission test, the candidates, the envelope map, and the
   rejected legacy categories. Do not hardcode an app list into the shell, framework,
   envelopes or wireframes. The calculator is the reproducibility exemplar only.
1. **Fullscreen behaviour** is specified for every envelope: what hides, what remains, how
   the user exits, how notifications behave, how focus and gestures work, what happens to
   multi-window and safety zones.
2. **The full Settings app** exists: every pane a person needs to run the OS — appearance,
   display, sound, notifications, privacy, network, Bluetooth, power, storage, users,
   apps, accessibility, language, date/time, updates, about, developer, recovery, security,
   keyboard, pointer/touch, and device-specific panes.
3. **The felt experience** is designed: how the person feels, not just what they click.
   Confidence, calm, control, trust, flow, delight, error recovery, stress, cognitive load,
   onboarding, learnability, dignity, cultural difference.
4. **Rare cases** are designed, not left to the crash: no network, no storage, denied
   permissions, low battery, thermal throttling, corrupted data, conflicts, multiple users,
   guest/kiosk, updates mid-work, hardware failure, accessibility extremes, RTL, 200% text,
   reduced motion, motion sickness, alarm fatigue.
5. **Unified capnp ecosystem**: nothing knows another service by name; roles, discovery,
   capabilities, zero-copy. The connected-device UX is specified: phone ↔ PC, phone ↔ car,
   phone ↔ watch, desktop ↔ TV, spacecraft redundancy.
6. **EV UI**: full interfaces and frames, protected zones, glare, vibration, one-hand,
   passenger vs driver, charging, navigation, media, climate, phone handoff, Android
   Auto-like projection but better, and adaptation to bespoke vehicle form factors.
7. **Spaceship UI**: deterministic timing, redundancy, alarms, procedure-first failure,
   high workload, gloves, glare, non-rectangular displays.
8. **Every bespoke form factor adapts**: foldables, ultra-wide, portrait/landscape,
   non-rectangular, multi-display, remote browser, spatial. No feature fork; content is
   re-flowed, collapsed, paged or moved to a peer.
9. **One OS to rule them all**: the same app grammar on every device, with envelope-specific
   composition. Phone and PC run the same OS and are connected by designed UX.

---

## 8. Agent boundaries

- Write only inside your assigned subtree. Do not edit the root `README.md`, `00-canon/`,
  or another agent's directory.
- Do not create implementation code. This corpus is design, contracts and acceptance.
- Do not delete or overwrite existing files outside your assignment.
- If you need a shared file (e.g., a token index), write a local proposal and note it in your
  report; do not edit the shared file.
- If you must reference a component or token that does not exist yet, use its proposed ID and
  record it in `12-open-questions.md`.
- Leave a short report at the end: files written, decisions made, sources used, gaps,
  conflicts.

---

## 9. Formatting conventions

- Headings: `#`, `##`, `###`; no skipped levels.
- Tables for matrices, budgets, bindings, priorities.
- ASCII wireframes in fenced `text` blocks, ≤ 80 columns where possible.
- Numbered frames: `Frame 1 — <state>`.
- Normative IDs: `LAW-###`, `ARCH-###`, `FW-###`, `SHELL-###`, `APP-###`, `ENV-###`,
  `WF-###`, `PROC-###`, `RES-###`, `AC-###`.
- Cross-references are relative Markdown links.
- No emoji in normative text.
- British spelling in prose; ASCII in IDs, file names and code.

---

## 10. Definition of done for an agent

- Every assigned directory has a `README.md` and the declared files.
- No stubs; every file has content a second team can act on.
- Every flow has frames; every frame has state, focus, action, transition.
- Every claim about human behaviour has a source or is marked as a design hypothesis.
- Every AC has a test.
- The report lists what is done and what is not.
