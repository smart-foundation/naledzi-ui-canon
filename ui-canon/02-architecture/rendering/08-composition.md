---
id: ARCH-REND-COMPOSITION
title: Composition
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-COMP-001, AC-REND-COMP-002]
---

# Composition

> Planes, blending, occlusion, colour spaces, HDR. Composition is an executor
> concern, not a policy concern. Policy produces a plan; the executor composites.

---

## 1. Composition is executor concern

Policy produces a plan (total order, geometry, focus). The executor composites
surfaces into one output per that plan. The authority owns the truth of what is
composed; the executor owns the pixels. No second scene graph (`01-model.md`
§7).

---

## 2. Planes

Hardware planes (`framebuffer.capnp`: Plane, FramebufferCaps.maxPlanes,
maxBlendPlanes) are positioned/scaled/composited by the display controller.
When planes are insufficient, the executor falls back to GPU/CPU composition.

---

## 3. Blending and occlusion

Blending follows declared opacity and material (`surface.capnp`: setOpacity,
SurfaceMaterial, ShadowShape). Occlusion is a fact of the depth model, not a
z-order accident (`CANON-GLOSSARY`: occlusion). The plan's total order
determines occlusion; the executor does not reorder.

---

## 4. Colour spaces and HDR

Colour space is declared per output (`display.capnp`: colorProfileId, hdr,
DisplayMode). HDR metadata is declared (`compositor` HdrMetadata). The executor
applies the declared profile; it does not infer from pixel values
(`LAW-003` generalized).

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-REND-COMP-001` | Executor composites per the plan's total order; no reordering. |
| `AC-REND-COMP-002` | HDR content uses declared HDR metadata. |

---

## 6. References

See `13-references.md`.