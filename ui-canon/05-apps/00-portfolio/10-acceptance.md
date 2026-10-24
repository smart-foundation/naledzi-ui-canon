---
id: PORTFOLIO-ACCEPTANCE
title: Acceptance
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-NEEDS, PORTFOLIO-JOBS, PORTFOLIO-ADMISSION, PORTFOLIO-CANDIDATES, PORTFOLIO-REJECTIONS, PORTFOLIO-ENVELOPES, PORTFOLIO-BOUNDARIES, PORTFOLIO-NAMING, PORTFOLIO-OPENQ, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-009]
---

# Acceptance

> The portfolio is proven when a second team can reproduce it, when every candidate is
> scored and mapped, when no legacy category is admitted without re-derivation, and when
> the boundary between apps and shell/system surfaces is exhaustive.

---

## 1. Acceptance criteria

| ID | Criterion | Evidence |
|---|---|---|
| `AC-PORTFOLIO-001` | Every file listed in `README.md` `children` exists and is non-empty. | Tree audit. |
| `AC-PORTFOLIO-002` | No candidate is admitted without a scored entry in `03-admission-test.md`. | Candidate audit. |
| `AC-PORTFOLIO-003` | No legacy category is admitted without a re-derivation in `05-rejections.md`. | Rejection audit. |
| `AC-PORTFOLIO-004` | Every candidate has an envelope status in `06-envelope-map.md`. | Envelope audit. |
| `AC-PORTFOLIO-005` | The boundary list in `07-shell-and-system-boundaries.md` is exhaustive for shell surfaces named in the master brief. | Boundary audit. |
| `AC-PORTFOLIO-006` | Every admitted name passes `08-naming.md`. | Naming audit. |
| `AC-PORTFOLIO-007` | Every open question has an owner and a deadline. | Open-question audit. |
| `AC-PORTFOLIO-008` | A second reader can reproduce the candidate list from `01` and `02` alone. | Reproducibility trial. |
| `AC-PORTFOLIO-009` | The portfolio as a whole passes the completeness contract (`PROC-COMPLETENESS`). | Completeness audit. |
| `AC-PORTFOLIO-NEEDS-001` | Every candidate traces to at least one need in `01-needs-not-apps.md`. | Traceability audit. |
| `AC-PORTFOLIO-NEEDS-002` | No need statement contains an app, screen, icon, dock, tab or vendor name. | Text audit. |
| `AC-PORTFOLIO-NEEDS-003` | Every job statement follows the Christensen form. | Statement audit. |
| `AC-PORTFOLIO-NEEDS-004` | Every need is tested against the envelope set. | Envelope audit. |
| `AC-PORTFOLIO-NEEDS-005` | A stranger can derive the need list from the citations. | Reproducibility trial. |
| `AC-PORTFOLIO-JOBS-001` | Every domain has all five fields. | Domain audit. |
| `AC-PORTFOLIO-JOBS-002` | Every domain has at least one Christensen-form job statement. | Statement audit. |
| `AC-PORTFOLIO-JOBS-003` | Every candidate maps to at least one domain. | Traceability audit. |
| `AC-PORTFOLIO-JOBS-004` | No domain names an app, vendor, file format or screen. | Text audit. |
| `AC-PORTFOLIO-JOBS-005` | Every domain with injury-level failure cost is cross-referenced to safety envelopes. | Safety audit. |
| `AC-PORTFOLIO-ADMISSION-001` | Every candidate has a scored row. | Score audit. |
| `AC-PORTFOLIO-ADMISSION-002` | No candidate is admitted with a 0 on criteria 1–4. | Score audit. |
| `AC-PORTFOLIO-ADMISSION-003` | Every rejected candidate has a recorded score and reason. | Rejection audit. |
| `AC-PORTFOLIO-ADMISSION-004` | A second scorer reproduces the score within ±1. | Reproducibility trial. |
| `AC-PORTFOLIO-REJECTIONS-001` | Every rejected category has a score and a reason. | Rejection audit. |
| `AC-PORTFOLIO-REJECTIONS-002` | Every surviving job is mapped to an admitted surface or shell surface. | Traceability audit. |
| `AC-PORTFOLIO-REJECTIONS-003` | No rejected category is implemented as an app without a new scored entry. | Gate audit. |
| `AC-PORTFOLIO-ENVELOPES-001` | Every candidate has an envelope status. | Envelope audit. |
| `AC-PORTFOLIO-ENVELOPES-002` | Every contextual status names its gating condition. | Condition audit. |
| `AC-PORTFOLIO-ENVELOPES-003` | Every absent status has a reason. | Absence audit. |
| `AC-PORTFOLIO-ENVELOPES-004` | Every peer-only status has a peer path. | Peer-path audit. |
| `AC-PORTFOLIO-ENVELOPES-005` | The mandatory set is consistent with the safety class of each envelope. | Safety audit. |
| `AC-PORTFOLIO-CANDIDATES-001` | Every candidate has all eight fields. | Candidate audit. |
| `AC-PORTFOLIO-CANDIDATES-002` | Every candidate has a score. | Score audit. |
| `AC-PORTFOLIO-CANDIDATES-003` | Every candidate maps to at least one domain and need. | Traceability audit. |
| `AC-PORTFOLIO-CANDIDATES-004` | The envelope matrix has no blank cell. | Matrix audit. |
| `AC-PORTFOLIO-BOUNDARIES-001` | Every shell surface named in the master brief appears. | Boundary audit. |
| `AC-PORTFOLIO-BOUNDARIES-002` | No boundary surface is specified as an app. | Boundary audit. |
| `AC-PORTFOLIO-BOUNDARIES-003` | Every candidate passes the app test. | Boundary audit. |
| `AC-PORTFOLIO-NAMING-001` | Every admitted app has a stable ID, directory name and display name. | Naming audit. |
| `AC-PORTFOLIO-NAMING-002` | No admitted name imitates a vendor's app name. | Naming audit. |
| `AC-PORTFOLIO-NAMING-003` | Every display name has a message key and translation path. | Naming audit. |
| `AC-PORTFOLIO-OPENQ-001` | Every question has an owner and a deadline. | Open-question audit. |
| `AC-PORTFOLIO-OPENQ-002` | Every gap is recorded with a consequence and an owner. | Gap audit. |

---

## 2. Traceability table

| Need | Domain | Candidate | Flow (future) | AC |
|---|---|---|---|---|
| N4 Compute | JD-04 | calculator | `FLOW-CALC-*` | `AC-CALC-*` |
| N4 Compute | JD-04 | converter | (none yet) | (none yet) |
| N3 Create | JD-03 | notes | (none yet) | (none yet) |
| N2 Remember | JD-02 | files | (none yet) | (none yet) |
| N3 Create | JD-03 | camera | (none yet) | (none yet) |
| N2/N10 | JD-02/10 | photos | (none yet) | (none yet) |
| N10/N11 | JD-10/11 | music, video | (none yet) | (none yet) |
| N3 Create | JD-03 | studio | (none yet) | (none yet) |
| N5 Navigate | JD-05 | browser | (none yet) | (none yet) |
| N1 Communicate | JD-01 | mail, messages, people | (none yet) | (none yet) |
| N12 Coordinate | JD-12 | calendar, tasks | (none yet) | (none yet) |
| N5 Navigate | JD-05 | maps | (none yet) | (none yet) |
| N10 Observe | JD-10 | weather, clock | (none yet) | (none yet) |
| N6 Care | JD-06 | health | (none yet) | (none yet) |
| N8 Transact | JD-08 | wallet, store | (none yet) | (none yet) |
| N9 Control env. | JD-09 | home-control, settings, agent-console | (none yet) | (none yet) |

A need without a flow is an unmet need (`DOC-SYSTEM` §11). Flows are written in Wave 3.

---

## 3. The stranger test for the portfolio

A competent team that has never spoken to the Portfolio Architect can, from this directory
alone:

1. state the twelve needs and why they predate computing (with citations);
2. derive the job domains and their failure costs;
3. apply the admission test to a new candidate and reach a verdict;
4. name the candidate apps, their envelopes and their status;
5. state which legacy categories were rejected and why;
6. state which surfaces are shell/system, not apps;
7. name an app without legacy baggage or vendor mimicry.

If any of these fails, the portfolio is not done. Fix the spec, not the scorer.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-ACCEPTANCE-001` | All criteria in §1 pass. |
| `AC-PORTFOLIO-ACCEPTANCE-002` | The traceability table in §2 has no blank cell for an admitted app. |
| `AC-PORTFOLIO-ACCEPTANCE-003` | The stranger test in §3 passes. |