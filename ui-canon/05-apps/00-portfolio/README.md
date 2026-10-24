---
id: PORTFOLIO-INDEX
title: App Portfolio — Index and Manifest
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PROC-MASTER-BRIEF, PROC-COMPLETENESS, PROC-APPEND-ONLY, CANON-TIMELESSNESS, CANON-LAWS, APP-STANDARD, APP-ANATOMY, UX-RESEARCH-INDEX, UX-TIMELESSNESS]
supersedes: []
superseded_by: []
children:
  - 01-needs-not-apps.md
  - 02-job-domains.md
  - 03-admission-test.md
  - 04-candidate-portfolio.md
  - 05-rejections.md
  - 06-envelope-map.md
  - 07-shell-and-system-boundaries.md
  - 08-naming.md
  - 09-open-questions.md
  - 10-acceptance.md
acceptance: [AC-PORTFOLIO-001, AC-PORTFOLIO-002, AC-PORTFOLIO-003, AC-PORTFOLIO-004, AC-PORTFOLIO-005, AC-PORTFOLIO-006, AC-PORTFOLIO-007, AC-PORTFOLIO-008]
---

# App Portfolio — Index and Manifest

> The Naledzi app suite is not a list inherited from a legacy operating system. It is the
> set of capability-scoped, stateful views of timeless human jobs that survive the
> admission test in [`03-admission-test.md`](03-admission-test.md) and the envelope map in
> [`06-envelope-map.md`](06-envelope-map.md). The calculator is the reproducibility
> exemplar, not a mandate.

**Status: review.** Authored to the completeness contract. Not yet canon; content is the
deliverable.

---

## 1. What this directory is

`05-apps/00-portfolio/` is the single owner of the answer to the question: **which apps
exist, why, on which envelopes, and which legacy categories were rejected.** Every other
subtree — shell, framework, envelopes, wireframes — composes around the jobs and the
derived portfolio. None of them hardcodes an app inventory.

This directory owns:

- the timeless human needs that predate computing (`01-needs-not-apps.md`);
- the job domains derived from those needs (`02-job-domains.md`);
- the admission test every candidate must pass (`03-admission-test.md`);
- the candidate portfolio with status (`04-candidate-portfolio.md`);
- the rejection list for legacy categories (`05-rejections.md`);
- the envelope map (`06-envelope-map.md`);
- the boundary between apps, shell and system surfaces (`07-shell-and-system-boundaries.md`);
- the naming rules (`08-naming.md`);
- the open questions (`09-open-questions.md`);
- the acceptance criteria (`10-acceptance.md`).

---

## 2. How app owners use this directory

1. **Before writing an app directory**, read `01-needs-not-apps.md`, `02-job-domains.md`
   and `03-admission-test.md`. An app that cannot state its human need, its job domain
   and its score is not ready to be specified (`LAW-012`).
2. **Find the candidate entry** in `04-candidate-portfolio.md`. It names the job, the need,
   the envelopes, the primary input, the capability needs and the confidence.
3. **Check the envelope map** in `06-envelope-map.md`. An app that is `absent` on an
   envelope MUST NOT be specified there; an app that is `contextual` must declare its
   gating condition.
4. **Check the boundary** in `07-shell-and-system-boundaries.md`. If the surface you are
   about to specify is in that list, it is not an app; specify it under `04-shell/`.
5. **Name the app** per `08-naming.md`. The stable ID is minted here and never reused.
6. **Record open questions** in `09-open-questions.md` (or the app's own
   `12-open-questions.md`), with owner and deadline. Do not hide them in prose.
7. **Prove conformance** against `10-acceptance.md` and the app standard
   (`APP-STANDARD`).

The calculator (`05-apps/calculator/`) remains the reproducibility exemplar: the smallest
unforgiving proof that the app standard works end to end. It is not a mandate that every
device ships a calculator; its presence in the portfolio is `contextual` and its admission
is recorded in `04-candidate-portfolio.md` with its score.

---

## 3. What is provisional

- **Status of every candidate is `review` or `provisional`** until the Canon Editor
  freezes the portfolio at Gate 1 (`19-agent-waves.md` §2). No candidate is `canon` yet.
- **The admission scores** in `03-admission-test.md` and `04-candidate-portfolio.md` are
  the Portfolio Architect's scored entries, subject to review. A score of 18 with a
  declared weakness is preferred to a dishonest 20 (`CANON-TIMELESSNESS` §2).
- **Envelope coverage** for candidates marked `contextual` depends on envelope agents
  confirming capability reach; see `09-open-questions.md`.
- **No app directory may be created from this portfolio** until Gate 1 closes. Wave 3
  app leads consume a frozen portfolio.
- **The framework's open question `FW-Q-005`** ("component coverage justified by
  primitives and jobs, not by a confirmed app list") is resolved only when this portfolio
  is frozen and re-checked.

---

## 4. The derived portfolio at a glance

See `04-candidate-portfolio.md` for the full table. Summary counts:

| Status | Count |
|---|---|
| Canon (proposed) | 0 |
| Review / provisional | 24 job surfaces (see `04-candidate-portfolio.md`) |
| Rejected legacy categories | 8 (see `05-rejections.md`) |
| Folded into shell/system | 9 (see `07-shell-and-system-boundaries.md`) |

The portfolio is **derived from jobs, not from app names.** A name that sounds like a
legacy app (files, notes, terminal, browser) survives only if its job survives and its
composition is re-derived. See `05-rejections.md` §2.

---

## 5. Directory tree

```text
05-apps/00-portfolio/
├── README.md                          this manifest (PORTFOLIO-INDEX)
├── 01-needs-not-apps.md               timeless human needs (PORTFOLIO-NEEDS)
├── 02-job-domains.md                  job domains (PORTFOLIO-JOBS)
├── 03-admission-test.md               admission test and scorecard (PORTFOLIO-ADMISSION)
├── 04-candidate-portfolio.md          candidates (PORTFOLIO-CANDIDATES)
├── 05-rejections.md                   rejected legacy categories (PORTFOLIO-REJECTIONS)
├── 06-envelope-map.md                 envelope map (PORTFOLIO-ENVELOPES)
├── 07-shell-and-system-boundaries.md  what is not an app (PORTFOLIO-BOUNDARIES)
├── 08-naming.md                       naming (PORTFOLIO-NAMING)
├── 09-open-questions.md               open questions (PORTFOLIO-OPENQ)
└── 10-acceptance.md                   acceptance (PORTFOLIO-ACCEPTANCE)
```

---

## 6. Cross-references

- Timelessness test: [`00-canon/01-timelessness-test.md`](../../00-canon/01-timelessness-test.md)
- Design laws: [`00-canon/02-design-laws.md`](../../00-canon/02-design-laws.md)
- App standard: [`../_standard/README.md`](../_standard/README.md)
- App anatomy: [`../_standard/01-anatomy.md`](../_standard/01-anatomy.md)
- Envelope standard: [`../../06-envelopes/_standard/README.md`](../../06-envelopes/_standard/README.md)
- UX research: [`../../09-research/ux/README.md`](../../09-research/ux/README.md)
- Layer model: [`../../08-process/01-layer-model.md`](../../08-process/01-layer-model.md)
- Agent waves: [`../../08-process/19-agent-waves.md`](../../08-process/19-agent-waves.md)

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-001` | Every file listed in `children` exists and is non-empty. |
| `AC-PORTFOLIO-002` | No candidate is admitted without a scored entry in `03-admission-test.md`. |
| `AC-PORTFOLIO-003` | No legacy category is admitted without a re-derivation in `05-rejections.md`. |
| `AC-PORTFOLIO-004` | Every candidate has an envelope status in `06-envelope-map.md`. |
| `AC-PORTFOLIO-005` | The boundary list in `07-shell-and-system-boundaries.md` is exhaustive for shell surfaces named in the master brief. |
| `AC-PORTFOLIO-006` | Every admitted name passes `08-naming.md`. |
| `AC-PORTFOLIO-007` | Every open question has an owner and a deadline. |
| `AC-PORTFOLIO-008` | A second reader can reproduce the candidate list from `01` and `02` alone. |