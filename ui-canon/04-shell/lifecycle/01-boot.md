---
id: SHELL-LIFECYCLE-BOOT
title: Lifecycle — Boot
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-010]
---

# Lifecycle — Boot

---

## 1. Boot stages

| Stage | What the user sees | Failure path |
|---|---|---|
| Firmware / bootloader | Vendor splash or nothing | Hardware failure → recovery |
| Kernel load | Minimal progress (bar or spinner) | Kernel panic → recovery |
| Service start | Progress with labels | Service failure → degraded boot with report |
| Shell start | Lock/login screen or session restore | Shell failure → recovery |
| Session restore | Previous surfaces reappear | Restore failure → fresh session + report |

## 2. Rules

- **SHELL-LIFECYCLE-011.** Boot MUST show honest progress; never a fake splash that
  hides a hang.
- **SHELL-LIFECYCLE-012.** If a non-critical service fails, boot continues in
  degraded mode with a visible report (`LAW-011`).
- **SHELL-LIFECYCLE-013.** If a critical service fails, boot stops at an honest
  failure screen with a recovery path, not a black screen.
- **SHELL-LIFECYCLE-014.** Boot time budget is declared per envelope; exceeding it is
  a defect, not a slow machine.
- **SHELL-LIFECYCLE-015.** The boot splash (if any) is the envelope's, not the OS's
  branding; it may be disabled.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-010` | Boot reaches usable state or honest failure. |
| `AC-SHELL-LIFECYCLE-011` | Degraded boot shows a report. |
| `AC-SHELL-LIFECYCLE-012` | Boot time within budget. |