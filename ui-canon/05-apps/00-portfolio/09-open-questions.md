---
id: PORTFOLIO-OPENQ
title: Open Questions
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-CANDIDATES, PORTFOLIO-ADMISSION, PORTFOLIO-ENVELOPES, FW-Q-005]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-OPENQ-001, AC-PORTFOLIO-OPENQ-002]
---

# Open Questions

> Unresolved portfolio decisions. Each has an owner, a deadline and the evidence needed.
> A question without an owner is a defect. A question hidden in prose is a defect.

---

## 1. Register

| ID | Question | Owner | Needed by | Evidence needed |
|---|---|---|---|---|
| `OQ-PORTFOLIO-001` | Is the candidate list frozen at 25 apps, or should `tasks` fold into `calendar`? | Apps Guild + Calendar lead | Gate 1 | User research on commitment tracking vs. time planning; envelope reach. |
| `OQ-PORTFOLIO-002` | Does `converter` fold into `calculator`, or stand alone? | Apps Guild + Compute lead | Gate 1 | Frequency of conversion tasks; watch/phone usage. |
| `OQ-PORTFOLIO-003` | Does `people` fold into `messages`/`mail`, or stand alone? | Apps Guild + Communicate lead | Gate 1 | Whether contact management is a separate job or a view. |
| `OQ-PORTFOLIO-004` | Is `studio` one app or a family (audio studio, video editor, image editor)? | Apps Guild + Create lead | Wave 3 | Capability scope; envelope reach; reproducibility cost. |
| `OQ-PORTFOLIO-005` | Does `browser` keep that name, or become "Read"/"Navigate"? | Apps Guild + Naming review | Gate 1 | Naming rules (`08-naming.md`); user comprehension test. |
| `OQ-PORTFOLIO-006` | Are `music` and `video` separate apps or one "media" app with two modes? | Apps Guild + Media lead | Wave 3 | Whether the jobs (listen vs. watch) share enough model. |
| `OQ-PORTFOLIO-007` | What is the minimum app set on a watch: clock only, or clock + glance surfaces? | Envelope Guild + Apps Guild | Envelope gate | Watch constraints; glance contract specification. |
| `OQ-PORTFOLIO-008` | What is the minimum app set on IoT: clock + home-control, or control only? | Envelope Guild + IoT lead | Envelope gate | IoT surface availability; remote rendering. |
| `OQ-PORTFOLIO-009` | Does `terminal` meet the reproducibility bar, or is it a developer tool outside the standard? | Apps Guild + Developer Ecosystem | Wave 3 | Scope of terminal behaviour; stranger test. |
| `OQ-PORTFOLIO-010` | Does `agent-console` belong in the default portfolio or in the developer subtree? | Apps Guild + AI Interaction lead | Wave 2 gate | Human-AI interaction spec. |
| `OQ-PORTFOLIO-011` | Resolve `FW-Q-005`: re-check component coverage against the frozen portfolio. | Framework Guild + Canon Editor | Portfolio freeze | Component manifest audit. |
| `OQ-PORTFOLIO-012` | Should `wallet` be a separate app or a capability of `store`/`home-control`? | Apps Guild + Transact lead | Gate 1 | Payment scope; security review. |
| `OQ-PORTFOLIO-013` | Are there jobs missing from the twelve needs (e.g., "play" as distinct from rest)? | UX Research Lead + Apps Guild | Gate 1 | Evidence from `09-research/ux/`; timelessness test. |
| `OQ-PORTFOLIO-014` | What is the migration story for a user coming from a legacy OS with a home screen? | Onboarding lead | Wave 3 | Onboarding spec; first-run flows. |
| `OQ-PORTFOLIO-015` | How does the portfolio version and change over time without breaking envelopes? | Canon Editor | Before 0.2.0 | Append-only protocol; versioning rules. |

---

## 2. Gaps

| ID | Gap | Consequence | Owner |
|---|---|---|---|
| `GAP-PORTFOLIO-01` | No Naledzi-specific user research exists. Every admission score is a hypothesis. | All scores rest on external evidence plus design argument. | UX Research Lead |
| `GAP-PORTFOLIO-02` | Envelope agents have not yet confirmed capability reach for contextual apps. | Contextual statuses may change. | Envelope Guild |
| `GAP-PORTFOLIO-03` | No second scorer has reproduced the scores. | Scores are single-author. | Canon Editor |
| `GAP-PORTFOLIO-04` | Accessibility community has not reviewed the candidate list. | Accessibility implications are standards-derived. | Accessibility Guild |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-OPENQ-001` | Every question has an owner and a deadline. |
| `AC-PORTFOLIO-OPENQ-002` | Every gap is recorded with a consequence and an owner. |