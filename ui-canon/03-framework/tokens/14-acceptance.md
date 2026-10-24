---
id: FW-TOKENS-ACCEPTANCE
title: "Tokens acceptance"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-ACCEPT-001]
---

# Tokens acceptance

| ID | Requirement | Evidence |
|---|---|---|
| `AC-FW-TOK-ACCEPT-001` | All token ACs in this subtree pass. | Test suite. |
| `AC-FW-TOK-ACCEPT-002` | No raw visual value outside `tokens/` (grep audit). | CI grep. |
| `AC-FW-TOK-ACCEPT-003` | Every token has type, default and resolution path. | Audit. |
| `AC-FW-TOK-ACCEPT-004` | Every component references only semantic tokens. | Audit. |