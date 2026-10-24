---
id: ARCH-PROTO-ACCEPTANCE
title: Protocol Acceptance
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PROTO-000]
---

# Protocol Acceptance

> AC index for the protocol branch.

---

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-PROTO-000` | Branch coverage complete. |
| `AC-PROTO-CAPNP-001` | Old reader reads new message. |
| `AC-PROTO-CAPNP-002` | New reader reads old message with defaults. |
| `AC-PROTO-CAPNP-003` | Canonical wire bytes identical across impls. |
| `AC-PROTO-CAP-001` | Forged capability rejected. |
| `AC-PROTO-CAP-002` | Revocation stops in-flight use with typed error. |
| `AC-PROTO-CAP-003` | No service addressed by global name. |
| `AC-PROTO-ROLES-001` | Peer resolved by role, not name. |
| `AC-PROTO-ROLES-002` | Absence handled as declared value. |
| `AC-PROTO-ROLES-003` | No hardcoded service name. |
| `AC-PROTO-FC-001` | Peer replaceable by test double. |
| `AC-PROTO-FC-002` | No service address hardcoded. |
| `AC-PROTO-EVO-001` | Adding field doesn't break old readers. |
| `AC-PROTO-EVO-002` | Deprecating field keeps old peers working. |
| `AC-PROTO-EVO-003` | Version mismatch rejected by name. |
| `AC-PROTO-OBS-001` | Observation requires capability; none by default. |
| `AC-PROTO-OBS-002` | Revocation stops observation with typed event. |
| `AC-PROTO-ERR-001` | Every request returns success or named typed error. |
| `AC-PROTO-ERR-002` | No silent failure. |
| `AC-PROTO-ERR-003` | Absence distinguished from error. |
| `AC-PROTO-HANDLE-001` | Handle rejected outside scope. |
| `AC-PROTO-HANDLE-002` | Revoked capability invalidates derived handles. |
| `AC-PROTO-HANDLE-003` | No raw pointer crosses boundary. |

---

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PROTO-000` | Branch coverage complete. |

---

## 3. Open questions

See `10-open-questions.md`.

---

## 4. References

See `12-references.md`.