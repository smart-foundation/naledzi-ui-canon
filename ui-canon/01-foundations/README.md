---
id: FOUND-INDEX
title: Foundations
kind: foundation
entity: foundations
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, CANON-GLOSSARY, CANON-DECISIONS, DOC-SYSTEM, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-INDEX-001, AC-FOUND-INDEX-002, AC-FOUND-INDEX-003]
children:
  - depth/README.md
  - motion/README.md
  - typography/README.md
  - color/README.md
  - iconography/README.md
  - sound-haptics/README.md
  - accessibility/README.md
---

# Foundations

> Foundations are the perceptual and interaction grammar every token, component, shell and app
> inherits. They are not a mood board. They state what a value means, when it is legal, what it
> costs, and how it survives a device that has not been designed yet.

**Status:** review. Content is complete against the completeness contract; promotion to `canon`
requires the review gate in `08-process/05-review-gates.md`. No file in this subtree claims a
passed gate that has not happened.

**Scope:** depth, motion, typography, colour, iconography, sound and haptics, and accessibility
as structural properties. Experience design, personas and emotion live in `01-foundations/experience/`
and are owned by another agent; this subtree links to them but does not write there.

---

## 1. What a foundation is

A foundation answers four questions for one perceptual domain:

1. **What is the human constant?** The need or perceptual fact that survives changes in
   hardware. Example: occlusion orders objects in depth at every visible distance
   (Cutting and Vishton, 1995).
2. **What is the model?** The named concepts, levels and relationships that turn the constant
   into a system. Example: five elevation levels, one light model, contact plus ambient shadow.
3. **What is legal?** Normative rules with `MUST`, `MUST NOT`, `SHOULD` and `MAY`, each scoped
   to an envelope, state or input.
4. **How is it proved?** Acceptance criteria that can fail, plus performance and failure
   behaviour.

A foundation is **not**:

- a list of values (that is a token file);
- a component (that is `03-framework/components/`);
- a theme (a theme is a complete token set, not a colour palette);
- a platform guideline copied without evidence;
- a decoration pass applied after layout.

---

## 2. How foundations bind

The binding chain is one direction. A lower layer may not cite a higher layer as its authority.

```text
00-canon laws and decisions
        |
        v
01-foundations (this subtree)          meaning, legality, human limits
        |
        v
03-framework/tokens                    named values, variants, aliases
        |
        v
03-framework/components                anatomy, states, behaviour
        |
        v
04-shell and 05-apps                   composition for a job
        |
        v
06-envelopes and 07-wireframes         declared device composition
```

Rules:

- **FOUND-INDEX-RULE-01.** A token MUST cite the foundation rule that makes its value legal.
  A token without a foundation is decoration.
- **FOUND-INDEX-RULE-02.** A component MUST consume tokens, not literal values. A component
  that hardcodes a shadow, spring, type size, colour, icon path or sound is non-conformant.
- **FOUND-INDEX-RULE-03.** An envelope MAY reduce, disable or replace a foundation effect when
  its constraints require it. The reduction MUST be declared in that foundation's envelope
  file and in the envelope's own constraints. Silent removal is a defect.
- **FOUND-INDEX-RULE-04.** When a foundation rule and an app request conflict, the foundation
  wins unless an ADR records a scoped exception with an expiry and an acceptance test.
- **FOUND-INDEX-RULE-05.** Accessibility is not a downstream audit. Every foundation MUST
  define its non-visual, non-audio and reduced-sensation path in the same model that produces
  the default path.
- **FOUND-INDEX-RULE-06.** A foundation value that cannot be measured (contrast ratio, settle
  time, frame cost, latency, target size) MUST declare the measurement method and the
  reference envelope.
- **FOUND-INDEX-RULE-07.** No foundation may require a capability that a declared envelope
  cannot provide. Where a capability is absent, the foundation MUST state the fallback.

The laws that dominate this subtree are `LAW-004` (idle is silent), `LAW-007` (depth
communicates hierarchy), `LAW-008` (motion explains change), `LAW-009` (accessibility is
structural), `LAW-011` (honesty over polish), `LAW-016` (performance is a design constraint),
`LAW-017` (local first) and `LAW-020` (the person owns attention).

---

## 3. Dependency order

The order below is the reading and review order. It is also the implementation order: a later
foundation assumes the earlier ones.

| Order | Foundation | Why it comes here | Hard dependency |
|---|---|---|---|
| 1 | [Depth](depth/README.md) | Establishes space, light and what is in front of what. Every other visual foundation composes inside it. | `LAW-007` |
| 2 | [Motion](motion/README.md) | Explains changes in the space depth defines. | `LAW-008`, depth |
| 3 | [Typography](typography/README.md) | Carries meaning at every depth level and in every script. | depth, motion |
| 4 | [Colour](color/README.md) | Separates roles, states and data without becoming the only carrier. | depth, typography |
| 5 | [Iconography](iconography/README.md) | Compresses meaning into glyphs that sit inside type, controls and depth levels. | typography, colour |
| 6 | [Sound and haptics](sound-haptics/README.md) | Adds non-visual confirmation and alerts under the same semantics. | motion, accessibility |
| 7 | [Accessibility](accessibility/README.md) | Proves that the whole model is usable through every sense and input. | all previous |

Circular **dependencies** are forbidden by the document system. Cross-links are allowed.
Accessibility links back to every foundation; it does not become a dependency of them. Each
foundation owns its own accessibility behaviour and cites `FOUND-A11Y-*` for the shared
structure.

---

## 4. The common file contract

Every foundation directory in this subtree uses the same spine:

| File | Question it answers |
|---|---|
| `README.md` | What is this foundation, what is in it, what is absent and why? |
| `01-...` to `0N-...` | The model, split by question. |
| `NN-tokens.md` | Which named values does the foundation propose, with ranges and variants? |
| `NN-rules.md` | What is normative, scoped and testable? |
| `NN-envelopes.md` | How does each of the ten envelopes change the behaviour? |
| `NN-adaptation.md` | Reduced motion or transparency, high contrast, 200% text and RTL. |
| `NN-assistive.md` | What does a screen reader, switch, braille or non-visual path receive? |
| `NN-performance.md` | What is the budget, how is it measured, what is the degradation ladder? |
| `NN-failure.md` | What happens when the effect, asset, capability or service is missing? |
| `NN-timelessness.md` | Why does this survive input, display and decade change? |
| `NN-references.md` | Full citations, access dates and evidence limits. |
| `NN-open-questions.md` | Unresolved decisions, owner, deadline and blocking scope. |
| `NN-changelog.md` | What changed, when and why. |
| Acceptance file | The AC table, with a runnable test for each criterion. |

The required standard files from the completeness contract that do not apply to a foundation
are declared absent, not silently omitted:

| Standard file | Status in a foundation |
|---|---|
| `01-purpose.md` | Folded into `README.md` section 1 and the model file. The purpose is one perceptual constant, not a product. |
| `04-anatomy.md` | `n/a — a foundation has no parts; components have anatomy.` |
| `05-layout.md` | `n/a — layout is owned by `03-framework/adaptivity/` and `06-envelopes/`. Foundations state constraints, not grids.` |
| `06-input.md` | `n/a — input grammar is owned by each envelope and `04-shell/gestures/`; foundations state the perceptual response to input.` |
| `09-capabilities.md` | Folded into the performance and failure files, because the capability question for a foundation is always "which sensor, GPU feature or output is required, and what is the fallback?" |
| `flows/` | `n/a — foundations have no user-facing state machine. Flows belong to apps and shell surfaces.` |

---

## 5. The expansion matrix

Every foundation MUST cover every row below. A cell is either a link or `n/a — reason`.
The audit is in section 7.

| Concern | Depth | Motion | Typography | Colour | Iconography | Sound and haptics | Accessibility |
|---|---|---|---|---|---|---|---|
| Tokens | [08](depth/08-tokens.md) | [06](motion/06-tokens.md) | [07](typography/07-tokens.md) | [08](color/08-tokens.md) | [07](iconography/07-tokens.md) | [06](sound-haptics/06-tokens.md) | [11](accessibility/11-tokens.md) |
| Normative rules | [09](depth/09-rules.md) | [08](motion/08-rules.md) | [08](typography/08-rules.md) | [09](color/09-rules.md) | [08](iconography/08-rules.md) | [07](sound-haptics/07-rules.md) | [12](accessibility/12-rules.md) |
| Per-envelope behaviour | [10](depth/10-envelopes.md) | [09](motion/09-envelopes.md) | [09](typography/09-envelopes.md) | [10](color/10-envelopes.md) | [09](iconography/09-envelopes.md) | [08](sound-haptics/08-envelopes.md) | [13](accessibility/13-envelopes.md) |
| Reduced motion and transparency | [11](depth/11-adaptation.md) | [04](motion/04-reduced-motion.md), [10](motion/10-adaptation.md) | [10](typography/10-adaptation.md) | [11](color/11-adaptation.md) | [10](iconography/10-adaptation.md) | [09](sound-haptics/09-adaptation.md) | [14](accessibility/14-adaptation.md) |
| High contrast | [11](depth/11-adaptation.md) | [10](motion/10-adaptation.md) | [10](typography/10-adaptation.md) | [04](color/04-contrast.md), [11](color/11-adaptation.md) | [10](iconography/10-adaptation.md) | [09](sound-haptics/09-adaptation.md) | [14](accessibility/14-adaptation.md) |
| 200% text | [11](depth/11-adaptation.md) | [10](motion/10-adaptation.md) | [05](typography/05-dynamic-type.md), [10](typography/10-adaptation.md) | [11](color/11-adaptation.md) | [10](iconography/10-adaptation.md) | [09](sound-haptics/09-adaptation.md) | [14](accessibility/14-adaptation.md) |
| RTL and vertical writing | [11](depth/11-adaptation.md) | [10](motion/10-adaptation.md) | [03](typography/03-scripts-and-localisation.md), [10](typography/10-adaptation.md) | [11](color/11-adaptation.md) | [10](iconography/10-adaptation.md) | [09](sound-haptics/09-adaptation.md) | [14](accessibility/14-adaptation.md) |
| Screen reader | [12](depth/12-assistive.md) | [11](motion/11-assistive.md) | [11](typography/11-assistive.md) | [12](color/12-assistive.md) | [05](iconography/05-accessibility.md), [11](iconography/11-assistive.md) | [10](sound-haptics/10-assistive.md) | [03](accessibility/03-announcements.md), [09](accessibility/09-assistive-tech.md) |
| Performance | [13](depth/13-performance.md) | [12](motion/12-performance.md) | [12](typography/12-performance.md) | [13](color/13-performance.md) | [12](iconography/12-performance.md) | [11](sound-haptics/11-performance.md) | [15](accessibility/15-performance.md) |
| Failure | [14](depth/14-failure.md) | [13](motion/13-failure.md) | [13](typography/13-failure.md) | [14](color/14-failure.md) | [13](iconography/13-failure.md) | [12](sound-haptics/12-failure.md) | [16](accessibility/16-failure.md) |
| Acceptance | [07](depth/07-acceptance.md) | [07](motion/07-acceptance.md) | [06](typography/06-acceptance.md) | [07](color/07-acceptance.md) | [06](iconography/06-acceptance.md) | [05](sound-haptics/05-acceptance.md) | [10](accessibility/10-acceptance.md) |
| Timelessness | [15](depth/15-timelessness.md) | [14](motion/14-timelessness.md) | [14](typography/14-timelessness.md) | [15](color/15-timelessness.md) | [14](iconography/14-timelessness.md) | [13](sound-haptics/13-timelessness.md) | [17](accessibility/17-timelessness.md) |
| Evidence | [16](depth/16-references.md) | [15](motion/15-references.md) | [15](typography/15-references.md) | [16](color/16-references.md) | [15](iconography/15-references.md) | [14](sound-haptics/14-references.md) | [18](accessibility/18-references.md) |
| Open questions | [17](depth/17-open-questions.md) | [16](motion/16-open-questions.md) | [16](typography/16-open-questions.md) | [17](color/17-open-questions.md) | [16](iconography/16-open-questions.md) | [15](sound-haptics/15-open-questions.md) | [19](accessibility/19-open-questions.md) |
| Change history | [18](depth/18-changelog.md) | [17](motion/17-changelog.md) | [17](typography/17-changelog.md) | [18](color/18-changelog.md) | [17](iconography/17-changelog.md) | [16](sound-haptics/16-changelog.md) | [20](accessibility/20-changelog.md) |

Two rows require a deliberate note:

- **Reduced transparency** is not the same as reduced motion. Depth and colour own the
  transparency rules; motion owns only the movement rules.
- **RTL** does not mirror physical light, shadow or sound. It mirrors reading order, alignment,
  directional glyphs and directional motion. Each adaptation file states which category applies.

---

## 6. Per-envelope summary

The ten envelopes are `watch`, `phone`, `tablet`, `desktop`, `tv`, `ev`, `spaceship`, `iot`,
`spatial` and `remote-browser`. The common classification below is binding for this subtree;
each foundation adds its own consequences.

| Envelope | Perceptual class | Depth | Motion | Type | Colour | Icons | Sound/haptics |
|---|---|---|---|---|---|---|---|
| Watch | constrained, glanceable, worn | shallow, 3 levels | short, bounded | small, high x-height | outdoor contrast | filled, 1 weight | haptic-first, quiet audio |
| Phone | compact, hand-held | 4 levels | full grammar | responsive | adaptive | 2 weights | haptic + audio |
| Tablet | compact-wide, hand-held or propped | 4 levels | full grammar | two-column | adaptive | 2 weights | audio, limited haptic |
| Desktop | high-throughput, pointer | 5 levels | full, precise | dense | adaptive, wide gamut | 3 weights | audio optional |
| TV | distant, remote-controlled | 4 levels, large | focus-led | 10-foot | high luminance | bold, 1 weight | audio primary |
| EV | safety, glare, vibration | 3 levels, protected | bounded, no overshoot | 1 m and 4 m | glare-safe, safety colours | filled, high contrast | audio + haptic, safety priority |
| Spaceship | safety, gloves, non-rectangular | 3 levels, protected | deterministic, bounded | 1 m and 4 m | safety-critical | filled, 2 weights | audio + haptic, redundancy |
| IoT | headless or tiny, remote | 1-2 levels | minimal | tiny or none | status only | 1 weight | audio/light only |
| Spatial | stereoscopic, head-tracked | true depth, vergence | comfort-bounded | world-locked | luminance-limited | 1-2 weights | spatial audio + haptic |
| Remote browser | variable latency, rectangle | 3 levels | reduced, jitter-tolerant | browser font stack | sRGB, no wide gamut | 1 weight | audio only, user-initiated |

A foundation file that says "same as phone" for any envelope is a defect. Each envelope file
must state the difference or declare `n/a — reason`.

---

## 7. Coverage audit

The audit is run against the completeness contract, section 3. For this subtree:

| Audit | How it is satisfied |
|---|---|
| Tree audit | Every directory has a README and the declared spine. Absences are listed in each README. |
| Stub audit | No `TODO`, no empty section, no "similar to". Unknowns are in open-questions files with owners and deadlines. |
| State audit | Foundations do not have app states; they define the perceptual states that components and envelopes must cover. |
| Flow audit | `n/a — no flows in foundations.` |
| Device audit | Every foundation has a ten-row envelope file. |
| Research audit | Every principle has a source, a limit and an implication in the references file. |
| Layer audit | Every depth level has a responsibility, an owner and a removal consequence. |
| App audit | `n/a — apps are outside this subtree.` |
| Rare-case audit | Failure files enumerate missing assets, missing capabilities, extreme text, RTL, reduced sensation and degraded output. |
| Reproducibility audit | Token files give ranges and decision rules; rules files give pass/fail tests; acceptance files give the proof. |

---

## 8. Conformance for an implementation

A surface is foundation-conformant when all of the following hold:

1. Every visual value resolves to a proposed `TOK-*` in the relevant token file.
2. Every depth level maps to a declared elevation and interaction meaning.
3. Every transition uses a named spring and settles inside its declared bound.
4. Every text style resolves to a type role with a declared script and numeral behaviour.
5. Every colour resolves to a role, not a hue name, and passes the contrast rules in both
   polarities.
6. Every icon resolves to a semantic name and an accessible name.
7. Every sound and haptic event maps to a semantic event class, never to a raw file.
8. Every interactive element has a focus appearance, a target size and a non-pointer path.
9. Every effect has a reduced-motion, reduced-transparency, high-contrast and 200% text
   behaviour.
10. Every failure mode in the foundation failure file has a visible or announced state.

---

## 9. Proposed shared identifiers

These identifiers are proposed for the token and component owners. They are not minted in
`00-canon/`, and this subtree does not edit the shared token index.

| Namespace | Examples | Owner after review |
|---|---|---|
| `TOK-DEPTH-*` | `TOK-DEPTH-ELEV-0` to `-4`, `TOK-DEPTH-SHADOW-*`, `TOK-DEPTH-SCRIM-*` | `03-framework/tokens/` |
| `TOK-MOTION-*` | `TOK-MOTION-SPRING-*`, `TOK-MOTION-STAGGER-*`, `TOK-MOTION-SAFETY-*` | `03-framework/tokens/` |
| `TOK-TYPE-*` | `TOK-TYPE-ROLE-*`, `TOK-TYPE-SCALE-*`, `TOK-TYPE-MEASURE-*` | `03-framework/tokens/` |
| `TOK-COLOR-*` | `TOK-COLOR-ROLE-*`, `TOK-COLOR-DATA-*`, `TOK-COLOR-SAFETY-*` | `03-framework/tokens/` |
| `TOK-ICON-*` | `TOK-ICON-SIZE-*`, `TOK-ICON-STROKE-*`, `TOK-ICON-WEIGHT-*` | `03-framework/tokens/` |
| `TOK-AUDIO-*` | `TOK-AUDIO-EVENT-*`, `TOK-AUDIO-GAIN-*` | `03-framework/tokens/` |
| `TOK-HAPTIC-*` | `TOK-HAPTIC-EVENT-*`, `TOK-HAPTIC-DURATION-*` | `03-framework/tokens/` |
| `COMP-FOCUS-RING` | focus appearance primitive | `03-framework/components/` |
| `COMP-SURFACE` | elevation and material host | `03-framework/components/` |
| `COMP-SCRIM` | modal and focus-dimming layer | `03-framework/components/` |
| `COMP-ICON` | semantic icon renderer | `03-framework/components/` |
| `COMP-ALERT` | safety and non-safety alert | `03-framework/components/` |

The full proposal, with values and acceptance, is in each foundation's token file.

---

## 10. Absences and boundaries

| Item | Status |
|---|---|
| `experience/` | `n/a — owned by the Experience Lead; not written here.` |
| Root `README.md` | `n/a — read-only for this agent; the index above is local.` |
| `00-canon/` edits | `n/a — every foundation obeys the canon and may not amend it.` |
| `03-framework/tokens/` | `n/a — this subtree proposes `TOK-*` IDs; it does not create the shared index.` |
| `06-envelopes/` | `n/a — this subtree states foundation consequences per envelope; the envelope owner states the full device contract.` |
| Implementation code | `n/a — the corpus is design, contracts and acceptance.` |

---

## 11. Open questions

The subtree-level questions are tracked in each foundation's `open-questions` file. The three
that affect more than one foundation are:

1. **High-contrast token authority.** Does high contrast replace role colours or add a
   parallel role set? Owner: Colour and Accessibility leads. Deadline: before token freeze.
   Tracked in `color/17-open-questions.md` and `accessibility/19-open-questions.md`.
2. **Solar licence scope.** The artwork is recorded as CC BY 4.0 by third parties, while the
   original repository has no licence file and the 480 Design site adds restrictions. Owner:
   Legal and Iconography. Deadline: before any icon is vendored. Tracked in
   `iconography/16-open-questions.md`.
3. **Safety motion profile ownership.** The EV and spaceship envelopes need a certified
   profile. Owner: Safety and Motion. Deadline: before envelope implementation.
   Tracked in `motion/16-open-questions.md`.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-INDEX-001` | Every child directory exists, has a README, and every README lists every file in its directory. |
| `AC-FOUND-INDEX-002` | The expansion matrix in section 5 has no blank cell and every link resolves to an existing file. |
| `AC-FOUND-INDEX-003` | No file in this subtree contains `TODO`, an empty heading, or the phrase "similar to phone"; an automated grep returns zero matches. |
| `AC-FOUND-INDEX-004` | Every foundation directory contains the ten envelope rows in its envelope file, or a declared `n/a — reason`. |
| `AC-FOUND-INDEX-005` | Every foundation file ends with an `## Acceptance` section that names at least one `AC-` identifier. |
