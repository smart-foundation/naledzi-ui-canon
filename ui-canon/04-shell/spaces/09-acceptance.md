---
id: SHELL-SPACES-ACCEPTANCE
title: Spaces — Acceptance
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-INDEX]
acceptance: [AC-SHELL-SPACES-000]
---

# Spaces — Acceptance

---

## 1. Golden flows

### Flow A — Create and switch

1. User creates "Work" space from fan-out.
2. Opens mail + calendar in it.
3. Switches to default space; mail/calendar remain in Work.
4. Switches back; focus and scroll restored.

### Flow B — Restore after restart

1. Three spaces exist; active is "Work".
2. Restart.
3. All three restored; "Work" active; surfaces restored or honest placeholders.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-SPACES-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-SPACES-001` | Space addressable + restorable | Flow B |
| `AC-SHELL-SPACES-002` | Transition preserves velocity + focus | Flow A |
| `AC-SHELL-SPACES-003` | Crash recovery | Failure tests |
| `AC-SHELL-SPACES-004` | Protected spaces enforced | Safety tests |