---
id: ARCH-PRESENT-EXECUTOR
title: The Executor
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-002, AC-REND-PATH-001]
---

# The Executor

> The executor is the replaceable component that makes a still visible: direct
> scanout, hardware plane, GPU blit, CPU fallback, remote encode, or headless
> sink. It produces pixels, never truth. All paths are one model.

---

## 1. What the executor is

The executor owns **realization**. It receives a plan and a set of buffer handles
and MUST either realize the still exactly as declared or reject with a typed
reason. It MUST NOT silently change format, colour, scale, order, or timing. If
it cannot realize a still, it reports `AtomicRejection` semantics
(`framebuffer.capnp:248-266`) or the path-specific equivalent; it does not
approximate without declaring degradation.

The executor is replaceable: a CPU rasterizer and a scanout engine are
interchangeable if both satisfy the same acceptance (`ADR-0014`).

---

## 2. The six paths

| Path | What it does | When chosen |
|---|---|---|
| Scanout | presents a buffer directly to a display controller without composition | single full-screen surface, format matches panel |
| Plane | hardware layer positioned/scaled/composited by the display controller | multi-surface with hardware plane support |
| GPU blit | GPU copy/scale of pixels between buffers | composition needed, GPU available |
| CPU | software rasterization/composition | no GPU, or GPU path failed |
| Remote encoder | encodes the still for a remote peer | remote output |
| Headless sink | discards or records pixels | no panel (IoT, testing, capture) |

All six are paths of the same model: same damage, fence, and still semantics
(`rendering/01-paths.md`).

---

## 3. Executor contract

The executor MUST:

- realize the still exactly as declared (pixels, damage, transform, ordering);
- honour the fence: not read a buffer before it is safe;
- report realization success/failure with evidence;
- release buffers per the fence and buffer lifetime rules;
- not be the authority for any fact (`01-model.md` INV-3).

The executor MUST NOT:

- reorder surfaces because it thinks it knows better;
- change format or colour space silently;
- report success before the authority has a still record;
- read a pixel buffer without a capability.

---

## 4. Executor crash

If the executor crashes, the still and the authority remain intact
(`AC-ARCH-PRESENT-002`). A new executor can take over; the authority provides
the current still number and plan. The screen may go blank briefly, but the
truth is preserved.

---

## 5. Executor and observation

Observation (thumbnails, capture, remote) is executor-mediated but
capability-gated by the authority (`10-observation.md`). The executor performs
the read; the authority decides who may observe.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-002` | A kill of the executor leaves the still and the authority intact. |
| `AC-REND-PATH-001` | The same scene renders correctly on all six paths within budget. |
| `AC-ARCH-PRESENT-020` | An executor that cannot realize a still returns a typed rejection; it does not approximate. |
| `AC-ARCH-PRESENT-021` | An executor crash does not invalidate the current still number. |

---

## 7. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-EXEC-001` | What is the executor re-attachment protocol after a crash (state transfer)? | Architecture Editor | proposed |

---

## 8. References

- Android SurfaceFlinger. https://source.android.com/docs/core/graphics/architecture
- Vulkan, DRM/KMS, DMA-BUF. https://www.khronos.org/vulkan/