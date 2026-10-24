---
id: PROC-LAYER-MODEL
title: Layer Model — Derived from Responsibilities
kind: process
entity: process
status: review
normative: true
version: 0.1.0
owner: Canon Editor
depends: [PROC-MASTER-BRIEF, PROC-COMPLETENESS, PROC-APPEND-ONLY, CANON-LAWS, CANON-TIMELESSNESS, DOC-SYSTEM, APP-STANDARD, PORTFOLIO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-LAYER-001, AC-LAYER-002, AC-LAYER-003, AC-LAYER-004, AC-LAYER-005, AC-LAYER-006, AC-LAYER-007, AC-LAYER-008]
---

# Layer Model — Derived from Responsibilities

> Layers exist because a responsibility must have an owner, not because a legacy OS had a
> layer with that name. A layer that cannot state its responsibility, its owned facts,
> its forbidden facts and the consequence of its removal is not a layer; it is a habit.

---

## 1. The rule

- `LAYER-001`. A layer is admitted only by **responsibility**: a named fact or
  behaviour that must have exactly one owner (`LAW-001`).
- `LAYER-002`. A layer MUST NOT exist because a legacy OS had one. "The OS has a kernel
  layer, a driver layer, a window manager layer" is not a justification.
- `LAYER-003`. A layer MUST state: its responsibility, what it owns, what it must not
  own, why it exists, what happens if removed, and its boundary contract.
- `LAYER-004`. A fact has exactly one owner; if two layers claim it, one is wrong and a
  conflict is recorded, not silently resolved.
- `LAYER-005`. Dependencies flow downward only. A lower layer MUST NOT depend on a higher
  one. A higher layer MAY be absent; the lower layers still function.
- `LAYER-006`. A layer that is optional on some envelopes (policy, apps) MUST be
  removable without losing the visible truth (`LAW-006`).
- `LAYER-007`. Pixels never cross a layer boundary as raw bytes; capabilities, buffers
  and declarations do (`LAW-002`).

---

## 2. The layers

Eight layers, from bottom to top. Lower layers are more fundamental and more stable; upper
layers are more optional and more replaceable.

| # | Layer | Responsibility | Optional? |
|---|---|---|---|
| L1 | Substrate / contracts | The wire truth and the capability to use a buffer. | No |
| L2 | Presentation truth | The numbered still: pixels, hit map, a11y, input ownership, buffer lifetime as one atomic fact. | No |
| L3 | Foundations / cross-cutting | The shared vocabulary: depth, motion, type, colour, icons, sound, accessibility, experience, locale. | No (but individual foundations may be subsetted per envelope) |
| L4 | App framework | The grammar apps share: components, tokens, palette, adaptivity, runtime. | No (the grammar is mandatory; individual components are optional) |
| L5 | Shell / policy | Placement, focus, arbitration, system surfaces, lifecycle, gestures. | Yes — optional on simple devices (`LAW-006`) |
| L6 | Apps / job surfaces | Capability-scoped, stateful views of domains. | Yes — an envelope may run zero apps |
| L7 | Envelopes / adaptation | Binding the grammar to physical and social facts of a device. | No — every output has an envelope |
| L8 | Process / research | The corpus, the evidence, the gates, the acceptance. | No — but it is documentation, not runtime |

**Note on ordering.** Envelopes (L7) sit "above" apps in the sense that they constrain
and adapt them, but they do not own app facts. They are a cross-cutting constraint layer,
not a runtime dependency. The runtime dependency order is L1 → L2 → L3 → L4 → (L5) →
(L6), with L7 describing how L4–L6 behave on a device and L8 governing all of them.

---

## 3. Layer by layer

### L1 — Substrate / contracts

- **Responsibility.** Define what may cross a boundary: capabilities, buffer handles,
  declarations, fences, semantic facts. Negotiate formats. Discover peers by role.
- **Owns.** Cap'n Proto schemas (`protocol/schemas/*.capnp`); role names; capability
  types; discovery protocol; schema evolution rules.
- **Must not own.** Pixels, raw pointers, layout decisions, app state, theme, locale,
  any UI fact.
- **Why it exists.** Without a small, stable contract, no two implementations can
  interoperate and no implementation can be replaced. The contract is the durable
  artefact (`AGENTS.md` §1).
- **If removed.** Nothing can be built. Every other layer loses its interoperability and
  its ability to be replaced.
- **Boundary contract.** Carries capabilities, buffers, declarations, fences and
  semantic facts. MUST NOT carry raw pixel bytes or global pointers (`LAW-002`). New
  fields are optional with defaults (`LAW-014`).
- **Runtime:** `02-architecture/protocol/`, `02-architecture/runtime/`.

### L2 — Presentation truth

- **Responsibility.** Own the numbered still: for each output, the pixels, hit map,
  accessibility snapshot, input ownership and buffer lifetime as one atomic, versioned
  fact. Validate commits. Crash-safe truth.
- **Owns.** The authority; commit numbering; damage declarations (as data, not detection);
  buffer lifecycle; the still itself.
- **Must not own.** Layout, stacking, arbitration, app content, theme, any policy
  decision. It validates; it does not decide (`LAW-006`).
- **Why it exists.** Most "impossible" UI bugs are consistency bugs (LAW-005). A single
  owner of the visible truth removes them.
- **If removed.** The screen becomes a mutable scene graph; races between move and click,
  close and screen-reader read, recycle and scanout become possible. Truth is lost.
- **Boundary contract.** Commits carry buffer, damage, present intent, fence. Authority
  is mandatory; policy is optional. Killing the authority fails honestly, not silently
  (`LAW-005`, `LAW-006`).
- **Runtime:** `02-architecture/presentation/`, `02-architecture/rendering/`.

### L3 — Foundations / cross-cutting

- **Responsibility.** The shared vocabulary of perception and experience: depth, motion,
  typography, colour, iconography, sound and haptics, accessibility, felt experience,
  locale and voice, culture.
- **Owns.** Tokens' *meaning* (what elevation means, what a spring explains), the icon
  language (Solar + Naledzi glyphs as semantic names), the accessibility structure,
  the felt-experience principles, the research that grounds them.
- **Must not own.** App-specific composition, envelope-specific layout, any value that
  changes per app or per envelope. Foundations define meaning; apps and envelopes apply it.
- **Why it exists.** Without a shared vocabulary, every app invents its own depth,
  motion and type, and the suite stops feeling like one product (`LAW-013`).
- **If removed.** Each app reinvents depth and motion; consistency is lost; accessibility
  becomes per-app and drifts.
- **Boundary contract.** Referenced by ID; never re-specified in an app. A foundation
  change is a `MAJOR` corpus change.
- **Runtime:** `01-foundations/`.

### L4 — App framework

- **Responsibility.** The shared grammar apps use: components, tokens (values), palette,
  adaptivity rules, layout/text/damage runtime, the MirUI ECS and scheduler.
- **Owns.** Component specifications, token values, the command palette, adaptivity
  (envelope archetypes, responsive rules, density), the runtime that apps build on.
- **Must not own.** App domain state, app content, any fact owned by a service. The
  framework provides parts; apps compose them.
- **Why it exists.** Reproducibility: a second team in a different UI language must
  produce the same behaviour, hierarchy, focus and states. The framework is the
  contract between "what an app is" and "how it is drawn".
- **If removed.** Apps must implement their own components, tokens and layout; the suite
  fragments; reproducibility is lost.
- **Boundary contract.** Components are derived from interaction primitives, not a
  widget catalogue (`03-framework/README.md` §5). No raw visual value in app or
  component behaviour (`FW-LAW-006`). Adaptivity changes composition, not meaning.
- **Runtime:** `03-framework/`.

### L5 — Shell / policy

- **Responsibility.** Placement, focus, arbitration, system surfaces (strip, status rail,
  notifications, lock, gestures, spaces, fullscreen, lifecycle, shortcuts), and the
  policy that decides layout and stacking.
- **Owns.** System surfaces at `system` elevation; the gesture grammar; the shortcut
  registry; lifecycle (boot, first-run, login, update, recovery, shutdown); the optional
  policy app.
- **Must not own.** The still (L2), app domain state, any fact owned by a service. Policy
  is optional; the authority is not (`LAW-006`).
- **Why it exists.** Someone must place windows, arbitrate focus and own the surfaces
  that are always potentially needed. Making it optional means a watch can run without it.
- **If removed.** Apps still commit stills; input leases expire safely; a new policy
  adopts the current truth. The screen remains coherent. This is the test of `LAW-006`.
- **Boundary contract.** Killing the policy does not lose the screen. Killing the
  authority does. System surfaces are OS-owned and never app-owned.
- **Runtime:** `04-shell/`.

### L6 — Apps / job surfaces

- **Responsibility.** Capability-scoped, stateful views of domains: the candidate
  portfolio derived from timeless human jobs.
- **Owns.** Domain state, buffer, damage declarations, commands exposed to the palette,
  capability declarations, flows, states, acceptance.
- **Must not own.** Output, status rail, strip, theme, scheduler, ECS, any fact owned by
  another service (`APP-STANDARD` §1).
- **Why it exists.** The person's work happens here. Apps are the only layer that
  changes with the person's domain.
- **If removed.** The OS still boots, shows the shell and runs system surfaces; no
  domain work is possible. The system degrades to a device with no apps, which is a
  valid state on some envelopes (IoT, kiosk).
- **Boundary contract.** Every app signs `APP-STANDARD`. Every app declares required,
  optional and refused capabilities. Every app works offline for its core task
  (`LAW-017`).
- **Runtime:** `05-apps/`.

### L7 — Envelopes / adaptation

- **Responsibility.** Bind the shared grammar to the physical and social facts of a
  device: input, output, power, safety, reach, orientation, protected zones.
- **Owns.** Envelope profiles, adaptation ladder, region/layout rules, input grammar per
  device, safety class, performance budgets per device, declared absences.
- **Must not own.** App content, app domain state, any change to meaning. An envelope
  changes composition, never meaning (`06-envelopes/README.md` §4).
- **Why it exists.** The same OS runs on a watch and a spacecraft. Without a declared
  adaptation layer, each device becomes a fork.
- **If removed.** Every envelope improvises; meaning drifts between devices; safety
  rules are lost.
- **Boundary contract.** No feature fork: a missing feature becomes a re-flow, a collapse,
  a page, a peer or a declared exception, in that order. An envelope file that says
  "similar to phone" is a defect.
- **Runtime:** `06-envelopes/`.

### L8 — Process / research

- **Responsibility.** The corpus itself: the document system, the timelessness test, the
  design laws, the research base, the gates, the acceptance, the changelog, the
  append-only protocol, the agent workflow.
- **Owns.** This directory (`docs/ui-canon/`), the bibliography, the decision log, the
  anti-patterns, the open questions.
- **Must not own.** Runtime facts, implementation details, any state that changes at
  runtime. It is design truth, not current state (`docs/ui-canon/README.md` §1).
- **Why it exists.** The OS may replace any implementation; this corpus is how the
  replacement knows what it must remain.
- **If removed.** Implementation proceeds without design truth; decisions are made by
  accident; cuts are never repaired (`LAW-012`).
- **Boundary contract.** Append-only. Shared documents are rewritten only by ADR.
  Superseded material is marked and kept. No stubs, no "TODO", no "similar to".
- **Runtime:** `docs/ui-canon/`, `progress/`, `.kilo/plans/`.

---

## 4. Dependency diagram

```text
                       ┌─────────────────────────────┐
                       │ L8  Process / research      │  governs all
                       └──────────────┬──────────────┘
                                      │
   ┌──────────────────────────────────┼──────────────────────────────────┐
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L7  Envelopes / adaptation  (constrains L4–L6 per device)   │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L6  Apps / job surfaces  (optional)                         │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L5  Shell / policy  (optional)                              │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L4  App framework  (components, tokens, palette, adaptivity) │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L3  Foundations / cross-cutting  (depth, motion, type, …)    │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L2  Presentation truth  (numbered stills, authority)        │   │
   │   └──────────────────────────────┬──────────────────────────────┘   │
   │                                  │                                  │
   │   ┌──────────────────────────────┴──────────────────────────────┐   │
   │   │ L1  Substrate / contracts  (Cap'n Proto, capabilities)       │   │
   │   └─────────────────────────────────────────────────────────────┘   │
   │                                                                     │
   └─────────────────────────────────────────────────────────────────────┘

   Runtime dependency: L1 → L2 → L3 → L4 → (L5) → (L6).
   Constraint layer:   L7 wraps L4–L6 per device.
   Governance layer:    L8 governs L1–L7.
```

**Rules of the diagram.**

- An arrow points from a layer to the layer it depends on. Dependencies go down only.
- L5 and L6 are optional; L1–L4 and L7 are mandatory on every output.
- L7 does not depend on L6: an envelope can exist with zero apps.
- L8 depends on nothing at runtime; it governs at design time.

---

## 5. Rejected layers

Layers that exist in legacy OS stacks but are rejected here because they have no
responsibility that is not already owned.

| Rejected layer | Why it exists in legacy stacks | Why it is rejected here | Where its responsibility goes |
|---|---|---|---|
| Window manager (as a separate layer) | Historical separation of "drawing" from "placing". | Placement is policy (L5) and truth is L2; there is no third thing. A separate window manager creates a second owner of placement. | L2 (truth) + L5 (policy). |
| Compositor (as a separate layer) | GPU-era separation of rendering from composition. | Composition is rendering (L2/L4); the authority owns the still. A separate compositor risks a second truth. | L2 + `02-architecture/rendering/`. |
| Theme engine (as a layer) | Per-app theming. | Theme is a token set (L4) applied by the framework; there is no engine. A second theme is a second owner (`LAW-001`). | L4 tokens. |
| Widget toolkit layer | Vendor widget sets. | Components are derived from primitives (L4), not from a toolkit. A toolkit is a library, not a layer. | L4. |
| Desktop environment layer | "GNOME/KDE" as a layer. | The environment is L5 (shell/policy) + L6 (apps). There is no environment layer distinct from them. | L5 + L6. |
| Driver layer (in the UI corpus) | Hardware abstraction. | Drivers are kernel, not UI. The UI corpus does not own them; it owns the contract (L1) that a driver-backed buffer must satisfy. | Kernel + L1. |
| Settings daemon layer | A background settings service presented as a layer. | Settings is an app (L6) plus a store owned by a service. It is not a UI layer. | L6 + service contract. |
| Notification daemon layer | A separate notification service as a UI layer. | Notification delivery is a shell surface (L5) plus a service. The UI layer is the surface, not the daemon. | L5 + service contract. |
| App launcher layer | A separate launcher. | Launching is the strip (L5) and the palette (L4). No separate layer. | L5 + L4. |
| Icon theme layer | Icon sets as a layer. | Icons are semantic names resolved through foundations (L3) and tokens (L4). No icon layer. | L3 + L4. |

**Rule.** `LAYER-REJECT-001`. A layer rejected here may be re-proposed only with a new
responsibility argument that is not "a legacy OS had it" and an ADR.

---

## 6. Boundary contracts (summary)

| Boundary | Lower layer | Upper layer | Rule |
|---|---|---|---|
| L1 ↔ L2 | Substrate | Presentation | Pixels never cross; capabilities and buffers do (`LAW-002`). |
| L2 ↔ L3 | Presentation | Foundations | Foundations reference the still; they do not own it. |
| L3 ↔ L4 | Foundations | Framework | Framework consumes foundation meaning; it does not redefine it. |
| L4 ↔ L5 | Framework | Shell | Shell uses components and tokens; it does not re-specify them. |
| L5 ↔ L6 | Shell | Apps | Apps never draw at `system`; shell never owns app domain state. |
| L6 ↔ L7 | Apps | Envelopes | Envelopes change composition, not meaning or domain state. |
| L1–L7 ↔ L8 | Runtime | Process | Process governs; it is not runtime. |

---

## 7. The layer integrity test

A layer passes the integrity test when:

1. Its responsibility is stated in one sentence and names a fact or behaviour, not a
   component.
2. Its owned facts are listed and no other layer claims them.
3. Its forbidden facts are listed and enforced by review.
4. Its removal consequence is stated and is not "the system breaks" (too vague).
5. Its boundary contract is testable.
6. Its dependencies are downward only.
7. It is not on the rejected list without an ADR.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-LAYER-001` | Every layer in §2 has all six fields in §3 (responsibility, owns, must not own, why it exists, if removed, boundary contract). |
| `AC-LAYER-002` | No fact is claimed by two layers. |
| `AC-LAYER-003` | Dependencies flow downward only. |
| `AC-LAYER-004` | L5 and L6 are removable without losing the visible truth. |
| `AC-LAYER-005` | Every rejected layer in §5 has a recorded reason and destination. |
| `AC-LAYER-006` | The dependency diagram in §4 matches the layer order in §2. |
| `AC-LAYER-007` | Boundary contracts are testable. |
| `AC-LAYER-008` | A second reader can place any corpus file into exactly one layer without ambiguity. |