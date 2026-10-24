---
id: SHELL-NOTIF-PRIORITY
title: Notifications — Priority and Channels
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-NOTIF-020]
---

# Notifications — Priority and Channels

---

## 1. Priority levels

| Level | Interruption | Examples | Budget |
|---|---|---|---|
| `critical` | Interrupts immediately, even in quiet hours (safety, alarms, calls) | EV warning, alarm, incoming call | uncapped but rare |
| `high` | Interrupts unless in quiet hours / focus mode | messages from people, calendar imminent | capped per hour |
| `normal` | Banner + sound if allowed; no interruption of focus | mail, app updates | capped per hour |
| `low` | Badge + history only | social, news | never interrupts |
| `passive` | History only, no badge | background sync complete | never interrupts |

## 2. Rules

- **SHELL-NOTIF-021.** Priority is proposed by the origin and **decided by the user's
  channel settings**. An origin may not force `critical` (`LAW-020`).
- **SHELL-NOTIF-022.** `critical` is reserved for safety and direct human contact. An
  app that misuses `critical` has its channel downgraded by the system and is flagged.
- **SHELL-NOTIF-023.** Budgets cap interruptions per hour (default 5 high/normal
  interruptions; configurable). Excess is queued for the next quiet window or batched.
- **SHELL-NOTIF-024.** Alarm fatigue is a design failure. Repeated identical
  notifications are coalesced; repeated low-value notifications cause the channel to be
  suggested for silencing (Cvach, 2012, alarm fatigue in clinical settings).

## 3. Channels

- A channel has: name, description, origin, importance (user-set), sound, vibration,
  visual, lock-screen visibility, cross-device sync toggle.
- The OS provides default channels: `system`, `safety`, `calls`, `messages`, `mail`,
  `calendar`, `app` (per app). Apps may add channels; the OS may merge duplicates.
- Channel settings are searchable in Settings and in the notification history.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-020` | Priority is user-decided per channel. |
| `AC-SHELL-NOTIF-021` | Budget caps interruptions; excess is queued. |
| `AC-SHELL-NOTIF-022` | Misuse of `critical` is downgraded and flagged. |
| `AC-SHELL-NOTIF-023` | Identical notifications are coalesced. |