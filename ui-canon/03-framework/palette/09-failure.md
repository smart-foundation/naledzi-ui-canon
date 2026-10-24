---
id: FW-PALETTE-FAIL
title: Failure
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-009]
---

# Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Registry empty | Palette shows "No commands registered" + link to help. |
| Command handler panics/errors | Palette closes, error toast with command id and safe detail; command marked failed in recents. |
| Capability denied | Command shown disabled with reason and request path; dispatch blocked. |
| Search throws | Fall back to last good result set; announce "search unavailable". |
| Voice recognition fails | Show transcript input; allow typing. |
| Remote disconnect | Palette shows connection state; commands requiring remote are disabled with reason. |

## 2. Rules

- `FW-PALETTE-FAIL-001`: The palette never reports success for a command that failed.
- `FW-PALETTE-FAIL-002`: A failed command does not corrupt recents or registry state.
- `FW-PALETTE-FAIL-003`: The palette is dismissible even when its content failed to load.
