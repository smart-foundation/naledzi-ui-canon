---
id: ARCH-REND-GPU
title: GPU
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-GPU-001, AC-REND-GPU-002]
---

# GPU

> Command submission, shaders, colour management, fallback. Vulkan/DRM/KMS/
> DMA-BUF. The contract is vendor-agnostic; backends implement it.

---

## 1. Contract

The GPU contract is `gpu.capnp`: `GpuProvider` interface, `Gpu3DProvider`
extends it. Naledzi does not embed vendor APIs (Vulkan, Metal, OpenGL,
D3D12, CUDA). Vendors change; the contract is durable (`gpu.capnp` header).

Key methods: `getCapabilities`, `allocateBuffer`, `freeBuffer`, `mapHost`,
`unmapHost`, `createTexture`, `destroyTexture`, `createShader`,
`destroyShader`, `createCommandPool`, `destroyCommandPool`,
`submitCommandBuffer`, `createFence`, `destroyFence`, `waitFence`,
`createSurface`, `destroySurface`, `presentToSurface`, `vendorCommand`.

---

## 2. Command submission

Commands are submitted as `CommandBuffer` (`gpu.capnp`): `opcodes :Data`,
`signalFence :GpuFenceId`, `referencedBuffers :List(GpuBufferId)`. The driver
interprets opcodes; the contract is agnostic. Submission returns `SubmitResult`
with `success`, `error`, `submittedFence`. Async submit is capability-reported
(`GpuCapabilities.supportsAsyncSubmit`).

---

## 3. Shaders

Shaders are `ShaderModule` (`gpu.capnp`): `id`, `entryPoint`, `vendorBinary`,
`vendor`. The binary is vendor-specific (Intel Gen, AMD GCN/RDNA, NVIDIA
SASS, SPIR-V via translation). Consumers compile their own source; the contract
carries opaque blobs. `Gpu3DProvider.uploadShader` accepts `(stage, source)`
and returns a `CompiledShader`.

---

## 4. Colour management

Colour space is declared, never inferred from pixels (`01-model.md` §3).
`Monitor.colorProfileId`, `Monitor.hdr`, adaptive sync, night light, and
`HdrMetadata` (compositor) carry colour facts. The GPU applies the declared
colour profile; it does not guess. HDR content uses declared HDR metadata.

---

## 5. Fallback

If the GPU path fails (device loss, format unsupported, driver crash), the
executor falls back per the degradation ladder (`09-degradation.md`) to CPU or
scanout. Fallback is declared in the still history as an observation with
reason. No silent approximation.

---

## 6. DRM/KMS/DMA-BUF

Framebuffer service (`framebuffer.capnp`): `FramebufferService` with `list`,
`get`, `getCrtc`, `capabilities`, `testAtomic`, `commitAtomic`, `getPlane`,
`listPlanes`. Atomic test/commit pattern: test before commit. `AtomicTestResult`
with `AtomicRejection` list. Planes are hardware layers with
`FramebufferCaps` (maxPlanes, atomicTest, maxFramebuffers, gpuPassthrough,
adaptiveSync, virtual, maxBlendPlanes, subpixelLayout).

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-REND-GPU-001` | GPU path uses declared colour profile; no inference from pixels. |
| `AC-REND-GPU-002` | GPU failure falls back per ladder; fallback declared. |
| `AC-REND-GPU-003` | Atomic test precedes atomic commit. |

---

## 8. References

See `13-references.md`.<|end|><|start|>write to=assistant<|channel|>analysis<|message|>Created file successfully: naledzi/docs/ui-canon/02-architecture/rendering/06-gpu.md