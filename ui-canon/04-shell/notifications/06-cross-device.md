---
id: SHELL-NOTIF-CROSSDEV
title: Notifications — Cross-Device
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-MODEL, ARCH-ECOSYSTEM-INDEX]
acceptance: [AC-SHELL-NOTIF-060]
---

# Notifications — Cross-Device

---

## 1. Principles

- A notification produced on one device may be delivered to others, but **only one
  device rings** (`LAW-017`, local first).
- The device the person is actively using is preferred; otherwise the originating
  device.
- Dismissal on one device dismisses on all (with a short reconciliation window).
- Acting on one device prevents the duplicate action elsewhere.

## 2. Dedup

- Notifications are deduplicated by `(origin, group, timestamp)` across devices.
- A notification already acknowledged on one device is not re-delivered on another.
- Reconnection reconciles unknown states rather than blindly replaying
  (`ADR-0019`).

## 3. Per-device rules

- Watch: only `high` and `critical` may interrupt; others badge.
- Phone: full delivery.
- Desktop: banners only when the device is in use; otherwise badge + history.
- TV: no banners during playback; badge on the home rail.
- EV: only `critical` (safety) interrupts while driving.
- Spaceship: procedure-list entries only.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-060` | Only one device rings for a cross-device notification. |
| `AC-SHELL-NOTIF-061` | Dismissal syncs across devices within 5 s. |
| `AC-SHELL-NOTIF-062` | Reconnection reconciles without duplicate delivery. |