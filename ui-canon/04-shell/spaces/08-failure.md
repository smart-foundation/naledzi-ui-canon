---
id: SHELL-SPACES-FAILURE
title: Spaces — Failure
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-SPACES-080]
---

# Spaces — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Corrupt space state | Restore from last good backup; if none, recreate default space and report |
| Too many spaces | Cap (default 16) with search-first beyond; new space requires closing one |
| Surface unavailable | Honest placeholder with install/open path |
| Sync conflict | Last-writer-wins with visible merge note; revert available |
| Crash mid-transition | Restore last committed space |
| Name collision | Suffix appended; user notified |

## 2. Rules

- **SHELL-SPACES-081.** A corrupt space is never silently replaced without a report.
- **SHELL-SPACES-082.** Cap is declared and enforced with a clear message, not a crash.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-080` | Every failure mode exercised. |