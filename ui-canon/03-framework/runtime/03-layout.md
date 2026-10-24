---
id: FW-RUNTIME-LAYOUT
title: "Layout: constraints, flex, intrinsic sizing, overflow, density, text scale, RTL, safe areas"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, FOUND-DEPTH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-LAYOUT-001]
---

# Layout

> MirUI provides flex layout only. The framework composes grids from nested flex rows and
> owns RTL mirroring, density and text-scale adaptation. No third layout engine.

---

## 1. Constraints

A layout is a function from available space to placed rects. Inputs: parent size, min/max
constraints, density, text scale, safe-area insets, direction (LTR/RTL). Outputs: rects
for every node.

- FW-LAYOUT-001. Layout MUST be pure: same inputs -> same rects. No global state.
- FW-LAYOUT-002. A node declares its constraints (min/max width/height, grow, shrink,
  padding, gap) via `LayoutStyle` (`src/ui/layout/node.rs:48`–`67`).
- FW-LAYOUT-003. Intrinsic sizing (content size) MUST be computed before flex distribution;
  flex distributes leftover space according to grow/shrink and basis.

## 2. Flex

MirUI flex supports: direction (row/column), wrap, justify, align, padding, gap, width/height
min/max, grow, shrink, position (flex/absolute), left/top
(`src/ui/layout/node.rs:1`–`46`).

- FW-LAYOUT-004. The framework MUST NOT add a grid primitive to MirUI. Grid-like layouts
  compose nested flex rows with declared tracks, or an app-owned pass (FW-Q-003).
- FW-LAYOUT-005. Nested scrolling on the same axis is forbidden (`../README.md` §7.6).
- FW-LAYOUT-006. Scroll model is declared per container: none, vertical, horizontal,
  two-axis, paged.

## 3. Intrinsic sizing

- Text nodes report their shaped size at the current scale and wrap width.
- Images report their decoded size (or a declared placeholder).
- Containers report the aggregate of children subject to padding/gap.
- FW-LAYOUT-007. A node with `grow > 0` may exceed its intrinsic size; a node with
  `shrink > 0` may be reduced to its min. Clipping is declared, not implicit.

## 4. Overflow

- FW-LAYOUT-008. Overflow behaviour is declared per container: clip, scroll, wrap, or
  ellipsis (text). Silent clipping is a defect.
- FW-LAYOUT-009. At 200% text, containers reflow; the interface is not a scaled screenshot.
- FW-LAYOUT-010. Long content: declared truncation, wrapping or scrolling; full value reachable
  via tooltip/expand/scroll (cross-cutting state vocabulary).

## 5. Density

Compact/comfortable/spacious change spacing, type rhythm and secondary-action visibility.
They never hide a primary action or change information architecture
(`../05-apps/_standard/01-anatomy.md` §5).

- FW-LAYOUT-011. Density is per window, not per app globally, and changes without restart.
- FW-LAYOUT-012. Density tokens are resolved through `tokens/` (`TOK-SPACE-*`,
  `TOK-TYPE-*`).

## 6. Text scale (200%)

- FW-LAYOUT-013. Text scale multiplies base type sizes; containers reflow. Target sizes and
  focus indicators scale with text where they are text-derived.
- FW-LAYOUT-014. No clipping at 200% for any required content or control.

## 7. RTL

MirUI has no layout-level RTL mirroring (`src/ui/layout/node.rs:48`–`67`: `left`/`top`
only). The framework owns an RTL adaptation pass:

- FW-LAYOUT-015. The pass mirrors: flex direction (row -> row-reverse where semantic),
  alignment, padding/insets, gesture directions, scroll direction, focus order.
- FW-LAYOUT-016. Icons with intrinsic direction (arrows, back) are mirrored; symmetric icons
  are not.
- FW-LAYOUT-017. Text-level bidi is handled by MirUI's `TextDirection` and shaping
  (`src/ui/widgets/text.rs:51`).
- FW-LAYOUT-018. The RTL pass MUST be measured; cost recorded (FW-Q-003).

## 8. Non-rectangular safe areas

- Displays may be circular, folded, notched, or have gesture zones. Safe-area insets come
  from `display.capnp`.
- FW-LAYOUT-019. Content MUST NOT be placed in unsafe regions; system chrome (status rail,
  strip) owns protected zones.
- FW-LAYOUT-020. Foldables: content reflows across the fold; no content is lost behind the
  hinge (adaptivity/04).
- FW-LAYOUT-021. Spatial/non-rectangular: layout uses the declared usable region polygon,
  not the bounding box.

## 9. Safe areas and system insets

- Insets (status rail, strip, notches, home indicator) are inputs to layout, not magic
  numbers.
- FW-LAYOUT-022. An app never hardcodes inset values; it reads them from the envelope's
  layout context.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-LAYOUT-001` | The same component tree reflows correctly at compact/comfortable/spacious, LTR/RTL, 100%/200% text, and on a circular display (golden stills). |
| `AC-FW-LAYOUT-002` | No hidden clipping at 200% text for required content. |
| `AC-FW-LAYOUT-003` | RTL golden flow passes review. |