---
id: ARCH-SEC-REMOTE
title: Remote Trust
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SEC-REMOTE-001, AC-SEC-REMOTE-002]
---

# Remote Trust

> Pairing, identity, session scope, revocation. Remote peers are untrusted
> until paired and scoped.

---

## 1. Pairing

Devices find each other via discovery (role-based, no names) and establish
trust via pairing (QR/NFC/code). Pairing grants a scoped identity and session
capability. See `ecosystem/01-discovery-and-pairing.md`.

---

## 2. Identity

Each device has a cryptographic identity (`crypto.capnp`, `signature.capnp`,
`key_management.capnp`). Identity is verified during pairing. Session scope
limits what a remote peer may observe or control.

---

## 3. Revocation

A paired device may be revoked at any time. Revocation invalidates its session
and capabilities; in-flight operations abort with typed errors. See
`ecosystem/11-failure.md`.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SEC-REMOTE-001` | Unpaired remote peer cannot observe or control. |
| `AC-SEC-REMOTE-002` | Revoked device loses all access immediately. |

---

## 5. Open questions

See `07-open-questions.md`.

---

## 6. References

See `09-references.md`. `crypto.capnp`, `signature.capnp`, `key_management.capnp`,
`tunnel.capnp`.