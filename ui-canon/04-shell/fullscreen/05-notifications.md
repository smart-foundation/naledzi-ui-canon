---
id: SHELL-FULLSCREEN-NOTIF
title: Fullscreen Notifications
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-NOTIFICATIONS-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-050, AC-SHELL-FULLSCREEN-051]
---

# Fullscreen Notifications

> What notifications appear in fullscreen, at what priority, with safety override and
> do-not-disturb.

---

## 1. What appears

| Priority | Immersive | Maximised | Presentation | Safety-fullscreen |
|---|---|---|---|---|
| Safety | banner (always) | banner | banner (always) | banner |
| Critical | toast/banner | normal | per declaration (safety always) | safety only |
| Time-sensitive | queued, shown on exit/summon | normal | per declaration | queued |
| Normal | queued | normal | per declaration | queued |
| Ambient | queued | normal | per declaration | queued |

Safety and critical notifications always carry their action (dismiss, acknowledge) and are
never silently queued.

---

## 2. Queuing

- Queued notifications are held in the notification history and shown when fullscreen
  exits or when the user summons the notification surface.
- Queued notifications do not expire while queued unless their expiry time passes; expired
  ones are dropped and recorded in history as expired.
- A queued safety notification that expires is a defect in the source; the shell records it.

---

## 3. Safety override

Safety notifications override do-not-disturb, quiet hours and focus modes. A safety
notification appears even in immersive and even in do-not-disturb. The user cannot disable
safety notifications; they can only acknowledge them.

---

## 4. Do-not-disturb

- Do-not-disturb suppresses non-safety, non-critical notifications (banners/toasts) but
  keeps them in history.
- In fullscreen immersive, do-not-disturb is effectively already active for normal/ambient;
  the user may additionally enable it to suppress critical.
- Safety cannot be suppressed.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-050` | Safety notifications appear in immersive; normal/ambient are queued. |
| `AC-SHELL-FULLSCREEN-051` | Queued notifications appear on exit or on summon. |
| `AC-SHELL-FULLSCREEN-052` | Safety overrides do-not-disturb and quiet hours. |
| `AC-SHELL-FULLSCREEN-053` | Expired queued notifications are recorded in history. |