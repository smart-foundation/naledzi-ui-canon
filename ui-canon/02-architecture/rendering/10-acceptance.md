---
id: ARCH-REND-ACCEPTANCE
title: Rendering Acceptance
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-REND-000]
---

# Rendering Acceptance

> AC index for the rendering branch.

---

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-REND-000` | Branch coverage complete. |
| `AC-REND-PATH-001` | Same scene renders correctly on all six paths within budget. |
| `AC-REND-PATH-002` | Path selection recorded in still history as observation. |
| `AC-REND-PATH-003` | Failed path produces typed rejection or declared degradation. |
| `AC-REND-DAMAGE-001` | Renderer touches only declared damaged regions. |
| `AC-REND-DAMAGE-002` | No pixel readback for damage discovery. |
| `AC-REND-DAMAGE-003` | Full-surface fallback produces correct frame. |
| `AC-REND-BUF-001` | Every buffer declares usage. |
| `AC-REND-BUF-002` | No raw pointer crosses boundary in buffer handle. |
| `AC-REND-BUF-003` | Format mismatch rejected. |
| `AC-REND-FENCE-001` | No read before acquire fence signals. |
| `AC-REND-FENCE-002` | Timeout recorded as failure, not release. |
| `AC-REND-FENCE-003` | Fence propagation typed. |
| `AC-REND-ZC-001` | Zero-copy only when all conditions hold. |
| `AC-REND-ZC-002` | Every copy declared with reason. |
| `AC-REND-ZC-003` | No silent copy. |
| `AC-REND-GPU-001` | GPU uses declared colour profile. |
| `AC-REND-GPU-002` | GPU failure falls back per ladder. |
| `AC-REND-GPU-003` | Atomic test precedes atomic commit. |
| `AC-REND-CPU-001` | CPU path meets p95 on weakest envelope. |
| `AC-REND-CPU-002` | CPU applies declared colour profile. |
| `AC-REND-COMP-001` | Executor composites per plan total order. |
| `AC-REND-COMP-002` | HDR uses declared metadata. |
| `AC-REND-DEG-001` | Degradation follows ladder; correctness never given up. |
| `AC-REND-DEG-002` | Safety indicators never degrade. |
| `AC-REND-DEG-003` | Degraded stills recorded as degraded. |

---

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-REND-000` | Branch coverage complete. |

---

## 3. Open questions

See `11-open-questions.md`.

---

## 4. References

See `13-references.md`.