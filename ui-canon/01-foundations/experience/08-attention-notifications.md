---
id: FOUND-EXPERIENCE-ATTENTION
title: Attention and Notifications — Attention Budget, Interruption Contract, Quiet Hours, Safety Overrides
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-ATTENTION]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-ATTN-001, AC-EXP-ATTN-002, AC-EXP-ATTN-003]
---

# Attention and Notifications

> Attention budget, interruption contract, quiet hours, safety overrides.

## 1. Principle

Attention is owned by the person. The system budgets it and never spends it on its own
behalf. Notifications are interruptions with a cost; they are delivered only when the
value exceeds the cost. Quiet hours are mandatory. Safety overrides are the only
exception.

## 2. Attention budget

- Per-person, per-device, per-day limits on non-urgent notifications.
- Non-urgent notifications are queued and batched, not pushed.
- Delivery prefers task breakpoints.
- A notification budget that is exceeded queues, not drops, and surfaces a summary.

## 3. Interruption contract

- Every notification declares its priority: urgent, important, informational.
- Urgent may interrupt; important is queued to the next breakpoint; informational is
  batched.
- A notification that is not actionable is not sent.
- The person can mute any source; the system honours it except for safety overrides.

## 4. Quiet hours

- Default quiet hours are set on first run (e.g., 22:00–07:00 local).
- During quiet hours, only safety overrides interrupt.
- The person can change quiet hours per device.
- Safety overrides (EV, spaceship, critical system) bypass quiet hours.

## 5. Safety overrides

- Safety-critical alarms always interrupt, regardless of quiet hours or budgets.
- They are redundant (visual + audio + haptic) on safety envelopes.
- They are prioritised and accurate; non-actionable alarms are suppressed.

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-ATTN-001` | Non-urgent notifications are queued, not interrupting. |
| `AC-EXP-ATTN-002` | Quiet hours suppress non-safety notifications. |
| `AC-EXP-ATTN-003` | Safety overrides bypass quiet hours and budgets. |