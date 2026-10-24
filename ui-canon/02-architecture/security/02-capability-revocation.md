---
id: ARCH-SEC-REVOCATION
title: Capability Revocation
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX, ARCH-PROTO-CAPABILITIES]
supersedes: []
superseded_by: []
acceptance: [AC-SEC-REV-001, AC-SEC-REV-002]
---

# Capability Revocation

> Mid-operation, no crash, no fake success. Revocation is enforced even while
> an operation is in flight.

---

## 1. Semantics

Revocation invalidates the capability and all derived handles. In-flight
operations either complete (if already past the point of no return) or abort
with a typed error. The holder is notified via a typed revocation event. No
fake success is reported (`LAW-011`).

---

## 2. Buffer revocation

A buffer under a revoked capability enters the `revoked` state
(`presentation/13-buffer-lifetime.md`): the holder stops reading/writing; the
authority records the revocation; the buffer recovers to `free` after
completion. No stale reads.

---

## 3. Mid-operation safety

A revocation during a drag, capture, or remote session degrades gracefully:
the holder receives the event and exits the operation without crashing. The
user sees an honest state.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SEC-REV-001` | Revocation mid-operation delivers typed event; holder does not crash. |
| `AC-SEC-REV-002` | No fake success after revocation. |
| `AC-SEC-REV-003` | Revoked buffer enters revoked state and recovers to free. |

---

## 5. Open questions

See `07-open-questions.md`.

---

## 6. References

See `09-references.md`. `capability.capnp`, `access.capnp`.