---
id: SHELL-NOTIF-MODEL
title: Notifications — Model
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-INDEX, SHELL-MODEL-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-NOTIF-010]
---

# Notifications — Model

---

## 1. What a notification is

A notification is a **time-sensitive fact** that an origin (app or system service) asks
the OS to deliver to the person's attention. It is not UI that the origin draws; it is a
fact the OS renders through its own delivery system at `system` elevation.

Fields:

| Field | Meaning |
|---|---|
| `origin` | The app or service that produced it |
| `channel` | The user-controllable group it belongs to |
| `priority` | `critical` / `high` / `normal` / `low` / `passive` |
| `title` | Short label |
| `body` | Optional detail |
| `timestamp` | When it was produced |
| `expiry` | When it stops being relevant (optional) |
| `actions` | Inline actions (optional, ≤ 3) |
| `group` | Grouping key for coalescing |
| `origin-device` | Which device produced it (for cross-device) |

## 2. What a notification is not

- Not a persistent place. There is no "notification centre" app; history is a view of
  delivered facts (`04-actions-and-history.md`).
- Not marketing. Notifications that exist to re-engage, upsell or gamify are forbidden
  (`LAW-020`).
- Not a second owner of app state. The notification carries a fact and a link to the
  origin; it does not duplicate the app's content (`LAW-001`).

## 3. Channels

A channel is a **user-controllable group** of notifications from one origin. Rules:

- **SHELL-NOTIF-011.** Every notification MUST belong to a channel.
- **SHELL-NOTIF-012.** Every channel MUST be silencable by the user, including the
  origin's "default" channel. An app may not create an unsilencable channel.
- **SHELL-NOTIF-013.** A channel's importance (interruption level) is set by the user,
  not by the origin. The origin proposes; the user decides.
- **SHELL-NOTIF-014.** Channel settings persist per user and roam if the user opts in.

## 4. Lifecycle

`created` → `queued` (budget/quiet hours) → `delivered` (banner/badge/sound) →
`dismissed` / `acted` / `expired`. A notification that expires undelivered is recorded
as expired, not silently dropped.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-010` | Every notification has origin, channel, priority, timestamp. |
| `AC-SHELL-NOTIF-011` | Every channel is silencable. |
| `AC-SHELL-NOTIF-012` | Expired notifications are recorded, not silently dropped. |