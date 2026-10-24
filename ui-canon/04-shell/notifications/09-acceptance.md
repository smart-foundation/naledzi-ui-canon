---
id: SHELL-NOTIF-ACCEPTANCE
title: Notifications — Acceptance
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-INDEX]
acceptance: [AC-SHELL-NOTIF-000]
---

# Notifications — Acceptance

---

## 1. Golden flows

### Flow A — Deliver, act, dismiss

1. App posts a `normal` notification on channel "mail".
2. Banner appears at top; sound plays (if allowed).
3. User taps "Archive" inline action.
4. App archives; banner dismisses; history records acted.
5. Status rail badge clears.

### Flow B — Quiet hours

1. Quiet hours active (22:00–07:00).
2. App posts `normal` notification.
3. No banner, no sound; queued.
4. At 07:00, summary delivered: "5 notifications overnight".
5. User opens history; all listed.

### Flow C — Cross-device single ring

1. Phone and watch paired.
2. Message arrives.
3. Only phone rings (user active on phone); watch badges.
4. User dismisses on phone; watch clears badge.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-NOTIF-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-NOTIF-001` | Every notification has a silencable channel | Unit test |
| `AC-SHELL-NOTIF-002` | Quiet hours suppress non-critical | Flow B |
| `AC-SHELL-NOTIF-003` | Cross-device single ring | Flow C |
| `AC-SHELL-NOTIF-004` | No silent drops | Failure tests |
| `AC-SHELL-NOTIF-005` | Alarm fatigue coalescing | Repeated-notification test |