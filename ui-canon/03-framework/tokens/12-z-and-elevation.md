---
id: FW-TOKENS-Z
title: "Z and elevation tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-DEPTH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-Z-001]
---

# Z and elevation tokens

Elevation levels are semantic and owned by the depth foundation. A component declares a
level, never a number (`FOUND-DEPTH-INDEX` §5).

| Token ID | Level | Meaning |
|---|---|---|
| `TOK-Z-BASE` | E0 | Page plane, canvas |
| `TOK-Z-RAISED` | E1 | Attached panel, card, list row |
| `TOK-Z-FLOATING` | E2 | Popover, tooltip, drag ghost |
| `TOK-Z-OVERLAY` | E3 | Dialog, sheet, palette, menu |
| `TOK-Z-SYSTEM` | E4 | OS-owned: rail, strip, lock, alerts |

No per-component z-index values. Z is derived from declared level + stacking rules.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-Z-001` | No component declares a numeric z-index. |