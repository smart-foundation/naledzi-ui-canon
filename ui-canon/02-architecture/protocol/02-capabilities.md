---
id: ARCH-PROTO-CAPABILITIES
title: Capabilities
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-CAP-001, AC-PROTO-CAP-002]
---

# Capabilities

> Unforgeable, scoped, revocable. Not a global name, not a raw pointer. A
> capability is the only authority to perform an operation on a resource.

---

## 1. What a capability is

A capability is an unforgeable, revocable right to perform an operation on a
resource. It is not a global name, not a raw pointer, not a permission bit
checked against a global table. It is the authority itself: holding it means
you may act; not holding it means you may not. This is capability-based
security (`Dennis & Van Horn 1966`, `Miller 2006`).

---

## 2. Properties

- **Unforgeable:** cannot be fabricated; only the issuer may create one.
- **Scoped:** limited to a specific resource and operation.
- **Revocable:** the issuer may revoke at any time; revocation is enforced
  even mid-operation (`security/02-capability-revocation.md`).
- **Transferable only by explicit grant:** a holder may grant a subset to
  another, never the whole unless authorised.

---

## 3. On the wire

Capabilities cross the boundary as handles, never pointers. `capability.capnp`
defines the capability structures; `access.capnp` defines access control.
Handshake (`compositor.capnp:46-62`) returns `granted :List(GrantedCapability)`
and `denied :List(DeniedCapability)`. Every service invocation that requires a
right takes a capability handle.

---

## 4. No global names

Nothing knows another service by name. Resolution is by role
(`03-roles-and-discovery.md`). A global name would be a capability forgery
surface and a coupling point.

---

## 5. Revocation semantics

Revocation is enforced mid-operation: the holder's next use fails with a typed
error; in-flight operations complete or abort per their contract; no fake
success. See `security/02-capability-revocation.md` and
`presentation/13-buffer-lifetime.md` (revoked state).

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-CAP-001` | A forged capability handle is rejected. |
| `AC-PROTO-CAP-002` | Revocation stops in-flight use with a typed error. |
| `AC-PROTO-CAP-003` | No service is addressed by global name. |

---

## 7. Open questions

See `10-open-questions.md`.

---

## 8. References

- Dennis, J. B. & Van Horn, E. C. (1966). https://dl.acm.org/doi/10.1145/365230.365252
- Miller, M. S. (2006). https://www.erights.org/talks/thesis/