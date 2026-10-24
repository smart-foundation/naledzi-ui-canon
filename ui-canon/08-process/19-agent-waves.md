---
id: PROC-AGENT-WAVES
title: Agent Waves and Dispatch Control
kind: process
entity: process
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [PROC-MASTER-BRIEF, PROC-COMPLETENESS, PROC-APPEND-ONLY]
acceptance: [AC-PROC-WAVES-001]
---

# Agent Waves and Dispatch Control

> Agents are employees, not a swarm. Each wave is dispatched only after the previous wave
> has reported, been reviewed and had its conflicts recorded. Overlapping waves are allowed
> only for genuinely disjoint, non-dependent work.

---

## 1. The rule

- **One wave at a time.**
- A wave is closed when every agent has reported and the Canon Editor has reviewed:
  - the files written;
  - the coverage matrix;
  - contradictions with other subtrees;
  - missing cells;
  - proposed shared IDs.
- No new agent is dispatched into a subtree that is still being written.
- A failed or incomplete agent is re-tasked before a new wave starts.
- The integration editor does not start until the wave's subtrees are stable.

---

## 2. Wave 1 — foundations of the corpus (in flight)

| Owner | Subtree | Status |
|---|---|---|
| UX Research + Felt Experience | `09-research/`, `01-foundations/experience/` | running |
| Foundations | `01-foundations/` (depth, motion, type, colour, icons, sound/haptics, a11y) | running |
| Systems Architecture + Ecosystem | `02-architecture/` | running |
| Portfolio + Layer Model | `05-apps/00-portfolio/`, `08-process/01-layer-model.md` | running |
| Framework | `03-framework/` | running |
| Shell / OS Behaviour | `04-shell/` | running |
| Envelopes (watch→spaceship) | `06-envelopes/` | running |
| Full Settings | `05-apps/settings/` | running |
| Process / Governance | `08-process/` | running |
| Accessibility / Inclusion / Usability | `10-assurance/accessibility/`, `09-research/usability/` | running (last of wave) |

**Gate 1:** review each subtree against `02-completeness-contract.md`; record conflicts;
freeze the shared IDs (tokens, components, commands, capabilities, envelope names).

---

## 3. Wave 2 — critical assurance and specialisms (queued)

Dispatch only after Gate 1. These are disjoint from Wave 1 paths, or append new files to
existing trees.

| Owner | Subtree | Why it is critical |
|---|---|---|
| Safety, Reliability and Sustainability | `10-assurance/safety/`, `10-assurance/reliability/`, `10-assurance/sustainability/` | Hazard analysis, alarm doctrine, degraded modes, fault injection, longevity, low-end hardware, energy. |
| Security, Privacy, Trust and Family Safety | `10-assurance/security-privacy/`, `10-assurance/family-child/` | Capability UX, consent ledger, observation rights, lost device, recovery, child safety without surveillance. |
| Content, Localization, Voice and Culture | `01-foundations/locale/`, `01-foundations/voice/`, `09-research/content/`, `05-apps/_standard/12-content-and-voice.md` | Message algebra, translation-safe strings, RTL/scripts/numerals, voice grammar, cultural risk. |
| Human-AI Interaction | `11-ai-interaction/` | Autonomy ladder, intent preview, explainability, memory consent, interruption, agent failure. |
| Developer Ecosystem and SDK | `03-framework/sdk/`, `09-research/developer-ecosystem/` | Third-party apps, capability manifests, distribution, review, reproducibility, versioning. |
| Data Surfaces | `03-framework/data-surfaces/`, `09-research/data-visualization/` | Charts, maps, tables, uncertainty, real-time data, accessible visualisation. |
| Integration / Canon Auditor | `08-process/20-integration-audit.md` + conflict register | Cross-subtree contradictions, duplicated facts, ID collisions, coverage gaps. |

---

## 4. Wave 3 — applied surfaces (queued)

Depends on the derived portfolio (`05-apps/00-portfolio/`) and the envelope specs.

| Owner | Subtree | Why |
|---|---|---|
| App leads (split by job domain, not legacy category) | `05-apps/<derived>/` | Implement the admitted portfolio to the full app standard; calculator is the exemplar. |
| Wireframes — OS and devices | `07-wireframes/` | Full OS frames per device, every state, every rare case, spacious and spaceship frames. |
| Cross-device UX | `07-wireframes/cross-device/`, `07-wireframes/shortcuts/` | Pairing, handoff, clipboard, notification sync, cast, remote input, shortcut maps. |
| Onboarding and Help | `05-apps/onboarding/` or shell surface, `09-research/learning/` | First-run, progressive disclosure, in-product help, learnability. |

---

## 5. Wave 4 — closure (queued)

| Owner | Deliverable |
|---|---|
| Completeness Auditor | Full tree audit, stub audit, matrix audit, ID audit, append-only audit. |
| Reproducibility Lead | Second-implementation trial for the calculator and one complex app. |
| Integration Editor | Final canon merge, changelog, supersession map, open-question register. |
| Release Gate | `08-process/07-review-gates.md` sign-off. |

---

## 6. Dispatch checklist

Before dispatching any agent:

- [ ] The previous wave has reported.
- [ ] The assigned paths are disjoint from active work.
- [ ] The agent has read `00-master-brief.md`, `02-completeness-contract.md` and
      `03-append-only-protocol.md`.
- [ ] The agent has a coverage matrix and a definition of done.
- [ ] The agent knows what it must not touch.
- [ ] The agent will append, not overwrite.
- [ ] The output will be reviewed before the next wave.

---

## 6.4 Wireframes, flows, AI, and futuristic scope (append)

The user requires that the corpus is **complete, unmatched and thorough in all layers**, and
that the OS shows everything it can offer. The following must be woven into every relevant
subtree, not treated as optional add-ons:

- **Wireframes for every surface.** Full OS frames per device: boot, first-run, lock, home,
  app, fullscreen, switcher, notifications, palette, settings root, every settings pane,
  permission prompts, error/offline/degraded, update/recovery, shutdown, safety states,
  rare cases. ASCII wireframes in fenced `text` blocks, ≤ 80 columns. No "similar to
  phone" substitutions.
- **Full user flows.** Every flow has every frame, every branch, every error, the
  accessibility path, the performance notes, and the acceptance. No flow is "covered by
  another flow" unless the shared flow is linked and the difference is declared.
- **Step-by-step flow diagrams.** State transitions drawn as diagrams, not just tables.
  Decision trees for branching flows (permission prompts, onboarding, recovery, update).
- **AI interfaces for the OS.** The OS is driven by AI in places: agent-console (already
  in the portfolio), AI-assisted search, AI-suggested actions, AI summarisation, AI
  accessibility (describe screen, read aloud), AI automation with preview and undo,
  AI-driven personalisation, AI anomaly detection. These need: autonomy levels, intent
  preview, confirmation, explainability, memory consent, interruption contract, trust
  calibration, failure taxonomy, human-AI handoff, agent observability, no fake
  intelligence. Dedicated subtree: `11-ai-interaction/`.
- **Futuristic and unique surfaces.** Spatial (AR/VR/neural), non-rectangular displays,
  multi-display, foldables, ultra-wide, portrait/landscape, remote browser as executor,
  phone-as-display, PC-as-compute, TV cast, car projection, spacecraft redundancy.
  These are first-class envelopes, not skins.
- **Decision trees.** Branching logic for: permission prompts, onboarding, recovery,
  update, pairing, conflict resolution, degraded mode, safety escalation. Drawn as
  diagrams, not prose.
- **Info graphics.** Architecture diagrams, state machines, envelope matrices, coverage
  matrices, layer dependency diagrams, data flow diagrams. ASCII or structured text.
- **Timelessness in every layer.** Every primitive, widget, gesture, screen, token, and
  protocol field must pass the timelessness test (`00-canon/01-timelessness-test.md`).
  "Everyone has one" is not a justification.
- **Append to everything.** New direction is a new file or a dated addendum. Superseded
  material is marked and kept. No overwrites, no deletions without ADR.

## 6.5 Cross-cutting inputs the queue must not forget:

These are sources and concerns that must be wired into the queued agents, not afterthoughts:

- **MirUI is the app-side runtime, not the compositor** (`ADR-0003`). The framework agent MUST read `/home/lufuno/Downloads/Smart_UI_Framework_Specification_v2.md` (~1800 lines) and `/home/lufuno/.opencode/plan/ui-layer-mirui.md` before writing `03-framework/`. MirUI's ECS, layout, raster, text, damage, animation, scheduler, and adapter boundary are the framework's core. The framework agent must cite repo file:line for real MirUI behaviour, not invent APIs.
- **Solar icon licensing** must be verified by real web search (foundations agent). The iconography subtree must not assume a permissive license; if Solar is not usable, an alternative set must be proposed with an ADR.
- **GPU-blitter session** (`ses_eb1d58bcfffentA4qBMXC7lp1a`, slug `misty-knight`) is a separate implementation concern, not part of the design canon. It must be resumed separately after design gates pass. The architecture agent must record the contract gap (role tags, discovery registration, `gpu-intel` vs `hal` mismatch) in `07-open-questions.md` so the implementation agent knows what to fix.
- **Cap'n Proto contract truth** is in `/home/lufuno/naledzi/protocol/schemas/`. Every wire fact in the architecture subtree must cite `protocol/schemas/<file>.capnp:<line>`. The architecture agent must not invent fields.
- **services.toml** defines the enabled service set. The runtime agent must read it and not assume a count.
- **GPU enablement** is blocked by role/discovery bugs and missing service registration. This is an implementation task, not a design task, but the design canon must record the contract requirements so the implementation is verifiable.
- **The prior four locks** (capnp is contract; pixels never cross contract; theme is data/single authority; one app-facing widget vocabulary) are formally unapproved but encoded in canon laws. The process agent must record their approval status.
- **The user's felt experience** is a design deliverable, not a nice-to-have. The UX agent must cover confidence, calm, control, trust, flow, delight, error recovery, stress, cognitive load, onboarding, learnability, dignity, cultural difference.
- **Rare cases** are designed, not left to the crash. Every envelope, app, and shell surface must have a rare-case register.
- **Full Settings app** is a complete system control surface, not a vendor tree. Every pane, control, default, scope, dependency, failure, and acceptance.
- **Fullscreen behaviour** is a declared behaviour per envelope, not a hidden mode.
- **EV UI** is a full interface set: zones, driving states, driver/passenger, glare/vibration, phone handoff, bespoke form factors.
- **Spaceship UI** is deterministic timing, redundancy, alarms, procedures, high workload, gloves, glare, non-rectangular displays.
- **Cross-device UX** (phone ↔ PC) is designed: pairing, handoff, shared clipboard, notification sync, continue-on-another-device, remote output, remote input.
- **One OS to rule them all**: same app grammar on every device, envelope-specific composition, no feature forks.

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-PROC-WAVES-001` | No wave is dispatched before the previous wave is reviewed. |
| `AC-PROC-WAVES-002` | Every agent has disjoint paths and a coverage matrix. |
| `AC-PROC-WAVES-003` | Every wave closes with a conflict register and a freeze of shared IDs. |
| `AC-PROC-WAVES-004` | No agent overwrites another agent's files. |
| `AC-PROC-WAVES-005` | The integration editor sees stable subtrees, not moving ones. |
