---
id: ARCH-PRESENT-AUTHORITY
title: The Presentation Authority
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-STILL, ARCH-PRESENT-COMMIT]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-001, AC-ARCH-PRESENT-002, AC-ARCH-PRESENT-003]
---

# The Presentation Authority

> The authority is the always-present component that validates commits, assigns
> still numbers, stores the current truth, and produces named rejections. It does
> not lay out or arbitrate. It is mandatory on every device that presents.

---

## 1. What the authority is

The presentation authority is a **role**, not a process. It validates commits,
numbers stills, owns the current truth, owns input ownership and focus owner,
tracks buffer lifetimes and observation rights, and produces named rejections.
It never rasterizes, never allocates a scanout buffer, never talks to a GPU, and
never decides placement. Those are policy and executor concerns.

Authority MUST exist exactly once per presentation domain. A presentation domain
may be one device, one seat, or one remote surface. Two authorities for one
still is a defect (`LAW-001`). A device with no authority is a peripheral, not
a presenter.

---

## 2. What the authority validates

On every commit (`02-commit.md` §8), the authority validates, in order:

1. Session validity and capability scope.
2. Surface ownership.
3. Buffer ownership and writable state.
4. Format match.
5. Fence validity.
6. Damage bounds.
7. Transform support.
8. Invariants INV-1 and INV-2.

Validation is mandatory and its result is recorded in the still history. The
authority MUST NOT infer any declaration: it MUST NOT diff a buffer, MUST NOT
guess a colour space, and MUST NOT assume a refresh rate when the display
validity flag is false (`display.capnp:267-376`).

---

## 3. What the authority numbers

The authority assigns the next still number for the output the commit targets.
Numbering rules (from `01-still.md` §3):

- Unique per output.
- Monotonic; never decreases.
- Never reused.
- Gapless; a gap is a defect.
- Durable across reboot, policy crash, executor swap, remote reconnection.

A rejected commit does not consume a still number. Only an accepted commit
produces a still. The number is assigned at validation success, before the
executor realizes the still; if realization fails, the still is recorded as
degraded and the number is still consumed (the truth includes the failure).

---

## 4. What the authority owns

| Fact | How it is owned | Schema anchor |
|---|---|---|
| Current still number per output | authority-internal | gap G-01 (no schema field) |
| Still history (numbered records) | authority-internal | gap G-01 |
| Input ownership (focus owner, capture leases) | authority-internal | `surface.capnp:323-336` (hit/input region) |
| Buffer lifetime state | authority-internal + buffer service | `compositor.capnp:572-577`, `surface.capnp:168-171` |
| Observation rights (who may observe which still) | authority-internal | `capability.capnp` (capability scoping) |
| Rejection log | authority-internal | `framebuffer.capnp:248-266` (AtomicRejection pattern) |

---

## 5. Crash-safe truth

The authority's state is the only state that must survive a crash. Policy and
executor state is disposable. On restart, the authority restores its last still
number and still record from durable storage; the new policy adopts the current
still (`08-crash-recovery.md`). The authority MUST persist the still number and
the still record at least at every accepted commit; a crash between commits
loses nothing because nothing was committed.

---

## 6. Authority and policy

Policy is optional. When present, the authority queries it for a plan (total
order, geometry, focus candidate) after validating a commit and before
presenting. The plan is an **input**, never an override of validation. If
policy is absent, crashed, or timed out, the authority applies the deterministic
default policy (`04-policy.md` §6) and continues presenting. Killing the policy
leaves stills intact and input leases expiring (`AC-ARCH-PRESENT-001`).

---

## 7. Authority and executor

The executor is replaceable. The authority hands it a plan and buffer handles
and expects either realization or a typed rejection. The executor MUST NOT be
the authority for any fact (`01-model.md` INV-3). If the executor cannot
realize a still, it reports `AtomicRejection` semantics
(`framebuffer.capnp:248-266`) or the path-specific equivalent; it does not
approximate without declaring degradation.

---

## 8. Authority and observation

Who may observe a still is governed by capabilities and observation rights
(`10-observation.md`). The authority checks a capability before granting any
observation handle. No observer reads a buffer without a capability, even with
a valid still number (`AC-ARCH-PRESENT-010`).

---

## 9. Mandatory on every presenter

Every device that presents has an authority. The envelope table in
`01-model.md` §6 shows authority placement per envelope. A headless device has
an authority with a sink executor. A remote browser's authority is remote; the
local browser is an executor.

---

## 10. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-001` | A kill of the policy leaves stills intact and input leases expiring. |
| `AC-ARCH-PRESENT-002` | A kill of the executor leaves the still and the authority intact. |
| `AC-ARCH-PRESENT-003` | Every commit produces either a numbered still or a named rejection. |
| `AC-ARCH-PRESENT-015` | Two authorities for one output is detected and rejected at startup. |
| `AC-ARCH-PRESENT-016` | The authority's last still number survives a reboot and the new policy adopts it. |
| `AC-ARCH-PRESENT-017` | The authority never reads a pixel buffer; instrumented builds assert zero buffer reads in the authority process. |

---

## 11. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-AUTH-001` | Schema gap G-01: no field for still number. Propose adding `stillNumber` to a new `StillRecord` struct or to `FrameSignal`. | Architecture Editor | open |
| `OQ-AUTH-002` | Should the authority expose a "current still" subscription or must observers poll? | Architecture Editor | proposed |

---

## 12. References

- Dennis, J. B. & Van Horn, E. C. (1966). *Programming semantics for
  multiprogrammed computations.* CACM 9(3). https://dl.acm.org/doi/10.1145/365230.365252
- Miller, M. S. (2006). *Robust Composition.* https://www.erights.org/talks/thesis/
- Wayland protocol. https://wayland.freedesktop.org/docs/html/