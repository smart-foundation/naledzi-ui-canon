---
id: ARCH-PRESENT-INPUT
title: Input Ownership
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-022, AC-ARCH-PRESENT-023]
---

# Input Ownership

> The authority owns input ownership: which session owns pointer/keyboard/touch,
> which surface has focus, which holds capture leases. Input goes to what the
> user sees, never to what an app thinks is there.

---

## 1. What input ownership is

Input ownership is part of the numbered still. For each still, the authority
records:

- which session owns pointer, keyboard, touch;
- which surface holds focus;
- which surfaces hold capture leases (time-bound, revocable rights to receive
  input during a drag or gesture, per glossary "Capture lease").

Because input ownership is part of the still, a move and a click cannot
disagree: the hit map and the input owner are one fact.

---

## 2. Focus owner

The focus owner is the surface that receives keyboard input and is the default
target for assistive technology. Policy may propose a focus candidate; the
authority decides. Focus is recorded per still and is immutable for that still.

Focus rules:

- A surface that is not visible cannot hold focus.
- A surface that is destroyed releases focus to the authority's default
  (most recently committed input-accepting surface).
- Focus transfer is a state change and produces a new still.

---

## 3. Capture leases

A capture lease is a time-bound, revocable right to receive input during a drag
or gesture. Leases are:

- scoped to a surface and a gesture;
- time-bound with an expiry;
- revocable by the authority at any time (e.g., on policy crash, session end,
  or capability revocation);
- recorded in the still so observers see who holds input.

A lease that expires is not a failure; it is a normal end. A lease that is
revoked mid-operation must not crash the holder; the holder receives a typed
revocation event and degrades gracefully (`security/02-capability-revocation.md`).

---

## 4. Input routing

Input events are routed by the authority using the still's hit map and input
ownership. The executor delivers raw input to the authority; the authority
decides the target. An executor that routes input by its own hit test is a
defect (it would be a second owner of truth).

---

## 5. Revocation

On capability revocation, session end, or policy crash, leases expire safely and
focus returns to a safe default. No input is silently dropped; the producer
receives a typed event. See `security/02-capability-revocation.md`.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-022` | A move and a click never disagree: hit map and input owner are one still. |
| `AC-ARCH-PRESENT-023` | A revoked capture lease delivers a typed revocation event; the holder does not crash. |
| `AC-ARCH-PRESENT-024` | Focus never rests on an invisible surface. |
| `AC-ARCH-PRESENT-025` | Input routing uses the authority's hit map, not the executor's. |

---

## 7. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-INPUT-001` | Should capture-lease expiry be wall-clock or frame-count based? | Architecture Editor | proposed |

---

## 8. References

- Wayland, `wl_pointer`, `wl_keyboard`, `wl_touch`, pointer confinement.
  https://wayland.freedesktop.org/docs/html/
- Miller, M. S. (2006). *Robust Composition.* https://www.erights.org/talks/thesis/