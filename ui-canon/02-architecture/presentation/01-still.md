---
id: ARCH-PRESENT-STILL
title: The Numbered Still
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-005, AC-ARCH-PRESENT-007]
---

# The Numbered Still

> The visible truth of an output is one atomic, versioned fact. Pixels, hit map,
> accessibility snapshot, input ownership and buffer lifetime are committed together
> and numbered together. There is no half-still.

---

## 1. What a still is

A **still** is the complete, self-consistent, immutable description of one output at one
moment. It is not a scene graph. It is not a frame buffer. It is not a snapshot taken
after the fact. It is the thing the authority declares as "what the user is seeing."

A still carries:

| Component | What it is | Why it must be atomic |
|---|---|---|
| **Pixels** | The rendered image for this output, as a buffer reference | The image and the hit map must agree; a moved window with stale pixels is a lie |
| **Hit map** | The spatial index of interactive regions and their owners | A click must land on what the eye sees, not what was there before |
| **Accessibility snapshot** | The semantic tree: roles, names, states, values, actions, geometry, relationships | A screen reader must describe what is visible, not a gone control |
| **Input ownership** | Which surface holds focus, which holds capture leases, which is the pointer target | Input must go to what the user sees, not what the app thinks is there |
| **Buffer lifetime** | Which buffers are in use, which are free, which are being scanned out | A recycled buffer must never be visible as a half-drawn frame |

All five are committed together. All five are numbered together. All five are immutable
once assigned. This is `LAW-005` and `ADR-0001`.

---

## 2. Why atomicity matters

Before this model, presentation systems kept pixels, hit-testing, accessibility and input
ownership in separate structures that were "kept in sync" by convention. The result was a
class of consistency bugs that could never be fully eliminated:

- **Stale hit targets.** A window moves. The pixels update. The hit map does not. The
  user clicks where the window was; the click lands on the window behind it.
- **Phantom accessibility.** A control is removed. The visual tree updates. The
  accessibility tree does not. The screen reader announces a button that no longer
  exists.
- **Recycled buffers.** A buffer is returned to the pool before the display controller
  finishes scanning it out. The user sees a half-drawn frame, or the next frame's content
  bleeding through.
- **Input races.** A capture lease expires. The pointer event arrives. The event goes to
  the surface that held the lease, not the surface that now owns the pointer.

These bugs are not implementation errors. They are structural: the model allows the
components to disagree because it has no single owner of the truth. The numbered still
fixes this by making the truth one fact with one owner.

---

## 3. Still identity

A still is identified by a **still number**: a monotonically increasing integer assigned
by the authority. Still numbers are:

- **Unique per output.** Each output has its own still sequence. There is no global still
  number across outputs; the output is part of the identity.
- **Monotonic.** Still numbers never decrease. A still number that goes backwards is a
  bug.
- **Never reused.** A still number is consumed once. A rejected commit does not consume
  a still number; only an accepted commit produces a still.
- **Gapless.** Still numbers are consecutive. A gap means a commit was lost without a
  rejection, which is a defect.
- **Durable.** A still number survives a reboot, a policy crash, an executor swap and a
  remote reconnection. It is the identity of "what the user saw."

Still numbers are not timestamps. A timestamp tells you when; a still number tells you
what. The authority may record a timestamp alongside the still number, but the still
number is the identity.

---

## 4. Still immutability

Once assigned, a still never changes. It is not updated, patched, or amended. If the
content changes, a new still is committed with a new number.

This means:

- **Forensics.** "What did the user see at 10:05:03?" is answered by a still number.
  The still can be retrieved, compared, and replayed.
- **Crash recovery.** After a crash, the authority's last still number tells the new
  policy and executor what was on screen. No reconstruction needed.
- **Remote output.** A remote peer receives still numbers. It can request a specific
  still, detect gaps, and reconcile without guessing.
- **Testing.** A test asserts a still number. The test is deterministic because the
  still is immutable.

The cost of immutability is that every change produces a new still. This is not a
performance problem because commits are declared, not detected (LAW-003): the producer
knows what changed and can produce a minimal commit.

---

## 5. Still scope

A still belongs to one **output**. An output is a presentation endpoint: a physical
display, a virtual display, a remote browser canvas, a recording, a projector. There
is no "the screen." There are outputs, and each output has its own still sequence.

An app that renders to multiple outputs produces multiple commits, one per output. The
authority numbers each independently. The app does not need to synchronise them; the
authority handles the per-output truth.

A single output may present content from multiple surfaces (windows, layers). The
authority composes them into one still for that output. The composition is part of the
still, not a separate step.

---

## 6. What a still is NOT

- **Not a frame buffer.** A frame buffer is a block of pixels. A still is the truth
  about the pixels, the hit map, the accessibility tree, the input ownership and the
  buffer lifetime, taken together.
- **Not a scene graph.** A scene graph is a mutable data structure that describes what
  to draw. A still is the immutable result of drawing it.
- **Not a snapshot.** A snapshot is taken after the fact by reading back state. A still
  is produced by declaration, not observation.
- **Not a window.** A window is a policy-level placement of one or more surfaces. A
  still is the composed truth of an output.
- **Not a surface.** A surface is a producer's drawable region. A still is the composed
  truth of an output that may contain many surfaces.

---

## 7. Still and the user

The user never sees a still number. The still number is an internal identity that makes
the system's behaviour verifiable, recoverable and reproducible. What the user sees is
the pixels, the hit targets, the accessibility tree and the input behaviour — all of
which are guaranteed to agree because they are one fact.

The user does, however, benefit from the still's properties:

- **No half-drawn frames.** The buffer lifetime is part of the still, so the display
  controller never scans out a buffer that is being written.
- **No stale hit targets.** The hit map is part of the still, so a click always lands
  on what the eye sees.
- **No phantom controls.** The accessibility snapshot is part of the still, so a screen
  reader always describes what is visible.
- **No lost input.** Input ownership is part of the still, so a key press always goes
  to the focused surface.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-005` | No two commits share a still number on the same output. |
| `AC-ARCH-PRESENT-007` | A still is retrieved by number and matches the pixels, hit map, accessibility snapshot, input ownership and buffer lifetime that were committed. |
| `AC-ARCH-PRESENT-008` | A policy crash does not invalidate the current still; the new policy adopts it. |
| `AC-ARCH-PRESENT-009` | A remote peer receives a still number and can request that still; the retrieved still matches. |
| `AC-ARCH-PRESENT-010` | No observer reads a buffer without a capability, even with a valid still number. |

---

## 9. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-PRESENT-001` | Should still numbers be 64-bit or 128-bit? 64-bit allows ~10^19 stills per output, which is sufficient for any realistic lifetime. | Architecture Editor | proposed |
| `OQ-PRESENT-002` | Should the authority expose a "current still" subscription, or must observers poll? A subscription is more efficient but requires a capability. | Architecture Editor | proposed |
| `OQ-PRESENT-003` | How does a remote peer request a specific still? By number, by timestamp, or by "latest"? | Architecture Editor | proposed |

---

## 10. References

- Dennis, J. B. & Van Horn, E. C. (1966). *Programming semantics for multiprogrammed
  computations.* Communications of the ACM, 9(3), 143–155. — Capability-based security
  foundation. https://dl.acm.org/doi/10.1145/365230.365252
- Miller, M. S. (2006). *Robust Composition: Towards a Unified Approach to Access
  Control and Concurrency Control.* PhD thesis, Johns Hopkins University. — Capability
  semantics and confinement. https://www.erights.org/talks/thesis/
- Wayland protocol documentation. — Atomic commits and buffer management.
  https://wayland.freedesktop.org/docs/html/
- Android SurfaceFlinger architecture. — Buffer lifecycle and composition.
  https://source.android.com/docs/core/graphics/architecture
- iOS Core Animation. — Layer tree and rendering.
  https://developer.apple.com/documentation/quartzcore