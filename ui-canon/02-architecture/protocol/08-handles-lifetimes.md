---
id: ARCH-PROTO-HANDLES
title: Handles and Lifetimes
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-HANDLE-001, AC-PROTO-HANDLE-002]
---

# Handles and Lifetimes

> Buffer handles, capability scoping, revocation. Handles are typed, scoped,
> revocable. No raw pointers.

---

## 1. Handles

Handles are typed opaque references: `T.BufferId`, `T.FenceHandle`,
`T.MappedRegionId`, `T.DataHandle`, `T.SurfaceId`, `T.SessionId`,
`GpuBufferId`, `GpuFenceId`, etc. They are not addresses; they are
capability-scoped rights. A holder uses a handle to invoke operations; the
service validates the handle and the capability.

---

## 2. Scoping

A handle is valid only within the scope (session, output, capability) that
issued it. Cross-scope use is rejected. Handles do not confer authority beyond
their scope.

---

## 3. Revocation

When a capability is revoked, all handles derived from it become invalid. The
holder's next use fails with a typed error; in-flight operations abort per
contract. No handle outlives its capability. See
`security/02-capability-revocation.md`.

---

## 4. Lifetime on the wire

Buffer lifetime states (free/writing/committed/acquired/displayed/released/
revoked) are tracked by the authority; handles remain valid only in states that
permit the holder's operation. A handle to a released buffer is not reusable
until re-acquired.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-HANDLE-001` | A handle is rejected outside its scope. |
| `AC-PROTO-HANDLE-002` | Revoked capability invalidates all derived handles. |
| `AC-PROTO-HANDLE-003` | No raw pointer crosses the boundary. |

---

## 6. Open questions

See `10-open-questions.md`.

---

## 7. References

See `12-references.md`.