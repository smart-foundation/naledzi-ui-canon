---
id: WF-SPACIOUS-ACCEPTANCE
title: Spacious — Acceptance
kind: wireframe
entity: spacious
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, PROC-COMPLETENESS, UX-RESEARCH-INDEX, UX-SPACIOUS, FOUND-EXPERIENCE-INDEX, WF-SPACIOUS-INDEX, WF-SPACIOUS-PRINCIPLES, WF-SPACIOUS-FRAMES, WF-SPACIOUS-ADAPTATION]
supersedes: []
superseded_by: []
acceptance: [AC-WF-SPACIOUS-040, AC-WF-SPACIOUS-041, AC-WF-SPACIOUS-042, AC-WF-SPACIOUS-043, AC-WF-SPACIOUS-044]
---

# Spacious — Acceptance

> How spacious density is proved. Every criterion is testable by a second team with no
> design question. Evidence is recorded per envelope.

---

## 1. Structural acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-040` | Every file listed in `WF-SPACIOUS-INDEX` `children` exists; no file contains `TODO`, an empty heading or "similar to". |
| `AC-WF-SPACIOUS-041` | Every frame in `02-frames.md` is drawn as ASCII and names state, focus, content, action, transition and announcement. |
| `AC-WF-SPACIOUS-042` | Every frame exists for all seven envelopes (watch, phone, tablet, desktop, TV, EV, spaceship) or declares a reason for absence. |
| `AC-WF-SPACIOUS-043` | No frame changes colour, depth semantics, motion grammar, state machine, command IDs or wording relative to its compact counterpart. |

## 2. Behavioural acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-044` | Spacious density is selectable per surface and per session, and is reversible without data loss or state change. |
| `AC-WF-SPACIOUS-045` | Spacious increases spacing, reduces visible action count and calms hierarchy, in that priority order, on every frame. |
| `AC-WF-SPACIOUS-046` | No primary action is hidden in spacious density. |
| `AC-WF-SPACIOUS-047` | Every spacious target meets the floors (44 × 44 primary, 32 × 32 secondary, 8 px gap) or the envelope's stricter floor. |
| `AC-WF-SPACIOUS-048` | Every spacious frame meets the WCAG 2.2 AA accessibility floor and does not reduce contrast, focus visibility or screen-reader completeness. |

## 3. Content acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-049` | Every piece of content from the compact frame is present in the spacious frame, re-flowed, collapsed, paged or moved to a peer. No content is dropped. |
| `AC-WF-SPACIOUS-050` | Every overflow is visible (`⋯`, page indicator, sheet handle or peer indicator) and reversible in one step. |

## 4. Degradation acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-051` | Degradation from spacious to compact fires automatically on every declared trigger and reverses when the trigger clears. |
| `AC-WF-SPACIOUS-052` | Degradation is announced in the surface's own language with the reason, except safety-required changes on safety envelopes, which are recorded in the still and announced to assistive tech. |
| `AC-WF-SPACIOUS-053` | Degradation does not drop content. |
| `AC-WF-SPACIOUS-054` | A person's explicit density choice overrides automatic degradation except where a safety rule forbids spacious; in that case the safety rule wins and the override is recorded. |

## 5. Safety acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-055` | On EV, no spacious frame covers a protected zone at any frame. |
| `AC-WF-SPACIOUS-056` | On spaceship, spacious is not the default during an alarm or high-workload state; compact is used and the change is recorded in the still. |
| `AC-WF-SPACIOUS-057` | Under stress, workload, fatigue, low battery, glare or vibration, spacious is the default and compact is not forced. |

## 6. Derivation acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-058` | A stranger can derive every spacious frame from its compact counterpart using `01-principles.md` §1 and §3–§7 without asking a design question. |
| `AC-WF-SPACIOUS-059` | Removing all shadows, borders and dividers from a spacious frame leaves the hierarchy readable from position, spacing, scale and contrast. |
| `AC-WF-SPACIOUS-060` | A stranger can implement the spacious frames without asking a question. |

## 7. Golden flows

| Flow | Evidence |
|---|---|
| Home in spacious on phone, tablet and desktop | Frames 9–11 pass the derivation and content tests. |
| App frame in spacious on all seven envelopes | Frames 15–21 pass the derivation and content tests. |
| Settings root in spacious | Frames 22–28 pass. |
| Palette in spacious | Frames 29–35 pass. |
| Notification in spacious | Frames 36–42 pass. |
| Fullscreen in spacious | Frames 43–49 pass. |
| Rare cases in spacious | Frames 50–56 pass. |
| Degradation phone 200% text | Frame 53 passes content and announcement tests. |
| EV protected zone | Frames 13, 20, 34, 41, 48 pass the safety test. |
| Spaceship alarm | Frame 42 and §2.7 pass the safety test. |

---

## 8. Open verification notes

- The concrete spacing multiplier for the spacious step is owned by `03-framework/tokens/` and is not fixed in this subtree. Until the token file is minted, the multiplier is recorded as a proposed value there and marked `review`.
- The paging budget (maximum pages before degradation) is proposed as 3 pages per surface and is recorded as an open question in `09-research/ux/16-open-questions.md`.
- The exact list of system rules that auto-select spacious (stress, fatigue, low battery, one-handed, glare, vibration) is owned jointly by this subtree and `01-foundations/experience/`; conflicts are recorded in the experience subtree's open questions.