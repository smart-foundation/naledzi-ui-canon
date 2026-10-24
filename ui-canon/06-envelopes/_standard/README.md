---
id: ENV-STANDARD-README
title: Envelope Standard — Index
kind: envelope
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Envelope and Device UX Guild
depends: [ENV-README, CANON-LAWS, APP-ENVELOPE-ADAPTATION, APP-PERF, APP-FLOW-SPEC]
children:
  - 01-envelope-profile.md
  - 02-adaptation-ladder.md
  - 03-region-and-layout-rules.md
  - 04-input-and-focus.md
  - 05-status-rail-and-system-ui.md
  - 06-fullscreen-and-immersive.md
  - 07-multi-window-and-spaces.md
  - 08-safety-and-criticality.md
  - 09-performance-and-resources.md
  - 10-failure-and-recovery.md
  - 11-cross-device-continuity.md
  - 12-acceptance.md
acceptance: [AC-ENV-STANDARD-001, AC-ENV-STANDARD-006]
---

# Envelope Standard — Index

> This is the contract every device envelope signs. It is deliberately smaller than the
> envelope files: it states the shared model, the shared obligations and the audit. The
> physical detail lives in each envelope.

---

## 1. What an envelope is

An **envelope** is the declared set of physical, social, input, output, power, network and
safety facts that surround a running session. It is a design object, not a hardware SKU.
Two devices with the same facts share an envelope; one device may switch envelopes when
its facts change (a tablet docked to a keyboard becomes closer to the desktop envelope for
input, but remains the tablet envelope for display and session).

An envelope declaration is **normative input to layout, input, performance, failure and
safety**. It is not a theme. It is not a user-agent string. It is not inferred from screen
size alone.

```text
Physical facts ─┐
Input set ──────┤
Output set ─────┼──► Envelope profile ──► Adaptation ──► Composition
Power/network ──┤                          ladder          (regions, focus, rail,
Safety class ───┤                                           fullscreen, windows)
Privacy/social ─┘
```

---

## 2. The thirteen standard files

| # | File | One question it answers |
|---|---|---|
| 01 | [Envelope profile](01-envelope-profile.md) | What must every envelope declare before any screen is drawn? |
| 02 | [Adaptation ladder](02-adaptation-ladder.md) | How does content move between envelopes without forking the app? |
| 03 | [Region and layout rules](03-region-and-layout-rules.md) | What are the regions, safe areas and density rules? |
| 04 | [Input and focus](04-input-and-focus.md) | What is the input grammar and who owns focus? |
| 05 | [Status rail and system UI](05-status-rail-and-system-ui.md) | What does the rail show, and what is always system-owned? |
| 06 | [Fullscreen and immersive](06-fullscreen-and-immersive.md) | What exactly happens in fullscreen on each envelope? |
| 07 | [Multi-window and spaces](07-multi-window-and-spaces.md) | Which envelopes have windows, splits and spaces, and what replaces them elsewhere? |
| 08 | [Safety and criticality](08-safety-and-criticality.md) | How do safety classes, protected zones and alarms constrain the UI? |
| 09 | [Performance and resources](09-performance-and-resources.md) | What are the budgets, thermal rules and degradation ladders? |
| 10 | [Failure and recovery](10-failure-and-recovery.md) | How does each envelope fail, and how does it recover honestly? |
| 11 | [Cross-device continuity](11-cross-device-continuity.md) | How do devices pair, trust, hand off, share and revoke? |
| 12 | [Acceptance](12-acceptance.md) | How is an envelope proven complete? |

`README.md` is this index. There is no separate `13-changelog.md`; the changelog is at the
end of this file and in each envelope README, because envelope versions move with the
corpus.

---

## 3. The envelope obligation

Every envelope directory MUST contain the files below. If a file is genuinely not
applicable it MUST still exist and begin with `n/a — <reason>`; silence is a defect.

| File | Obligation |
|---|---|
| `README.md` | Manifest, profile summary, coverage matrix, declared absences, changelog. |
| `01-constraints.md` | Physical, environmental, input, output, power, network and safety facts. |
| `02-input.md` | Every input, its grammar, its fallback and its focus behaviour. |
| `03-layout.md` | Regions, safe areas, protected zones, orientation, density, text scaling. |
| `04-status-rail.md` | Rail contents, collapse rule, protected indicators, notification behaviour. |
| `05-fullscreen.md` | The six-part fullscreen declaration plus exit and failure. |
| `06-multi-window-and-spaces.md` | Capability, or `n/a — reason` plus the replacement model. |
| `07-safety.md` | Hazards, safety class, alarm hierarchy, degraded modes and interlocks. |
| `08-performance.md` | Budgets, measurement device, thermal/power rules, degradation ladder. |
| `09-failure.md` | Failure taxonomy, messages, recovery, dead ends and data safety. |
| `10-accessibility.md` | Structural semantics, focus, input alternatives, adaptation extremes. |
| `11-acceptance.md` | AC IDs, golden flows, evidence and audit results. |
| `12-open-questions.md` | Unresolved questions with owner and deadline. |
| `flows/README.md` | Flow index: ID, goal, entry, envelopes, frames, status. |
| `flows/NN-*.md` | The fourteen required OS flows, each with frames. |

The **fourteen required flows** are: boot, first run, lock/identity, home/idle, open app,
fullscreen, switcher, notifications, settings root, search/palette, permission,
error/offline, update/recovery and shutdown. An envelope that lacks a surface still draws
the state transition that replaces it (for example, IoT commissioning instead of first run,
or a physical key instead of a lock screen).

---

## 4. Normative vocabulary

- `MUST` / `MUST NOT` — binding. A violation fails acceptance.
- `SHOULD` / `SHOULD NOT` — binding unless a declared envelope exception exists.
- `MAY` — permitted, not required.
- **Declared absence** — the exact string `n/a — <reason>` at the top of a section or file.
- **Protected zone** — a rectangle that no non-safety surface may draw into or cover.
- **Critical indicator** — a value or state whose omission or delay could cause harm.
- **Envelope exception** — a recorded, approved scope decision with an alternative.

Identifiers follow `DOC-SYSTEM` §5: `ENV-<ENTITY>-<TOPIC>-<NN>`, `AC-ENV-<ENTITY>-<NN>`.

---

## 5. The envelope contract in one page

An envelope is complete when a stranger can answer all of these from its files:

1. What is the device physically doing, and who else can see or hear it?
2. What inputs exist, which is primary, and what happens when one fails?
3. What are the regions, the safe areas and the protected zones?
4. What does the rail show at rest, under load and in an emergency?
5. What hides in fullscreen, what remains, and how does the user get out?
6. Can two things be on screen at once? If not, what replaces that capability?
7. What is the safety class, the alarm hierarchy and the interlock rule?
8. What are the budgets on the weakest supported hardware, and how does it degrade?
9. What are the failure modes, the messages and the recovery paths?
10. How is the device discovered, paired, trusted, handed off from and revoked?
11. What is deliberately absent, and why is the alternative sufficient?
12. Which claims are sourced, and which are unvalidated hypotheses?

If any answer requires asking a designer, the envelope is `review`, not `canon`.

---

## 6. Relationship to sibling standards

| Sibling | Relationship |
|---|---|
| [`../../05-apps/_standard/04-envelope-adaptation.md`](../../05-apps/_standard/04-envelope-adaptation.md) | Binding adaptation ladder and region matrix. This standard extends it with physical and safety rules; it does not replace it. |
| [`../../05-apps/_standard/07-performance.md`](../../05-apps/_standard/07-performance.md) | Binding budget table. Envelopes may add metrics (thermal, glare, determinism) but MUST NOT relax a ceiling. |
| [`../../05-apps/_standard/03-flow-spec.md`](../../05-apps/_standard/03-flow-spec.md) | Binding flow and frame format. Envelope flows use it unchanged. |
| `../../04-shell/*` | Shell owns the strip, rail, notifications and lifecycle. Envelopes declare presence, geometry and safety constraints, not shell internals. |
| `../../02-architecture/ecosystem/*` | Protocol owns discovery, trust and transport. This standard owns what the person sees and can revoke. |

Where a conflict exists it is recorded in the owning envelope's `12-open-questions.md` and,
if cross-cutting, in the corpus decision log. It is never resolved silently (`LAW-001`).

---

## 7. Change rules

- A change to an envelope profile that alters safety class or input set requires an ADR.
- A new surface on one envelope does not automatically appear on another. It is re-derived
  from the envelope's jobs.
- Removing a capability requires a declared absence and an alternative, not a deletion.
- Budgets may only tighten without an approved exception.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-ENV-STANDARD-001` | All 14 files exist per envelope, or absence is declared. |
| `AC-ENV-STANDARD-002` | The device × surface matrix has no silent cell. |
| `AC-ENV-STANDARD-003` | Every flow has frames with state, focus, action, transition, announce. |
| `AC-ENV-STANDARD-004` | No stub, TODO or "similar to". |
| `AC-ENV-STANDARD-005` | Every S3/S4 safety rule has a failing test. |
| `AC-ENV-STANDARD-006` | Every envelope profile declares all fourteen fields. |
| `AC-ENV-STANDARD-007` | Every declared absence has a replacement path for the affected job. |

---

## 9. Changelog

| Version | Date | Change |
|---|---|---|
| 0.1.0 | 2026-10-22 | Initial standard: profile, ladder, regions, input, rail, fullscreen, windows, safety, performance, failure, continuity, acceptance. |
