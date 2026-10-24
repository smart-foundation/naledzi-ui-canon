---
id: FW-RUNTIME-DAMAGE
title: "Damage: declared damage, invalidation, merging, full-surface fallback, zero readback"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-DAMAGE-001]
---

# Damage

> Declared, not detected (LAW-003). The producer declares what changed; the system never
> diffs frames, never scans pixels, never readbacks.

---

## 1. Declared damage

- FW-DAMAGE-001. Every component that changes its visual output MUST mark its own damage
  rect(s) in the same frame the change is committed.
- FW-DAMAGE-002. A parent style change (theme swap, viewport resize) MUST call
  `mark_subtree_dirty` to flag all descendants; per-entity damage is not inherited
  (`src/ui/dirty.rs:1`–`8`).
- FW-DAMAGE-003. An animation marks damage for the region it affects each frame; when settled
  it stops (LAW-004).

## 2. Invalidation

- FW-DAMAGE-004. Invalidation is explicit: a component sets a `Dirty` component or calls
  the world's mark helpers. There is no implicit invalidation from reads.
- FW-DAMAGE-005. Layout changes invalidate the layout pass for the affected subtree; the
  damage rect is the union of old and new rects.
- FW-DAMAGE-006. A component that cannot track its damage precisely declares the whole
  surface — correct, just more pixel work (LAW-003).

## 3. Merging

- FW-DAMAGE-007. Damage rects from one frame are merged into a minimal set of
  non-overlapping rects before commit, to reduce flush calls.
- FW-DAMAGE-008. Merging MUST NOT discard a region; correctness over compactness.
- FW-DAMAGE-009. Overlapping rects merge; disjoint rects remain separate (better for
  partial flush on tiled displays).

## 4. Full-surface fallback

- FW-DAMAGE-010. When damage tracking is unavailable or unreliable for a surface, the
  component declares the full surface. This is honest and allowed.
- FW-DAMAGE-011. Full-surface fallback MUST be recorded (metric) so regressions are visible.
- FW-DAMAGE-012. A full-surface fallback on every frame is a defect (idle silence violation).

## 5. Zero readback

- FW-DAMAGE-013. No pixel readback in the production path. `dirty_rect` in
  `src/render/partial.rs:5` compares two framebuffers and is diagnostic/verification only.
- FW-DAMAGE-014. No frame-to-frame comparison in production. Instrumentation that detects
  one fails the build (LAW-003 test).
- FW-DAMAGE-015. Remote outputs receive declared damage rects, not diffs (LAW-017).

## 6. Commit

- FW-DAMAGE-016. Damage rects travel in `FrameSubmission.damage` across the adapter. The
  authority numbers the resulting still (LAW-005).
- FW-DAMAGE-017. Pixels, hit map, accessibility snapshot, input ownership and buffer
  lifetimes commit as one versioned fact.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-DAMAGE-001` | Instrumentation shows zero frame-to-frame pixel comparisons and zero readbacks in the production path. |
| `AC-FW-DAMAGE-002` | A component that changes state produces a damage rect covering exactly its visual region (golden). |
| `AC-FW-DAMAGE-003` | Full-surface fallback is recorded and not used as default. |