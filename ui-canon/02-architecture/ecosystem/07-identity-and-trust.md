---
id: ARCH-ECO-IDENTITY
title: Identity and Trust
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-ID-001, AC-ECO-ID-002]
---

# Identity and Trust

> Account optional, device identity, session scope, multi-user, guest. Identity
> is device-first; accounts are optional enhancers.

---

## 1. Principles

- Account is optional: the OS works fully without one.
- Device identity is cryptographic and primary (`crypto.capnp`,
  `key_management.capnp`).
- Session scope limits access per user/session.
- Multi-user: each user has their own session and data.
- Guest: restricted session, no persistent user data, no sync.

---

## 2. Trust establishment

Trust is established via pairing (`01-discovery-and-pairing.md`) and
cryptographic identity verification. No central account is required for
device-to-device trust.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-ID-001` | OS is fully usable without an account. |
| `AC-ECO-ID-002` | Guest session has no persistent data and no sync. |

---

## 4. Open questions

See `13-open-questions.md`.

---

## 5. References

See `15-references.md`. `user.capnp`, `auth.capnp`.