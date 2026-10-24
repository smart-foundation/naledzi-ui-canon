---
id: SHELL-NOTIF-ACTIONS
title: Notifications — Actions and History
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-DELIVERY, SHELL-NOTIF-MODEL]
acceptance: [AC-SHELL-NOTIF-040]
---

# Notifications — Actions and History

---

## 1. Inline actions

- A notification may carry up to 3 inline actions (e.g. Reply, Archive, Snooze).
- Actions are verbs from the app's command registry (`shortcuts/`); they invoke the same
  command IDs, so voice and keyboard work too.
- Destructive actions require confirmation, even from a notification.
- Actions execute in the origin app's context; if the app is closed, it is launched to
  the relevant state.

## 2. History

- Every delivered notification is recorded in history (local, per user).
- History is a view of facts, not a separate place: it is reachable from the control
  centre and from Settings.
- History supports: search, filter by origin/channel, clear (with confirmation), export.
- A cleared history does not delete the origin's data; it only removes the delivery
  record.

## 3. Dismissal and grouping

- Dismiss one: removes the banner and marks the fact acknowledged.
- Dismiss all from an origin: marks all that origin's pending facts acknowledged.
- Grouping: notifications with the same `group` key collapse; expanding shows members.
- A dismissed group can be undone for 5 s (snackbar).

## 4. Snooze

- A notification may be snoozed for a user-chosen duration (5 min, 15 min, 1 h, until
  tomorrow morning).
- Snoozed notifications re-deliver at the chosen time, respecting quiet hours.
- Snooze is per notification, not per channel.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-040` | Inline actions invoke the same command IDs as the palette. |
| `AC-SHELL-NOTIF-041` | Destructive notification actions require confirmation. |
| `AC-SHELL-NOTIF-042` | History is searchable and clearable with confirmation. |
| `AC-SHELL-NOTIF-043` | Snooze re-delivers at the chosen time. |