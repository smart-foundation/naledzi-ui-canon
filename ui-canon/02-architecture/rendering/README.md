---
id: ARCH-REND-INDEX
title: Rendering
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-REND-000]
children:
  - 01-paths.md
  - 02-damage.md
  - 03-buffers.md
  - 04-fences.md
  - 05-zero-copy.md
  - 06-gpu.md
  - 07-cpu.md
  - 08-composition.md
  - 09-degradation.md
  - 10-acceptance.md
  - 11-open-questions.md
  - 12-changelog.md
  - 13-references.md
---

# Rendering

> How declared content becomes pixels on each path, and what is never assumed.
> GPU and CPU are paths of one model (`ADR-0014`). Composition is an executor
> concern, not a policy concern.

**Scope:** paths, damage, buffers, fences, zero-copy, GPU, CPU, composition,
degradation.

**Non-goals:** presentation truth (presentation/), protocol fields (protocol/),
component anatomy (03-framework/).

---

## 1. The single question

> How does declared content become pixels on each path, and what is never
> assumed?

---

## 2. The paths

Scanout, plane, GPU blit, CPU, remote, headless — all one model, selected per
case. Every path honours damage, fences, and still semantics.

---

## 3. Directory map

| File | Question |
|---|---|
| `01-paths.md` | scanout, plane, GPU blit, CPU, remote, headless |
| `02-damage.md` | declared damage, merging, bounds, full-surface fallback |
| `03-buffers.md` | capabilities, format, modifiers, stride, tiling, lifetime |
| `04-fences.md` | acquire/release, implicit vs explicit, timeouts, propagation |
| `05-zero-copy.md` | when legal; format/domain/coherence/security; declared copies |
| `06-gpu.md` | command submission, shaders, colour management, fallback |
| `07-cpu.md` | SIMD, tiling, scaling, colour conversion |
| `08-composition.md` | planes, blending, occlusion, colour spaces, HDR |
| `09-degradation.md` | ordered ladder; correctness first |
| `10-acceptance.md` | AC index |
| `11-open-questions.md` | unresolved |
| `12-changelog.md` | creation record |
| `13-references.md` | evidence |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-REND-000` | Every file listed in children exists; no TODO or empty section. |

---

## 5. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `protocol/schemas/framebuffer.capnp`, `gpu.capnp`,
  `display.capnp`, `surface.capnp`.
- Children: see children above.