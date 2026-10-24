---
id: FW-TOKENS-TYPOGRAPHY
title: "Typography tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, FOUND-TYPOGRAPHY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-TYPE-001]
---

# Typography tokens

---

## 1. Principles

- Type is a token; families are named by role until licensed (FW-Q-001).
- Scale is modular and reflows at 200% text.
- Tabular numerals for columns; proportional for prose.

## 2. Token table

| Token ID | Role | Size basis | Weight | Line height | Use |
|---|---|---|---|---|---|
| `TOK-TYPE-DISPLAY-L` | Display large | base × 3.0 | bold | 1.1 | Hero, splash |
| `TOK-TYPE-DISPLAY-M` | Display medium | base × 2.4 | bold | 1.1 | Section hero |
| `TOK-TYPE-HEADLINE-L` | Headline large | base × 2.0 | semibold | 1.2 | Page title |
| `TOK-TYPE-HEADLINE-M` | Headline medium | base × 1.6 | semibold | 1.2 | Section title |
| `TOK-TYPE-TITLE-L` | Title large | base × 1.33 | medium | 1.3 | Card/panel title |
| `TOK-TYPE-TITLE-M` | Title medium | base × 1.17 | medium | 1.3 | List header |
| `TOK-TYPE-TITLE-S` | Title small | base × 1.0 | medium | 1.3 | Subsection |
| `TOK-TYPE-BODY-L` | Body large | base × 1.17 | regular | 1.5 | Long-form |
| `TOK-TYPE-BODY-M` | Body medium | base × 1.0 | regular | 1.5 | Default body |
| `TOK-TYPE-BODY-S` | Body small | base × 0.83 | regular | 1.4 | Secondary |
| `TOK-TYPE-LABEL-L` | Label large | base × 1.0 | medium | 1.3 | Button, tab |
| `TOK-TYPE-LABEL-M` | Label medium | base × 0.83 | medium | 1.3 | Form label |
| `TOK-TYPE-LABEL-S` | Label small | base × 0.75 | medium | 1.3 | Caption |
| `TOK-TYPE-CODE` | Monospace | base × 0.92 | regular | 1.4 | Terminal, code |
| `TOK-TYPE-NUMERAL-TABULAR` | Tabular numerals | inherited | inherited | inherited | Columns, counters |

## 3. Font family roles

| Token ID | Role | Fallback chain |
|---|---|---|
| `TOK-FONT-UI` | UI sans | system sans -> Noto Sans -> sans-serif |
| `TOK-FONT-READING` | Reading serif | system serif -> Noto Serif -> serif |
| `TOK-FONT-CODE` | Monospace | system mono -> Noto Sans Mono -> monospace |
| `TOK-FONT-EMOJI` | Emoji | system emoji -> Noto Color Emoji |

## 4. Variable font axes

`TOK-FONT-AXIS-WEIGHT`, `TOK-FONT-AXIS-WIDTH`, `TOK-FONT-AXIS-OPSZ` resolve through tokens;
values are not hardcoded.

## 5. Letter/word spacing and features

`TOK-TYPE-TRACKING-TIGHT`, `TOK-TYPE-TRACKING-NORMAL`, `TOK-TYPE-TRACKING-LOOSE`;
`TOK-TYPE-FEATURE-LIGA`, `TOK-TYPE-FEATURE-KERN`.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-TYPE-001` | All type tokens reflow at 200% text without clipping. |
| `AC-FW-TOK-TYPE-002` | Font fallback chain renders missing glyphs visibly. |