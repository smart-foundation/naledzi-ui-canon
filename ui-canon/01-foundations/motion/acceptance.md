---
id: FOUND-MOTION-ACCEPT-16
title: Motion Acceptance
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, FOUND-MOTION-CHOREO-02, FOUND-MOTION-DETERM-03, FOUND-MOTION-REDUCED-04, FOUND-MOTION-SAFETY-05, FOUND-MOTION-TOKENS-06, FOUND-MOTION-RULES-07, FOUND-MOTION-ENVELOPES-08, FOUND-MOTION-ASSISTIVE-09, FOUND-MOTION-PERF-10, FOUND-MOTION-FAILURE-11]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-1000, AC-FOUND-MOTION-1001, AC-FOUND-MOTION-1002]
---

# Motion Acceptance

> Every criterion here can fail. A criterion that cannot fail is a slogan.

---

## 1. The reference set

The tests use five reference motions, built once and reused by every foundation:

| Reference | What it contains | Why it is in the set |
|---|---|---|
| `REF-MOTION-ENTER` | A dialog entering and settling | Exercises enter, settle, interrupt |
| `REF-MOTION-GESTURE` | A list row dragged and released with measured velocity | Exercises gesture handoff, settle |
| `REF-MOTION-SHARED` | A thumbnail opening into a full image | Exercises shared element, geometry spring |
| `REF-MOTION-STAGGER` | A list of 6 items entering with stagger | Exercises stagger, cancellation |
| `REF-MOTION-SAFETY` | An EV frame with speed, range and a critical warning | Exercises safety motion, protected zones |

---

## 2. Structural acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-1000` | Every file listed in `children` exists and is listed | Tree audit | 100%, zero missing |
| `AC-FOUND-MOTION-1001` | No `TODO`, empty section or "similar to" | Grep | Zero matches |
| `AC-FOUND-MOTION-1002` | Every motion in the reference set is a named spring | Static inspection | 100% |
| `AC-FOUND-MOTION-1003` | Every named spring declares all five fields | Conformance script | Zero incomplete |
| `AC-FOUND-MOTION-1004` | Every `FOUND-MOTION-*` rule appears in a model or token file | Cross-reference | Zero orphan rules |

---

## 3. Interaction acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-020` | Interrupt each choreography at three arbitrary frames; no jump; velocity continuous | Slow-motion capture at 120 Hz | Zero jumps |
| `AC-FOUND-MOTION-021` | A shared-element transition keeps at least one of source or destination visible in every frame | Frame-by-frame still inspection | 100% of frames |
| `AC-FOUND-MOTION-022` | A flick above throw threshold pages; a release below it returns to current snap point | Scripted gesture test | Matches reference recording |
| `AC-FOUND-MOTION-010` | Retarget a spring mid-flight; x and v continuous across the retarget frame | Slow-motion capture | Zero discontinuity |
| `AC-FOUND-MOTION-011` | Release a dragged surface; measured release velocity becomes initial velocity | Scripted gesture + profiler | Matches reference recording |
| `AC-FOUND-MOTION-012` | Every spring settles and stops scheduling within its bound | 10-minute run | Idle wakeups zero |
| `AC-FOUND-MOTION-051` | A transition that would cross a protected zone is rejected; previous still remains | Scripted safety injection | Zero crossings |

---

## 4. Rate acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-030` | Same motion at 60, 90, 120, 144 Hz; final position within 0.5 px; settle time within 8 ms | Automated cross-rate test | All four rates pass |
| `AC-FOUND-MOTION-031` | A 50 ms frame stall during motion; 4 steps advance; no explosion, no teleport, no NaN | Fault injection | Pass |
| `AC-FOUND-MOTION-032` | 10-minute run on 60 Hz; no drift in settle position above 0.5 px | Long-run test | Pass |
| `AC-FOUND-MOTION-033` | Idle surface schedules zero motion work over 10 minutes | Idle test | Zero wakeups |

---

## 5. Adaptation acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-040` | Enable reduced motion via each of three channels; motion reduces per §3 | Toggle test | All channels pass |
| `AC-FOUND-MOTION-041` | With reduced motion on, every state change still occurs and is visible or announced | Flow run | 100% |
| `AC-FOUND-MOTION-042` | No motion in default mode exceeds §4 thresholds (25% travel, combined) | Measurement | Pass |
| `AC-FOUND-MOTION-043` | Safety motion unchanged under reduced motion | Toggle test | Unchanged |
| `AC-FOUND-MOTION-044` | No surface flashes above 3 Hz in any mode | Frame capture | Pass |
| `AC-FOUND-MOTION-023` | Under reduced motion, stagger removed; all items appear together | Flow run | Pass |

---

## 6. Safety acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-050` | EV and spaceship reference flows; every spring uses `SPRING-SAFETY` or stricter; no overshoot | Static + measurement | Pass |
| `AC-FOUND-MOTION-052` | Safety alert during non-safety motion; non-safety yields; alert within 200 ms; resumes without jump | Scripted injection | Pass |
| `AC-FOUND-MOTION-053` | Reduced motion leaves safety motion unchanged | Toggle test | Pass |
| `AC-FOUND-MOTION-054` | No critical indicator occluded at any frame of safety reference flow at 1 m and 4 m | Render at distances | Zero occlusions |

---

## 7. Performance acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-100` | Motion CPU ≤ 0.6 ms on watch reference; ≤ 0.9 ms on desktop | Profiler | Pass |
| `AC-FOUND-MOTION-101` | Idle surfaces schedule zero motion work over 10 minutes | Idle test | Zero |
| `AC-FOUND-MOTION-102` | Damage during motion limited to animating surface | Damage trace | Pass |
| `AC-FOUND-MOTION-103` | Under load, degradation follows the ladder in order and is observable | Load test | Pass |

---

## 8. Assistive acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-090` | Read each reference flow with a screen reader; every state change announced in the same still | Screen-reader run | Pass |
| `AC-FOUND-MOTION-091` | Complete each reference flow with switch access and no motion | Switch run | Pass |
| `AC-FOUND-MOTION-092` | Reduced motion + screen reader together; announcements identical; no duplicate | Combined run | Pass |

---

## 9. Failure acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-110` | Force a spring to not settle; force-settles at hard max; logs; final position is target | Fault injection | Pass |
| `AC-FOUND-MOTION-111` | Cancel a gesture mid-flight via system event; returns to last stable position without jump | Fault injection | Pass |
| `AC-FOUND-MOTION-112` | Expire an input lease during a gesture; gesture cancels; in-flight spring continues | Fault injection | Pass |
| `AC-FOUND-MOTION-113` | Sustain 50 ms frame drop for 2 s; spring settles within hard max; no NaN; warning logged | Fault injection | Pass |
| `AC-FOUND-MOTION-114` | Disconnect/reconnect display during motion; current interpolated state committed on reconnect | Fault injection | Pass |

---

## 10. Token acceptance

| ID | Criterion | Method | Pass condition |
|---|---|---|---|
| `AC-FOUND-MOTION-060` | Every named spring token declares all five fields | Conformance script | Zero incomplete |
| `AC-FOUND-MOTION-061` | Every envelope uses only its declared available set | Conformance script | Zero violations |
| `AC-FOUND-MOTION-062` | Every spring settles within its hard max on reference surfaces | Measurement | Pass |

---

## 11. Traceability

| Need | Foundation rule | Proposed token | Component | AC |
|---|---|---|---|---|
| Explain a change | `FOUND-MOTION-001` | `TOK-MOTION-SPRING-*` | All | `AC-FOUND-MOTION-001` |
| Settle and stop | `FOUND-MOTION-003`, `FOUND-MOTION-040` | `TOK-MOTION-EPS-*` | All | `AC-FOUND-MOTION-012` |
| Interrupt without jump | `FOUND-MOTION-004`, `FOUND-MOTION-020` | `TOK-MOTION-SPRING-*` | All | `AC-FOUND-MOTION-010` |
| Gesture handoff | `FOUND-MOTION-030`, `FOUND-MOTION-091` | `TOK-MOTION-VELOCITY-WINDOW` | `COMP-*` | `AC-FOUND-MOTION-011` |
| Determinism across rates | `FOUND-MOTION-140` to `-193` | `TOK-MOTION-SIM-STEP` | Engine | `AC-FOUND-MOTION-030` |
| Reduced motion | `FOUND-MOTION-220` to `-223` | `TOK-MOTION-SPRING-REDUCED` | All | `AC-FOUND-MOTION-041` |
| Safety motion | `FOUND-MOTION-260` to `-293` | `TOK-MOTION-SPRING-SAFETY` | Safety | `AC-FOUND-MOTION-054` |
| No decorative parallax | `FOUND-MOTION-130`, `FOUND-DEPTH-110` | n/a | All | `AC-FOUND-MOTION-042` |
| Critical indicator never occluded | `FOUND-MOTION-270`, `FOUND-MOTION-271` | `TOK-DEPTH-MATERIAL-SAFETY` | `COMP-ALERT` | `AC-FOUND-MOTION-054` |

---

## 12. Sign-off checklist

- [ ] All 16 files exist and are listed in the README.
- [ ] Every `FOUND-MOTION-*` rule has at least one AC.
- [ ] Every AC has a method and a pass condition.
- [ ] The five reference motions are specified.
- [ ] The ten envelope rows are filled.
- [ ] Cross-rate determinism passes at 60/90/120/144 Hz.
- [ ] Reduced-motion, switch and screen-reader paths pass.
- [ ] Safety reference passes at 1 m and 4 m.
- [ ] Performance budget measured on the weakest envelope.
- [ ] Open questions have owners and deadlines.

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-1000` | The structural, interaction, rate, adaptation, safety, performance, assistive, failure and token tables above are executed; every pass condition is met. |
| `AC-FOUND-MOTION-1001` | A second team can implement the five reference motions from this directory and pass the same tests without asking a motion question. |
| `AC-FOUND-MOTION-1002` | The sign-off checklist is complete, with the name of the reviewer and the date. |
