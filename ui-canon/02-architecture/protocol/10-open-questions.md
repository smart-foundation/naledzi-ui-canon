---
id: ARCH-PROTO-OQ
title: Open Questions
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PROTO-044]
---

# Open Questions

---

## 1. Consolidated list

| ID | Question | Owner | Deadline | Status |
|---|---|---|---|---|
| `OQ-PROTO-001` | Should still number be added to a new StillRecord struct (G-01)? | Architecture Editor | 2026-11-30 | open |
| `OQ-PROTO-002` | Should `custom :Data` damage be removed or typed? | Architecture Editor | 2026-11-30 | open |
| `OQ-PROTO-003` | How is observation scoped across remote peers with version skew? | Architecture Editor | 2026-12-15 | proposed |

---

## 2. Contract gaps

- `G-01`: no still-number field.
- `G-02`: `custom :Data` damage opaque.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PROTO-044` | Every open question has owner and deadline. |

---

## 4. References

See `12-references.md`.