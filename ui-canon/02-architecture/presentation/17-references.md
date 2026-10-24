---
id: ARCH-PRESENT-REFERENCES
title: References
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-046]
---

# References

> Evidence with limits for the presentation branch.

---

## Sources

1. Dennis, J. B. & Van Horn, E. C. (1966). *Programming semantics for
   multiprogrammed computations.* Communications of the ACM, 9(3), 143–155.
   https://dl.acm.org/doi/10.1145/365230.365252 — accessed 23 October 2026.
   Capability-based security foundation. Limits: theoretical; no UI-specific
   measurement.

2. Miller, M. S. (2006). *Robust Composition: Towards a Unified Approach to
   Access Control and Concurrency Control.* PhD thesis, Johns Hopkins University.
   https://www.erights.org/talks/thesis/ — accessed 23 October 2026.
   Capability semantics and confinement. Limits: thesis; not peer-reviewed in
   full.

3. Wayland protocol documentation. https://wayland.freedesktop.org/docs/html/
   — accessed 23 October 2026. Atomic commits, buffer management, frame
   callbacks. Limits: Linux-only; not a cross-platform contract.

4. Android SurfaceFlinger architecture. https://source.android.com/docs/core/graphics/architecture
   — accessed 23 October 2026. Buffer lifecycle and composition. Limits:
   Android-specific; not a contract.

5. iOS Core Animation. https://developer.apple.com/documentation/quartzcore
   — accessed 23 October 2026. Layer tree and rendering. Limits: proprietary.

6. Lamport, L. (1978). *Time, clocks, and the ordering of events in a
   distributed system.* Communications of the ACM. https://dl.acm.org/doi/10.1145/359545.359563
   — accessed 23 October 2026. Distributed ordering. Limits: theoretical.

7. Cap'n Proto documentation. https://capnproto.org/ — accessed 23 October 2026.
   Schema evolution and ordinals. Limits: implementation docs, not a standard.

8. Vulkan specification. https://www.khronos.org/vulkan/ — accessed 23 October 2026.
   GPU contract concepts. Limits: graphics-focused.

9. Linux DMA-BUF documentation. https://docs.kernel.org/driver-api/dma-buf.html
   — accessed 23 October 2026. Zero-copy buffer sharing. Limits: Linux kernel.

10. NHTSA driver distraction guidelines. https://www.nhtsa.gov/ — accessed
    23 October 2026. Safety-envelope input. Limits: automotive-specific.

---

## 2. Schema citations used

- `compositor.capnp:529-541` SurfaceCommit
- `compositor.capnp:543-554` DamageOption
- `compositor.capnp:564-571` PresentIntent
- `compositor.capnp:572-577` SyncFence
- `compositor.capnp:46-62` HandshakeRequest/Response
- `surface.capnp` FrameSubmission, PresentIntent, SyncFence
- `surface.capnp:168-171` T.FenceHandle
- `surface.capnp:323-336` input/hit region
- `framebuffer.capnp:248-266` AtomicRejection
- `display.capnp:267-376` validity flags
- `gpu.capnp` BufferUsage, BufferDesc, GpuBuffer, GpuProvider

---

## 3. Limits

- Evidence for atomicity and numbered truth is drawn from prior art and
  capability theory; no controlled study of Naledzi-specific outcomes exists.
- Schema citations are to the current repo state; schema changes require
  updates here.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-046` | Every cited source has author, title, year, URL, access date. |

---

## References

Self (this file is the reference list).