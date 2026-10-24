---
id: SHELL-STATUS-FAILURE
title: Status Rail — Failure
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-STATUS-070]
---

# Status Rail — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Fact owner unavailable | Indicator shows `NOT REPORTED` with that label; rail remains usable |
| Fact stale (older than declared freshness) | Indicator shows stale marker (age) and `NOT REPORTED` if beyond threshold |
| Sensor denied | Indicator hidden or shown as denied with a settings path; never faked |
| Overflow (indicators do not fit even after collapse) | Rail grows to a second row on envelopes that allow it; otherwise record layout defect and keep safety only |
| Policy crash | Rail commits its last known indicator set; policy restarts and re-derives |
| Authority restart | Rail re-commits from facts; no indicator is lost |
| Clock unavailable | Time indicator shows `NOT REPORTED`; do not fabricate |

## 2. Rules

- **SHELL-STATUS-071.** The rail MUST never fabricate a value. A missing fact is
  `NOT REPORTED` (`LAW-011`).
- **SHELL-STATUS-072.** The rail MUST never truncate a safety indicator. Overflow with
  safety present is a layout defect to be recorded, not a silent truncation.
- **SHELL-STATUS-073.** A denied sensor MUST produce a visible state with a path to
  request it, not a silent absence.
- **SHELL-STATUS-074.** Recovery from policy crash MUST be silent to the user except
  for a logged event; the rail must not flash.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-070` | Every failure mode in §1 is exercised in a test. |
| `AC-SHELL-STATUS-071` | No fabricated value appears for any missing fact. |
| `AC-SHELL-STATUS-072` | Safety indicators never truncate under overflow. |