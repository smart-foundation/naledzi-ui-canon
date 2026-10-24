---
id: CANON-ANTI
title: Anti-Patterns
kind: canon
entity: canon
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [CANON-TIMELESSNESS, CANON-LAWS]
acceptance: [AC-DOC-006]
---

# Anti-Patterns

> Rejected patterns and the reason. A pattern does not return without new evidence. "It is
> common" is not evidence.

Each entry names the pattern, the failed assumption, the timelessness score where scored,
and the replacement.

---

## AP-001 — Glassmorphism as the visual language

**Failed assumption.** Blur and transparency communicate sophistication.
**Score.** 6/20 (see timelessness test §4.4).
**Why.** Destroys contrast, costs GPU, fails on low-end/outdoor, carries no hierarchy.
**Replacement.** Depth model: elevation, shadow, occlusion, focus. Translucency only as a
declared material on a specific transient layer, with contrast and performance budgets.

---

## AP-002 — The permanent dock

**Failed assumption.** Users need a persistent strip to find apps.
**Score.** 9/20.
**Why.** Spends space forever, assumes a wide pointer screen, shows memorized icons,
conflates launch and switch, fails on watch/TV/car.
**Replacement.** The strip: summon-only, live stills, depth cards, fan-out switcher.

---

## AP-003 — Icon-only launcher

**Failed assumption.** A grid of icons is self-explanatory.
**Why.** Icons are learned, not read. They are ambiguous across cultures and domains, and
they hide the actual content.
**Replacement.** Live stills, labels, search, recents, and the palette.

---

## AP-004 — Tabs as the primitive

**Failed assumption.** The tab strip is the natural model for parallel views.
**Score.** 15/20 for the need, but the chrome is an artifact.
**Why.** Horizontal chrome fails on narrow screens, fights split views, and is only one
spatial rendering.
**Replacement.** Section Set primitive with per-envelope renderings.

---

## AP-005 — Hidden gestures as the only path

**Failed assumption.** A swipe or long-press is discoverable.
**Why.** It is a secret. Secrets exclude new users, assistive tech and remote inputs.
**Replacement.** A visible affordance plus a gesture accelerator. Every gesture has a
visible path.

---

## AP-006 — Modal everything

**Failed assumption.** A dialog focuses attention.
**Why.** It interrupts, stacks, traps focus, and makes recovery hard. Most dialogs are
better as inline states or a sheet.
**Replacement.** Inline states, progressive disclosure, sheets for transient tasks,
dialogs only for irreversible decisions or blocking errors.

---

## AP-007 — Whole-screen VNC as the remote model

**Failed assumption.** Remote means pixels.
**Why.** Bandwidth, latency, a second UI stack, no semantics, poor accessibility.
**Replacement.** Remote executor of structured commits; media streams as a declared
exception.

---

## AP-008 — Runtime frame diffing

**Failed assumption.** The system should discover what changed.
**Why.** Burns CPU, scales with screen size, and rediscovers what the producer knew.
**Replacement.** Declared damage from the producer; full-surface declaration when unknown.

---

## AP-009 — Global raw pointers or global buffer IDs

**Failed assumption.** A shared address is the simplest way to share pixels.
**Why.** Forgeable, retainable, no revocation, ambient authority, lifetime bugs.
**Replacement.** Capabilities: scoped, revocable, unforgeable.

---

## AP-010 — A second ECS / shadow scene tree

**Failed assumption.** The app framework and the system each need their own model.
**Why.** Two owners of composition state drift; every sync is a bug window.
**Replacement.** One ECS (MirUI) for app content; the authority owns stills; the policy owns
placement.

---

## AP-011 — Per-app damage trackers

**Failed assumption.** Every app should implement damage tracking.
**Why.** Duplicated work, inconsistent correctness, higher app burden.
**Replacement.** The framework tracks damage. An app that cannot declares the full surface.

---

## AP-012 — Fake aliveness

**Failed assumption.** Motion and pulsing chrome make the system feel responsive.
**Why.** It costs battery, distracts, violates idle-is-silent, and lies about work.
**Replacement.** Honest progress, settle-and-stop motion, `NOT REPORTED` where unknown.

---

## AP-013 — Infinite decorative animation

**Failed assumption.** A looping animation is delightful.
**Why.** It never lets the eye rest, costs GPU, and violates reduced-motion and safety.
**Replacement.** Motion only to explain a change; it settles and stops.

---

## AP-014 — Dark patterns

**Failed assumption.** Clever defaults increase engagement.
**Why.** They steal attention, data or money, destroy trust, and are incompatible with
`LAW-020`.
**Replacement.** Explicit consent, easy reversal, honest defaults, no pre-checked
observation.

---

## AP-015 — Notification spam

**Failed assumption.** More signals mean a more useful system.
**Why.** Attention is finite; alarm fatigue makes real warnings invisible.
**Replacement.** Priority, budgets, quiet hours, grouping, expiry, and a history the user
can audit.

---

## AP-016 — Platform mimicry

**Failed assumption.** Users want the OS to feel like the one they know.
**Why.** It imports assumptions that fail on other devices and guarantees we are a worse
copy.
**Replacement.** First-principles primitives, researched and scored.

---

## AP-017 — Design by screenshot

**Failed assumption.** A beautiful frame is a specification.
**Why.** It hides states, focus, failure, motion, accessibility and adaptation.
**Replacement.** Flows, frames, state machines, acceptance criteria.

---

## AP-018 — One-file app specification

**Failed assumption.** An app can be described in one document.
**Why.** It mixes purpose, behaviour, layout, input, accessibility and acceptance; review
is coarse; readers scroll through irrelevant material.
**Replacement.** The entity directory with one question per file.

---

## AP-019 — The panic spec

**Failed assumption.** A huge document written quickly protects the schedule.
**Why.** It cuts layers, hides open questions, and becomes code justification rather than
design.
**Replacement.** The gated corpus; many perspectives; explicit open questions; no code
before the gate.

---

## AP-020 — Hardcoded visual values

**Failed assumption.** A value is obvious enough to inline.
**Why.** It breaks theming, density, contrast, accessibility and reproducibility.
**Replacement.** Tokens only. A new value is a token proposal with a law and a test.

---

## AP-021 — Hover-only, right-click-only, long-press-only

**Failed assumption.** Every user has the same input device.
**Why.** Excludes touch, keyboard, remote, switch and voice; inaccessible by construction.
**Replacement.** Every operation has a visible, input-independent path; special inputs are
accelerators.

---

## AP-022 — A single "spacious" skin

**Failed assumption.** Spacious means bigger padding.
**Why.** It hides actions, breaks small screens, and changes hierarchy accidentally.
**Replacement.** A density mode with its own scale, action visibility and degradation
rules.

---

## AP-023 — Untested accessibility claims

**Failed assumption.** "We support screen readers" is a feature description.
**Why.** Without a path, focus order, names and announcements, it is a claim, not support.
**Replacement.** Structural semantics, per-flow focus and an acceptance transcript.

---

## AP-024 — Infinite scroll as the only navigation

**Failed assumption.** Users can always scroll further.
**Why.** No end, no position, no recovery, poor for keyboard and remote.
**Replacement.** Bounded pages or a virtualized list with an explicit end, position and
jump-to.

---

## AP-025 — The invisible default

**Failed assumption.** A default is harmless if the user can change it.
**Why.** Defaults decide behaviour for most people; an invisible default is a silent
policy.
**Replacement.** Defaults are documented, reversible, and visible where they matter.

---

## AP-026 — The one-true-density

**Failed assumption.** One layout works for every person and device.
**Why.** Reach, vision, context and input differ.
**Replacement.** Declared densities, envelope layout rules, user scaling, and no content
loss.

---

## AP-027 — The feature-first screen

**Failed assumption.** Every capability deserves a permanent control.
**Why.** The screen becomes a control panel; the task disappears.
**Replacement.** Task-first composition; capabilities in context, palette and progressive
disclosure.

---

## AP-028 — The "smart" silent action

**Failed assumption.** The system should act for the user without saying so.
**Why.** Loss of control, trust, and reproducibility; automation surprises.
**Replacement.** Visible automation, preview, undo, and an explicit mode.

---

## AP-029 — Safety-critical decoration

**Failed assumption.** A car or spacecraft UI should feel like a phone.
**Why.** Motion, glare, alarm fatigue and occlusion can kill.
**Replacement.** Safety motion profile, protected zones, alarm hierarchy, deterministic
timing.

---

## AP-030 — Documentation as an afterthought

**Failed assumption.** The code is the truth; docs can follow.
**Why.** The design decays, the next agent re-decides, and layers are cut silently.
**Replacement.** The canon is a deliverable; gates require it; the code is verified against
it.
