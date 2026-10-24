---
id: ARCH-PRESENT-INTENT
title: Present Intent
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-COMMIT]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-037, AC-ARCH-PRESENT-038]
---

# Present Intent

> When the producer wants the commit visible: immediate, next vsync, after a
> fence, at a named time. Intent interacts with damage and fences.

---

## 1. The PresentIntent union

`compositor.capnp:564-571` and `surface.capnp` PresentIntent:

- `immediate @0 :Void` — as soon as possible.
- `nextVsync @1 :Void` — at the next vertical sync.
- `atTime @2 :T.Timestamp` — at a named wall time.
- `periodic @3 :T.Duration` (surface.capnp only) — repeating cadence.
- `custom @4 :Data` (surface.capnp) — backend-specific scheduling.

---

## 2. Intent and damage

Damage declares what changed; intent declares when. They are independent: a
commit may declare full damage with `nextVsync` intent, or rect damage with
`immediate`. The executor applies both: it composites the damaged region and
presents at the requested time. If the requested time has passed, the executor
presents at the next opportunity and records the slip in `FrameSignal.onTime`
/ `FrameSignal.dropped` (`compositor.capnp` FrameSignal struct).

---

## 3. Intent and fences

A commit with `atTime` intent and a fence that is not yet signaled is held
until the fence signals; if the fence times out, the commit is rejected
(`fence-timeout`). The producer may choose `immediate` with a fence to let the
executor wait on the fence and present as soon as safe.

---

## 4. Pacing

The authority returns a `FrameSignal` (`compositor.capnp` FrameSignal struct)
in the ack: `nextPresentTime`, `framePeriod`, `lastPresentTime`, `onTime`,
`dropped`. The producer uses these to pace future commits. Pacing is advisory;
the authority still numbers every accepted commit.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-037` | A commit with `atTime` intent is presented at or after the named time; slip is recorded. |
| `AC-ARCH-PRESENT-038` | A commit whose fence times out under `atTime` intent is rejected by name. |
| `AC-ARCH-PRESENT-039` | `FrameSignal` is delivered in the ack and usable for pacing. |

---

## 6. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-INTENT-001` | Should `periodic` intent be promoted into `compositor.capnp` PresentIntent? | Architecture Editor | proposed |

---

## 7. References

- Wayland, frame callbacks and presentation time. https://wayland.freedesktop.org/docs/html/
- Android, Choreographer. https://developer.android.com/reference/android/view/Choreographer