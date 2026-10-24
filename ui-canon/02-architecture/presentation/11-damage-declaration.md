---
id: ARCH-PRESENT-DAMAGE
title: Damage Declaration
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-COMMIT]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-033, AC-ARCH-PRESENT-034]
---

# Damage Declaration

> Damage is declared, never detected. The producer declares what changed; the
> system never diffs frames. Declared damage is merged; full-surface fallback is
> legal; never diff.

---

## 1. Why declared

`LAW-003`: the producer declares what changed. The system MUST NOT compare two
frames, scan pixels, or infer damage at runtime. Diffing is a hidden cost that
scales with screen size and burns cycles to rediscover what the producer
already knew. An app that cannot track damage declares the whole surface —
correct, just more pixel work. The receiver never guesses.

---

## 2. The DamageOption union

`compositor.capnp:543-554` and `surface.capnp` DamageOption:

- `omitted @0 :Void` — no hint; authority applies the surface's declared
  default (full surface) and records that the producer did not track damage.
- `full @1 :Void` — entire surface damaged.
- `rects @2 :List(T.Rect)` — the changed rectangles.
- `custom @3 :Data` — opaque backend-specific damage blob (contract gap:
  unauditable; recorded as `OQ-COMMIT-002`).

---

## 3. Merging

When multiple commits target the same surface within one present cycle, their
damage rects are unioned into one damage region. Merging is a union of
rectangles, not a re-scan. The merged region is recorded in the still
(`FrameData.committedDamage :T.Region`, `surface.capnp` FrameData struct).

---

## 4. Full-surface fallback

An app that cannot track damage declares `full`. This is correct behaviour, not
a failure. The system does more pixel work but the truth is identical. No app
is required to track damage; tracking is an optimisation with a declared cost.

---

## 5. Bounds check

Declared rects MUST lie within the surface bounds; otherwise the commit is
rejected (`damage-out-of-bounds`, `07-rejections.md`). The authority checks
bounds; it does not clamp or extend.

---

## 6. Never diff

There is no frame-to-frame comparison anywhere in the pipeline. Instrumented
builds assert zero pixel reads for damage discovery. A "damage tracker" that
reads the buffer is a defect (`01-model.md` §7).

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-033` | No code path diffs two frames to discover damage; instrumented builds assert zero. |
| `AC-ARCH-PRESENT-034` | An app declaring `full` produces a correct still with more pixel work. |
| `AC-ARCH-PRESENT-035` | Out-of-bounds damage rects are rejected by name. |
| `AC-ARCH-PRESENT-036` | Merged damage equals the union of declared rects. |

---

## 8. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-DAMAGE-001` | Should damage rects be allowed to overlap, or must the producer merge? | Architecture Editor | proposed |

---

## 9. References

- Wayland, `wl_surface.damage`. https://wayland.freedesktop.org/docs/html/
- Android SurfaceFlinger, dirty regions. https://source.android.com/docs/core/graphics/architecture