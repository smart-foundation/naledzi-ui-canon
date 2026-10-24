---
id: ARCH-BUFFER-01
title: Buffer Lifecycle
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [ARCH-MODEL-01, ARCH-OWNERSHIP-01, ARCH-PATHS-01, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-BUF-001, AC-ARCH-BUF-002, AC-ARCH-BUF-003]
---

# Buffer Lifecycle

> A buffer is not "memory the compositor uses". It is a fact with an owner, a fence, a
> generation, and a release. Every bug that looks like tearing, corruption, or a leak is
> a violation of one of the transitions below.

This file enumerates **every state** a buffer may occupy, the owner of each state, the
events that enter and leave it, and the failure edge. It applies to all six paths.

---

## 1. The states

A buffer is always in exactly one state per **holder** (producer, authority, executor,
peer). Global state is the join of holders; the model below names the canonical global
state and then specifies per-holder obligations.

| # | State | Owner of the state | Meaning |
|---|---|---|---|
| B0 | `declared` | producer | producer intends to allocate; no storage yet |
| B1 | `allocated` | buffer service | storage exists; no content contract yet |
| B2 | `exported` | buffer service | a shareable handle/region exists |
| B3 | `imported` | importer | importer has a valid handle in its namespace |
| B4 | `acquired` | producer | producer may write; previous readers are done |
| B5 | `writing` | producer | producer is writing; content invalid |
| B6 | `ready` | producer | write fence signalled; content valid if fence succeeds |
| B7 | `queued` | producer/authority | commit submitted, not yet validated |
| B8 | `validated` | authority | commit accepted for this still |
| B9 | `scheduled` | executor | assigned to a path and a presentation time |
| B10 | `in-use` | executor/peer | being read by scanout, GPU, CPU, or decoder |
| B11 | `presented` | authority | still containing it is numbered and visible/sent |
| B12 | `retiring` | executor | last reader has a fence but has not completed |
| B13 | `released` | authority | producer may reacquire |
| B14 | `recycled` | producer | reused for a new frame; new generation |
| B15 | `orphaned` | buffer service | owner gone; storage held until reclaim |
| B16 | `revoked` | security/service | handle invalidated; storage may persist |
| B17 | `failed` | any | a transition failed; buffer is not usable |
| B18 | `destroyed` | buffer service | storage reclaimed; identity retired |

**MUST.** Exactly one global state is current. An implementation may represent states
differently, but it MUST be able to answer "which of B0–B18 is this buffer in?" for
audit.

---

## 2. The canonical path

```
B0 declared
  │ allocate
  ▼
B1 allocated ──export──► B2 exported ──import──► B3 imported
  │                                                  │
  │ producer maps                                    │
  ▼                                                  │
B4 acquired ◄─────────────────────────────────────────┘
  │ begin write
  ▼
B5 writing
  │ write fence signal
  ▼
B6 ready
  │ commit
  ▼
B7 queued
  │ validate
  ├── reject ──────────────────────────────► B17 failed (commit rejected)
  ▼
B8 validated
  │ plan + schedule
  ▼
B9 scheduled
  │ executor begins read
  ▼
B10 in-use
  │ present fence signal
  ▼
B11 presented
  │ last reader fence
  ▼
B12 retiring
  │ release fence observed
  ▼
B13 released
  │ producer reacquires
  ▼
B14 recycled ──► B5 writing (new generation)
```

Terminal or side states: `B15 orphaned`, `B16 revoked`, `B17 failed`, `B18 destroyed`.

---

## 3. Transitions, owners, and gates

Each transition has a **gate**: a condition that must be true before it occurs. A
transition without its gate is the defect.

### T0 → T1: declare → allocate

- Gate: producer holds a buffer capability and a size within `BufferLimits`
  (`buffer.capnp:212-219`).
- Owner: buffer service.
- Failure: limit exceeded ⇒ typed error; buffer stays `declared` or becomes `failed`.
- **MUST NOT** allocate on behalf of a session that has not declared usage. Overcommit
  is a policy (`buffer.capnp:173-190`), not an excuse to skip declaration.

### T1 → T2: allocate → export

- Gate: buffer is shareable; `BufferType` and security permit export
  (`buffer.capnp:222-233`, `426-439`).
- Owner: buffer service.
- The export produces a handle and, for DMA-BUF, a file descriptor. A `dmaBufFd` of `0`
  means not shareable (`gpu.capnp:94-103`); the path MUST treat it as absence.
- **MUST.** The export records the device/namespace in which the handle is valid.

### T2 → T3: export → import

- Gate: importer is authorized by the handle's scope and the session's capability; the
  handle has not been revoked.
- Owner: importer, with buffer service as validator.
- Failure: stale handle, wrong namespace, revoked handle ⇒ `failed`; never a silent
  fallback that aliases another buffer.
- **MUST NOT** import by raw address. `BufferId.addr` (`types.capnp:8`) is not a handle
  and MUST NOT be used as one (G-02).

### T3 → T4: import → acquire

- Gate: all prior readers of this buffer generation have released; the producer's
  acquire fence has succeeded.
- Owner: producer.
- This is where a ring buffer blocks. Blocking is normal; busy-waiting is forbidden
  (`performance/03-idle.md`).

### T4 → T5: acquire → write

- Gate: producer has exclusive write access for this generation.
- Owner: producer.
- **MUST NOT** write while any still references the buffer. The authority's release
  (T12 → T13) is the only permission.

### T5 → T6: write → ready

- Gate: the producer's write fence signals success.
- Owner: producer, observed by authority.
- The fence is declared in the commit (`compositor.capnp:536`) or in the frame
  submission (`surface.capnp:147-156`).
- Failure: fence signals error or never signals ⇒ buffer `failed`, commit rejected with
  `dependency-failed`.

### T6 → T7: ready → queued

- Gate: commit is well-formed and the producer still owns the buffer.
- Owner: producer → authority.
- **MUST.** The commit carries one still's worth of declaration. A commit that only
  says "buffer N is now different" is invalid.

### T7 → T8: queued → validated

- Gate: schema validation, capability validation, format/buffer match, damage validity,
  fence validity, output availability.
- Owner: authority.
- Result is recorded. Rejection is a first-class outcome (`presentation/07-rejections.md`).

### T8 → T9: validated → scheduled

- Gate: policy plan exists or default plan applies; executor has capacity; present
  intent is satisfiable or explicitly relaxed by the authority.
- Owner: authority + executor.
- **MUST.** The schedule records the target still number and the path. A buffer scheduled
  for still *n* MUST NOT be used for still *n+1* without a new commit.

### T9 → T10: scheduled → in-use

- Gate: executor has imported the buffer and its dependency fences succeeded.
- Owner: executor (or remote peer after decode).
- **MUST.** The executor records read access. A scanout read is a read even though it is
  not a CPU load.

### T10 → T11: in-use → presented

- Gate: the path's present evidence:
  - scanout: vblank/commit completion for the target output;
  - plane: plane commit completion;
  - GPU: render completion plus scanout completion (both, if displayed);
  - CPU: composition complete plus scanout/copy complete;
  - remote: peer acknowledgement of decode/display, or explicit `sent` if none;
  - headless: sink write complete.
- Owner: authority, using executor evidence.
- **MUST NOT.** The authority MUST NOT mark `presented` on submission alone.

### T11 → T12: presented → retiring

- Gate: a later still no longer references this buffer, or the still is withdrawn.
- Owner: executor.
- The buffer may still be read by hardware until its last-reader fence signals.

### T12 → T13: retiring → released

- Gate: last-reader fence signalled success.
- Owner: authority.
- **MUST NOT.** A timeout MUST NOT be treated as release. A timeout is `failed`
  (`B17`) and triggers recovery, because releasing early causes corruption.

### T13 → T14: released → recycled

- Gate: producer reacquires; generation increments.
- Owner: producer.
- **MUST.** Every reuse increments a generation. A still record names the generation; a
  handle without generation is ambiguous and forbidden.

### Any → B15 orphaned

- Trigger: owning session dies, device disconnects, transport session ends.
- Owner: buffer service.
- The buffer is not immediately freed if an executor still reads it. It is `orphaned`
  and reclaimed after the last-reader fence or a declared safety timeout that logs a
  leak. The timeout MUST NOT silently reuse.

### Any → B16 revoked

- Trigger: capability revocation, trust downgrade (`device.capnp:102-109`), capture grant
  expiry (`capture.capnp:352-368`), user lock.
- Owner: security service, enforced by buffer service.
- Revocation invalidates handles immediately. In-flight reads are allowed to finish only
  if the security policy says so; otherwise the executor must stop and report.

### Any → B17 failed

- Trigger: any gate failure that cannot be retried within the same generation.
- Owner: the failing transition's owner.
- A failed buffer MUST NOT be presented. Its identity may be reused only after
  `destroyed`.

### B17/B15 → B18 destroyed

- Gate: no holder references it; storage reclaim is safe.
- Owner: buffer service.
- Destruction retires the identity. `BufferId` values are never reused for a different
  buffer.

---

## 4. Per-path state obligations

The state machine is global, but each path observes different states.

| Path | First state it sees | Last state it owns | Extra obligation |
|---|---|---|---|
| Scanout | B9 scheduled | B12 retiring | record CRTC/plane and vblank evidence |
| Plane | B9 scheduled | B12 retiring | record plane ID and per-plane fence |
| GPU | B3 imported | B12 retiring | honour modifier (`gpu.capnp:79-82`) and explicit fences (`gpu.capnp:119-126`) |
| CPU | B3 imported or B1 mapped | B11 presented | copy accounting; no readback without declaration |
| Remote | B2 exported or encoded copy | B11 presented (`sent` if no ack) | encode/decode generation; no stale frame reuse |
| Headless | B9 scheduled | B11 presented | sink completion is the evidence |

**MUST.** A path that cannot observe a state MUST say so. A remote path that cannot know
whether the peer displayed the frame MUST report `sent`, not `presented`.

---

## 5. Fences

The contract has two fence representations, and this corpus resolves them for
architecture purposes:

- `compositor.capnp:572-577` — a native `UInt64` or `none`.
- `surface.capnp:168-171` — a `T.FenceHandle` plus a name.
- `T.FenceHandle` is an opaque `UInt64` (`types.capnp:979`).

**MUST.** Any fence crossing a process or device boundary MUST be the handle form.
The native form MAY be used only within one address space where the number is
meaningful.

**MUST.** A fence has three observable outcomes: `pending`, `signalled`, `failed`.
There is no "assume signalled". A missing fence means `pending` forever, not success.

**MUST NOT.** A fence timeout MAY trigger recovery, but it MUST NOT trigger release.
Recovery means: mark still failed, re-create the buffer or reset the path, and record the
event; it never means "the GPU is probably done".

Fence failure edges:

| Event | Buffer state | Still outcome |
|---|---|---|
| write fence failed | B17 | commit rejected |
| write fence timeout | B17 | commit rejected; producer notified |
| read fence failed | B17 | still failed, not presented |
| read fence timeout | B17 | still failed; path reset |
| release fence failed | B17 | buffer not recycled; leak recorded |
| peer ack missing | B11 as `sent` | still recorded as sent, not presented |

---

## 6. Lifetimes and generations

A buffer identity has three parts in the architecture, even though the schema carries
only an ID and a handle:

```
(buffer identity, generation, holder namespace)
```

- **Identity** is stable for the allocation.
- **Generation** increments on every recycle (T13 → T14). It invalidates cached
  observations and stale commits.
- **Namespace** is the process/device in which the handle is valid. A handle copied to
  another namespace is not valid until imported.

**MUST.** Every still record names the generation for each buffer it references. Without
it, a late release can free a buffer that a new frame is already using.

---

## 7. Buffer families

The lifecycle is the same; the gates differ.

### 7.1 Scanout framebuffer

- Allocated by the display/GPU service, not the app.
- The app never writes it directly; composition writes it, or a plane reads an app
  buffer.
- `Framebuffer` carries `region`, `stride`, `bytesPerPixel`, optional `clut`, and
  `cursors` (`framebuffer.capnp:48-88`). The lifecycle MUST validate stride and bpp
  before use.

### 7.2 App buffer (shared memory)

- Allocated through `BufferService`, imported by the authority/executor.
- The most common family; zero-copy depends on the authority importing rather than
  copying.

### 7.3 GPU buffer (DMA-BUF)

- Export/import with modifier. A modifier mismatch is a rejection, not a conversion.
- Residency may change; the lifecycle records the resident device.

### 7.4 Tensor/audio/compressed

- `BufferType` includes `tensor`, `audio`, `compressed` (`buffer.capnp:222-233`).
- They do not participate in stills directly, but they obey the same ownership and
  release rules when a still depends on them (for example, a tensor producing a
  visualization).
- Compression is declared (`buffer.capnp:440-449`); an executor that cannot decode it
  rejects.

### 7.5 Cursor buffer

- Often a small plane buffer. It is a still contribution and follows the same states.
- A cursor move is a new still if it changes what the user can see or click.

---

## 8. Leaks and reclaim

A leak is a buffer in `B10`, `B12`, or `B15` beyond its declared lifetime. Leaks are
observable facts and MUST be reported, not hidden.

```
on leak detect:
  record(buffer, state, holder, age, still)
  quiesce path if corruption is possible
  reclaim only after fence or declared safety timeout
  never reuse while any still may reference it
```

**MUST NOT.** A safety timeout that reclaims a buffer MUST be treated as a correctness
failure, logged, and surfaced in diagnostics. It is not normal operation.

---

## 9. Acceptance

- **AC-ARCH-BUF-001** — State coverage: a harness drives a buffer through B0–B18,
  including orphan, revoke, fail, and destroy, and asserts the owner and gate at each
  transition.
- **AC-ARCH-BUF-002** — Fence honesty: inject pending, failed, and never-signalled
  fences on every path. Assert no buffer is released and no still is presented on a
  non-success fence.
- **AC-ARCH-BUF-003** — Generation safety: recycle a buffer while a still references the
  old generation; assert the late release does not free the new generation and the stale
  commit is rejected.
