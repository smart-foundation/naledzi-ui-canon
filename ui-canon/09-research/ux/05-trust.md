---
id: UX-TRUST
title: Trust — Automation Trust, Calibration, Over/Under-trust, Privacy, Transparency, Reversibility
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-EMOTION]
supersedes: []
superseded_by: []
acceptance: [AC-UX-TRUST-001, AC-UX-TRUST-002, AC-UX-TRUST-003]
---

# Trust

> How trust in the system is built, calibrated and repaired, and why honesty beats
> polish.

## 1. Principle

Trust is not maximised; it is calibrated. A system that over-promises trust is
dangerous; a system that under-promises is unused. Trust is built on transparency
(what the system is doing and why), reversibility (a way back), privacy (data and
attention are the user's), and honesty about uncertainty and automation. Over-trust
in automation leads to complacency; under-trust leads to disuse. Both are failures
of calibration, not of capability.

## 2. Evidence

### 2.1 Automation trust

- **Parasuraman, R. and Riley, V. (1997).** "Humans and automation: use, misuse,
  disuse, abuse." *Human Factors*, 39(2), pp. 230–253. (URL:
  https://doi.org/10.1518/001872097778543886 ; accessed 23 October 2026.) Finding:
  automation use falls into use, misuse (over-trust), disuse (under-trust) and abuse
  (using automation for unintended purposes). Limit: the taxonomy is descriptive;
  interventions are context-specific. Implication: Naledzi automation (sync, agents,
  predictive actions) must be transparent and interruptible; over-trust is prevented
  by visible provenance and easy override.

- **Lee, J. D. and See, K. A. (2004).** "Trust in automation: designing for
  appropriate reliance." *Human Factors*, 46(1), pp. 50–80. (URL:
  https://doi.org/10.1518/hfes.46.1.50_30392 ; accessed 23 October 2026.) Finding:
  trust is a function of performance, process and purpose information; appropriate
  reliance requires calibration, not maximisation. Implication: Naledzi shows what an
  automated action did, why, and how to undo it; it never hides automation behind
  polish (`LAW-011`).

### 2.2 Over- and under-trust

- **Dzindolet, M. T., Peterson, S. A., Pomranky, R. A., Pierce, L. G. and Beck, H. P.
  (2003).** "The role of trust in automation reliance." *International Journal of
  Human-Computer Studies*, 58(6), pp. 697–718. (URL:
  https://doi.org/10.1016/S1071-5819(03)00038-7 ; accessed 23 October 2026.)
  Finding: trust is shaped by early experience and by the system's stated reliability;
  a single failure can collapse trust if it is unexpected. Implication: Naledzi's
  first-run and first-success paths must be honest and uneventful; surprises in
  automation are defects.

- **Muir, B. M. (1994).** "Trust in automation: Part I. Theoretical issues in the
  study of trust and human intervention in automated systems." *Ergonomics*, 37(11),
  pp. 1905–1922. (URL: https://doi.org/10.1080/00140139408964957 ; accessed
  23 October 2026.) Finding: trust has three dimensions — predictability,
  dependability, faith. Implication: Naledzi must be predictable (consistent grammar),
  dependable (honest state), and earn faith through recovery, not through marketing.

### 2.3 Transparency and provenance

- **Endsley, M. R. (1995).** "Toward a theory of situation awareness in dynamic
  systems." *Human Factors*, 37(1), pp. 32–64. (URL:
  https://doi.org/10.1518/001872095779049543 ; accessed 23 October 2026.) Finding:
  situation awareness requires perception, comprehension and projection; transparency
  of system state supports all three. Implication: Naledzi shows system state
  (sync status, battery, network, safety) as a first-class, readable fact, never
  hidden behind an icon with no label.

- **Kizilcec, R. F. (2016).** "How much information? Effects of transparency on trust
  in an algorithmic interface." *Proceedings of CHI '16*, pp. 2390–2395. (URL:
  https://doi.org/10.1145/2858036.2858402 ; accessed 23 October 2026.) Finding:
  moderate transparency increases trust; too much or too little decreases it.
  Implication: Naledzi exposes automation at the level of "what and why", not the
  full internal trace, unless the person asks (palette, developer settings).

### 2.4 Privacy and attention

- **LAW-020 (canon).** The user owns their data and attention. No training, upload or
  monetisation without explicit, revocable, informed choice. Notifications and motion
  respect attention as finite. Implication: all observation capabilities (screen
  recording, clipboard, thumbnails) are off by default and revocable; notification
  budgets and quiet hours are mandatory.

### 2.5 Reversibility

- **Norman, D. A. (1998).** *The Invisible Computer.* MIT Press. (URL:
  https://www.worldcat.org/title/invisible-computer/oclc/37398113 ; accessed
  23 October 2026.) Finding: the best interface is one that disappears into the task;
  recovery from error is part of the task. Implication: reversibility is a design
  requirement, not a feature (`LAW-015`); crash-safe stills and undo are mandatory.

## 3. What this predicts for Naledzi

1. **Trust is calibrated.** Transparency + reversibility + privacy + honesty.
2. **Automation is visible and interruptible.** Provenance shown; override is one
   action away.
3. **Observation is off by default and revocable.** (`LAW-020`.)
4. **Notification budgets and quiet hours are mandatory.** (`LAW-020`.)
5. **Reversibility is mandatory.** Undo, confirmation, crash-safe stills
   (`LAW-015`).
6. **Honesty over polish.** `NOT REPORTED` is valid; no fake success.

## 4. Limits and contested claims

- Trust research is domain-specific (aviation, medicine, driving); transfer to a
  general OS is interpretation and must be tested.
- Transparency effects are non-monotonic; the right level is a design decision that
  must be validated per envelope.

## 5. Where implemented (IDs)

- `UX-LAW-05`.
- `LAW-011`, `LAW-015`, `LAW-020`.
- `02-architecture/security/` — revocation, observation rights.
- `04-shell/notifications/` — budgets, quiet hours.
- `01-foundations/experience/05-error-recovery.md` — trust repair.

## 6. Acceptance implications

- `AC-UX-TRUST-001`: All observation capabilities are off by default on a fresh
  install; all are revocable from Settings.
- `AC-UX-TRUST-002`: Every automated action that changes user data shows provenance
  and an undo within one action.
- `AC-UX-TRUST-003`: Trust-repair flow (error → cause → recovery → undo) completes
  without a manual in the first-contact test.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-TRUST-001` | Observation capabilities off by default and revocable. |
| `AC-UX-TRUST-002` | Automated actions show provenance and undo. |
| `AC-UX-TRUST-003` | Trust-repair flow passes first-contact test. |