---
id: ARCH-PRESENT-CRASH
title: Crash Recovery
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY, ARCH-PRESENT-POLICY, ARCH-PRESENT-EXECUTOR]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-001, AC-ARCH-PRESENT-002, AC-ARCH-PRESENT-008]
---

# Crash Recovery

> Policy crash, executor crash, authority survives. Adoption, still preservation.
> The screen may flicker; the truth does not.

---

## 1. What survives

The authority survives. Its state — last still number, still record, input
ownership, buffer lifetimes, observation rights — is the only state that must
survive. Policy and executor state is disposable (`LAW-015`).

---

## 2. Policy crash

1. Authority detects policy death (process exit, timeout, or heartbeat loss).
2. Authority applies the deterministic default policy (`04-policy.md` §6).
3. Stills remain visible via the executor.
4. Input leases expire safely (revocation events delivered).
5. A new policy may adopt the current truth; the authority provides the current
   still number and plan inputs.
6. No still number is invalidated; no pixels change because of the crash.

`AC-ARCH-PRESENT-001`: policy kill leaves stills intact and leases expiring.

---

## 3. Executor crash

1. Authority detects executor death.
2. Authority retains the still and the still number.
3. A new executor is attached; authority provides the current still number, plan,
   and buffer handles.
4. The new executor realizes the still or reports a typed rejection.
5. The screen may go blank briefly; the truth is preserved.

`AC-ARCH-PRESENT-002`: executor kill leaves still and authority intact.

---

## 4. Authority crash

Authority crash is the one case the system cannot absorb transparently. The
device fails honestly: the screen shows a recovery state, not a stale or
fabricated image. On restart, the authority restores its last persisted still
number and still record; policy and executor are re-attached. A still number
gap after an authority crash is permitted only if recorded as a recovery event
in the still history (not a silent gap).

---

## 5. Adoption

Adoption is the process by which a new policy or executor takes over the
current truth. The authority provides:

- current still number per output;
- current still record (pixels ref, hit map, a11y, input ownership, buffer
  lifetimes);
- current capability set.

The new component does not reconstruct; it adopts.

---

## 6. Still preservation

Numbered stills are immutable and durable. A crash does not erase them. After
recovery, the last still number is the current truth and the still history is
intact. Forensics can still answer "what did the user see?"

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-001` | Policy kill leaves stills intact and leases expiring. |
| `AC-ARCH-PRESENT-002` | Executor kill leaves still and authority intact. |
| `AC-ARCH-PRESENT-008` | Policy crash does not invalidate current still; new policy adopts it. |
| `AC-ARCH-PRESENT-028` | Authority crash results in honest recovery state, not stale image. |
| `AC-ARCH-PRESENT-029` | After recovery, last still number is current and history intact. |

---

## 8. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-CRASH-001` | How is authority state persisted (fsync cadence, storage)? | Architecture Editor | proposed |
| `OQ-CRASH-002` | What is the maximum acceptable blank-screen duration on executor crash? | Architecture Editor | proposed |

---

## 9. References

- Wayland, compositor restart. https://wayland.freedesktop.org/docs/html/
- Android SurfaceFlinger. https://source.android.com/docs/core/graphics/architecture