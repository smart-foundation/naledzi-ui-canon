---
id: FOUND-EXPERIENCE-ACCEPTANCE
title: Experience Acceptance — Confidence, Recovery, Learnability, Dignity, Stress; How to Test Without Faking It
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, FOUND-EXPERIENCE-FELT, FOUND-EXPERIENCE-RARE]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-ACC-001, AC-EXP-ACC-002, AC-EXP-ACC-003, AC-EXP-ACC-004, AC-EXP-ACC-005]
---

# Experience Acceptance

> How the experience is proved without faking it. Confidence, recovery, learnability,
> dignity, stress.

## 1. Principle

Experience acceptance is measured, not asserted. A test that can be passed by a fake
success is not a test. Tests use real tasks, real users (inclusive recruitment) and
real failure conditions.

## 2. Acceptance criteria

| ID | Criterion | Test |
|---|---|---|
| `AC-EXP-ACC-001` | Confidence | Failure test: deny, disconnect, remove, fill disk — every state honest and recoverable. |
| `AC-EXP-ACC-002` | Recovery | Crash recovery restores the last committed still without data loss. |
| `AC-EXP-ACC-003` | Learnability | First-contact test: primary action in < 5 s; golden flow without manual. |
| `AC-EXP-ACC-004` | Dignity | No blaming error messages; no dark patterns; ethics review pass. |
| `AC-EXP-ACC-005` | Stress | Stress scenario: task completion holds in spacious mode; NASA-TLX within threshold. |

## 3. How to test without faking it

1. **Use real tasks**, not synthetic ones. The task must be something a person would
   actually do.
2. **Use real users**, recruited inclusively (disabled, older, non-dominant-language,
   low-literacy).
3. **Use real failure conditions.** Deny a capability, disconnect the network, fill
   the disk, kill a service. Do not simulate success.
4. **Measure, do not assert.** Time, errors, completion, SUS/UMUX-Lite, NASA-TLX.
5. **Report failures plainly.** A failed test is a finding, not a embarrassment.
6. **Do not weaken the test.** If a test is too hard, the design is not done.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-ACC-001` | Failure test passes. |
| `AC-EXP-ACC-002` | Crash recovery passes. |
| `AC-EXP-ACC-003` | First-contact test passes. |
| `AC-EXP-ACC-004` | Dignity review passes. |
| `AC-EXP-ACC-005` | Stress test passes. |