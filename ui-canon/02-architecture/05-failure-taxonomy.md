---
id: ARCH-FAILURE-01
title: Failure Taxonomy
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [ARCH-MODEL-01, ARCH-BUFFER-01, ARCH-PATHS-01]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-FAIL-001, AC-ARCH-FAIL-002, AC-ARCH-FAIL-003]
---

# Failure Taxonomy

> A failure is not an exception. It is a still outcome with a reason, a recovery, and a
> statement of what the user can still trust. "It crashed" is not a taxonomy.

Every failure below is classified by **where it is detected**, **what it invalidates**,
**what the next still contains**, and **what the authority still guarantees**. No failure
may produce an unnumbered change to the visible world.

---

## 1. Failure classes

| ID | Class | Detected by | Invalidates | Next still |
|---|---|---|---|---|
| F-01 | malformed commit | authority | this commit | prior still, rejection event |
| F-02 | unauthorized commit | authority | this commit | prior still, denial event |
| F-03 | unknown surface/session | authority | this commit | prior still, rejection |
| F-04 | buffer not owned / stale generation | authority | this commit | prior still, rejection |
| F-05 | format/transform mismatch | authority or executor | this contribution | degraded or rejected |
| F-06 | fence failed | authority/executor | this contribution | prior contribution or failed still |
| F-07 | fence timeout | executor | this path | failed still, path reset |
| F-08 | resource exhaustion | buffer/GPU/authority | admission of new work | prior still, admission refusal |
| F-09 | GPU hang / device lost | GPU service | GPU path | CPU/remote degraded still |
| F-10 | scanout commit failure | display executor | output still | prior still, output degraded |
| F-11 | output hotplug/loss | display service | output mapping | reconfigured stills |
| F-12 | policy absent/crashed/timeout | authority | plan | default plan still |
| F-13 | authority restart | runtime supervisor | still history epoch | new epoch still, never silent continuity |
| F-14 | producer crash | authority | producer surfaces | surfaces withdrawn, still valid |
| F-15 | input path loss | input service | input ownership | still with input suspended |
| F-16 | accessibility snapshot stale | authority | a11y fact | still marked a11y-degraded |
| F-17 | clock discontinuity | runtime | pacing/ordering | still with new clock epoch |
| F-18 | remote transport loss | ecosystem runtime | remote contributions | local still or remote withdrawn |
| F-19 | remote peer refusal | remote peer | remote contribution | local fallback or degraded |
| F-20 | capture grant expiry | capture service | capture/stream | stream stopped, UI notified |
| F-21 | capability revocation | security service | affected operations | still with surface withdrawn/redacted |
| F-22 | trust downgrade | device service | remote input/output | remote demoted or disconnected |
| F-23 | thermal/power limit | power service | path quality | degraded but honest still |
| F-24 | update/integrity failure | update service | service start | prior version or safe mode |
| F-25 | storage/state failure | runtime state | continuity data | fresh state, explicit loss |
| F-26 | security violation (attempted) | security service | offending operation | still unchanged, audit entry |

---

## 2. Failure record

Every failure produces a record with the following fields. The record is part of the
still history; it is not a log line that may be dropped.

```
FailureRecord {
  id                 stable, never reused
  class              F-01..F-26
  detectedAt         monotonic timestamp + clock epoch
  detectedBy         authority | executor | policy | peer | service
  session            T.SessionId if known
  surface            T.SurfaceId if known
  output             T.OutputId if known
  buffer             handle + generation if known
  still              last valid still number
  attemptedStill     the still that failed, if it was numbered
  reason             typed reason or schema error
  evidence           fence state, rejection enum, transport status
  recovery           none | retry | fallback | reset | quarantine
  userVisible        bool
  stillEffect        none | contribution-degraded | still-failed | path-failed
}
```

**MUST.** A failure that changes what the user sees MUST have `userVisible=true` and MUST
be reflected in the still's degradation field. A silent degradation is a lie.

---

## 3. What remains true

For each class, the authority's guarantee. This is the part users and tests rely on.

### 3.1 Commit failures (F-01..F-04)

- The last valid still remains visible and remains the input truth.
- Nothing is partially applied: no half-updated surface, no new hit map with old pixels.
- The producer receives a typed rejection with the schema error or reason.
- The authority MUST NOT terminate the session for a malformed commit unless the
  session is malicious (repeat + capability violation); it rejects and records.

### 3.2 Rendering failures (F-05..F-10)

- The still is either realized exactly or explicitly degraded per contribution.
- A GPU hang does not freeze the UI: the authority falls back to CPU or remote within
  the degradation budget, and records the fallback.
- A scanout failure leaves the previous still on screen and does not claim the new one.
- A format mismatch is never "fixed" by reinterpreting bytes.

### 3.3 Infrastructure failures (F-11..F-17)

- Output loss: stills for that output stop; other outputs continue; the authority records
  the output's last still and does not invent a replacement mode.
- Policy failure: default policy is deterministic and documented; the still is valid.
- Authority restart: a new epoch starts. Old still numbers are not reused. Clients must
  re-handshake. The UI MUST NOT pretend continuity.
- Producer crash: surfaces are withdrawn atomically; their buffers are orphaned and
  released only after safe reclaim.
- Input loss: the still remains visible; input ownership becomes `suspended`; the user
  is told which input is unavailable.
- Clock discontinuity: pacing resumes on the new epoch; present intents in the old epoch
  are invalid, not late.

### 3.4 Ecosystem failures (F-18..F-22)

- Remote loss: the remote contribution is withdrawn or frozen with a declared
  `last-seen`; local contributions continue.
- Remote refusal: the authority may fall back locally or show a declared placeholder;
  it MUST NOT show the remote content as if it were current.
- Revocation: affected surfaces/operations stop at the next still; in-flight pixels may
  finish only if policy permits, and the still records the revocation.
- Trust downgrade: remote input is suspended first, then output; the authority records
  the new trust level.

### 3.5 Resource and integrity failures (F-23..F-26)

- Thermal/power: quality degrades in declared steps. The still remains correct; only
  observation quality (resolution, frame rate, effects) may drop. Truth never degrades.
- Update failure: the running version continues or safe mode starts. The UI MUST NOT
  claim an update succeeded.
- State failure: continuity data is lost explicitly; the UI says what was lost.
- Security violation: the offending operation is refused; the still is unchanged; the
  audit entry is immutable.

---

## 4. Failure → still state machine

```
                 commit
                   │
        ┌──────────┴──────────┐
        │                     │
   valid & realizable    invalid/unrealizable
        │                     │
        ▼                     ▼
   still N (valid)      still N-1 remains
        │                     │
        │              ┌──────┴───────┐
        │              │              │
        │         recoverable?     not recoverable
        │              │              │
        │              ▼              ▼
        │        still N (degraded)  still N (failed)
        │              │              │
        └──────────────┴──────────────┘
                       │
                       ▼
                 history record
```

**MUST.** A failed still number is consumed and never reused. The next successful still
has a higher number. This makes gaps observable and prevents ambiguity.

---

## 5. Retry policy

Retry is allowed only when the failure is **transient** and the commit is still valid.

| Class | Retry? | Bound | On exhaustion |
|---|---|---|---|
| F-06 fence pending | yes | until present deadline | F-07 |
| F-07 timeout | no (reset path) | — | degraded fallback |
| F-08 resource | yes, admission only | declared queue bound | reject new work |
| F-09 GPU lost | no (switch path) | — | CPU/remote |
| F-12 policy | no (default) | — | default plan |
| F-18 transport | yes, session-scoped | declared reconnect budget | withdraw remote |
| F-19 peer refusal | no for same config | — | fallback |
| F-23 thermal | yes, quality step | until floor | degraded floor |

**MUST NOT.** Retrying a failed fence or a rejected commit MUST NOT use the same still
number. A retry is a new attempt, with a new still number if it reaches presentation.

---

## 6. User-visible failure language

The architecture does not define copy, but it defines what must be communicable:

| Situation | Must be communicable | Must not be claimed |
|---|---|---|
| Commit rejected | the app's frame was not shown; why (generic class) | "your device is broken" |
| Remote frozen | last update time; stale | "live" |
| GPU fallback | reduced performance, not reduced truth | "everything is fine" |
| Output lost | which output; what moved | a fabricated mode |
| Authority restart | session restarted; state preserved/lost | seamless continuity |
| Capture stopped | why (grant expired/revoked) | "still recording" |
| Trust downgraded | remote input/output limited | "paired and trusted" |

The shell copy lives in `04-shell`; the architecture only guarantees the facts are
available and cannot be suppressed.

---

## 7. Recovery and quarantine

- **Retry** re-attempts a bounded operation.
- **Fallback** switches path and records the degradation.
- **Reset** tears down a path (GPU context, remote session, scanout state) and rebuilds;
  buffers in flight become `failed` unless a fence proves completion.
- **Quarantine** removes a service or device from the eligible set
  (`discovery.capnp:171-219` exposes `quarantined`, `faultCount`, `consecutiveFaults`,
  `restarts`). The authority must not route stills to a quarantined executor.
- **Safe mode** is a runtime decision (`runtime/13-degradation.md`), never an
  architecture exception: stills are still numbered and honest.

---

## 8. Failure injection acceptance

- **AC-ARCH-FAIL-001** — For each F-01..F-26, inject the failure at its detection point
  and assert: (a) no unnumbered visible change, (b) a failure record exists, (c) the
  still effect matches §3, (d) recovery terminates in bounded time.
- **AC-ARCH-FAIL-002** — Cascading failure: kill authority, policy, GPU, and one remote
  peer in sequence. Assert every surviving still is valid or explicitly degraded and no
  still number is reused.
- **AC-ARCH-FAIL-003** — Silent-degradation detector: any still whose content differs
  from its declarations MUST be flagged; a degraded still MUST be externally observable.

Traceability: `08-acceptance.md`.
