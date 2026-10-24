---
id: ARCH-REND-OQ
title: Open Questions
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-REND-044]
---

# Open Questions

---

## 1. Consolidated list

| ID | Question | Owner | Deadline | Status |
|---|---|---|---|---|
| `OQ-REND-001` | What is the minimum frame rate floor per envelope? | Architecture Editor | 2026-11-30 | proposed |
| `OQ-REND-002` | Does CPU path need a separate budget or share the envelope budget? | Architecture Editor | 2026-11-30 | proposed |
| `OQ-REND-003` | Should plane fallback to GPU be automatic or policy-declared? | Architecture Editor | 2026-12-01 | proposed |
| `OQ-REND-004` | How is modifier negotiation versioned across driver updates? | Architecture Editor | 2026-12-15 | open |

---

## 2. Contract gaps

- `G-03`: `custom :Data` damage is opaque; unauditable.
- `G-04`: no schema field for copy reason in still history.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-REND-044` | Every open question has owner and deadline. |

---

## 4. References

See `13-references.md`.