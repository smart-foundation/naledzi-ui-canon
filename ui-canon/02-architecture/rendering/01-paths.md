---
id: ARCH-REND-PATHS
title: Rendering Paths
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-PATH-001, AC-REND-PATH-002]
---

# Rendering Paths

> Scanout, plane, GPU blit, CPU, remote, headless: same model, per-case
> selection. Every path honours damage, fences, and still semantics.

---

## 1. The six paths

| Path | Mechanism | Selection criteria |
|---|---|---|
| Scanout | buffer handed to display controller directly | single full-screen surface; format matches panel; no composition |
| Plane | hardware plane positioned/scaled/composited by controller | multi-surface with hardware plane support; format/modifier supported |
| GPU blit | GPU copy/scale between buffers | composition needed; GPU available; format supported |
| CPU | software rasterization/composition | no GPU, or GPU path failed, or format unsupported |
| Remote | encode + transport to remote peer | remote output target |
| Headless | discard or record pixels | no panel (IoT, testing, capture) |

All are paths of one model (`ADR-0014`). The degradation ladder (`09-degradation.md`)
selects among them when the preferred path is unavailable.

---

## 2. Per-case selection

Selection is per commit, per surface, per output. The executor evaluates, in
order:

1. Is scanout legal (single surface, format match, no composition)? If yes,
   scanout.
2. Are hardware planes available and formats supported? If yes, plane.
3. Is a GPU available with the required format/modifier? If yes, GPU blit.
4. Otherwise, CPU.
5. If the target is remote, remote path (wraps one of the above for encoding).
6. If no panel, headless.

The selection is recorded in the still history as an observation
(`01-model.md` §4 observation fact) with timestamp and validity.

---

## 3. Same semantics on every path

Every path honours:

- damage (only damaged regions are touched);
- fences (no read before safe);
- still numbering (the executor does not number);
- buffer lifetime (release via fence);
- transform (declared orientation).

A path that cannot satisfy one of these is not an architecture path; it is an
experiment and MUST NOT ship (`01-model.md` §5).

---

## 4. Fallback

Fallback is declared, not silent. When a path fails, the executor reports a
typed rejection or a declared degradation; it does not approximate. The
degradation ladder (`09-degradation.md`) orders what is given up first.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-REND-PATH-001` | Same scene renders correctly on all six paths within budget. |
| `AC-REND-PATH-002` | Path selection is recorded in still history as an observation. |
| `AC-REND-PATH-003` | A failed path produces a typed rejection or declared degradation, not a silent approximation. |

---

## 6. Open questions

See `11-open-questions.md`.

---

## 7. References

- `ADR-0014` GPU and CPU paths of one model.
- Android SurfaceFlinger. https://source.android.com/docs/core/graphics/architecture
- Wayland. https://wayland.freedesktop.org/docs/html/