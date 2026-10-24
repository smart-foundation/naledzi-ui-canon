---
id: SHELL-NOTIF-A11Y
title: Notifications — Accessibility
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-DELIVERY, CANON-LAWS]
acceptance: [AC-SHELL-NOTIF-070]
---

# Notifications — Accessibility

---

## 1. Semantics

- A banner is an `alert` (assertive for `critical`) or `status` (polite otherwise) live
  region.
- History entries are a list with roles; each entry announces origin, channel, time,
  title, body.
- Inline actions are buttons with accessible names.

## 2. Announcements

| Event | Announcement |
|---|---|
| Banner appears | Title + body (polite/assertive by priority) |
| Coalesced banner | "3 new messages" |
| Dismissed | "Dismissed" |
| Snoozed | "Snoozed until 09:00" |
| History cleared | "Notification history cleared" |

## 3. Adaptation

- **Reduced motion:** banner appears/disappears instantly; state change announced.
- **High contrast:** banner border + icon shape; not colour alone.
- **200% text:** banner grows; actions wrap; never truncate the title.
- **Screen reader:** full transcript of history entries available; banner actions
  reachable.
- **Quiet hours respected by assistive tech:** non-critical banners are not announced
  during quiet hours.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-070` | Banners are live regions with correct politeness. |
| `AC-SHELL-NOTIF-071` | History is fully readable by screen reader. |
| `AC-SHELL-NOTIF-072` | Passes at 200% text and high contrast. |