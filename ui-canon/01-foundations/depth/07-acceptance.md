---
id: FOUND-DEPTH-ACCEPT-07
title: Depth Acceptance
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-INDEX, FOUND-DEPTH-SPACE-01, FOUND-DEPTH-ELEV-02, FOUND-DEPTH-SHADOW-03, FOUND-DEPTH-PARALLAX-04, FOUND-DEPTH-OCCLUSION-05, FOUND-DEPTH-MATERIAL-06]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-100, AC-FOUND-DEPTH-101, AC-FOUND-DEPTH-102]
---

# Depth Acceptance

> Every criterion here can fail. A criterion that cannot fail is a slogan.

---

## 1. The reference set

The tests use four reference surfaces, built once and reused by every foundation:

| Reference | What it contains | Why it is in the set |
|---|---|---|
| `REF-DEPTH-BASE` | A page with a heading, body text, a list and a map region | Exercises E0 and E1 |
| `REF-DEPTH-FLOAT` | The base plus an anchored menu and a tooltip | Exercises E2 and parallax |
| `REF-DEPTH-MODAL` | The base plus a dialog with a form, a scrim and a return focus target | Exercises E3 and focus |
| `REF-DEPTH-SAFETY` | An EV frame with speed, range, a critical warning and a protected zone | Exercises E4, safety material and occlusion |

The reference surfaces are wireframe-level specifications, not screenshots. They are drawn in
`07-wireframes/` by the wireframe owner; this file names the depth facts they must contain.

---

## 2. Structural acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-DEPTH-100` | Every surface has one level and one material | Static inspection of the component spec and the runtime still | 100% of surfaces, zero unlabelled |
| `AC-FOUND-DEPTH-101` | Every level is distinguishable without shadow | Render with the shadow pass disabled; ask five people to order the surfaces | All five produce the declared order |
| `AC-FOUND-DEPTH-102` | Occlusion, hit map, focus order and accessibility order agree | Automated still comparison plus a scripted click and screen-reader read | No disagreement in any still |
| `AC-FOUND-DEPTH-103` | One light direction per output | Inspect all shadow offsets in the still | All offsets share the declared sign and ratio |
| `AC-FOUND-DEPTH-104` | No E0 shadow, no E0 translucency | Inspect the base surface | Both absent |
| `AC-FOUND-DEPTH-105` | Every E1-E4 surface has contact and ambient shadow, or the declared outline fallback | Toggle the shadow renderer and inspect | Level readable in both modes |
| `AC-FOUND-DEPTH-106` | No shadow crosses a critical indicator | Render the safety reference at 1 m and 4 m | Zero intersections with the protected zone |

---

## 3. Interaction acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-DEPTH-110` | E2 dismisses on outside action and Escape | Scripted pointer and keyboard test | Menu closes, focus returns to trigger |
| `AC-FOUND-DEPTH-111` | E3 traps focus and blocks input behind | Scripted tab cycle and click-through test | Focus never leaves; clicks behind do nothing |
| `AC-FOUND-DEPTH-112` | E4 interrupts an E3 without losing its state | Scripted safety injection during a dialog | Alert receives focus; dialog state is intact after dismissal |
| `AC-FOUND-DEPTH-113` | Focus returns to the invoker or a declared fallback | Close each overlay after the invoker is removed | Focus lands on the declared fallback and is announced |
| `AC-FOUND-DEPTH-114` | Scrim and input block appear and disappear together | Frame-by-frame still inspection | No frame with one and not the other |
| `AC-FOUND-DEPTH-115` | A level transition never hides both source and destination | Record the transition at 60 Hz and 120 Hz | At least one surface is visible in every frame |

---

## 4. Adaptation acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-DEPTH-120` | Reduced motion removes parallax | Toggle while displaced | Offset settles to zero within 120 ms, no snap |
| `AC-FOUND-DEPTH-121` | Reduced transparency makes every surface opaque | Toggle and sample each translucent surface | Opacity is 100%, blur is off, layout unchanged |
| `AC-FOUND-DEPTH-122` | High contrast replaces shadows with outlines | Enable high contrast | Every level has a visible outline; no shadow is required |
| `AC-FOUND-DEPTH-123` | 200% text does not change depth order | Render at 200% text | Order, occlusion and protected zones unchanged |
| `AC-FOUND-DEPTH-124` | RTL does not mirror the light | Switch to Arabic or Hebrew | Shadow offsets unchanged; reading order mirrored |
| `AC-FOUND-DEPTH-125` | A screen reader receives the level and the protection, not the shadow | Read each reference with a screen reader | Level is conveyed by role and context; protected warnings are announced first |

---

## 5. Performance acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-DEPTH-130` | No per-frame Gaussian blur for shadows | GPU trace of the reference set | Zero shadow blur passes per frame |
| `AC-FOUND-DEPTH-131` | Shadow cost is within budget on the weakest envelope | Measure the watch reference at p95 | At most 0.8 ms GPU or 1.2 ms CPU per frame |
| `AC-FOUND-DEPTH-132` | Parallax does not force a full-surface redraw | Damage trace during pointer motion | Damage is limited to the parallaxing layers |
| `AC-FOUND-DEPTH-133` | Idle surfaces schedule no depth work | Leave the reference idle for 10 minutes | Zero shadow, blur or parallax wakeups |

---

## 6. Failure acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-DEPTH-140` | Missing shadow asset falls back without an error dialog | Remove each shadow asset in turn | Level readable; no modal error; non-fatal log entry |
| `AC-FOUND-DEPTH-141` | Missing blur falls back to opaque | Disable the blur capability | Surface opaque; text contrast passes |
| `AC-FOUND-DEPTH-142` | Occlusion disagreement is rejected, not drawn | Inject a commit with a wrong order | Authority rejects with a named error; previous still remains |
| `AC-FOUND-DEPTH-143` | Critical indicator occlusion triggers redundancy | Cover the protected zone in a test build | Audio/haptic redundant indicator fires; event recorded |
| `AC-FOUND-DEPTH-144` | Shadow cache exhaustion is bounded | Fill the cache in a stress test | Old shadows evict; no unbounded allocation; no crash |
| `AC-FOUND-DEPTH-145` | Tracking loss holds a stable pose | Interrupt spatial tracking | Last pose holds; a tracking-loss state appears if it persists |

---

## 7. Traceability

| Need | Foundation rule | Proposed token | Component | AC |
|---|---|---|---|---|
| Tell what is in front | `FOUND-DEPTH-001`, `FOUND-DEPTH-160` | `TOK-DEPTH-ELEV-*` | `COMP-SURFACE` | `AC-FOUND-DEPTH-102` |
| Show a card belongs to the page | `FOUND-DEPTH-050`, `FOUND-DEPTH-080` | `TOK-DEPTH-SHADOW-1` | `COMP-SURFACE` | `AC-FOUND-DEPTH-101` |
| Separate a modal task | `FOUND-DEPTH-170`, `FOUND-DEPTH-190` | `TOK-DEPTH-SCRIM-3` | `COMP-SCRIM` | `AC-FOUND-DEPTH-111` |
| Warn without being covered | `FOUND-DEPTH-070`, `FOUND-DEPTH-200` | `TOK-COLOR-SAFETY-*`, `TOK-DEPTH-MATERIAL-SAFETY` | `COMP-ALERT` | `AC-FOUND-DEPTH-106` |
| Show distance without sickness | `FOUND-DEPTH-110`, `FOUND-DEPTH-150` | `TOK-DEPTH-PARALLAX-*` | `COMP-SURFACE` | `AC-FOUND-DEPTH-120` |
| Survive a weak GPU | `FOUND-DEPTH-082`, `FOUND-DEPTH-220` | `TOK-DEPTH-SHADOW-FALLBACK` | `COMP-SURFACE` | `AC-FOUND-DEPTH-130` |

---

## 8. Sign-off checklist

- [ ] All 18 files exist and are listed in the README.
- [ ] Every `FOUND-DEPTH-*` rule has at least one AC.
- [ ] Every AC has a method and a pass condition.
- [ ] The four reference surfaces are drawn by the wireframe owner.
- [ ] The ten envelope rows in `10-envelopes.md` are filled.
- [ ] The high-contrast, reduced-motion, reduced-transparency, 200% text and RTL tests pass.
- [ ] The performance budget is measured on the weakest envelope, not the development machine.
- [ ] The safety reference passes at 1 m and 4 m.
- [ ] The open questions have owners and deadlines.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-100` | The structural, interaction, adaptation, performance and failure tables above are executed; every pass condition is met. |
| `AC-FOUND-DEPTH-101` | A second team can implement the four reference surfaces from this directory and pass the same tests without asking a depth question. |
| `AC-FOUND-DEPTH-102` | The sign-off checklist is complete, with the name of the reviewer and the date. |
