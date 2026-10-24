---
id: ENV-README
title: Envelopes — Device UX Canon
kind: envelope
entity: envelopes
status: canon
normative: true
version: 0.1.0
owner: Envelope and Device UX Guild
depends: [CANON-LAWS, PROC-MASTER-BRIEF, PROC-COMPLETENESS, APP-ENVELOPE-ADAPTATION, APP-PERF]
children:
  - _standard/README.md
  - watch/README.md
  - phone/README.md
  - tablet/README.md
  - desktop/README.md
  - tv/README.md
  - ev/README.md
  - spaceship/README.md
  - iot/README.md
  - spatial/README.md
  - remote-browser/README.md
  - cross-device/README.md
  - references/README.md
acceptance: [AC-ENV-STANDARD-001, AC-ENV-STANDARD-002]
---

# Envelopes — Device UX Canon

> Naledzi OS is one system on many devices. An envelope is not a smaller or larger version
> of another envelope. It is a declared physical and social situation with its own input,
> output, power, privacy and safety facts. The grammar is shared; the composition is earned.

This directory specifies **how the OS behaves on each device class**. It does not specify
app content (see `../05-apps/`), tokens (`../03-framework/tokens/`), shell internals
(`../04-shell/`) or protocol (`../02-architecture/protocol/`). It binds those layers to the
physical facts of a device.

---

## 1. Scope and status

| Item | State |
|---|---|
| Standard (`_standard/`) | canon, 13 files |
| Device envelopes | 10, each 14 files plus a flows set |
| Cross-device UX | canon, 13 flows |
| Research citations | `references/01-bibliography.md` |
| Implementation | none; this is design truth (`LAW-012`) |
| Portfolio dependency | `../05-apps/00-portfolio/` is authored separately. This subtree composes around **jobs** and never hardcodes an app inventory. |

An envelope file that says "similar to phone" is a defect. A missing surface is a declared
absence with a reason, not an omission. `PROC-COMPLETENESS` applies in full.

---

## 2. The envelope set

`S` is the safety class defined in [`_standard/08-safety-and-criticality.md`](_standard/08-safety-and-criticality.md).
`P` is the primary input. `Session` is the dominant session model.

| Envelope | Class | Physical situation | P | Session | S |
|---|---|---|---|---|---|
| Watch | personal, intermittent | wrist, one hand, outdoors | touch + crown + voice | glance, 5–30 s | S1 |
| Phone | personal, mobile | hand, pocket, walking | touch + voice | task, seconds to minutes | S1 |
| Tablet | personal, lean-back/lean-forward | lap or table, optional keyboard | touch + pointer + keyboard | task, minutes | S1 |
| Desktop | productivity, stationary | desk, large display, keyboard | keyboard + pointer | long session, hours | S1 |
| TV | shared viewing, 10-foot | sofa, across a room | D-pad + voice | passive session, hours | S1 |
| EV | vehicle, safety-critical | moving vehicle, driver and passengers | touch + physical + voice | drive cycle, minutes to hours | S3 |
| Spaceship | flight-critical | flight deck, high workload | physical + touch + procedure | mission phase, minutes to days | S4 |
| IoT | ambient, constrained | wall, appliance, wearable-less | one button + network | always-on, headless | S2 |
| Spatial | embodied, mixed reality | head-worn, room scale | gaze + pinch + voice | spatial session, minutes | S2 |
| Remote browser | executor, remote | browser tab on a foreign OS | pointer + keyboard + touch | attached session | S2 |

The safety class is a property of the **envelope**, not of an app. An app cannot raise or
lower it. A video app on a spaceship is still S4 for input, alarm and failure purposes.

---

## 3. Reading order

1. [`_standard/01-envelope-profile.md`](_standard/01-envelope-profile.md) — the fourteen
   facts every envelope must declare.
2. [`_standard/02-adaptation-ladder.md`](_standard/02-adaptation-ladder.md) — how content
   moves between envelopes without forking the app.
3. [`_standard/03-region-and-layout-rules.md`](_standard/03-region-and-layout-rules.md) —
   regions, safe areas, protected zones, density.
4. [`_standard/04-input-and-focus.md`](_standard/04-input-and-focus.md) — input grammar and
   focus ownership.
5. [`_standard/05-status-rail-and-system-ui.md`](_standard/05-status-rail-and-system-ui.md)
   — the adaptive rail and system-owned surfaces.
6. [`_standard/06-fullscreen-and-immersive.md`](_standard/06-fullscreen-and-immersive.md) —
   the fullscreen declaration.
7. [`_standard/07-multi-window-and-spaces.md`](_standard/07-multi-window-and-spaces.md) —
   multi-window, spaces and declared absence.
8. [`_standard/08-safety-and-criticality.md`](_standard/08-safety-and-criticality.md) —
   safety classes, protected zones, alarm hierarchy.
9. [`_standard/09-performance-and-resources.md`](_standard/09-performance-and-resources.md)
   — budgets, thermal, power, degradation.
10. [`_standard/10-failure-and-recovery.md`](_standard/10-failure-and-recovery.md) —
    failure taxonomy and the recovery ladder.
11. [`_standard/11-cross-device-continuity.md`](_standard/11-cross-device-continuity.md) —
    pairing, trust, handoff, clipboard, notification dedupe, remote I/O.
12. [`_standard/12-acceptance.md`](_standard/12-acceptance.md) — the audit and AC set.

Then read the envelope that applies. Each envelope has the same file order:

```text
<envelope>/
├── README.md                       manifest, coverage matrix, declared absences
├── 01-constraints.md               physical, input, power, network, safety facts
├── 02-input.md                     the input grammar on this device
├── 03-layout.md                    regions, safe areas, density, orientation
├── 04-status-rail.md               what the rail shows and when it collapses
├── 05-fullscreen.md                the fullscreen declaration
├── 06-multi-window-and-spaces.md   or n/a with a reason
├── 07-safety.md                    hazards, protected zones, alarms
├── 08-performance.md               budgets and degradation
├── 09-failure.md                   failure and recovery on this device
├── 10-accessibility.md             structural and input accessibility
├── 11-acceptance.md                ACs and evidence
├── 12-open-questions.md            unresolved, owner, deadline
└── flows/                          README plus 14 OS flows, frame by frame
```

---

## 4. What is shared and what is earned

| Shared across every envelope | Earned per envelope |
|---|---|
| Human need and job | Region arrangement |
| Domain model and state machine | Input grammar and focus order |
| Command IDs | Rail content and collapse rule |
| Error and confirmation wording | Fullscreen behaviour |
| Accessibility semantics | Multi-window capability |
| Capability and data-ownership rules | Performance budget |
| Safety laws | Protected zones and alarm presentation |
| Flow logic | Frame geometry and density |

An envelope MAY change composition. It MUST NOT change meaning. If the meaning changes, it
is a different feature and needs its own model (`APP-ENVELOPE-ADAPTATION` §4).

---

## 5. Coverage matrices

### 5.1 Devices × OS surfaces

`F` = frame set present · `A` = declared absence with reason · `C` = conditional surface
declared in the envelope README.

| Surface | Watch | Phone | Tablet | Desktop | TV | EV | Ship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|
| Boot | F | F | F | F | F | F | F | F | F | F |
| First run | F | F | F | F | F | F | F | F | F | F |
| Lock / identity | F | F | F | F | C | C | C | A | F | C |
| Home / idle | F | F | F | F | F | F | F | F | F | F |
| Open app | F | F | F | F | F | F | F | F | F | F |
| Fullscreen | F | F | F | F | F | F | F | A | F | F |
| Switcher | F | F | F | F | F | C | F | A | F | C |
| Notifications | F | F | F | F | F | F | F | C | F | C |
| Settings root | F | F | F | F | F | F | F | F | F | F |
| Search / palette | F | F | F | F | F | F | F | A | F | F |
| Permission | F | F | F | F | F | F | F | F | F | F |
| Error / offline | F | F | F | F | F | F | F | F | F | F |
| Update / recovery | F | F | F | F | F | F | F | F | F | F |
| Shutdown | F | F | F | F | F | F | F | F | F | F |
| Safety state | A | A | A | A | A | F | F | C | A | A |

`A` entries are justified in the envelope README and in the relevant flow index. A watch
has no multi-window; a watch still has boot, lock, home, app, error, update and shutdown.
An IoT device has no first-run *screen* and no lock screen in the personal sense; both are
declared as commissioning and physical-presence states, not omitted.

### 5.2 Envelopes × standard sections

Every envelope file has content or `n/a — reason`. Empty headings are defects.

---

## 6. Rules an envelope agent must not break

These are restatements of binding rules, not new law:

1. **Safety outranks composition.** On S3 and S4, no app, notification, animation or
   fullscreen surface MAY cover a protected indicator or delay a safety action
   (`LAW-011`, `ENV-STANDARD-SAFETY-04`).
2. **Input independence.** Every flow MUST be completable with the envelope's primary input
   without a gesture that the envelope does not have (`ENV-STANDARD-INPUT-03`).
3. **Honest absence.** An unsupported surface, sensor, capability or window mode is shown as
   absent, never faked (`LAW-011`).
4. **No feature fork.** A missing feature becomes a re-flow, a collapse, a page, a peer or a
   declared exception, in that order (`APP-ENVELOPE-ADAPTATION` §1).
5. **One still.** Pixels, hit map, accessibility and input ownership commit together
   (`LAW-005`).
6. **Idle is silent.** The rail, the clock and the home surface do not animate to appear
   alive (`LAW-004`).
7. **Wording is translated, not rewritten.** The same error means the same thing on a watch
   and on a flight deck; only length and channel change.

---

## 7. Research and hypotheses

Every behavioural claim is either sourced in
[`references/01-bibliography.md`](references/01-bibliography.md) or marked
`Hypothesis (unvalidated)`. The principal sources are NHTSA's visual-manual distraction
guidelines, FAA HF-STD-001, NASA-STD-3001, MIL-STD-1472, SAE J3016, ISO 26262, ISO 15008,
ARINC 661, 14 CFR 25.1322 and 121.542, WCAG 2.2, and platform guidance from Apple and
Android. Research limits are recorded with each source.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-ENV-STANDARD-001` | Every envelope directory contains the 14 declared files or a declared absence. |
| `AC-ENV-STANDARD-002` | Every device × surface cell in §5.1 has a frame or a declared absence. |
| `AC-ENV-STANDARD-003` | Every flow has frames with state, focus, action, transition and announcement. |
| `AC-ENV-STANDARD-004` | No envelope text contains "similar to", "TODO" or a representative sample. |
| `AC-ENV-STANDARD-005` | Every safety rule on S3/S4 has a test that can fail. |

The full audit is in [`_standard/12-acceptance.md`](_standard/12-acceptance.md).

---

## 9. Changelog

| Version | Date | Change |
|---|---|---|
| 0.1.0 | 2026-10-22 | Initial canon: standard, ten envelopes, cross-device flows, bibliography. |
