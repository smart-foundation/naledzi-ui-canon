---
id: SHELL-NOTIF-INDEX
title: Notifications
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-NOTIF-000]
children:
  - 01-model.md
  - 02-priority-and-channels.md
  - 03-delivery-and-presentation.md
  - 04-actions-and-history.md
  - 05-quiet-hours-and-attention.md
  - 06-cross-device.md
  - 07-accessibility.md
  - 08-failure.md
  - 09-acceptance.md
---

# Notifications

> Notifications are **time-sensitive facts delivered to attention**. Attention is a finite
> resource (`LAW-020`). The OS budgets, prioritises, batches and silences them. A
> notification is not a place; it is a delivery.

**Scope:** model, priority and channels, delivery and presentation, actions and history,
quiet hours and attention, cross-device sync, accessibility, failure, acceptance.

**Non-goals:** notification centre as a separate place (folded into delivery +
history); app internals (`05-apps/`); marketing or engagement notifications (forbidden).

---

## 1. The single question this branch answers

> When something needs the person's attention, how does the OS tell them without stealing
> it?

---

## 2. The model in one page

```text
    PRODUCER (app, system service)  ── notification commit ──►  NOTIFICATION SERVICE
                                                                  │
                                                                  ▼
    CHANNELS (named, user-controllable)  ──►  PRIORITY + BUDGET  ──►  DELIVERY
                                                                  │
                                                                  ▼
    PRESENTATION (banner / badge / sound / haptic / history)  ──►  ATTENTION
```

- A notification is a fact with a priority, a channel, an origin and an expiry.
- Channels are user-controllable groups; an app may not create a channel that cannot be
  silenced.
- Priority determines interruption: `critical` may interrupt; `passive` never does.
- Budgets cap how many notifications may interrupt per hour (`LAW-020`).

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What a notification is; channels; origins; expiry |
| [02-priority-and-channels.md](02-priority-and-channels.md) | Priority levels; channels; user control |
| [03-delivery-and-presentation.md](03-delivery-and-presentation.md) | Banner, badge, sound, haptic, grouping, coalescing |
| [04-actions-and-history.md](04-actions-and-history.md) | Inline actions; history; dismissal; grouping |
| [05-quiet-hours-and-attention.md](05-quiet-hours-and-attention.md) | Quiet hours; focus modes; budgets; alarm fatigue |
| [06-cross-device.md](06-cross-device.md) | Sync; dedup; which device rings |
| [07-accessibility.md](07-accessibility.md) | Screen reader; reduced motion; high contrast |
| [08-failure.md](08-failure.md) | Dropped, expired, denied, duplicate |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-NOTIF-001` | Every notification has a channel the user can silence. |
| `AC-SHELL-NOTIF-002` | Budget and quiet hours are honoured. |
| `AC-SHELL-NOTIF-003` | Cross-device dedup prevents duplicate rings. |