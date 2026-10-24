---
id: ARCH-PRESENT-REJECTIONS
title: Rejections
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-COMMIT]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-003, AC-ARCH-PRESENT-006]
---

# Rejections

> A rejection is a named refusal of a commit, with the failed invariant and the
> culprit. Never a silent drop. The user sees an honest state, not a fake
> success.

---

## 1. What a rejection is

A rejection is the authority's typed answer when a commit cannot produce a
numbered still. It names the failed invariant and the culprit (surface, buffer,
session, fence). It is recorded in the still history and delivered to the
producer. It never silently disappears.

Pattern: `AtomicRejection` (`framebuffer.capnp:248-266`) —
`target :AtomicTargetKind`, `targetId :UInt64` (legacy), `reason :T.Error`,
`typedId :AtomicTargetId`. The presentation layer generalizes this pattern to
commit rejections.

---

## 2. Named rejection classes

| Class | Failed invariant | What the user sees |
|---|---|---|
| `buffer-format-mismatch` | declared format != buffer format | previous still remains; producer may retry with correct format |
| `fence-already-failed` | fence failed before commit | previous still remains; producer resubmits with a fresh fence |
| `fence-timeout` | fence not signaled in time | previous still remains; degraded if repeated |
| `damage-out-of-bounds` | rects outside surface bounds | previous still remains; producer fixes damage |
| `capability-denied` | session lacks the right | previous still remains; UI shows denied state with reason |
| `buffer-not-owned` | buffer not owned by session | previous still remains; producer fixes ownership |
| `buffer-not-writable` | buffer not in writable state | previous still remains; producer waits for release |
| `surface-not-owned` | surface not owned by session | previous still remains |
| `session-dead` | session gone | commit discarded; session teardown |
| `transform-unsupported` | orientation not supported | previous still remains |
| `still-number-collision` | internal defect | system failure; honest error |

---

## 3. What the user sees

On rejection, the previous numbered still remains current. The user sees no
change (or a declared degraded state if the authority chooses). The authority
never fakes success: a rejected commit does not advance the still number and
does not alter pixels. The producer receives the rejection by name and may
retry, degrade, or surface an error to the person.

---

## 4. Rejection and honesty

`LAW-011` (honesty over polish): unsupported, denied, unknown states MUST be
shown as such. A rejection is such a state. The UI must not hide it or fabricate
a success. A capability denial becomes a visible state with a reason and a path
to request it.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-003` | Every commit produces either a numbered still or a named rejection. |
| `AC-ARCH-PRESENT-006` | No commit is silently dropped. |
| `AC-ARCH-PRESENT-026` | Each rejection class in §2 has a test exercising it. |
| `AC-ARCH-PRESENT-027` | A rejected commit leaves the previous still current and the still number unchanged. |

---

## 6. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-REJ-001` | Should rejections carry a retry-after hint? | Architecture Editor | proposed |

---

## 7. References

- `framebuffer.capnp:248-266` AtomicRejection.
- Wayland, error protocol. https://wayland.freedesktop.org/docs/html/