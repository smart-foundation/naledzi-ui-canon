---
id: FW-TOKENS-ICON
title: "Icon tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-ICONOGRAPHY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-ICON-001]
---

# Icon tokens

Solar icons are the base language; Naledzi glyphs cover OS-specific concepts. Icons are
semantic names, never file paths (master brief §2).

| Token ID | Value | Use |
|---|---|---|
| `TOK-ICON-SIZE-XS` | 12 px | Inline, dense |
| `TOK-ICON-SIZE-S` | 16 px | Default small |
| `TOK-ICON-SIZE-M` | 20 px | Default |
| `TOK-ICON-SIZE-L` | 24 px | Toolbar, nav |
| `TOK-ICON-SIZE-XL` | 32 px | Empty state, hero |
| `TOK-ICON-WEIGHT` | role-based | Solar weights by context |
| `TOK-ICON-COLOR` | inherits semantic colour token | Icons use colour roles |

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-ICON-001` | No icon references a file path; all use semantic names. |