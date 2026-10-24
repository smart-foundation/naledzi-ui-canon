---
id: ARCH-PROTO-ERRORS
title: Error Model
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-ERR-001, AC-PROTO-ERR-002]
---

# Error Model

> Named rejections, no silent failure. Every failure is a typed, named value
> with the failed invariant and the culprit.

---

## 1. Principles

- No silent drops: every request produces either success or a named error.
- Errors are typed (`T.Error`, `T.VoidResult`) and carry the failed invariant.
- Errors are not strings to be parsed; they are enum/struct variants.
- `NOT REPORTED` is a valid value for unknown hardware facts
  (`display.capnp:267-376`).

---

## 2. Rejection pattern

`AtomicRejection` (`framebuffer.capnp:248-266`): `target :AtomicTargetKind`,
`targetId :UInt64` (legacy), `reason :T.Error`, `typedId :AtomicTargetId`.
The presentation layer generalizes this to commit rejections
(`presentation/07-rejections.md`).

---

## 3. Absence vs error

Absence is a value, not an error. A missing panel, unknown refresh, or absent
policy is a declared absence with a validity flag, never a zero or a default
(`01-model.md` INV-4). An error is a failure to perform a requested
operation.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-ERR-001` | Every request returns success or a named, typed error. |
| `AC-PROTO-ERR-002` | No silent failure in any path. |
| `AC-PROTO-ERR-003` | Absence is distinguished from error in all schemas. |

---

## 5. Open questions

See `10-open-questions.md`.

---

## 6. References

See `12-references.md`.