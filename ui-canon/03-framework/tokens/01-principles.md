---
id: FW-TOKENS-PRINCIPLES
title: "Token principles: only legal visual values; semantic vs primitive; versioning"
kind: framework
entity: tokens
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-TOKENS-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TOK-PRINC-001]
---

# Token principles

---

## 1. Tokens are the only legal visual values

- FW-TOK-P-001. Every colour, spacing, radius, elevation, duration, font size, icon size,
  shadow recipe and material quality MUST resolve through a token. No literal in component
  or app behaviour (FW-LAW-006, AC-FW-003).
- FW-TOK-P-002. A component that cannot state which token drives a visual property is not
  finished.
- FW-TOK-P-003. Tokens are referenced by ID in code and in the corpus.

## 2. Semantic vs primitive

- **Primitive tokens** name a raw value (e.g. a specific OKLCH colour, a 4 px step).
  They are the palette of the system and are never referenced by components directly.
- **Semantic tokens** name a role (e.g. `surface`, `on-surface`, `accent`). Components
  reference semantic tokens only.
- FW-TOK-P-004. A component MUST NOT reference a primitive token. Primitives are composed
  into semantics by the theme.
- FW-TOK-P-005. Semantic tokens are stable across themes; primitives may change per theme.

## 3. Versioning

- FW-TOK-P-006. Tokens are versioned with the framework. Renames are breaking and need a
  migration note.
- FW-TOK-P-007. Deprecation: a token stays resolvable for one major version, then removed.
- FW-TOK-P-008. Additive only for minor versions (LAW-014).
- FW-TOK-P-009. A token's type, default and resolution path are part of its contract.

## 4. Aliases and groups

- FW-TOK-P-010. Aliases (design-tokens format) are allowed for convenience; the canonical
  name is the ID.
- FW-TOK-P-011. Groups organise tokens by domain; a token belongs to exactly one group.

## 5. Honesty

- FW-TOK-P-012. A missing token value renders `NOT REPORTED` with a reason; never a
  plausible default (FW-LAW-008).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TOK-PRINC-001` | Grep audit finds no hex colour or numeric visual literal outside `tokens/`. |
| `AC-FW-TOK-PRINC-002` | Every semantic token resolves to a primitive in every theme. |