---
id: FOUND-EXPERIENCE-ERROR
title: Error Recovery — Shame, Blame, Loss of Work, Trust Repair; Wording and Interaction Patterns
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-TRUST, UX-EMOTION]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-ERROR-001, AC-EXP-ERROR-002, AC-EXP-ERROR-003]
---

# Error Recovery

> How errors are worded and recovered from without shame, blame or loss of work.

## 1. Principle

Errors are not failures of the person; they are failures of the fit between person and
system. The system names the cause and the recovery, never the person. Work is preserved
wherever possible. Recovery is faster than the error. Trust is repaired by honesty, not
by apology.

## 2. Wording rules

1. **Name the cause.** "The file could not be saved because the disk is full."
2. **Name the recovery.** "Free space, then try again." with a button.
3. **Never blame.** No "you did", "invalid", "illegal", "wrong", "failed to".
4. **Never shame.** No "oops", no exclamation marks, no emoji.
5. **Be specific.** "Network unavailable" not "Something went wrong."
6. **Be honest.** `NOT REPORTED` is valid; "unknown error" with a code is acceptable.
7. **Be calm.** Errors are not emergencies unless they are.

## 3. Interaction patterns

- **Inline validation.** Validate as the person types; show the problem next to the
  field; do not clear the field.
- **Reversible actions.** Undo for destructive actions; confirmation for irreversible.
- **Crash-safe stills.** A crash restores the last committed still; work is not lost
  (`LAW-005`, `LAW-015`).
- **Retry.** Transient failures offer retry with backoff; the person can retry manually.
- **Fallback.** When a capability is denied, show the denied state with a path to
  request it.
- **Escalation.** When recovery fails, escalate to a human or to support, with the
  diagnostic preserved.

## 4. Trust repair

Trust is repaired by:

1. **Acknowledging** what happened (honestly).
2. **Explaining** the cause (specifically).
3. **Offering** recovery (actionably).
4. **Preserving** work (always).
5. **Preventing** recurrence (where possible).

An apology without a fix is not trust repair.

## 5. What is intentionally absent

- Blaming language.
- "Oops" / playful error copy.
- Error screens that require a restart to recover.
- Silent failures.

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-ERROR-001` | No error message in the reference set blames the user. |
| `AC-EXP-ERROR-002` | Every error names cause and recovery. |
| `AC-EXP-ERROR-003` | Crash recovery restores the last committed still without data loss. |