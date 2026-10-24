---
id: CANON-LAWS
title: The Design Laws
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-MANIFESTO, CANON-TIMELESSNESS]
acceptance: [AC-DOC-003]
---

# The Design Laws

> Binding on every layer, every app, every agent. A law is not a preference. If an
> implementation violates a law, the implementation is wrong, even if it demos well.

Each law has a statement, the reason it exists, what it forces, and how it is tested.

---

## LAW-001 — One fact, one owner

**Statement.** Every fact has exactly one authoritative owner. Every other appearance of
that fact is a derived view or a link, never a copy kept in sync.

**Why.** Two owners eventually disagree. The disagreement is the bug, and no amount of
sync code removes the window in which it exists.

**Forces.** No shadow scene graph. No second theme. No duplicated focus state. No
"mirror" of another service's data. The owner is named in the spec.

**Test.** Delete the derived copy. Does the system still behave? If yes, it was derived. If
no, it was a second owner.

---

## LAW-002 — Pixels never cross a contract boundary

**Statement.** A contract boundary carries capabilities, buffer handles, declarations,
fences and semantic facts. It MUST NOT carry raw pixel bytes or a global pointer.

**Why.** Pixels are a rendering detail. A boundary that carries them couples every
implementation to one pixel format, one memory model and one security model. A capability
carries the right to use a buffer without granting the address.

**Forces.** Shared buffers are capabilities. The producer owns the buffer; the consumer
gets a scoped right. Formats are negotiated, not assumed.

**Test.** Trace every field in the commit. If any field is a raw address, a length plus a
pointer, or an untyped byte blob that the receiver interprets as pixels, the law is
violated.

---

## LAW-003 — Declared, not detected

**Statement.** The producer declares what changed. The system MUST NOT compare two frames,
scan pixels, or infer damage at runtime.

**Why.** Diffing is a hidden cost that scales with screen size and burns cycles to
rediscover what the producer already knew.

**Forces.** The app or framework tracks dirty regions and declares them. An app that
cannot track damage declares the whole surface — correct, just more pixel work. The
receiver never guesses.

**Test.** Instrument the path. Is there any frame-to-frame comparison? Any pixel readback?
Any heuristic damage scan? If yes, it is a violation.

---

## LAW-004 — Idle is silent

**Statement.** A surface that has not changed MUST send nothing and schedule nothing. No
polling, no heartbeat, no redraw to appear alive.

**Why.** The interface's cost must be proportional to change, not to time. Idle silence is
what makes a watch last a week and a desktop stay cool.

**Forces.** Springs stop at rest. Clocks commit on the tick they choose. Status indicators
update on change. No background animation without a reason and a stop condition.

**Test.** Leave every surface untouched for one hour. Measure messages, wakeups, GPU time
and battery. The expected result is zero (or the declared periodic cost of a clock).

---

## LAW-005 — Every visible state is a numbered still

**Statement.** For each output, the visible truth is one atomic, versioned fact: the
pixels, the hit map, the accessibility snapshot, input ownership and buffer lifetimes.
There is no moment when these disagree.

**Why.** Most "impossible" UI bugs are consistency bugs: the window moved but the click
target did not; the screen reader describes a control that is gone; the buffer was
recycled while it was still on screen.

**Forces.** Commits are explicit and atomic. The authority numbers them. Observers read a
still, not a live mutable scene.

**Test.** Race a move and a click. Race a close and a screen-reader read. Race a buffer
recycle and a scanout. No sequence may observe a half-updated state.

---

## LAW-006 — Authority is mandatory; policy is optional

**Statement.** The component that validates commits and owns the stills is always present.
The component that decides layout, stacking and arbitration is an optional, replaceable
app.

**Why.** Truth and crash recovery cannot be optional. Layout and taste can.

**Forces.** A watch may have no policy app. A desktop has one. An EV has a safety-reviewed
one. All of them speak the same contract. Killing the policy does not lose the screen.

**Test.** Kill the policy process. The stills remain visible; input leases expire safely; a
new policy can adopt the current truth. Kill the authority. The system must fail honestly,
not silently.

---

## LAW-007 — Depth communicates hierarchy

**Statement.** Elevation, shadow, parallax, occlusion and focus dimming MUST encode
meaning: what is base, what is raised, what is floating, what is modal, what is system.
They MUST NOT be applied for decoration.

**Why.** Depth is the visual model that survives device and decade changes. Used
semantically, it replaces borders, dividers and chrome. Used decoratively, it becomes
noise and a performance tax.

**Forces.** A fixed elevation scale. One light model. A shadow recipe per level. Parallax
tied to real motion and disabled under reduced motion. No floating element without a
declared level.

**Test.** Remove the shadow. Can a user still tell the hierarchy from position and
contrast? If not, the depth is doing no semantic work. Add a random elevation to a random
element; does it change meaning? If not, it is decoration.

---

## LAW-008 — Motion explains change

**Statement.** Motion MUST explain what changed, where it came from and where it went. It
MUST settle and stop. It MUST be interruptible and velocity-preserving. It MUST have a
reduced-motion alternative.

**Why.** Motion is cognition, not garnish. A spring that preserves velocity makes an
interruption feel continuous. A fixed-duration curve that restarts makes it feel broken.

**Forces.** Named spring tokens. Target-based animation. Gesture handoff. Deterministic
integration across refresh rates. No infinite decorative motion.

**Test.** Interrupt an animation halfway. Does it continue from its current velocity
without a jump? Does it settle within its declared bound? Does reduced motion remove travel
while preserving the state change?

---

## LAW-009 — Accessibility is structural

**Statement.** Accessibility semantics MUST be derived from the same model that draws the
screen. They MUST NOT be a parallel tree scraped from pixels or maintained by hand after
the fact.

**Why.** A parallel tree goes stale. A derived tree cannot.

**Forces.** Every component declares its role, name, state and actions. The accessibility
snapshot rides the same commit as the pixels. Focus order is specified per flow.

**Test.** Change a control's state. Is the accessibility snapshot updated in the same
still? Remove the visual layer. Can the screen reader still complete the flow?

---

## LAW-010 — No permanent chrome without a timeless job

**Statement.** Any element that is always on screen MUST justify its permanence on every
envelope by a need that survives input, display and decade change. Otherwise it is
summoned on demand.

**Why.** Permanent chrome spends space, attention and battery forever. Most of it is
inherited, not earned.

**Forces.** The dock is transformed into a summon-only strip. The status rail is adaptive
and collapses. Tabs are a rendering of a Section Set, not a permanent bar.

**Test.** Remove the element for a day. Can every task still be completed? If yes, it was
not permanent; make it summonable. If no, name the need and the envelope exceptions.

---

## LAW-011 — Honesty over polish

**Statement.** Unsupported, denied, unknown, stale and degraded states MUST be shown as
such. The system MUST NOT fake success, fake data, fake aliveness or a silent fallback.

**Why.** Trust is the product. A beautiful lie is a defect.

**Forces.** `NOT REPORTED` is a first-class value. A denied capability is a visible state
with a reason and a path to request it. An offline app says offline. A missing service is
named.

**Test.** Deny a capability. Disconnect the network. Remove a service. Does the UI explain
what happened and what the user can do? If it hides or fabricates, it fails.

---

## LAW-012 — Design before code

**Statement.** A slice MUST NOT be implemented until its design gate is passed: purpose,
model, behaviour, flows, states, accessibility, performance, acceptance.

**Why.** Code written before the design is a decision made by accident. Layers get cut to
fit the code, and the cut is never repaired.

**Forces.** The gate checklist in `08-process/05-review-gates.md`. No "spike" becomes the
product. A spike is thrown away.

**Test.** Open the slice's directory. Are the required files `canon` and are the acceptance
criteria written? If not, code is premature.

---

## LAW-013 — One vocabulary, one grammar

**Statement.** All apps share one anatomy, one state machine, one input grammar, one
depth semantics, one token system and one accessibility structure. Domain differences do
not justify grammar differences.

**Why.** A suite feels like a product when the user learns once. Reproducibility requires a
shared grammar.

**Forces.** The app standard. The component catalog. The token system. The flow standard.

**Test.** Take two apps. Swap their content. Does the navigation, focus, state and action
grammar still make sense? If not, they diverged.

---

## LAW-014 — The smallest contract wins

**Statement.** A contract MUST carry the minimum needed to make the fact true. Optional
layers grow by addition, never by making the core mandatory.

**Why.** Contracts that grow without discipline ossify. The timeless primitives of
computing — the pipe, the file descriptor, TCP — stayed small.

**Forces.** The commit core is buffer, damage, present intent, fence. Semantics, proofs,
audiences and policies are optional payloads. New fields are optional with defaults.

**Test.** Remove every optional field from the contract. Is the core still useful? If not,
the core is too big. Add a field; does an old implementation still work? If not, it is a
breaking change.

---

## LAW-015 — Reversibility and recoverability

**Statement.** Every destructive action MUST be reversible, confirmable, or recoverable.
Every component MUST be replaceable without losing the user's work or the visible truth.

**Why.** A timeless system is one people can trust with their work. Trust requires a way
back.

**Forces.** Undo where possible. Confirmation for the irreversible. Crash-safe stills. A
new policy adopts the old truth. A new executor can take over.

**Test.** Kill the process mid-action. Is the work recoverable? Is the screen still
coherent? Can the user undo the last step?

---

## LAW-016 — Performance is a design constraint

**Statement.** Every entity MUST declare a budget: frame time, memory, messages, wakeups
or energy. A design that cannot meet its budget on the target envelope is not finished.

**Why.** Performance is not an optimization phase. It is a property of the design. A
beautiful interaction that drops frames is a bad interaction.

**Forces.** Per-envelope budgets. Degradation ladders. Measurement in acceptance. No
"we'll optimize later" for a foundational path.

**Test.** Run the budget on the weakest supported envelope. Does it pass at p95? If not,
the design is not done.

---

## LAW-017 — Local first; remote is a peer

**Statement.** The local device MUST remain fully usable without a network. A remote output
or service is a peer with the same contract, not a replacement for local truth.

**Why.** The network is not a dependency for looking at your own screen or editing your own
file.

**Forces.** The browser is an executor, not a VNC stream. Remote updates are structured
commits. Reconnection reconciles, never blindly replays.

**Test.** Disconnect the network. Does the local session continue? Reconnect. Does the
remote output resynchronize without corrupting state?

---

## LAW-018 — Every screen is a state; every state is addressable

**Statement.** Every visible screen MUST correspond to a named state that can be reached,
tested and linked. There are no one-off screens outside the state model.

**Why.** A screen that is not a state cannot be tested, reproduced or recovered.

**Forces.** State machines per app. Flows as sequences of named frames. Deep links to
states. Restore after crash.

**Test.** Can you navigate directly to the state? Can you restore it after a restart? Is it
in the flow document?

---

## LAW-019 — No hidden global state

**Statement.** A component MUST NOT depend on ambient global state that is not declared in
its contract. Theme, locale, focus, capabilities and session MUST be explicit inputs.

**Why.** Hidden globals make behaviour unreproducible and tests flaky.

**Forces.** Explicit context objects. Capability handles. No singletons with mutable state.
No "current window" global.

**Test.** Instantiate the component twice with different contexts in one process. Do they
behave independently? If not, it depends on a global.

---

## LAW-020 — The user owns their data and attention

**Statement.** The system MUST NOT train on, upload, or monetize user content without an
explicit, revocable, informed choice. Notifications and motion MUST respect attention as a
finite resource.

**Why.** A timeless OS is one the user can trust for decades. Attention and data are the
two things an interface can steal.

**Forces.** Local-first defaults. Explicit capability grants for observation (thumbnails,
screen recording, clipboard). Notification budgets. Quiet hours. No dark patterns.

**Test.** Fresh install, no network. Is every core task possible? Are all observation
capabilities off by default? Can the user see and revoke every grant?

---

## The hierarchy of laws

When laws conflict, resolve in this order:

1. Safety and honesty (`LAW-011`, `LAW-015`, `LAW-020`).
2. Truth and consistency (`LAW-001`, `LAW-005`).
3. Capability safety (`LAW-002`, `LAW-019`).
4. Accessibility (`LAW-009`).
5. Performance proportionality (`LAW-004`, `LAW-016`).
6. Depth and motion (`LAW-007`, `LAW-008`).
7. Chrome minimalism (`LAW-010`).
8. Everything else.

A conflict is recorded as an ADR. It is not resolved silently.
