---
id: ARCH-PRESENT-COMMIT
title: The Commit
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-STILL]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-003, AC-ARCH-PRESENT-006]
---

# The Commit

> A commit is the producer's explicit declaration that a surface's content has
> changed: the buffer, the damaged region, the present intent, the fence, and
> optional semantic payloads. It is the only door into the visible world. There
> is no side door.

---

## 1. What a commit is

A commit is a single, atomic declaration made by a producer (app, shell, system
service) to the presentation authority. It says: "I have written new content into
buffer *b* of surface *s*; the damaged region is *d*; I want it shown with intent
*p*; the buffer is safe to read after fence *f*; the orientation is *t*." The
authority either numbers a new still from that commit or returns a named
rejection. It never silently drops it.

The commit is not a request. It is a declaration plus a capability. The producer
has already written the buffer; the commit tells the authority that the write is
complete and safe to read after the fence. The authority does not pull pixels; it
validates declarations.

---

## 2. The commit fields

The wire shape is `SurfaceCommit` (`compositor.capnp:529-541`) and
`FrameSubmission` (`surface.capnp` FrameSubmission struct, lines of the struct
definition). Both carry the same core:

| Field | Type | Schema line | Meaning |
|---|---|---|---|
| `surfaceId` | `T.SurfaceId` | `compositor.capnp:530` | Which surface this still replaces |
| `frameId` | `UInt64` | `compositor.capnp:531` | Producer's frame identity, for ack and pacing |
| `bufferIndex` | `UInt8` | `compositor.capnp:532` | Which buffer of the surface's set |
| `format` | `T.PixelFormat` | `compositor.capnp:533` | Declared format; must match the buffer |
| `damageOption` | `DamageOption` | `compositor.capnp:534` | Declared damage or explicit omission |
| `present` | `PresentIntent` | `compositor.capnp:535` | When the producer wants it shown |
| `fence` | `SyncFence` | `compositor.capnp:536` | When the buffer is safe to read |
| `transform` | `T.BufferTransform` | `compositor.capnp:537` | Declared orientation |

`FrameSubmission` (`surface.capnp`) mirrors these: `surfaceId @0`, `frameId @1`,
`bufferId @2 :T.BufferId`, `bufferOffset @3 :T.Vec2i`, `damage @4`,
`present @5`, `fence @6`, `transform @7`. The two shapes exist because
`SurfaceCommit` is the compositor-level batch and `FrameSubmission` is the
per-surface hot path. They carry the same declarations.

---

## 3. Buffer

The buffer is a reference, never bytes. `bufferIndex`/`bufferId` names a buffer
the session owns; the authority checks ownership via the capability set
established at handshake (`compositor.capnp:46-62`). The bytes live in the
buffer; they never cross the contract boundary (`LAW-002`). The buffer's
format, stride, tiling and modifier are negotiated out of band; the commit
declares the format the producer wrote (`format :T.PixelFormat`) and the
authority verifies it matches the buffer's negotiated format. A mismatch is a
named rejection (see `07-rejections.md`).

---

## 4. Damage

Damage is the region the producer declares as changed. It is one of
`DamageOption` (`compositor.capnp:543-554`):

- `omitted @0 :Void` — no hint; the authority applies the surface's declared
  default (full surface) and records that the producer did not track damage.
- `full @1 :Void` — the entire surface is damaged.
- `rects @2 :List(T.Rect)` — the changed rectangles.
- `custom @3 :Data` — an opaque, backend-specific damage blob; the authority
  treats it as declared and passes it through.

See `11-damage-declaration.md` for why damage is declared and never detected,
how rects are merged, and when full-surface fallback is used.

---

## 5. Present intent

Present intent states when the producer wants the commit visible. It is one of
`PresentIntent` (`compositor.capnp:564-571`):

- `immediate @0 :Void` — as soon as possible.
- `nextVsync @1 :Void` — at the next vertical sync.
- `atTime @2 :T.Timestamp` — at a named wall time.
- `periodic @3 :T.Duration` — added in `surface.capnp` PresentIntent: a
  repeating cadence.
- `custom @4 :Data` — backend-specific scheduling.

See `12-present-intent.md` for how intent interacts with damage and fences.

---

## 6. Fence

The fence says when the buffer is safe to read. It is `SyncFence`
(`compositor.capnp:572-577`):

- `native @0 :UInt64` — a native fence handle.
- `none @1 :Void` — no fence; the producer asserts the buffer is already safe.

`surface.capnp` strengthens this to `SyncFence { handle @0 :T.FenceHandle; name @1 :Text; }`.
The authority prefers the typed handle. A fence that is already failed makes the
commit invalid. A fence that times out is a failure, not a release
(`01-model.md` INV-2). See `rendering/04-fences.md`.

---

## 7. Transform

`transform :T.BufferTransform` declares the orientation of the buffer as written
(`compositor.capnp:537`). The authority does not rotate pixels to discover it; it
trusts the declaration and rejects a mismatch with the buffer's negotiated
transform capability. See `rendering/06-gpu.md` for colour/transform handling.

---

## 8. Commit validation

On receipt, the authority performs, in order:

1. **Session validity.** The session that issued the commit is live and
   capability-scoped (`compositor.capnp:46-62` HandshakeRequest/Response).
2. **Surface ownership.** The surface belongs to the session.
3. **Buffer ownership.** The buffer belongs to the session and is in a writable
   state (see `13-buffer-lifetime.md`).
4. **Format match.** Declared format matches the buffer's negotiated format.
5. **Fence validity.** The fence is not already failed.
6. **Damage bounds.** Declared rects lie within the surface bounds.
7. **Transform match.** Declared transform is supported for this buffer.
8. **Invariant check.** Single writer per still (INV-1), read-only after present
   (INV-2).

Each failure produces a named rejection (see `07-rejections.md`). Each success
produces a numbered still and an ack to the producer carrying the still number
and the `FrameSignal` (`compositor.capnp` FrameSignal struct) for pacing.

---

## 9. Commit rejection classes

See `07-rejections.md` for the full named list. Summary of classes:

- `buffer-format-mismatch` — declared format != buffer format.
- `fence-timeout` / `fence-already-failed` — sync failure.
- `damage-out-of-bounds` — rects outside surface.
- `capability-denied` — session lacks the right.
- `buffer-not-owned` / `buffer-not-writable` — lifetime violation.
- `surface-not-owned` — wrong surface.
- `session-dead` — session gone.
- `transform-unsupported` — orientation not supported.
- `still-number-collision` — internal defect (must not happen).

Every rejection names the failed invariant and the culprit. No silent drop
(`AC-ARCH-PRESENT-006`).

---

## 10. Commit and the user

The user never sees a commit. The user sees the numbered still that results.
The commit is the producer's side of the contract; the still is the authority's
side. The two are linked by the still number, which the producer receives in
the ack and may use for pacing (`FrameSignal.nextPresentTime`,
`FrameSignal.framePeriod`).

---

## 11. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-003` | Every commit produces either a numbered still or a named rejection. |
| `AC-ARCH-PRESENT-006` | No commit is silently dropped; every commit is acked or rejected by name. |
| `AC-ARCH-PRESENT-011` | A commit with a format mismatch is rejected by name and the previous still remains current. |
| `AC-ARCH-PRESENT-012` | A commit with out-of-bounds damage is rejected by name. |
| `AC-ARCH-PRESENT-013` | A commit whose fence is already failed is rejected by name. |
| `AC-ARCH-PRESENT-014` | The producer receives the still number in the ack and can pace on `FrameSignal`. |

---

## 12. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-COMMIT-001` | Should `SurfaceCommit` and `FrameSubmission` be unified into one shape? | Architecture Editor | proposed |
| `OQ-COMMIT-002` | Is `custom :Data` damage a contract gap (opaque, unauditable)? | Architecture Editor | proposed |

---

## 13. References

- Wayland protocol, `wl_surface.commit` and `wl_surface.damage`. —
  https://wayland.freedesktop.org/docs/html/
- Android SurfaceFlinger, BufferQueue. —
  https://source.android.com/docs/core/graphics/architecture
- Cap'n Proto documentation. — https://capnproto.org/
- Miller, M. S. (2006). *Robust Composition.* — capability semantics.
  https://www.erights.org/talks/thesis/