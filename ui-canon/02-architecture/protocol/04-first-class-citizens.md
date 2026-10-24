---
id: ARCH-PROTO-FIRSTCLASS
title: First-Class Citizens
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-FC-001, AC-PROTO-FC-002]
---

# First-Class Citizens

> Every service is a peer. No privileged hardcoding. The OS is one system of
> peers; no service is more equal than another by construction.

---

## 1. Peers

Every service — policy, executor, authority, theme, input, app — is a peer
speaking the same contract. None is hardwired into another. The authority is
mandatory as a role, but it is still a peer: it is discovered by role, not by
name, and it may be replaced (on the same device or remotely) without changing
the contract.

---

## 2. No privileged hardcoding

No service may assume another is present at a fixed address or name. No
"compositor is always PID 1" assumptions. Discovery by role is the only
binding mechanism. An implementation that assumes a privileged peer is
non-conformant.

---

## 3. Consequences

- Services can be restarted, replaced, or moved without contract changes.
- Remote peers are peers with the same contract (`LAW-017`).
- Testing can substitute any peer with a test double speaking the contract.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-FC-001` | Any peer can be replaced by a test double speaking the contract. |
| `AC-PROTO-FC-002` | No service address is hardcoded. |

---

## 5. Open questions

See `10-open-questions.md`.

---

## 6. References

See `12-references.md`.