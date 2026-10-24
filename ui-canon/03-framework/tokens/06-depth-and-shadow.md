---
id: FW-TOKENS-DEPTH
title: "Depth and shadow tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-DEPTH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-DEPTH-001]
---

# Depth and shadow tokens

Elevation levels E0–E4 (`FOUND-DEPTH-INDEX` §2). Shadow recipes per level; elevation is
semantic, not decorative (LAW-007).

| Token ID | Level | Shadow recipe | Use |
|---|---|---|---|
| `TOK-DEPTH-E0` | base | none | Page plane, canvas |
| `TOK-DEPTH-E1` | raised | contact shadow + tonal separation | Cards, list rows, panels |
| `TOK-DEPTH-E2` | floating | shadow + offset | Popovers, tooltips, drag ghost |
| `TOK-DEPTH-E3` | overlay | scrim 32% + shadow | Dialogs, sheets, palette, menus |
| `TOK-DEPTH-E4` | system | scrim 48–60% | Alerts, permission prompts, safety warnings |

Shadow components: `TOK-SHADOW-BLUR-E1`, `TOK-SHADOW-OFFSET-E2`, `TOK-SCRIM-E3`,
`TOK-SCRIM-E4`. Parallax bounds: `TOK-PARALLAX-MAX` (bounded, disabled under reduced
motion).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-DEPTH-001` | Removing all shadows leaves elevation order readable from position/overlap/contrast/scale. |