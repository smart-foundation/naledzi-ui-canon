---
id: SHELL-NOTIF-QUIET
title: Notifications — Quiet Hours and Attention
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-PRIORITY, CANON-LAWS]
acceptance: [AC-SHELL-NOTIF-050]
---

# Notifications — Quiet Hours and Attention

---

## 1. Quiet hours

- User-defined time window (default 22:00–07:00) during which only `critical`
  notifications interrupt.
- Quiet hours are per device by default, with an option to sync across devices.
- During quiet hours, non-critical notifications are queued and delivered at the end of
  the window as a single summary, or held in history.
- `critical` (safety, alarms, calls from favourites) still interrupts.

## 2. Focus modes

- Named focus modes (Work, Sleep, Driving, Custom) suppress notification channels by
  rule.
- A focus mode may allow specific people or apps through.
- Focus modes are triggered manually, by schedule, or by context (driving, meeting).
- The status rail shows the active focus mode (`focus-mode` indicator).

## 3. Attention budgets

- Per-hour interruption cap (default 5) for `high`/`normal` (`LAW-020`).
- Excess is queued; the person is told "3 notifications held" with a review path.
- Budgets reset each hour; unused budget does not carry over (to prevent catch-up
  floods).

## 4. Alarm fatigue

- Repeated identical notifications are coalesced into one with a count.
- A channel that fires more than N times in an hour without acknowledgement is
  suggested for silencing or downgrade.
- The system never rewards engagement with more notifications.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-050` | Quiet hours suppress non-critical delivery. |
| `AC-SHELL-NOTIF-051` | Focus mode suppresses by channel rule. |
| `AC-SHELL-NOTIF-052` | Budget caps interruptions; excess is queued and reported. |
| `AC-SHELL-NOTIF-053` | Repeated notifications coalesce. |