# Naledzi UI Canon — Context and Programme

> This repository is the **design source of truth** for the Naledzi interface. The OS may
> replace any implementation; this corpus is how the replacement knows what it must remain.
>
> **Repository:** smart-foundation/naledzi-ui-canon
> **Corpus version:** 0.1.0
> **Date:** 24 October 2026

---

## 1. What this is

The Naledzi UI Canon is a tree of Markdown entity directories that specifies the entire
human-facing system of Naledzi OS — across every device envelope, in enough detail that
different teams can implement the same experience in different UI languages and get the
same behaviour, hierarchy, focus, wording and states.

It is **design truth**, written before implementation, validated before code. It is not
marketing, not a mood board, not a code dump.

### Core principle

**Timelessness is the only design goal.** A thing earns its place only if it still makes
sense when the input device, the display, the form factor and the decade have all changed.
"Everyone has one" is not a justification. "It has always been this way" is not a
justification. "It is beautiful" is not sufficient.

### Second principle

**Depth, not glassmorphism.** Hierarchy made visible through space, light, occlusion and
motion — not through decoration. Glassmorphism is a surface treatment; depth is a model
of space. We build the model.

---

## 2. The one goal and the non-negotiables

### Timelessness

Every primitive, widget, gesture, screen, token, protocol field, and component must pass
the timelessness test (`00-canon/01-timelessness-test.md`). The test scores 10 criteria
(0–2 each, max 20). Minimum 16, no 0 on criteria 1–4.

### Non-negotiables (12 laws)

1. **One fact, one owner.** No second copy, no shadow authority, no "keep it in sync."
2. **Pixels never cross a contract boundary.** A boundary carries capabilities, buffers
   and declarations — not raw pixels and not global pointers.
3. **Declared, not detected.** The producer declares what changed. The system never diffs
   frames to discover dirt.
4. **Idle is silent.** No polling, no heartbeat redraws, no animation that exists to look
   alive.
5. **Every visible state is a numbered still.** Pixels, hit targets, accessibility, input
   ownership and buffer lifetime are one atomic, versioned fact.
6. **Authority is mandatory; policy is optional.** Validation and crash-safe truth are
   always present. Layout and arbitration are a replaceable app, absent on simple devices.
7. **Depth communicates hierarchy.** Elevation, shadow, parallax and occlusion have meaning.
   Nothing floats for decoration.
8. **Motion explains change.** A spring is an explanation of what moved and why, not a
   garnish. It settles and stops.
9. **Accessibility is structural.** Derived from the same semantics that draw the screen,
   never scraped afterwards.
10. **No permanent chrome without a timeless job.** A dock, a bar, a tab strip or a
    floating button must answer "what does a human always need here?" on every envelope,
    or it does not exist.
11. **Honesty over polish.** Unsupported, denied, unknown and degraded states are shown
    as such. `NOT REPORTED` is a valid, premium answer.
12. **Design before code.** A slice may not be implemented until its gate is passed.

### Additional binding decisions (ADRs)

| ADR | Decision |
|---|---|
| ADR-0001 | Numbered stills are the presentation truth |
| ADR-0002 | Authority is mandatory; policy is optional |
| ADR-0003 | MirUI is the app-side runtime, not the compositor |
| ADR-0004 | Depth, not glassmorphism |
| ADR-0005 | Spring physics is the motion foundation |
| ADR-0006 | The strip replaces the dock |
| ADR-0007 | The status rail is adaptive and UX-owned |
| ADR-0008 | Damage is declared, not detected |
| ADR-0009 | Buffers are capabilities; no global raw pointers |
| ADR-0010 | Solar icons plus a Naledzi glyph set |
| ADR-0011 | Every entity is a directory |
| ADR-0012 | Tabs are transformed into a Section Set |
| ADR-0013 | The remote browser is an executor, not VNC |
| ADR-0014 | GPU and CPU are paths of one model |
| ADR-0015 | Design gates precede implementation |
| ADR-0016 | Spacious is a density mode, not a theme |
| ADR-0017 | Safety envelopes use bounded motion |
| ADR-0018 | The palette is a foundation |
| ADR-0019 | Local first; remote is a peer |
| ADR-0020 | Spaceship and spatial envelopes are first-class |
| ADR-0021 | Shortcuts are accelerators, never the only path |
| ADR-0022 | Real UX research is normative for principles |

Full ADR text: `ui-canon/00-canon/04-decision-log.md`

---

## 3. The entity model

Every entity is a directory. Every directory has a `README.md` that is its index and
manifest. Files answer **one question each**. The same anatomy everywhere.

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

Not every entity needs every file. The manifest in `README.md` declares which files exist
and which are intentionally absent (`n/a — reason`). A missing file without a declared
reason is a defect.

See `ui-canon/00-canon/06-document-system.md` for the exact front matter, identifiers,
statuses and review rules.

---

## 4. The full tree

```
docs/ui-canon/
├── README.md
├── 00-canon/                  constitution, laws, glossary, ADRs, anti-patterns, doc system
├── 01-foundations/
│   ├── depth/                 space, light, elevation, shadow, parallax, occlusion (COMPLETE)
│   ├── motion/                spring physics, choreography, determinism (COMPLETE)
│   ├── typography/            type system, scales, scripts, numerals
│   ├── color/                 roles, light/dark, contrast, colour science (PARTIAL)
│   ├── iconography/           Solar set + Naledzi glyphs + rendering pipeline
│   ├── sound-haptics/         audio cues, haptics, silence
│   ├── accessibility/         structure, focus, assistive tech, adaptation
│   └── experience/            felt experience, personas, emotion, onboarding, rare cases (COMPLETE)
├── 02-architecture/
│   ├── presentation/          stills, commit, authority, policy, executor (COMPLETE)
│   ├── rendering/             paths, damage, buffers, fences, GPU, CPU, composition (COMPLETE)
│   ├── protocol/              capabilities, roles, discovery, schema evolution (COMPLETE)
│   ├── runtime/               services, lifecycles, envelopes (COMPLETE)
│   ├── security/              revocation, secure surfaces, observation rights (COMPLETE)
│   ├── performance/           budgets, measurement, regressions (COMPLETE)
│   └── ecosystem/             pairing, continuity, handoff, clipboard, remote, sync (COMPLETE)
├── 03-framework/
│   ├── runtime/               MirUI, ECS, scheduler, layout, text, damage
│   ├── components/            one directory per component
│   ├── tokens/                color, type, space, depth, motion, icon, radius
│   ├── palette/               command palette, search, actions
│   ├── adaptivity/            envelope archetypes, responsive rules, density
│   └── rust/                  modern Rust, no_std, allocation, style
├── 04-shell/
│   ├── model/                 what the shell is and is not
│   ├── fullscreen/            fullscreen behaviour, immersive mode, system UI
│   ├── strip/                 the depth card reel (navigation + launch)
│   ├── status-rail/           adaptive, UX-owned indicator rail
│   ├── notifications/         delivery, priority, history
│   ├── spaces/                workspaces, focus, switcher
│   ├── gestures/              the global gesture grammar
│   ├── lock/                  lock screen, session, identity
│   ├── lifecycle/             boot, first-run, login, update, recovery, shutdown
│   └── shortcuts/             global shortcut registry and per-envelope bindings
├── 05-apps/
│   ├── _standard/             the contract every app signs (COMPLETE)
│   ├── 00-portfolio/          derived app portfolio (COMPLETE)
│   ├── settings/              full system settings (README only)
│   ├── calculator/            exemplar tree, fully specified
│   └── (other apps from derived portfolio)
├── 06-envelopes/
│   ├── _standard/             envelope profile (PARTIAL)
│   ├── watch/ phone/ tablet/ desktop/ tv/
│   ├── ev/ spaceship/ iot/ spatial/ remote-browser/
│   └── cross-device/          pairing, handoff, clipboard, notification sync, cast
├── 07-wireframes/
│   ├── 00-standard.md
│   ├── shells/                desktop, phone, watch, tv, ev
│   ├── modes/spacious/        spacious frames (COMPLETE)
│   ├── cross-app/             first-run, palette, permissions, drag, offline, rare cases
│   ├── cross-device/          pairing, handoff, clipboard, notification sync, cast
│   └── shortcuts/             shortcut maps and palettes per envelope
├── 08-process/
│   ├── 00-master-brief.md     (COMPLETE)
│   ├── 01-layer-model.md     (COMPLETE)
│   ├── 02-completeness-contract.md (COMPLETE)
│   ├── 03-append-only-protocol.md (COMPLETE)
│   ├── 19-agent-waves.md     (COMPLETE)
│   └── (remaining process files)
├── 09-research/
│   ├── 00-matrix.md           (COMPLETE)
│   ├── ux/                    UX principles (COMPLETE)
│   ├── prior-art/
│   ├── depth/ motion/ input/ performance/ timelessness/
│   └── references/
├── 10-assurance/              (not started — accessibility, safety, security, etc.)
├── 11-ai-interaction/         (not started)
└── 11-ai-interaction/         (AI interfaces for OS)
```

---

## 5. What is complete vs. in progress

### Complete

| Subtree | Files | Notes |
|---|---|---|
| `00-canon/` | 6 | Constitution, laws, glossary, ADRs, anti-patterns, doc system |
| `01-foundations/depth/` | 19 | Full depth foundation with research citations |
| `01-foundations/motion/` | 17 | Full spring physics foundation with research citations |
| `01-foundations/experience/` | 11 | Felt experience, personas, rare cases, onboarding |
| `01-foundations/color/` | 6 | Colour model, roles, light/dark, contrast, colour vision (partial — needs tokens, envelopes, etc.) |
| `02-architecture/` | 84 | All 7 branches complete with research citations |
| `05-apps/_standard/` | 12 | Full app contract, state machine, flow spec, input, a11y, performance, capabilities, failure, acceptance, reproducibility |
| `05-apps/00-portfolio/` | 11 | Derived portfolio: 25 candidates, 8 rejections, envelope map, naming, acceptance |
| `07-wireframes/modes/spacious/` | 5 | Spacious density frames |
| `08-process/` | 6 | Master brief, completeness contract, append-only protocol, agent waves, layer model |
| `09-research/ux/` | 18 | Full UX research base with real sources |
| `09-research/00-matrix.md` | 1 | Research coverage matrix |

### In progress / not started

| Subtree | Status | What's needed |
|---|---|---|
| `01-foundations/typography/` | Not started | Type system, legibility, scripts, numerals, dynamic type |
| `01-foundations/iconography/` | Not started | Solar license verification, Naledzi glyphs, semantic names, rendering |
| `01-foundations/sound-haptics/` | Not started | Audio language, haptics, safety alarms, silence |
| `01-foundations/accessibility/` | Not started | Structure, focus, announcements, vision, motor, hearing, cognitive, vestibular |
| `03-framework/` | README only | MirUI runtime, tokens, components, palette, adaptivity, Rust |
| `04-shell/` | Not started | Model, fullscreen, strip, status rail, notifications, spaces, gestures, lock, lifecycle, shortcuts |
| `05-apps/settings/` | README only | All settings panes and flows |
| `05-apps/calculator/` | Not started | Exemplar app with full flows |
| `06-envelopes/` | README + profile only | All 10 envelopes, EV, spaceship, cross-device |
| `07-wireframes/` | Spacious only | Full OS frames per device, cross-app, cross-device, shortcuts |
| `08-process/` | 6 files | Roles, research protocol, spec protocol, gates, implementation, acceptance, roadmap, changelog, open questions |
| `09-research/` | UX + matrix only | Prior art, depth, motion, input, performance, timelessness, references |
| `10-assurance/` | Not started | Accessibility, safety, security, privacy, reliability, legal, sustainability |
| `11-ai-interaction/` | Not started | AI interfaces for OS |
| `01-foundations/locale/` | Not started | Localization, culture |
| `01-foundations/voice/` | Not started | Voice interaction |

---

## 6. The derived app portfolio

25 candidate apps derived from 12 timeless human needs (not from legacy app categories).
8 legacy categories rejected (file manager as folder-tree, browser as chrome-and-tabs,
settings as vendor tree, app store as grid, home screen as icon grid, dock, widget
dashboard, notification centre as separate place).

Full portfolio: `ui-canon/05-apps/00-portfolio/`

| # | Name | Job | Score | Status |
|---|---|---|---|---|
| 1 | calculator | get a number | 20 | canon (proposed) exemplar |
| 2 | converter | express a quantity in a familiar unit | 17 | provisional |
| 3 | terminal | type a command for unexposed control | 15 | provisional (review) |
| 4 | notes | capture an idea in <5s | 19 | provisional |
| 5 | files | find what I stored | 18 | provisional |
| 6 | camera | capture a view faithfully | 17 | provisional |
| 7 | photos | revisit/share a captured image | 18 | provisional |
| 8 | music | play sound with minimal friction | 18 | provisional |
| 9 | video | watch with safe interruption | 18 | provisional |
| 10 | studio | compose/edit media | 16 | provisional |
| 11 | browser | read and navigate information | 16 | provisional |
| 12 | mail | correspond formally with a record | 17 | provisional |
| 13 | messages | converse informally | 18 | provisional |
| 14 | people | reach and remember a person | 17 | provisional |
| 15 | calendar | see conflicts before they happen | 18 | provisional |
| 16 | tasks | track commitments to done | 17 | provisional |
| 17 | maps | route fitting my constraints | 17 | provisional |
| 18 | weather | know the sky at a glance | 17 | provisional |
| 19 | health | know early and calmly | 17 | provisional |
| 20 | clock | know time, wake, rest | 18 | provisional |
| 21 | wallet | pay/prove identity with a record | 16 | provisional |
| 22 | store | get a capability I lack | 16 | provisional |
| 23 | home-control | fix environment in one action | 17 | provisional |
| 24 | settings | change what the system does, safely | 19 | provisional (review) |
| 25 | agent-console | direct and review agent actions | 16 | provisional |

Shell/system surfaces (not apps): lock, palette/search, strip, status rail, notifications,
permission prompts, onboarding, updates/recovery, home/idle, quick settings,
multi-window/spaces, fullscreen behaviour.

---

## 7. The layer model

8 responsibility-derived layers:

1. **Substrate / contracts** — Cap'n Proto schemas, capabilities, roles, discovery
2. **Presentation truth** — numbered stills, authority, policy, executor
3. **Shell / policy** — strip, status rail, notifications, spaces, gestures, lock, lifecycle
4. **App framework** — MirUI, ECS, layout, text, damage, tokens, components, palette
5. **Apps / job surfaces** — the derived portfolio
6. **Envelopes / adaptation** — per-device composition, safety, performance
7. **Foundations / cross-cutting** — depth, motion, type, colour, icons, sound, a11y, UX
8. **Process / research** — agentic workflow, gates, acceptance, research base

10 rejected layers (exist only because legacy OS had them): compositor as monolith,
window manager, theme engine, animation framework, accessibility scraper, notification
centre as app, settings as vendor tree, home screen as icon grid, dock, widget engine.

Full layer model: `ui-canon/08-process/01-layer-model.md`

---

## 8. Cross-cutting inputs (must not be forgotten)

These are sources and concerns wired into the programme:

- **MirUI** is the app-side runtime, not the compositor (ADR-0003). Framework agent
  must read `Smart_UI_Framework_Specification_v2.md` and `ui-layer-mirui.md`.
- **Solar icon licensing** must be verified by real web search.
- **GPU-blitter session** (`ses_eb1d58bcfffentA4qBMXC7lp1a`) is a separate
  implementation concern. Architecture agent recorded contract gaps.
- **Cap'n Proto contract truth** is in `protocol/schemas/`. Every wire fact cites
  `protocol/schemas/*.capnp:<line>`.
- **services.toml** defines the enabled service set.
- **Felt experience** is a design deliverable: confidence, calm, control, trust, flow,
  delight, error recovery, stress, cognitive load, onboarding, learnability, dignity.
- **Rare cases** are designed, not left to the crash.
- **Full Settings app** is a complete system control surface.
- **Fullscreen behaviour** is a declared behaviour per envelope.
- **EV UI** is a full interface set: zones, driving states, driver/passenger, glare,
  vibration, phone handoff, bespoke form factors.
- **Spaceship UI** is deterministic timing, redundancy, alarms, procedures, high
  workload, gloves, glare, non-rectangular displays.
- **Cross-device UX** (phone ↔ PC): pairing, handoff, shared clipboard, notification
  sync, continue-on-another-device, remote output, remote input.
- **One OS to rule them all**: same app grammar on every device, envelope-specific
  composition, no feature forks.
- **AI interfaces**: agent-console, AI-assisted search, AI-suggested actions, AI
  summarisation, AI accessibility, AI automation with preview and undo, AI
  personalisation, AI anomaly detection. Autonomy levels, intent preview, confirmation,
  explainability, memory consent, interruption, trust calibration, failure taxonomy.
- **Wireframes for every surface**: full OS frames per device, all states, all rare cases.
- **Full user flows**: every frame, branch, error, accessibility path, performance notes.
- **Step-by-step flow diagrams**: state transitions drawn as diagrams. Decision trees
  for branching flows.
- **Info graphics**: architecture diagrams, state machines, envelope matrices, coverage
  matrices, layer dependency diagrams.
- **Timelessness in every layer**: every primitive, widget, gesture, screen, token,
  protocol field must pass the timelessness test.

---

## 9. The append-only protocol

Shared documents are append-only. New direction is a new file or a dated addendum.
Superseded material is marked and kept. No overwrites, no deletions without ADR.

Full protocol: `ui-canon/08-process/03-append-only-protocol.md`

---

## 10. The completeness contract

Size is not the risk; a cut layer is. A file may be long. A flow may have many frames.
An envelope may have many rare cases. The corpus expands until every question is answered.

No stubs. No "similar to." No representative samples. Every matrix cell is filled or
explicitly absent.

Full contract: `ui-canon/08-process/02-completeness-contract.md`

---

## 11. The agent programme

Agents are dispatched in waves of 2, sequentially. Each wave is reviewed before the next
is dispatched. Every agent reads the master brief, completeness contract, and append-only
protocol before writing.

### Completed waves

| Wave | Agents | Status |
|---|---|---|
| 1 | UX research + felt experience; Foundations (depth, motion); Architecture + ecosystem; Portfolio + layer model | Complete (partial — some agents hit rate limits) |
| 2 | Framework (incl. MirUI); Shell / OS behaviour | Rate limited — needs re-dispatch |
| 3 | Envelopes (EV, spaceship, all 10, cross-device) | Rate limited — needs re-dispatch |

### Queued waves

| Wave | Agents | Status |
|---|---|---|
| 4 | Settings children (all panes + flows); Wireframes (full OS frames per device) | Queued |
| 5 | Process completion (roles, gates, roadmap, changelog, open questions); Assurance (accessibility, safety, security, privacy, reliability, legal, sustainability) | Queued |
| 6 | Specialisms (AI interaction, content/locale/voice, developer ecosystem, data surfaces, integration auditor) | Queued |

Full wave plan: `ui-canon/08-process/19-agent-waves.md`

---

## 12. Key files to read first

1. `ui-canon/README.md` — corpus index
2. `ui-canon/00-canon/00-manifesto.md` — why this exists
3. `ui-canon/00-canon/01-timelessness-test.md` — how a thing earns its place
4. `ui-canon/00-canon/02-design-laws.md` — the binding laws
5. `ui-canon/00-canon/06-document-system.md` — how the corpus is structured
6. `ui-canon/01-foundations/depth/README.md` — the visual model
7. `ui-canon/01-foundations/motion/README.md` — the motion model
8. `ui-canon/02-architecture/presentation/README.md` — how a still becomes visible
9. `ui-canon/05-apps/_standard/README.md` — how an app is specified
10. `ui-canon/08-process/00-master-brief.md` — how the corpus is built and kept true

---

## 13. Relationship to existing documents

This corpus is the **UI** source of truth. It does not replace:

- `docs/NALEDZI.md` — what the OS is
- `docs/DESIGN.md` — the complete system specification and current-state audit
- `protocol/schemas/*.capnp` — the wire contract
- `docs/ux-design.md` — the console/TUI design system
- `docs/SMART-PROTOCOL.md` — protocol architecture

Where an older document covers the same ground, this corpus links to it and states which
is authoritative. No document is silently overridden.

---

## 14. The rule for contributors

> Do not add a screen. Add a **need**, a **flow**, a **state machine** and a **test** —
> then the screen is the residue.

If you cannot state the human need in one sentence, the screen is not ready. If you
cannot name the state transition it performs, the interaction is not ready. If you cannot
describe how it fails, it is not ready. If it only makes sense on one device, it is not
timeless. If it needs a paragraph of explanation to be usable, it is not finished.

---

*This document was created on 24 October 2026 as part of the Naledzi UI Canon programme.*
*It is a living document. New direction is appended, never overwritten.*
