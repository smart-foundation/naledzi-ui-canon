---
id: ARCH-SEC-THREAT
title: Threat Model
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SEC-THREAT-001, AC-SEC-THREAT-002]
---

# Threat Model

> Malicious app, compromised service, remote peer, physical access, supply
> chain. What we defend against and on what terms.

---

## 1. Threats

| Threat | What it can do | Mitigation |
|---|---|---|
| Malicious app | try to read another app's buffers, inject input, observe screen | capability scoping, sandbox, no global names |
| Compromised service | lie about facts, leak data | role discovery, capability checks, audit |
| Remote peer | impersonate, replay, eavesdrop | pairing, identity, session scope, revocation |
| Physical access | read screen, extract data | lock screen, protected zones, encryption |
| Supply chain | ship compromised binary | signatures, updates, sandbox |

---

## 2. Assumptions

- The kernel and hardware are trusted (out of scope for this corpus).
- The authority is trusted on the local device.
- Remote peers are untrusted until paired and scoped.

---

## 3. What we do not defend against

- Kernel-level compromise (out of scope).
- Physical extraction of RAM (out of scope; handled by hardware).

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SEC-THREAT-001` | A malicious app cannot read another app's buffer. |
| `AC-SEC-THREAT-002` | A compromised service cannot lie without detection (audit). |

---

## 5. Open questions

See `07-open-questions.md`.

---

## 6. References

See `09-references.md`. `sandbox.capnp`, `auth.capnp`, `crypto.capnp`.