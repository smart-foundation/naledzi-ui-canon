---
id: ARCH-SECURITY-INDEX
title: Security
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-SEC-000]
children:
  - 01-threat-model.md
  - 02-capability-revocation.md
  - 03-secure-surfaces.md
  - 04-observation.md
  - 05-remote-trust.md
  - 06-acceptance.md
  - 07-open-questions.md
  - 08-changelog.md
  - 09-references.md
---

# Security

> What may be observed, injected, captured, or revoked, and by whom.
> Capability-based, honest, revocable.

---

## 1. The single question

> What may be observed, injected, captured, or revoked, and by whom?

---

## 2. Directory map

| File | Question |
|---|---|
| `01-threat-model.md` | malicious app, compromised service, remote peer, physical access, supply chain |
| `02-capability-revocation.md` | mid-operation, no crash, no fake success |
| `03-secure-surfaces.md` | lock, auth, protected zones, DRM-like content |
| `04-observation.md` | camera/mic/screen/clipboard indicators, consent, audit |
| `05-remote-trust.md` | pairing, identity, session scope, revocation |
| `06-acceptance.md` | AC index |
| `07-open-questions.md` | unresolved |
| `08-changelog.md` | creation record |
| `09-references.md` | evidence |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-SEC-000` | Branch coverage complete. |

---

## 4. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `capability.capnp`, `access.capnp`, `auth.capnp`, `sandbox.capnp`,
  `screenlock.capnp`, `crypto.capnp`, `signature.capnp`.