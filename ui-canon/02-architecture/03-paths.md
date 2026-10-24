---
id: ARCH-PATHS-01
title: Architecture × Paths Matrix
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [ARCH-MODEL-01, ARCH-OWNERSHIP-01, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PATHS-001, AC-ARCH-PATHS-002, AC-ARCH-PATHS-003]
---

# Architecture × Paths Matrix

> There are exactly six ways a still can become visible. Each has the same truth
> obligations and different realizations. A path that cannot meet all obligations is not
> a path; it is a degradation mode, and it must say so.

The six paths are **scanout**, **plane**, **GPU**, **CPU**, **remote**, and **headless**.
They are not mutually exclusive: one still may use a plane for video, GPU for app
content, and CPU for a cursor. The matrix is per **surface contribution**, not per
device.

---

## 1. The matrix

Legend: **M** mandatory; **O** optional but declared; **N** never; **—** not applicable.

| Obligation | Scanout | Plane | GPU | CPU | Remote | Headless |
|---|---|---|---|---|---|---|
| Authority validates commit | M | M | M | M | M | M |
| Still numbered before visible | M | M | M | M | M | M |
| Pixels cross contract boundary | N | N | N | N | N | N |
| Buffer handle + fence | M | M | M | M | M | M |
| Damage declared or full fallback | M | M | M | M | M | M |
| Format/transform honoured exactly | M | M | M | M | M | M |
| Colour/HDR declared or SDR | M | M | M | M | M | M |
| Hit map coherent with pixels | M | M | M | M | M | M |
| Accessibility snapshot coherent | M | M | M | M | M | M |
| Input ownership recorded | M | M | M | M | M | M |
| Frame pacing intent honoured or rejected | M | M | M | M | O | O |
| Tearing permitted | N | O (declared) | N | N | O (declared) | N |
| Zero-copy required | O | O | O | N | O | N |
| Local scanout | M | M | O | O | N | N |
| Remote transport | N | N | O | O | M | O |
| Physical panel required | M | M | N | N | N | N |
| Present evidence available | M | M | M | M | O | M |
| Degradation must be visible | M | M | M | M | M | M |
| Idle silent | M | M | M | M | M | M |

**MUST.** Every path MUST implement the M cells or refuse to be a path. Refusal is a
startup diagnostic, not a runtime surprise.

**MUST NOT.** No path may add a fact to the still that is not in §1 of
`01-model.md`. A path may add **observations**, with time and validity.

---

## 2. Path definitions

### 2.1 Scanout

The executor programs a display controller to read a framebuffer directly. The still is
realized by hardware scan.

- Minimum contract: framebuffer region, format, stride, dimensions
  (`framebuffer.capnp:48-88`), and a completion signal.
- The executor MUST NOT read pixels to validate the commit. Validation is structural.
- The authority MUST record which framebuffer and CRTC realized the still, because the
  user's observation is tied to that output.
- Scanout is the only path that can guarantee a still is visible without a copy.

**Failure.** If scanout cannot be programmed, the path MUST fall back to CPU or remote
**only if** the authority accepts a degraded still; otherwise it presents nothing and
reports `present-failed`. It MUST NOT show a stale framebuffer as if it were the new
still.

### 2.2 Plane

A plane is a hardware overlay with its own position, scale, format, and possibly colour
pipeline. It is a scanout path with per-surface parameters.

- The contract models planes in `framebuffer.capnp` (`Plane`, plane blending and
  properties via `FramebufferService`).
- The executor MUST validate that the declared transform, format, and scale are
  representable by the plane. If not, it MUST reject the plane assignment rather than
  silently convert.
- Plane assignment is a **policy** decision, accepted by the authority. A plane failure
  must not invalidate the whole still; it degrades the offending surface and records
  which one.
- Alpha blending and colour keying are declared properties, never inferred from pixel
  content.

### 2.3 GPU

The executor composes or renders through a GPU command stream.

- Buffers are described by `BufferDesc` (`gpu.capnp:72-83`): size, usage, format,
  dimensions, modifier, label. The modifier is a `DRM_FORMAT_MOD_*` equivalent and `0`
  means linear (`gpu.capnp:79-82`).
- Export/import uses DMA-BUF; a `dmaBufFd` of `0` means **not shareable**
  (`gpu.capnp:94-103`). The path MUST treat that as a capability absence, not an error
  to retry forever.
- Synchronization uses explicit fences; a command buffer declares
  `signalFence` and `referencedBuffers` (`gpu.capnp:119-126`). The authority MUST NOT
  assume submission order implies completion.
- A GPU path MAY use zero-copy; it MUST NOT require it. If import fails, the path
  degrades to CPU composition (declared) rather than reading back through the contract.

### 2.4 CPU

The executor composes into a CPU-mapped buffer.

- CPU composition is always available, which makes it the universal fallback. It is not
  a licence to ignore declarations: format conversion, transform, damage, and colour
  handling still apply, and the result must match the still.
- CPU composition MUST be budgeted (`performance/01-budgets.md`); an unbounded fallback
  is a denial of service by the compositor itself.
- CPU readback of a GPU buffer is a **copy** and MUST be declared as degraded if it
  changes the frame time beyond budget.

### 2.5 Remote

The executor encodes the still and sends it over a transport to a peer that decodes and
displays it.

- The contract carries handles, not pixels, but a remote path necessarily serializes
  pixels or a scene. This is the one place where pixel data leaves the device. It leaves
  **outside** the contract boundary, under an explicit capture/stream grant
  (`capture.capnp:352-368`), and the schema is not changed by it.
- The authority owns the meaning of "presented". The peer's acknowledgement is evidence,
  not truth. Without evidence the still is `sent`.
- Remote MUST declare: codec, resolution, frame rate, latency target, colour, and whether
  input is remote. `ContentStreamingConfig` already carries codec, bitrate, latency,
  dimensions, and frame rate (`display.capnp:812-833`).
- A remote still MUST NOT claim to be a local still. The still record names the path.

### 2.6 Headless

There is no panel. The executor writes to a sink: a file, a virtual framebuffer, a test
harness, or nothing.

- Headless stills are still numbered and validated. The absence of a viewer does not
  relax the contract, because automated consumers (tests, capture, accessibility tools)
  observe the same stills.
- `physicalSizeValid=false` and empty EDID are the honest declaration
  (`display.capnp:267-376`).
- A headless path MUST NOT fabricate an output refresh. Frame pacing is driven by the
  declared present intent or by the test clock.
- Headless MAY be the only path on IoT devices and build machines.

---

## 3. Composition of paths within one still

A still can mix paths. The matrix is applied per contribution, and the still is valid
only if every contribution is valid or explicitly degraded.

```
still 42
├── surface A (video)      → plane 1      (scanout, YUV, HDR)
├── surface B (app)        → GPU layer    (zero-copy, SDR)
├── surface C (cursor)     → plane 2      (scanout, ARGB)
├── surface D (remote app) → remote path  (H.264, 60 ms)
└── surface E (a11y HUD)   → CPU overlay  (fallback)
```

Rules:

1. **One still number** covers all contributions.
2. **One present fence** gates the still; per-contribution fences are dependencies, not
   the still release.
3. **One hit map** covers all contributions, including remote and overlay.
4. **One accessibility snapshot** covers all contributions, ordered by the same stacking
   as the pixels.
5. **Per-contribution degradation** is allowed, but the still MUST record it and the UI
   MUST expose it when it affects interaction or truth.

---

## 4. Path selection

Path selection is a decision, not a discovery:

```
declared surface + output + capabilities
        │
        ├── output has scanout and format supported? ──► scanout/plane
        ├── GPU available and import succeeds? ────────► GPU
        ├── remote grant and peer reachable? ──────────► remote
        ├── CPU budget available? ─────────────────────► CPU
        └── otherwise ─────────────────────────────────► present-failed (honest)
```

**MUST.** The decision and its reason MUST be recorded per still. "It chose CPU" without
a reason is not auditable and is forbidden.

**MUST NOT.** Selection MUST NOT depend on a hardcoded device name, vendor, or bus. It
depends only on declared capabilities (`gpu.capnp:31-60`, `framebuffer.capnp:208-239`,
`display.capnp:702+`).

---

## 5. Path invariants

### P-1 — One copy is the default, zero is the optimization

Every path assumes at least one copy between producer and scanout. Zero-copy is an
optimization that must be proven per still; a failed import falls back, never fails the
still outright.

### P-2 — The last writer is not the presenter

A producer writing a buffer and an executor reading it are separated by a fence. Absence
of a fence means the authority MUST assume the buffer is not ready.

### P-3 — A path may be slow, never dishonest

A slow path may drop a still. It may not present an old still as new, present a
different format as declared, or omit a contribution without recording it.

### P-4 — Remote is a peer, not a subordinate

A remote executor may refuse a still (codec, bandwidth, colour). The authority must
handle refusal as a first-class outcome, not as packet loss.

### P-5 — Headless is not invisible

Headless stills are observable by capture and test. They obey the same numbering and
history rules as panel stills.

---

## 6. Acceptance

- **AC-ARCH-PATHS-001** — For each of the six paths, a conformance harness submits the
  same commit and asserts the same still facts (pixels hash, hit map, a11y snapshot,
  input owner, buffer release). Differences are allowed only in observations, never in
  truth.
- **AC-ARCH-PATHS-002** — Forced-failure matrix: for each path and each M cell, inject a
  failure and assert the still is either rejected or explicitly degraded, with a reason.
- **AC-ARCH-PATHS-003** — Mixed-path still: plane + GPU + CPU + remote in one still,
  assert one number, one fence, one hit map, one accessibility order.

The full completed matrix with per-envelope values is in
`ecosystem/envelopes/README.md`.
