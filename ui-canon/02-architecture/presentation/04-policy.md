---
id: ARCH-PRESENT-POLICY
title: Policy
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-001, AC-ARCH-PRESENT-018]
---

# Policy

> Policy is optional. It decides placement, stacking, focus and arbitration. It
> produces a plan, never pixels. A watch may have none. A desktop has one (the
> shell). Killing it does not lose the screen.

---

## 1. What policy is

Policy is the optional, replaceable component that owns **choice**, not truth. It
decides:

- which surface is above which (stacking);
- how surfaces are laid out under a placement hint;
- which surface receives focus when several are eligible;
- how conflicting gestures or shortcuts arbitrate.

Policy MUST produce a **plan**: a total order of surface IDs plus geometry plus a
focus candidate, expressed in contract terms. Policy never writes pixels and
never rejects a valid commit (`LAW-006`).

---

## 2. When policy exists

| Envelope | Policy presence |
|---|---|
| Watch | on-device, minimal (or absent) |
| Phone | on-device |
| Tablet | on-device |
| Desktop | on-device or session service |
| TV | on-device |
| EV | on-device, deterministic, safety-reviewed |
| Spacecraft | deterministic, frozen |
| IoT | usually absent |
| Spatial | spatial policy |
| Remote browser | remote policy |
| Headless | optional |

When policy is absent, the authority applies the deterministic default policy
(§6). Absence is normal and declared, not a failure (`LAW-011`).

---

## 3. What policy may decide

- Surface ordering (z-order) among surfaces the authority has accepted.
- Geometry under a placement hint (where a window goes).
- Focus candidate when multiple surfaces are eligible.
- Arbitration of conflicting gestures/shortcuts among eligible surfaces.

Policy MUST NOT:

- reject a valid commit;
- change a declared buffer, format, damage, or fence;
- reorder surfaces against the authority's safety-zone constraints;
- claim truth about what is on screen.

---

## 4. What policy produces

A plan: total order of surface IDs + geometry per surface + focus candidate +
capture-lease candidates. The plan is expressed in contract terms (surface IDs,
rects, transforms) so it crosses no pixel boundary (`LAW-002`).

---

## 5. Policy crash recovery

If policy crashes or times out, the authority applies the deterministic default
policy and continues presenting. Input leases expire safely. A new policy can
adopt the current truth (`AC-ARCH-PRESENT-001`, `AC-ARCH-PRESENT-008`). Policy
crash does not invalidate the current still.

---

## 6. Deterministic default policy

When no policy is present, the authority applies:

- surfaces in creation order, later above earlier;
- placement hints honoured as declared (no arbitration);
- focus to the most recently committed surface that accepts input;
- no capture leases beyond the committing surface.

This default is total and deterministic: two implementations produce the same
plan from the same inputs.

---

## 7. Policy and remote

A remote policy is a peer speaking the same contract. The authority may use a
remote policy's plan, but the authority remains the owner of truth. Remote
policy latency is a performance budget (`performance/01-budgets.md`), not a
correctness exception.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-001` | A kill of the policy leaves stills intact and input leases expiring. |
| `AC-ARCH-PRESENT-008` | A policy crash does not invalidate the current still; the new policy adopts it. |
| `AC-ARCH-PRESENT-018` | With no policy, the default policy produces a deterministic plan identical across two implementations. |
| `AC-ARCH-PRESENT-019` | Policy cannot reject a valid commit; an attempt is recorded as a defect. |

---

## 9. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-POLICY-001` | What is the policy timeout threshold before the default policy is applied? | Architecture Editor | proposed |
| `OQ-POLICY-002` | Can a remote policy be used for a safety envelope (EV)? | Architecture Editor | open (safety review) |

---

## 10. References

- Wayland protocol, surface stacking and focus. https://wayland.freedesktop.org/docs/html/
- ARINC 661, cockpit display management. https://www.arinc.com/