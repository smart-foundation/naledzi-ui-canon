---
id: FOUND-MOTION-ASSISTIVE-09
title: Assistive Motion
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, FOUND-MOTION-REDUCED-04, LAW-009, LAW-011]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-090, AC-FOUND-MOTION-091, AC-FOUND-MOTION-092]
---

# Assistive Motion

> Motion is a visual explanation. A person who cannot see it, or who uses a switch, still
> needs the explanation. The explanation is the state change, announced, not the travel.

---

## 1. The principle

Motion explains change (`LAW-008`). In a non-visual path the change is still explained,
but by an announcement, a focus move, a value update or a haptic, never by travel. The
travel was never the information; the state change was. This is the same split that
reduced motion makes, applied to every non-visual output.

- **FOUND-MOTION-340.** A non-visual path MUST receive the state change, not the motion.
  Conveying travel instead of state is forbidden.
- **FOUND-MOTION-341.** Motion MUST NOT be the only carrier of a state change. If a
  screen reader, switch or braille user cannot complete the flow, the motion is
  decorative and must be removed (`LAW-009`).

---

## 2. What each assistive path receives

| Path | What it receives instead of motion | Timing |
|---|---|---|
| Screen reader (voice) | An announcement of the state change ("Dialog opened", "Item deleted", "Value changed to 42") | In the same still as the visual change |
| Screen reader (braille) | A refresh of the current line/region; no travel | In the same still |
| Switch access | Focus moves to the new surface in the same still; no animation | Instant |
| Voice control | The target is addressable by name; no motion needed | n/a |
| Haptic | A single pulse for the state change, if the envelope supports haptics | In the same still |
| Audio cue | A short, non-speech sound for the state change (sound-haptics foundation) | In the same still |

Rules:

- **FOUND-MOTION-350.** The accessibility snapshot MUST update in the same still as the
  pixels, including any motion-driven change (`LAW-005`, `LAW-009`).
- **FOUND-MOTION-351.** A focus move caused by a motion (for example a dialog opening)
  MUST place focus on the new surface in the same still; it MUST NOT wait for the motion
  to settle.
- **FOUND-MOTION-352.** An announcement MUST describe the state change in plain language,
  not the motion ("the dialog opened", not "the dialog slid in").
- **FOUND-MOTION-353.** A haptic or audio cue for a state change MUST fire once, in the
  same still, and MUST NOT repeat or loop.

---

## 3. Per-choreography assistive behaviour

| Choreography | Visual | Assistive |
|---|---|---|
| Enter (dialog/sheet) | Spring enter | Focus moves to the new surface; announcement "Dialog opened" |
| Exit | Spring exit | Focus returns to invoker or fallback; announcement "Dialog closed" |
| Shared element | Geometry spring | Focus follows the element; announcement of the new context |
| Stagger | Sequential entry | All items announced as a list update; no per-item travel |
| Gesture settle | Spring settle | Value/state update announced on settle; no motion |
| Value tick | Spring on value | New value announced (or aria-live region updated) |
| Safety alert | `SPRING-SAFETY` enter | Alert announced first, before any other announcement; focus moves to alert |

Rules:

- **FOUND-MOTION-360.** An assistive path MUST NOT depend on a motion completing. If a
  flow requires the motion to finish before the next step, the motion is a blocker and is
  forbidden.
- **FOUND-MOTION-361.** A safety alert's announcement MUST precede all other
  announcements in the same still.
- **FOUND-MOTION-362.** A switch user MUST be able to complete every flow without any
  motion occurring; motion is never on the critical path for switch access.

---

## 4. Reduced motion and assistive paths

Reduced motion and assistive paths are independent but aligned: both remove travel and
keep the state change. A person using a screen reader with reduced motion on receives
the same announcements as without; the only difference is that the visual travel is also
gone.

- **FOUND-MOTION-370.** Enabling reduced motion MUST NOT change the assistive output.
  The announcements, focus moves and haptics are identical.
- **FOUND-MOTION-371.** A person using both a screen reader and reduced motion MUST
  receive the state change once, not twice.

---

## 5. What this model refuses

- A state change that is only communicated by motion.
- An announcement that describes the motion rather than the state.
- Focus that waits for a motion to settle.
- A flow that requires motion to complete.
- A haptic or audio cue that repeats.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-090` | Read each reference flow with a screen reader; every state change is announced in the same still as the visual change. |
| `AC-FOUND-MOTION-091` | Complete each reference flow with switch access and no motion enabled; every flow completes. |
| `AC-FOUND-MOTION-092` | Enable reduced motion and a screen reader together; announcements are identical to reduced-motion-off; no duplicate. |