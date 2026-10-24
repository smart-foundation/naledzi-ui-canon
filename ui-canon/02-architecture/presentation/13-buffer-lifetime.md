---
id: ARCH-PRESENT-BUFFERLIFE
title: Buffer Lifetime
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY, ARCH-PRESENT-COMMIT]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-040, AC-ARCH-PRESENT-041]
---

# Buffer Lifetime

> Free, writing, committed, acquired, displayed, released, revoked. Who owns
> each state. Capability-gated. No raw pointers cross the boundary.

---

## 1. The state machine

A buffer moves through these states:

| State | Meaning | Owner |
|---|---|---|
| `free` | not in use; available to producer | producer |
| `writing` | producer is writing pixels | producer |
| `committed` | commit accepted; buffer handed to authority | authority |
| `acquired` | executor has acquired it for realization | executor |
| `displayed` | included in a numbered still being scanned out | authority + executor |
| `released` | fence signaled; safe to reuse | authority returns to producer |
| `revoked` | capability revoked mid-use; buffer must not be read/written further | authority |

Transitions are capability-gated and recorded in the still history. There is no
state in which a buffer is both being written and scanned out
(`01-model.md` INV-2).

---

## 2. Single writer

For any still number *n* and surface *s*, at most one commit may define *s* in
*n* (INV-1). Concurrent producers on one surface are a contract violation, not
a merge problem.

---

## 3. Read-only after present

Once a buffer is included in a numbered still, its producing session MUST NOT
write to it until the authority has released it. Release is expressed by the
found fence and the buffer's return to the producer. `SyncFence`
(`compositor.capnp:572-577`) and `T.FenceHandle` (`surface.capnp:168-171`,
`types.capnp`) are the only valid release signals; a timeout is a failure, not
a release.

---

## 4. Capability-gated handles

Buffers cross the contract boundary as handles, never pointers
(`LAW-002`). `T.BufferId`, `T.FenceHandle`, `T.MappedRegionId`,
`T.DataHandle` are the typed handles. A consumer with a handle has a scoped
right, not an address. Revocation of the capability invalidates the handle
(`security/02-capability-revocation.md`).

---

## 5. Revoked state

On capability revocation mid-operation, the buffer enters `revoked`: the holder
MUST stop reading/writing; the authority records the revocation; no fake
success is reported. The buffer is recovered to `free` only after the
revocation completes. See `security/02-capability-revocation.md`.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-040` | No buffer is written while displayed; instrumented builds detect any write. |
| `AC-ARCH-PRESENT-041` | A revoked buffer stops being read/written; the holder receives a typed event. |
| `AC-ARCH-PRESENT-042` | Release occurs only via fence signal; a timeout is not a release. |
| `AC-ARCH-PRESENT-043` | No raw pointer crosses the contract boundary in a buffer handle. |

---

## 7. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-BUF-001` | Should buffer state be exposed to producers as a subscription? | Architecture Editor | proposed |

---

## 8. References

- Wayland, buffer release events. https://wayland.freedesktop.org/docs/html/
- Android, BufferQueue and fence sync. https://source.android.com/docs/core/graphics/architecture
- Linux DMA-BUF. https://docs.kernel.org/driver-api/dma-buf.html