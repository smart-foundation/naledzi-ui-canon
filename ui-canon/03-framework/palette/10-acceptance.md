---
id: FW-PALETTE-ACC
title: Acceptance
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-010]
---

# Acceptance

---

## 1. Criteria

| ID | Test |
|---|---|
| `AC-FW-PALETTE-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-FW-PALETTE-001` | Every command has a stable ID, label, shortcut (if any), capability requirement and visible path. |
| `AC-FW-PALETTE-002` | The palette opens, searches and dispatches a command on desktop, phone, watch, TV, EV and spatial. |
| `AC-FW-PALETTE-003` | A denied command displays its reason and a request path. |
| `AC-FW-PALETTE-004` | Keyboard-only and screen-reader users can complete a golden flow through the palette. |
| `AC-FW-PALETTE-005` | Idle (closed) palette schedules zero frames over one hour. |
| `AC-FW-PALETTE-006` | First-keystroke-to-first-result meets the budget on the weakest supported envelope. |

## 2. Golden flow

1. User presses Ctrl/Cmd+K.
2. Types "save".
3. Highlights "File: Save changes".
4. Presses Enter.
5. Command runs; palette closes; focus returns.
6. Screen reader announces "Save changes" and the result.
