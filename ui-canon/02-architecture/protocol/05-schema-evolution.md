---
id: ARCH-PROTO-EVOLUTION
title: Schema Evolution
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX, ARCH-PROTO-CAPNP]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-EVO-001, AC-PROTO-EVO-002]
---

# Schema Evolution

> New ordinals, defaults, compatibility, deprecation. The protocol evolves
> without breaking old peers.

---

## 1. Rules

- New fields use new ordinals; old readers ignore them.
- Old fields are deprecated, never deleted; their ordinal is retired.
- New fields MUST have defaults or be optional.
- Enums gain variants at the end with `other`/`custom` for forward compat.
- Unions gain arms with new ordinals.
- Incompatible type changes are forbidden; add a new field instead.

---

## 2. Defaults

A missing field resolves to its declared default. Defaults are part of the
contract and must be documented. "Unset" is a valid value with meaning
(`display.capnp:267-376` honesty rule).

---

## 3. Deprecation

Deprecated fields remain on the wire for compatibility. They are marked
deprecated in comments and may be ignored by new readers. Removal requires a
contract change ADR and a migration window.

---

## 4. Version negotiation

Handshake (`compositor.capnp:46-62`) negotiates `protocolVersion`. A peer
that cannot agree on a version is rejected (`rejectedBadVersion`). Within a
negotiated version, ordinal-based evolution applies.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-EVO-001` | Adding a field does not break old readers. |
| `AC-PROTO-EVO-002` | Deprecating a field keeps old peers working. |
| `AC-PROTO-EVO-003` | Version mismatch is rejected by name. |

---

## 6. Open questions

See `10-open-questions.md`.

---

## 7. References

- Cap'n Proto. https://capnproto.org/ — accessed 23 October 2026.