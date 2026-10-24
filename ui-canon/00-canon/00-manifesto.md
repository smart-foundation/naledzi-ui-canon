---
id: CANON-MANIFESTO
title: The Naledzi UI Manifesto
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: []
acceptance: [AC-DOC-001]
---

# The Naledzi UI Manifesto

> We are not building a desktop. We are not building a phone. We are not building a
> competitor. We are building the interface an operating system can still justify in a
> century.

---

## 1. The problem we refuse

Every mainstream interface is a layer cake of accidents:

- a desktop metaphor from 1973, kept because it was once a good idea;
- a dock from 2001, kept because it was once a good idea;
- tabs from 1994, kept because a browser had them;
- a status bar from 1984, kept because a terminal had one;
- glassmorphism from 2013, kept because it photographs well;
- a thousand invisible gestures, added because a demo needed a reveal.

None of these is evil. But none of them is automatically timeless. Most of them assume a
large pointer-driven rectangle. Put the same interface on a watch, a television, a car
dashboard, a spacecraft or a browser, and the assumptions fail one by one — so teams add
special cases, and the special cases become the product.

We are not doing that.

---

## 2. The one admission criterion

**Timelessness.**

A thing earns its place only if it still makes sense when the input, the display, the
form factor and the decade have changed. The test is
[`01-timelessness-test.md`](01-timelessness-test.md). It is not a vibe. It is scored.

"Users expect it" is not timeless; users expect what they were taught. "It is standard" is
not timeless; standards expire. "It looks premium" is not timeless; fashion moves. "It is
fast" is necessary, not sufficient.

The things that survive are the ones that answer a human need older than computing:
**communication, memory, navigation, creation, comparison, safety, status, play.** Those
needs do not change. The interface that serves them can.

---

## 3. Depth, not decoration

We choose **depth** as the visual model.

Not glassmorphism. Glass is a surface treatment: blur, transparency, a highlight. It
photographs beautifully and communicates almost nothing. Depth is older and stronger. It
is how a human reads space: what is near, what is behind, what is above, what is
occluded, what is in focus, what is safe to touch.

Depth gives us:

- **hierarchy** without a thousand borders — elevation says what matters now;
- **continuity** across devices — a card on a watch is the same card, closer;
- **calm** — a surface can recede instead of shouting;
- **physical intuition** — shadows, contact, mass and springs are understood before they
  are learned;
- **a future** — a 3D, AR or neural display is a change of executor, not a change of
  model.

Depth is expressed through a small, strict system: one light model, a fixed elevation
scale, contact and ambient shadows, parallax tied to real motion, occlusion, focus dimming,
and material rules. It is specified in
[`../01-foundations/depth/README.md`](../01-foundations/depth/README.md).

Depth is not "make everything float". A thing that floats without meaning is noise.
Elevation is a semantic property, not a style option.

---

## 4. Truth, not rendering

The interface is a **presentation of truth**, not a pile of drawings that hope to agree.

Every visible state is a **numbered still**: pixels, hit targets, accessibility semantics,
input ownership and buffer lifetimes are one atomic, versioned fact. A half-updated screen
— where the window moved but the clicks did not — is not a bug to fix. It is
unrepresentable.

This is the core architectural bet, and it is the reason the rest of the corpus can be
simple:

- the producer declares what changed; the system never diffs frames;
- the authority validates and numbers the truth; it is always present;
- the policy (layout, stacking, arbitration) is an optional, replaceable app;
- the executor (scanout, planes, GPU blit, CPU fallback) is disposable;
- buffers are capabilities, never global pointers;
- idle is silent; the cost of the interface is proportional to change, not to screen size.

See [`../02-architecture/presentation/README.md`](../02-architecture/presentation/README.md).

---

## 5. One vocabulary, one grammar

An app is not a snowflake. Every app in the suite signs the same contract
([`../05-apps/_standard/README.md`](../05-apps/_standard/README.md)):

- the same anatomy: one content region, one action region, one status region, one overlay
  layer;
- the same state machine: loading, ready, empty, error, offline, denied, degraded;
- the same input grammar: pointer, touch, keyboard, remote, voice, gesture;
- the same depth semantics: base, raised, floating, overlay, system;
- the same tokens: color, type, space, radius, shadow, spring, icon;
- the same accessibility structure: semantic roles, focus order, announcements.

A calculator and a video player are different in domain, not in grammar. That is what
makes the suite feel like one product, and what makes a second team able to reproduce an
app exactly.

---

## 6. What we refuse

We refuse, explicitly and permanently:

1. **Platform mimicry.** We do not copy macOS, Windows, Android, iOS or Material. We may
   learn from them; we do not inherit their assumptions.
2. **Glassmorphism as a foundation.** Translucency is a tool for a specific transient
   layer, not the visual language.
3. **Permanent chrome.** A dock, bar or tab strip that is always present must prove a
   timeless job on every envelope. Otherwise it is summoned, not installed.
4. **Icon-only launchers.** An icon is a promise the user must memorize. A live still is a
   fact.
5. **Magic gestures.** A gesture without an affordance is a secret. Secrets are not UX.
6. **Runtime diffing.** The system does not compare frames to discover dirt. The producer
   declares it.
7. **Global raw pointers.** No app receives a global address it can forge or retain. It
   receives a capability, scoped, revocable, and only for as long as it is needed.
8. **A second UI model.** One ECS, one layout, one scheduler, one source of composition
   state. No shadow tree "kept in sync".
9. **Per-app damage trackers.** The framework tracks dirty regions; the app does not
   rebuild that machinery. If an app cannot, it declares the whole surface and remains
   correct.
10. **Design by screenshot.** A beautiful frame with no state model is a poster, not a
    specification.
11. **Panic specs.** A giant document rushed to justify code is how layers get cut. We
    write the tree first; code follows the tree.
12. **Fake aliveness.** Spinners that exist to signal effort, pulsing chrome, animation
    that never settles. Idle is silent.

---

## 7. The human we serve

Every personality, every body, every language, every level of expertise.

- **The first-time user** must be able to do one useful thing without a manual.
- **The expert** must never be slowed down by the beginner's path.
- **The disabled user** must have the whole product, not a subset.
- **The child and the elder** must be safe from irreversible mistakes.
- **The privacy-conscious user** must be able to see and revoke what observes them.
- **The offline user** must not be treated as broken.
- **The power user** must be able to inspect, script, automate and repair.
- **The person in a hurry** must be able to leave and resume without losing work.

Calm is a feature. Speed is a feature. Silence is a feature. Reversibility is a feature.
Honesty is a feature. Beauty is a feature, but only when it serves the others.

---

## 8. The machine we build on

- **Microkernel, capability-isolated.** The UI is a set of disposable services, not a
  privileged monolith.
- **Cap'n Proto contracts.** One wire truth. Schemas evolve by ordinal, never by breaking.
- **MirUI** is the app-side UI runtime: ECS, layout, raster, text, animation. It is not the
  compositor and it is not the system.
- **The authority** validates commits and owns the stills. **The policy** lays out and
  arbitrates; it is optional. **The executor** presents; it is replaceable.
- **GPU and CPU are both first-class.** Direct scanout, hardware planes, GPU blit and CPU
  fallback are paths of one model, not four products. Zero-copy is a per-case optimality,
  never a promise.

See [`../02-architecture/`](../02-architecture/README.md).

---

## 9. The process we commit to

Design before code. Not a phase that is skipped when the demo is late — a gate.

- Many perspectives before a single line: research, personas, systems, interaction,
  depth, accessibility, performance, security, red team.
- Options, not a single chosen answer. The rejected options are recorded.
- Every requirement has an identifier and an acceptance test.
- Every screen has a flow; every flow has frames; every frame has a state and a focus.
- Every app is a directory, not a document. Every entity follows the same anatomy.
- The corpus is allowed to grow to thousands of files. It is not allowed to lie.
- Implementation begins only when the slice's gate is passed, and it is verified against
  the same acceptance criteria that were written before it.

See [`../08-process/01-agentic-workflow.md`](../08-process/01-agentic-workflow.md).

---

## 10. The promise

A user should be able to move from a watch to a phone to a desktop to a car to a browser
and recognize the same system — not because it looks the same, but because it **thinks**
the same.

An app should be reproducible by a different team, in a different UI language, and behave
identically down to the focus order.

A design should still make sense in 4506, when the display is not a rectangle and the
input is not a pointer.

That is the bar. Everything else is iterable.
