---
id: FW-TOKENS-BREAKPOINTS
title: "Breakpoints and sizes"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-TYPOGRAPHY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-BP-001]
---

# Breakpoints and sizes

Space classes drive composition; breakpoints are inputs, not device names.

| Token ID | Width | Class |
|---|---|---|
| `TOK-BP-WATCH` | ≤ 240 px | glance |
| `TOK-BP-PHONE` | 241–480 px | compact |
| `TOK-BP-PHABLET` | 481–720 px | medium |
| `TOK-BP-TABLET` | 721–1024 px | expanded |
| `TOK-BP-DESKTOP` | 1025–1600 px | wide |
| `TOK-BP-WIDE` | > 1600 px | extra-wide |
| `TOK-BP-TV` | 10 ft viewing | lean-back |

Target sizes: `TOK-TARGET-MIN` (24×24 CSS px minimum, WCAG 2.2 SC 2.5.8), `TOK-TARGET-COMFORTABLE` (44×44).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-BP-001` | Breakpoints are not device names; composition adapts by space class. |