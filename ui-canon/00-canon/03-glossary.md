---
id: CANON-GLOSSARY
title: Glossary
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-LAWS]
acceptance: [AC-DOC-004]
---

# Glossary

> One word, one meaning. If a document uses a term differently from this list, the
> document is wrong.

---

## Truth and presentation

**Still** — the complete visible truth of one output at one version: pixels, hit map,
accessibility snapshot, input ownership and buffer lifetimes. A still is atomic. There is
no half-still.

**Commit** — the producer's explicit declaration that a surface's content has changed:
the buffer, the damaged region, the present intent, the fence, and optional semantic
payloads.

**Authority** — the always-present component that validates commits, assigns still
numbers, stores the current truth, and produces named rejections. It does not lay out or
arbitrate.

**Policy** — the optional, replaceable component that decides placement, stacking, focus
and arbitration. On a watch it may not exist. On a desktop it is the shell.

**Executor** — the replaceable component that makes a still visible: direct scanout,
hardware plane, GPU blit, CPU fallback, remote encode or headless capture.

**Envelope** — a device class with its own constraints: watch, phone, tablet, desktop, TV,
EV, spaceship, IoT, spatial, remote browser.

**Output** — a presentation endpoint. A panel, a projector, a browser canvas, a recording.
Outputs are peers; there is no global "the screen".

**Surface** — a producer's drawable region. It owns a buffer and commits stills. It is not
the same as a window; a window is a policy-level placement of one or more surfaces.

**Present intent** — when the producer wants the commit to become visible (immediate, next
vsync, after a fence, at a named time).

**Damage** — the region the producer declares as changed. Declared, never detected.

**Fence** — a synchronization primitive that says when a buffer is safe to read or reuse.

**Scanout** — presenting a buffer directly to a display controller without composition.

**Plane** — a hardware layer that can be positioned, scaled and composited by the display
controller.

**Blit** — a copy or scale of pixels from one buffer to another, usually on the GPU.

**Composition** — combining surfaces into one output. It is an executor concern, not a
policy concern.

**Zero-copy** — a path where the buffer is used without an intermediate copy. It is a
per-case optimality, not a promise.

**Numbered still** — a still with a stable identity. "What did the user see at 10:05:03?"
is answered by a still number.

**Rejection** — a named refusal of a commit, with the failed invariant and the culprit.
Never a silent drop.

---

## Design and space

**Depth** — the semantic use of space, light, occlusion, parallax and focus to express
hierarchy. Not decoration.

**Elevation** — a semantic level in the depth scale: base, raised, floating, overlay,
system. Each has a shadow and interaction meaning.

**Material** — the declared surface quality of a layer: matte, translucent, emissive. A
material is a token, not an arbitrary style.

**Parallax** — the relative movement of layers in response to real motion (pointer, device,
head). It communicates distance and must respect reduced motion.

**Occlusion** — what is in front of what. Occlusion is a fact of the depth model, not a
z-order accident.

**Focus dimming** — reducing the prominence of layers outside the active task. It is a
depth cue and an attention cue.

**Token** — a named design value: color, type, space, radius, shadow, spring, icon,
duration. Tokens are the only legal source of visual values.

**Primitive** — a timeless interaction concept: field, list, card, rail, section set,
palette, overlay. A primitive is not a widget.

**Component** — a concrete, reusable implementation of one or more primitives, with
anatomy, states, behaviour and tokens.

**Composite** — a component assembled from other components for a specific job. It must
not invent new grammar.

**Section Set** — the timeless primitive behind tabs: a set of labelled peers that can be
rendered as a rail, segmented control, list or crown-scroll.

**Spacious** — a declared density mode with larger spacing, fewer visible actions and a
calmer hierarchy. It is a layout mode, not a theme.

---

## Interaction

**Flow** — a sequence of frames that accomplishes one user goal.

**Frame** — one complete screen state in a flow, with a wireframe, focus location and
transition.

**State** — a named condition the interface can be in: loading, ready, empty, error,
offline, denied, degraded.

**Intent** — what the user means to do, expressed as an action, command or direct
manipulation.

**Command** — a named, invocable action with an ID, a label, a shortcut and a capability
requirement.

**Action** — a user-visible operation. Every action is reversible, confirmable or
recoverable.

**Palette** — the universal command surface: type or say what you want, see ranked
results, act. It is a foundation, not an app.

**Shortcut** — a keyboard or gesture binding to a command. Shortcuts are accelerators, never
the only path.

**Capture lease** — a time-bound, revocable right to receive input during a drag or
gesture.

---

## Shell

**Strip** — the summon-only depth reel of live stills at the edge of the screen. It is
both a switcher and a launcher. It is not a dock.

**Status rail** — the adaptive, UX-owned indicator rail. It shows what a person always
needs on that envelope, in priority order, and collapses when space is tight.

**Space** — a named workspace or context. Spaces are policy state, not app state.

**Session** — the authenticated, capability-scoped context of one user.

**Notification** — a time-sensitive fact delivered to the user. It has a priority, a
source, a history entry and an expiry.

---

## System

**Capability** — an unforgeable, revocable right to perform an operation on a resource. Not
a global name, not a raw pointer.

**Role** — a named responsibility resolved through discovery: `policy`, `executor`,
`authority`, `theme`, `input`. Composition by role is how one OS serves many devices.

**Discovery** — the mechanism by which a component finds peers by role, never by literal
name.

**Contract** — the Cap'n Proto schema that defines a wire fact. The contract is durable;
implementations are disposable.

**Ordinal** — the stable field number in a Cap'n Proto schema. New fields use new ordinals;
old readers ignore them. This is how the protocol stays timeless.

**Resource profile** — a declared performance/feature class: constrained, compact,
balanced, high-throughput, remote, safety-critical.

**Degradation ladder** — the ordered list of what a system gives up first when a budget is
exceeded. It is designed, not improvised.

**Idle** — no change, no work, no messages, no wakeups. Idle is the default state.

---

## Process

**Canon** — approved, binding design truth.

**Normative** — contains requirements (`MUST`, `SHOULD`, `MAY`).

**Informative** — explains, never overrides.

**ADR** — Architecture Decision Record. One decision, its context, alternatives and
consequences.

**Gate** — a review checkpoint that must pass before the next phase. Gates are not
ceremonial; they are where layers are protected.

**Acceptance criterion (AC)** — a testable statement that proves a requirement. An AC has
an ID and a test.

**Persona** — a named human with a routine, constraints and acceptance scenarios. Not a
marketing segment.

**Envelope profile** — the declared constraints of a device class: input, display, power,
safety, performance.

---

## Words we do not use

- **"Compositor"** for the whole presentation system. Use *presentation authority*,
  *policy*, *executor* or *composition*, depending on which part is meant. "Compositor"
  hides three different responsibilities.
- **"Dock"** for the strip. A dock is permanent chrome; the strip is summon-only.
- **"Tab"** for the primitive. Use *Section Set*. A tab is one rendering.
- **"Theme"** for a palette of colors only. A theme is a full token set: color, type,
  space, depth, motion, icon, material.
- **"Animation"** for motion that explains change. Use *motion* or *transition*.
- **"User"** when a more precise role is meant: person, operator, driver, passenger, child,
  administrator.
