---
id: FW-TOKENS-RADIUS
title: "Radius tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-RADIUS-001]
---

# Radius tokens

Round or square is a profile choice (Lock 3). Radii are tokens; a theme may set them to
zero for a square profile.

| Token ID | Value | Use |
|---|---|---|
| `TOK-RADIUS-0` | 0 | Square profile / sharp |
| `TOK-RADIUS-XS` | 2 px | Chips, tags |
| `TOK-RADIUS-S` | 4 px | Buttons, inputs |
| `TOK-RADIUS-M` | 8 px | Cards, panels |
| `TOK-RADIUS-L` | 12 px | Sheets, dialogs |
| `TOK-RADIUS-XL` | 16 px | Large surfaces |
| `TOK-RADIUS-FULL` | 9999 px | Pills, avatars |

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-RADIUS-001` | Setting all radii to 0 yields a square profile with no layout change. |