---
id: ARCH-PROTO-INDEX
title: Protocol
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PROTO-000]
children:
  - 01-capnp.md
  - 02-capabilities.md
  - 03-roles-and-discovery.md
  - 04-first-class-citizens.md
  - 05-schema-evolution.md
  - 06-observation-rights.md
  - 07-error-model.md
  - 08-handles-lifetimes.md
  - 09-acceptance.md
  - 10-open-questions.md
  - 11-changelog.md
  - 12-references.md
---

# Protocol

> What crosses the contract boundary, in what envelope, with what authority.
> Cap'n Proto is the contract; capabilities are the authority; roles are the
> discovery mechanism.

**Scope:** capnp contract, capabilities, roles/discovery, first-class citizens,
schema evolution, observation rights, error model, handles/lifetimes.

---

## 1. The single question

> What crosses the contract boundary, in what envelope, with what authority?

---

## 2. Directory map

| File | Question |
|---|---|
| `01-capnp.md` | schema as contract, ordinals, evolution, canonicalisation |
| `02-capabilities.md` | unforgeable, scoped, revocable |
| `03-roles-and-discovery.md` | nothing knows another service by name |
| `04-first-class-citizens.md` | every service is a peer |
| `05-schema-evolution.md` | new ordinals, defaults, compatibility, deprecation |
| `06-observation-rights.md` | thumbnails, capture, clipboard, remote |
| `07-error-model.md` | named rejections, no silent failure |
| `08-handles-lifetimes.md` | buffer handles, capability scoping, revocation |
| `09-acceptance.md` | AC index |
| `10-open-questions.md` | unresolved |
| `11-changelog.md` | creation record |
| `12-references.md` | evidence |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PROTO-000` | Branch coverage complete. |

---

## 4. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `protocol/schemas/*.capnp` (authoritative).