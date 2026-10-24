---
id: ARCH-REND-ZEROCOPY
title: Zero-Copy
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-ZC-001, AC-REND-ZC-002]
---

# Zero-Copy

> When legal; format/domain/coherence/security. Declared copies; no silent
> copies. Zero-copy is a per-case optimality, not a promise.

---

## 1. When legal

Zero-copy is legal only when all of the following hold:

- **Format:** producer and consumer agree on the pixel format (no conversion).
- **Domain:** buffer is shareable across the domain boundary (DMA-BUF fd
  nonzero, `GpuBuffer.dmaBufFd`; shm region for host).
- **Coherence:** cache coherence is guaranteed (hostCoherent usage) or
  explicit sync is performed.
- **Security:** capability scope permits the consumer to read the buffer.

If any fails, a declared copy is made. The copy is declared in the still history
as an observation (format, size, reason).

---

## 2. Declared copies

A copy is never silent. When the renderer copies, it records: source buffer,
destination buffer, format, size, and the reason zero-copy was illegal. This
makes performance regressions visible and auditable.

---

## 3. No silent copies

An implementation that copies without recording it is a defect. Instrumented
builds assert that every copy has a declared reason. `LAW-002` (pixels never
cross a boundary) is upheld because even copies stay within capability-scoped
handles.

---

## 4. Across devices

Zero-copy across devices is usually impossible; see
`ecosystem/10-zero-copy-across-devices.md` for declared copies, compression,
and colour handling.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-REND-ZC-001` | Zero-copy is used only when format/domain/coherence/security all hold. |
| `AC-REND-ZC-002` | Every copy is declared with reason in still history. |
| `AC-REND-ZC-003` | No silent copy exists; instrumented builds detect. |

---

## 6. References

See `13-references.md`.