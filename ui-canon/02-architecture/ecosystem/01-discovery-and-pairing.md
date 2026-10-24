---
id: ARCH-ECO-DISCOVERY
title: Discovery and Pairing
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX, ARCH-PROTO-ROLES]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-DISC-001, AC-ECO-DISC-002]
---

# Discovery and Pairing

> How devices find each other without names; trust establishment; QR/NFC/code;
> revocation.

---

## 1. Discovery

Devices discover peers by role over local networks / proximity, never by
literal name (`protocol/03-roles-and-discovery.md`). `discovery.capnp` carries
discovery contracts. Discovery returns candidate peers with their advertised
roles and a short-lived pairing token.

---

## 2. Pairing

Pairing establishes trust: the user confirms via QR code, NFC tap, or a short
code. On confirmation, devices exchange cryptographic identities
(`crypto.capnp`, `signature.capnp`, `key_management.capnp`) and create a
scoped session capability. Pairing is explicit and user-initiated; no silent
pairing.

---

## 3. Revocation

A paired device can be revoked at any time (`security/05-remote-trust.md`).
Revocation invalidates the session and capabilities; in-flight operations abort
with typed errors.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-DISC-001` | Discovery finds peers by role, not name. |
| `AC-ECO-DISC-002` | Pairing requires explicit user confirmation. |
| `AC-ECO-DISC-003` | Revocation invalidates the paired session. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `discovery.capnp`, `nfc.capnp`.