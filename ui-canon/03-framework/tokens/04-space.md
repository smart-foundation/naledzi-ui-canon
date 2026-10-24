---
id: FW-TOKENS-SPACE
title: "Space tokens"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-SPACE-001]
---

# Space tokens

4 px rhythm. All spacing is a multiple of `TOK-SPACE-1` (4 px) unless a density override
applies.

| Token ID | Value | Use |
|---|---|---|
| `TOK-SPACE-0` | 0 | Flush |
| `TOK-SPACE-1` | 4 px | Hairline gap |
| `TOK-SPACE-2` | 8 px | Tight |
| `TOK-SPACE-3` | 12 px | Compact |
| `TOK-SPACE-4` | 16 px | Default |
| `TOK-SPACE-5` | 20 px | Comfortable |
| `TOK-SPACE-6` | 24 px | Spacious |
| `TOK-SPACE-8` | 32 px | Section |
| `TOK-SPACE-10` | 40 px | Large section |
| `TOK-SPACE-12` | 48 px | Page |
| `TOK-SPACE-16` | 64 px | Major section |

Density scales these by mode (compact 0.75, comfortable 1.0, spacious 1.5) but never below
target-size floors.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-SPACE-001` | No spacing literal outside tokens. |
| `AC-FW-TOK-SPACE-002` | Density scaling never drops below target-size floors. |