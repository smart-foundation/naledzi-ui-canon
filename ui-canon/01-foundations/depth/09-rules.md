---
id: FOUND-DEPTH-RULES-09
title: Depth Rules
kind: foundation
entity: depth
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-DEPTH-TOKENS-08, FOUND-DEPTH-ACCEPT-07]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-DEPTH-210, AC-FOUND-DEPTH-211]
---

# Depth Rules

> This is the one-page normative index. The model files explain why. This file states what is
> binding and what proves it. If a rule here disagrees with a model file, the model file is
> wrong and must be corrected in the same change.

Every rule uses `MUST`, `MUST NOT`, `SHOULD` or `MAY` in the sense of RFC 2119. A `SHOULD` may
be deviated from only with a recorded reason in the component or envelope spec. A `MAY` is a
real option, not a hint.

---

## 1. Truth and hierarchy

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-001` | Occlusion MUST be truthful across pixels, hit map, accessibility tree and input ownership. | All outputs | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-002` | Elevation MUST be carried by at least two cues besides shadow: position, overlap, contrast, scale or outline. | All outputs | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-003` | A shadow MUST indicate a real relationship to a lower surface. | All outputs | `AC-FOUND-DEPTH-103` |
| `FOUND-DEPTH-010` | An app MUST NOT invent a spatial plane outside world, view and system. | Apps, shell | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-011` | The system plane MUST be outside app layout and app reordering. | Apps, shell | `AC-FOUND-DEPTH-106` |
| `FOUND-DEPTH-012` | Scroll and pan MUST move the world plane without changing the elevation of the view plane. | All scrollable surfaces | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-020` | Every shadow in one output MUST share one key direction. | All outputs | `AC-FOUND-DEPTH-103` |
| `FOUND-DEPTH-021` | RTL MUST NOT mirror the light direction. | RTL outputs | `AC-FOUND-DEPTH-124` |
| `FOUND-DEPTH-022` | A material MAY change shadow opacity or softness but MUST NOT change key direction. | Materials | `AC-FOUND-DEPTH-103` |
| `FOUND-DEPTH-023` | A world-locked light anchor MAY replace the viewer-fixed key in a spatial envelope, declared once and held stable. | Spatial | `AC-FOUND-DEPTH-145` |

---

## 2. Tone, perspective and levels

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-030` | A raised surface MUST have the declared tonal separation, or an outline where tonal separation would break contrast. | E1-E4 | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-031` | Tonal separation MUST NOT be the only cue. | E1-E4 | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-032` | Tone MUST NOT be used to fake an elevation that is not declared. | All surfaces | `AC-FOUND-DEPTH-100` |
| `FOUND-DEPTH-040` | A 2D envelope MUST NOT apply perspective to interface chrome, including pointer-following tilt. | 2D envelopes | `AC-FOUND-DEPTH-013` |
| `FOUND-DEPTH-041` | A perspective content preview MUST provide a flat view with the same information. | Map, 3D viewer, media | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-042` | Scale MUST NOT be the only signal of elevation. | All surfaces | `AC-FOUND-DEPTH-101` |
| `FOUND-DEPTH-050` | Every surface MUST declare exactly one level; a level change MUST declare its trigger. | All surfaces | `AC-FOUND-DEPTH-100` |
| `FOUND-DEPTH-051` | A surface MUST NOT sit above its interaction authority. | All surfaces | `AC-FOUND-DEPTH-023` |
| `FOUND-DEPTH-052` | A child surface MUST be at the parent's level or one above, never below. | Nested surfaces | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-053` | E3 and E4 MUST block pointer and focus access below, except declared pass-through regions. | Overlays | `AC-FOUND-DEPTH-111` |
| `FOUND-DEPTH-054` | E4 MUST be system-rendered; an app MUST NOT draw an E4 surface directly. | Apps | `AC-FOUND-DEPTH-022` |
| `FOUND-DEPTH-055` | E0 MUST NOT cast a shadow. | Base plane | `AC-FOUND-DEPTH-104` |
| `FOUND-DEPTH-056` | Elevation MUST NOT indicate selection, emphasis or brand. | All surfaces | `AC-FOUND-DEPTH-100` |

---

## 3. Level transitions and safety

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-060` | A level transition MUST preserve the state of the underlying surface. | Overlays | `AC-FOUND-DEPTH-112` |
| `FOUND-DEPTH-061` | A level transition MUST NOT have a still in which both source and destination are invisible. | Motion | `AC-FOUND-DEPTH-115` |
| `FOUND-DEPTH-062` | Focus MUST move with the level in the same still. | Overlays | `AC-FOUND-DEPTH-111` |
| `FOUND-DEPTH-070` | EV and spaceship critical indicators MUST occupy a declared protected zone at E4 while the condition holds. | Safety envelopes | `AC-FOUND-DEPTH-106` |
| `FOUND-DEPTH-071` | A critical indicator MUST NOT be occluded, blurred, dimmed or moved by an app transition. | Safety envelopes | `AC-FOUND-DEPTH-106` |
| `FOUND-DEPTH-072` | If the protected zone cannot be drawn, the system MUST use the redundant indicator and state what is unavailable. | Safety envelopes | `AC-FOUND-DEPTH-143` |

---

## 4. Shadows

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-080` | E1-E4 MUST have contact and ambient shadow, or the high-contrast outline substitute. | E1-E4 | `AC-FOUND-DEPTH-105` |
| `FOUND-DEPTH-081` | A shadow MUST fall on a declared lower surface. | E1-E4 | `AC-FOUND-DEPTH-103` |
| `FOUND-DEPTH-082` | A shadow MUST NOT serve as border, focus, selection or divider. | All surfaces | `AC-FOUND-DEPTH-105` |
| `FOUND-DEPTH-090` | A shadow MUST NOT use a saturated colour. | All shadows | `AC-FOUND-DEPTH-103` |
| `FOUND-DEPTH-091` | A shadow MUST NOT reduce text or indicator contrast below its threshold. | All shadows | `AC-FOUND-DEPTH-031` |
| `FOUND-DEPTH-092` | A shadow across text MUST be re-checked as a background change. | All shadows | `AC-FOUND-DEPTH-031` |
| `FOUND-DEPTH-100` | Shadow motion MUST be coupled to a real level transition. | Motion | `AC-FOUND-DEPTH-032` |
| `FOUND-DEPTH-101` | A shadow MUST reach its final recipe in the same still as its surface. | Motion | `AC-FOUND-DEPTH-032` |

---

## 5. Parallax

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-110` | Parallax MUST be driven by a real viewpoint or orientation change, never time or scroll. | E2-E3, spatial | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-111` | Parallax MUST be limited to E2-E3 or declared spatial layers; E0, E1, text and critical indicators MUST NOT parallax. | All | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-112` | Parallax MUST be disabled under reduced motion, vestibular-sensitive settings, EV and spaceship. | All | `AC-FOUND-DEPTH-041`, `AC-FOUND-DEPTH-043` |
| `FOUND-DEPTH-120` | Parallax response MUST be monotonic with input. | Pointer, device | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-121` | Parallax MUST be bounded; no unbounded follow or post-input acceleration. | Pointer, device | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-122` | Parallax MUST settle within 120 ms of input stop. | E2-E3 | `AC-FOUND-DEPTH-041` |
| `FOUND-DEPTH-130` | Parallax rate MUST be declared per layer. | E2-E3 | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-131` | A layer's rate MUST NOT change while visible; a change is a level transition. | E2-E3 | `AC-FOUND-DEPTH-115` |
| `FOUND-DEPTH-132` | Text MUST stay at rate 0.0 inside a moving layer; the layer moves as a rigid body. | Text | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-140` | When the pointer leaves, the layer MUST return to rest or hold at a bounded value, as declared. | Pointer | `AC-FOUND-DEPTH-040` |
| `FOUND-DEPTH-141` | Device motion MUST be filtered against hand tremor with a declared cutoff. | Phone, tablet | `AC-FOUND-DEPTH-042` |
| `FOUND-DEPTH-142` | If motion sensing is unavailable or denied, parallax MUST be absent and no permission prompt shown for it. | Phone, tablet | `AC-FOUND-DEPTH-042` |
| `FOUND-DEPTH-150` | Reduced motion MUST remove parallax, not merely reduce it. | All | `AC-FOUND-DEPTH-120` |
| `FOUND-DEPTH-151` | A spatial scene MUST offer a fixed-reference mode. | Spatial | `AC-FOUND-DEPTH-145` |
| `FOUND-DEPTH-152` | Parallax MUST NOT apply to critical indicators, warnings, reading surfaces or text blocks. | All | `AC-FOUND-DEPTH-043` |

---

## 6. Occlusion and focus

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-160` | If A occludes B, A MUST receive input, B MUST NOT, and the accessibility tree MUST agree. | All | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-161` | Pass-through regions MUST be declared; visual and input holes MUST agree. | All | `AC-FOUND-DEPTH-053` |
| `FOUND-DEPTH-162` | Occlusion order MUST be total for overlapping surfaces. | All | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-163` | Occluding a critical indicator is a safety defect. | Safety | `AC-FOUND-DEPTH-143` |
| `FOUND-DEPTH-170` | E3 and E4 MUST have a scrim or equivalent separation that blocks input. | Overlays | `AC-FOUND-DEPTH-111` |
| `FOUND-DEPTH-171` | A scrim MUST NOT exist without an input block. | Overlays | `AC-FOUND-DEPTH-114` |
| `FOUND-DEPTH-172` | A scrim MUST NOT reduce text or indicator contrast below threshold. | Overlays | `AC-FOUND-DEPTH-031` |
| `FOUND-DEPTH-173` | A scrim MUST disappear in the same still as its modal surface. | Overlays | `AC-FOUND-DEPTH-114` |
| `FOUND-DEPTH-180` | Focus dimming MUST NOT be the only indication of the active surface. | All | `AC-FOUND-DEPTH-111` |
| `FOUND-DEPTH-181` | Focus dimming MUST NOT dim the focus ring, active text or critical indicators. | All | `AC-FOUND-DEPTH-125` |
| `FOUND-DEPTH-182` | Focus dimming MUST NOT change the hit map. | All | `AC-FOUND-DEPTH-102` |
| `FOUND-DEPTH-183` | Dimming MUST reverse in the same still as focus moves. | All | `AC-FOUND-DEPTH-115` |
| `FOUND-DEPTH-190` | An occluded surface MUST be inert in the accessibility tree unless declared as a non-interactive background. | Overlays | `AC-FOUND-DEPTH-125` |
| `FOUND-DEPTH-191` | Focus MUST enter a new E3/E4 surface in the still in which it appears. | Overlays | `AC-FOUND-DEPTH-111` |
| `FOUND-DEPTH-192` | Focus MUST return to the invoker or declared fallback. | Overlays | `AC-FOUND-DEPTH-113` |
| `FOUND-DEPTH-200` | A protected zone MUST declare geometry, priority and a redundant indicator. | Safety | `AC-FOUND-DEPTH-052` |
| `FOUND-DEPTH-201` | No transition may pass a surface through a protected zone. | Safety | `AC-FOUND-DEPTH-052` |
| `FOUND-DEPTH-202` | A remote or recorded output MUST preserve the protected zone or declare the indicator unavailable. | Remote, recording | `AC-FOUND-DEPTH-143` |

---

## 7. Materials

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-210` | Every surface MUST declare exactly one material; matte is the default. | All | `AC-FOUND-DEPTH-060` |
| `FOUND-DEPTH-211` | Translucency MUST NOT be used on E0 or E1. | Base, raised | `AC-FOUND-DEPTH-060` |
| `FOUND-DEPTH-212` | A translucent surface MUST have an opaque fallback with the same role. | E2-E4 | `AC-FOUND-DEPTH-061` |
| `FOUND-DEPTH-213` | Emissive material MUST NOT decorate; it signals. | All | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-220` | Backdrop blur MUST be off on watch, TV, EV, spaceship and IoT. | Envelopes | `AC-FOUND-DEPTH-063` |
| `FOUND-DEPTH-221` | Blur MUST NOT sit behind body text unless contrast is re-measured against the blurred result. | E2-E4 | `AC-FOUND-DEPTH-062` |
| `FOUND-DEPTH-222` | Missing blur MUST produce the opaque fallback, never a fake texture. | E2-E4 | `AC-FOUND-DEPTH-141` |
| `FOUND-DEPTH-230` | Reduced transparency MUST make every surface opaque without removing information. | All | `AC-FOUND-DEPTH-061` |
| `FOUND-DEPTH-231` | Reduced transparency MUST NOT be implemented as 99% opacity. | All | `AC-FOUND-DEPTH-061` |
| `FOUND-DEPTH-232` | A translucent surface MUST be legible without blur. | E2-E4 | `AC-FOUND-DEPTH-062` |
| `FOUND-DEPTH-240` | Emissive material MUST declare on, off and degraded states. | Indicators | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-241` | Emissive material MUST NOT be the only carrier of a state. | Indicators | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-242` | Emissive luminance MUST stay within the envelope bound. | Indicators | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-243` | Emissive signals MUST NOT flash above the photosensitivity threshold. | Indicators | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-250` | Safety material MUST be theme-independent. | Safety | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-251` | Safety material MUST pass legibility in every declared lighting condition. | Safety | `AC-FOUND-DEPTH-064` |
| `FOUND-DEPTH-252` | Safety material MUST NOT be used for non-safety content. | Safety | `AC-FOUND-DEPTH-064` |

---

## 8. Governance rules added by this file

| ID | Rule | Scope | Proof |
|---|---|---|---|
| `FOUND-DEPTH-300` | A component that consumes depth MUST declare level, material, shadow, scrim and parallax by token ID. | Components | `AC-FOUND-DEPTH-200` |
| `FOUND-DEPTH-301` | A token value change that alters a reference still MUST be an ADR, not an edit. | Tokens | `AC-FOUND-DEPTH-201` |
| `FOUND-DEPTH-302` | A new elevation level MUST NOT be added without a new ADR and a new interaction meaning. | Model | `AC-FOUND-DEPTH-100` |
| `FOUND-DEPTH-303` | A surface that cannot satisfy a depth rule MUST declare its degraded state, not draw an approximation. | All | `AC-FOUND-DEPTH-140` |
| `FOUND-DEPTH-304` | A review MUST test every rule in this file against the four reference surfaces before the status can move to canon. | Review | `AC-FOUND-DEPTH-102` |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-DEPTH-210` | Every `FOUND-DEPTH-*` rule in this file appears in at least one model file, token file or acceptance table, and no rule exists only here. |
| `AC-FOUND-DEPTH-211` | A conformance script walks every component spec, finds each depth declaration by token ID, and reports zero literals and zero undeclared levels. |
