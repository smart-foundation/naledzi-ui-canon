---
id: SHELL-STATUS-ACCEPTANCE
title: Status Rail — Acceptance
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-INDEX]
acceptance: [AC-SHELL-STATUS-000]
---

# Status Rail — Acceptance

---

## 1. Golden flows

### Flow A — Collapse under scarcity (phone, compact density)

1. Rail shows time, privacy, battery, signal, notifications.
2. Available width drops (rotation to portrait narrow).
3. Signal collapses first, then notifications count, then date.
4. Time, privacy, battery remain.
5. Collapse announced; focus preserved.
6. Restore width: indicators return in priority order with spring motion.

### Flow B — Safety override (EV)

1. Rail shows speed, range, time.
2. A safety warning appears.
3. Warning occupies protected zone; speed/range/time remain but do not occlude it.
4. Warning never collapses even at minimum width.
5. Warning dismisses only when the safety condition clears.

### Flow C — Missing fact

1. Battery fact owner unavailable.
2. Battery indicator shows `NOT REPORTED`.
3. No fabricated percentage appears.
4. When owner returns, indicator updates without a flash.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-STATUS-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-STATUS-001` | Priority table per envelope | Unit test of collapse order |
| `AC-SHELL-STATUS-002` | Safety never truncated | Safety reference flow frames |
| `AC-SHELL-STATUS-003` | Hidden rail costs zero | Idle measurement over 1 h |
| `AC-SHELL-STATUS-004` | Collapse announced + focus preserved | A11y transcript |
| `AC-SHELL-STATUS-005` | `NOT REPORTED` for missing facts | Missing-owner test |
| `AC-SHELL-STATUS-006` | Passes at 200% text + high contrast | Visual + a11y audit |