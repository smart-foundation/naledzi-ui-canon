---
id: ARCH-REND-REFERENCES
title: References
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-REND-046]
---

# References

## Sources

1. `ADR-0014` GPU and CPU are paths of one model.
2. Wayland protocol. https://wayland.freedesktop.org/docs/html/ — accessed 23 October 2026.
3. Android SurfaceFlinger. https://source.android.com/docs/core/graphics/architecture — accessed 23 October 2026.
4. Vulkan specification. https://www.khronos.org/vulkan/ — accessed 23 October 2026.
5. Linux DRM/KMS and DMA-BUF. https://docs.kernel.org/driver-api/dma-buf.html — accessed 23 October 2026.
6. Cap'n Proto. https://capnproto.org/ — accessed 23 October 2026.

## Schema citations

- `framebuffer.capnp:248-266` AtomicRejection
- `framebuffer.capnp` FramebufferService, FramebufferCaps, Plane, AtomicTestResult
- `gpu.capnp` GpuProvider, Gpu3DProvider, BufferUsage, BufferDesc, GpuBuffer, ShaderModule, CommandBuffer, SurfacePresent, GpuCapabilities, GpuFenceId
- `display.capnp:267-376` validity flags
- `surface.capnp` DamageOption, PresentIntent, SyncFence, FrameData
- `compositor.capnp:529-541` SurfaceCommit
- `compositor.capnp:543-554` DamageOption

## Limits

- Performance numbers are envelope-specific; see performance branch.

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-REND-046` | Every cited source has author, title, year, URL, access date. |