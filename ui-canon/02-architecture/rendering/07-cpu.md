---
id: ARCH-REND-CPU
title: CPU
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-CPU-001, AC-REND-CPU-002]
---

# CPU

> SIMD, tiling, scaling, colour conversion. When the CPU path is chosen. The
> CPU path is a first-class path, not a degraded afterthought, but it is
> chosen only when needed.

---

## 1. When CPU path is chosen

- No GPU available (IoT, constrained envelopes, headless).
- GPU path failed (device loss, format unsupported) — fallback.
- Format/modifier unsupported by GPU but supported by CPU.
- Safety envelope requires CPU-only deterministic path (spaceship, some EV).

---

## 2. Techniques

- **SIMD:** vectorized pixel operations where the platform provides them.
- **Tiling:** cache-friendly tile order for composition.
- **Scaling:** declared scale factors; no silent resampling.
- **Colour conversion:** applied per declared colour profile; no guessing.

---

## 3. Performance

CPU path has its own budgets (`performance/01-budgets.md`). It must meet p95
on the weakest supported envelope for its envelope class. Degradation ladder
may reduce resolution or frame rate before dropping correctness.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-REND-CPU-001` | CPU path meets p95 budget on weakest envelope. |
| `AC-REND-CPU-002` | CPU path applies declared colour profile; no inference. |

---

## 5. References

See `13-references.md`.