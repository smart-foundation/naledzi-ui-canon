---
id: SHELL-GESTURES-CONFLICT
title: Gestures — Conflict and Arbitration
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-SYSTEM, SHELL-MODEL-INDEX]
acceptance: [AC-SHELL-GESTURES-030]
---

# Gestures — Conflict and Arbitration

---

## 1. Conflict rules

| Conflict | Winner | Reason |
|---|---|---|
| App requests a system-reserved gesture at the edge | System | Edges belong to the OS |
| App requests the same gesture inside content | App | Content is the app's domain |
| Two apps request the same gesture | Policy arbitrates by focus | Focused app wins |
| System gesture vs accessibility shortcut | Accessibility | A11y is a safety property |
| Gesture vs capture lease | Lease holder | Lease is explicit scope |

## 2. Rules

- **SHELL-GESTURES-031.** Conflicts are resolved by the policy, not by an app "winning"
  a race (`APP-INPUT` §5).
- **SHELL-GESTURES-032.** An app that loses a conflict receives a notification
  (callback) so it can fall back to a visible alternative.
- **SHELL-GESTURES-033.** Arbitration decisions are deterministic given the same input
  and state.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-030` | Conflicts resolve deterministically per the table. |
| `AC-SHELL-GESTURES-031` | Losing app receives a fallback callback. |