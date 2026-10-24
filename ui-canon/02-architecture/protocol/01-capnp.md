---
id: ARCH-PROTO-CAPNP
title: Cap'n Proto as Contract
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-CAPNP-001, AC-PROTO-CAPNP-002]
---

# Cap'n Proto as Contract

> The schema is the contract. Ordinals are stable. Evolution is additive.
> Canonicalisation is deterministic. Implementations are disposable.

---

## 1. Schema as contract

The contract is the Cap'n Proto schema in `protocol/schemas/*.capnp`. It defines
every wire fact. Implementations (processes, drivers, services) speak the
contract; they are disposable. The contract is durable; implementations are
not. This is the foundation of timelessness (`LAW-014`).

---

## 2. Ordinals

Every field has a stable ordinal (`@0`, `@1`, ...). New fields use new
ordinals; old readers ignore unknown ordinals. This is how the protocol stays
timeless: an old implementation keeps working when new fields are added, and a
new implementation keeps working against an old peer (with defaults).

---

## 3. Evolution

Evolution rules:

- Add fields with new ordinals; never reuse an ordinal.
- New fields MUST have defaults or be optional.
- Never remove a field; mark it deprecated in a comment and leave the ordinal.
- Never change a field's type incompatibly; add a new field instead.
- Enums gain variants at the end (with `other`/`custom` for forward compat).
- Unions gain arms with new ordinals.

These rules are already followed in the schemas (audit notes in headers).

---

## 4. Canonicalisation

Canonicalisation means two implementations produce byte-identical wire output
for the same logical fact. This matters for hashing, signatures, and
reproducibility. Cap'n Proto's packed encoding and deterministic field order
support this. Implementations MUST NOT add implementation-specific padding or
ordering.

---

## 5. Compatibility

An old reader facing a new message ignores unknown ordinals and uses defaults
for missing fields. A new reader facing an old message uses defaults. This is
the compatibility guarantee that lets devices of different ages interoperate
(`ecosystem/11-failure.md` version skew).

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-CAPNP-001` | An old reader reads a new message without error. |
| `AC-PROTO-CAPNP-002` | A new reader reads an old message using defaults. |
| `AC-PROTO-CAPNP-003` | Two implementations produce identical wire bytes for the same fact. |

---

## 7. Open questions

See `10-open-questions.md`.

---

## 8. References

- Cap'n Proto documentation. https://capnproto.org/ — accessed 23 October 2026.