---
id: ARCH-REND-DAMAGE
title: Damage (Rendering)
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX, ARCH-PRESENT-DAMAGE]
supersedes: []
superseded_by: []
acceptance: [AC-REND-DAMAGE-001, AC-REND-DAMAGE-002]
---

# Damage (Rendering)

> Declared damage, merging, bounds, full-surface fallback. Never diff frames.
> Rendering consumes the declaration; it never detects.

---

## 1. Rendering consumes declarations

The renderer never discovers damage. It receives the declared `DamageOption`
from the commit and touches only those regions. If damage is `omitted`, the
renderer treats the whole surface as damaged (full-surface fallback) and records
that the producer did not track damage.

---

## 2. Merging at render time

When multiple commits target the same surface within one present cycle, their
damage rects are unioned. The renderer composites the union. Merging is a
rectangle union, not a re-scan. `FrameData.committedDamage` records the merged
region (`surface.capnp` FrameData struct).

---

## 3. Bounds

Damage rects outside surface bounds are rejected before rendering
(`presentation/07-rejections.md`). The renderer assumes all rects it receives
are in-bounds.

---

## 4. Full-surface fallback

`full` damage means the entire surface is repainted. This is legal and correct;
it costs more pixel work. The degradation ladder may prefer full-surface
commits on constrained envelopes if partial damage tracking is unavailable.

---

## 5. Never diff

No frame-to-frame comparison, no pixel readback, no heuristic scan. Instrumented
builds assert zero pixel reads for damage discovery (`LAW-003`,
`AC-ARCH-PRESENT-033`).

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-REND-DAMAGE-001` | Renderer touches only declared damaged regions. |
| `AC-REND-DAMAGE-002` | No pixel readback occurs for damage discovery. |
| `AC-REND-DAMAGE-003` | Full-surface fallback produces a correct frame. |

---

## 7. References

See `13-references.md`.