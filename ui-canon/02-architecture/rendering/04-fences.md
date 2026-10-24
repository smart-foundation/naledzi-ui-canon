---
id: ARCH-REND-FENCES
title: Fences
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-FENCE-001, AC-REND-FENCE-002]
---

# Fences

> Acquire/release, implicit vs explicit, timeouts, propagation. A fence says
> when a buffer is safe to read or reuse. A timeout is a failure, not a
> release.

---

## 1. What a fence is

A fence is a synchronization primitive stating when a buffer is safe to read
or reuse. `SyncFence` (`compositor.capnp:572-577`): `native @0 :UInt64` or
`none @1 :Void`. `surface.capnp` strengthens to
`SyncFence { handle @0 :T.FenceHandle; name @1 :Text; }`. GPU fences:
`GpuFenceId` (`gpu.capnp`).

---

## 2. Acquire and release

- **Acquire:** the executor acquires a buffer for realization after the
  producer's fence signals (buffer safe to read).
- **Release:** the authority releases the buffer back to the producer after the
  executor's fence signals (scanout complete). Release is expressed by the
  fence and the buffer's return; a timeout is a failure, not a release
  (`presentation/13-buffer-lifetime.md`).

---

## 3. Implicit vs explicit

- **Explicit:** producer supplies a fence (`SyncFence.native`); the authority
  waits on it. Preferred for predictable latency.
- **Implicit/none:** `SyncFence.none` means the producer asserts the buffer is
  already safe. The authority may accept this only if the producer holds the
  appropriate capability; otherwise it is a rejection.

---

## 4. Timeouts

A fence that does not signal within the declared timeout is a failure
(`fence-timeout`), not a release. The producer must resubmit with a fresh
fence. Timeouts are recorded in `FrameSignal.dropped` and measured against
budgets (`performance/01-budgets.md`).

---

## 5. Propagation

Fences propagate across paths: a GPU submission fence becomes the buffer's
release fence; a remote encode fence becomes the transport's release fence.
Propagation is typed (no raw handle reinterpretation). A fence that is already
failed makes the commit invalid (`presentation/07-rejections.md`).

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-REND-FENCE-001` | A buffer is not read before its acquire fence signals. |
| `AC-REND-FENCE-002` | A timeout is recorded as failure, not release. |
| `AC-REND-FENCE-003` | Fence propagation across GPU/remote paths is typed. |

---

## 7. References

See `13-references.md`.