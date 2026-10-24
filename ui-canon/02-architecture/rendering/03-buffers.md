---
id: ARCH-REND-BUFFERS
title: Buffers
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-BUF-001, AC-REND-BUF-002]
---

# Buffers

> Capabilities, format, modifiers, stride, tiling, lifetime. No raw pointers.
> Buffers are capabilities; the producer owns the buffer; the consumer gets a
> scoped right.

---

## 1. Buffer capabilities

A buffer's usage is declared via `BufferUsage` (`gpu.capnp` BufferUsage enum):
`scanout`, `shaderRead`, `shaderWrite`, `transferSrc`, `transferDst`,
`hostVisible`, `hostCoherent`, `renderTarget`, `depthStencil`, `linear`,
`tiled`, `protected`, plus `other`/`custom`. Usage is a list, not a bitfield,
so consumers pattern-match. A buffer allocated for scanout must declare
`scanout`; a buffer the CPU maps must declare `hostVisible`.

---

## 2. Format

Format is `T.PixelFormat` (types.capnp). The commit declares the format the
producer wrote (`compositor.capnp:533` `format :T.PixelFormat`); the authority
verifies it matches the buffer's negotiated format. GPU-supported formats are
reported by the driver via `GpuCapabilities.supportedFormats`
(`gpu.capnp` GpuCapabilities struct). Format negotiation is first-class; no
format is assumed.

---

## 3. Modifiers, stride, tiling

- Modifier: `BufferDesc.modifier :UInt64` (`gpu.capnp`), Linux
  DRM_FORMAT_MOD_* equivalent; 0 = linear.
- Width/height: `BufferDesc.width/height`.
- Size: `BufferDesc.sizeBytes`, `GpuBuffer.allocatedBytes` (may be larger due
  to alignment).
- Tiling: `BufferUsage.linear` / `tiled`; `GpuCapabilities.supportsTiling`.

Stride is implied by format × width × modifier and is negotiated per buffer; it
is not a global constant. The contract forbids baking a specific format's byte
layout — drivers decide (`gpu.capnp` header).

---

## 4. Lifetime

See `presentation/13-buffer-lifetime.md` for the full state machine (free →
writing → committed → acquired → displayed → released → revoked). Rendering
consumes buffers in `acquired`/`displayed` states and releases via fence.

---

## 5. No raw pointers

Buffers cross the contract boundary as handles: `T.BufferId`, `T.FenceHandle`,
`T.MappedRegionId`, `T.DataHandle`, `GpuBufferId`, `GpuBuffer.dmaBufFd`
(optional DMA-BUF fd; 0 = not shareable). A consumer with a handle has a
scoped right, not an address (`LAW-002`). `GpuBuffer.mappedRegion` is a typed
region id, not a pointer.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-REND-BUF-001` | Every buffer declares usage; scanout buffers declare scanout. |
| `AC-REND-BUF-002` | No raw pointer crosses a contract boundary in a buffer handle. |
| `AC-REND-BUF-003` | Format mismatch between commit and buffer is rejected. |

---

## 7. References

See `13-references.md`.