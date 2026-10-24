---
id: SHELL-MODEL-POLICY
title: Policy — Optional Placement, Stacking, Focus and Arbitration
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, ARCH-PRESENT-POLICY, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-020, AC-SHELL-MODEL-021]
---

# Policy

> Policy is optional. It decides placement, stacking, focus and arbitration. It produces a
> plan, never pixels. A watch may have none. A desktop has one (the shell). Killing it does
> not lose the screen.

This file is the shell's view of `ARCH-PRESENT-POLICY`, extended with shell-specific
consequences: what the shell's policy decides, how it interacts with safety zones, and
how it is replaced.

---

## 1. When policy exists (shell view)

| Envelope | Policy | Notes |
|---|---|---|
| Watch | minimal or absent | single surface; deterministic default applies |
| Phone | on-device | stacking, focus, gesture arbitration |
| Tablet | on-device | split/tiling decisions |
| Desktop | on-device or session service | multi-window, spaces, multi-display |
| TV | on-device | focus-first; no free stacking |
| EV | on-device, deterministic, safety-reviewed | protected zones are hard constraints |
| Spaceship | deterministic, frozen | no runtime replacement; certified |
| IoT | absent | default policy only |
| Spatial | spatial policy | 6-DOF placement |
| Remote browser | remote policy peer | latency is a budget, not an exception |

When policy is absent, the authority applies the deterministic default policy
(`ARCH-PRESENT-POLICY` §6): surfaces in creation order, placement hints honoured,
focus to the most recently committed surface that accepts input, no capture leases beyond
the committing surface. This default is total and deterministic.

---

## 2. What the shell's policy may decide

1. **Stacking** — total order of surface IDs among surfaces the authority has accepted.
2. **Geometry** — where a surface goes under a placement hint (split, tile, float, snap).
3. **Focus candidate** — which surface receives focus when several are eligible.
4. **Arbitration** — conflicting gestures or shortcuts among eligible surfaces.
5. **Space transitions** — which space becomes active and how the transition animates.
6. **Capture-lease candidates** — which surface may hold a capture lease and for how long.

---

## 3. What the shell's policy MUST NOT do

1. Reject a valid commit (`LAW-006`).
2. Change a declared buffer, format, damage or fence (`LAW-002`).
3. Reorder surfaces against the authority's safety-zone constraints. Safety zones are
   hard; the policy cannot move a protected indicator (`ADR-0017`).
4. Claim truth about what is on screen (`LAW-001`).
5. Depend on a global mutable state; context must be explicit (`LAW-019`).
6. Run forever or block the authority; a timeout applies the default policy.

---

## 4. Safety policy

On EV and spaceship envelopes, the policy is **safety-reviewed** and **frozen** on
spaceship. It is a separate, certifiable component. Its constraints:

- Protected zones are declared by the envelope; the policy may not place any surface in
  them, ever, including during animation.
- Critical indicators never animate through an occluding path.
- Motion in safety envelopes is bounded and non-overshooting (`ADR-0017`).
- The policy may not be replaced at runtime on a spaceship; on an EV it may be updated
  only through the update lifecycle with a safety gate.

A non-safety policy running on a safety envelope is a defect, not a configuration.

---

## 5. Policy replacement

The shell policy is replaceable without losing the screen (`LAW-015`):

1. The new policy is loaded and given the current numbered still as its starting truth.
2. It may read the current plan (surfaces, geometry, focus) as input.
3. It takes over on the next commit boundary; no surface is torn down.
4. The old policy's capture leases expire safely; the new policy re-grants as needed.
5. If the new policy fails to produce a plan within the timeout, the default policy
   applies and the failure is recorded.

Replacement is the mechanism by which a user switches window managers, or by which a
crashed policy is recovered. It is never a screen reset.

---

## 6. Watch with no policy

A watch may have no policy. In that case:

- The single surface fills the display.
- There is no stacking, no tiling, no floating.
- Focus is the surface itself.
- The strip is summoned by the crown and shows a linear reel; no arbitration needed.
- The default policy applies for any rare multi-surface case (permission prompt, lock).

This is the minimal shell: authority + executor + one surface + crown. Everything else is
absent by design, not by omission.

---

## 7. Desktop policy

The desktop policy is the richest. It owns:

- Multi-window placement (free, snapped, tiled, split).
- Spaces and transitions.
- Multi-display composition (which surfaces go to which output).
- Fullscreen behaviour per app declaration.
- Gesture and shortcut arbitration.
- The strip and status rail composition.

The desktop policy may be on-device or a session service (remote peer). If remote, its
latency is a performance budget; correctness is unchanged.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-020` | Killing the policy leaves stills intact and input leases expiring on every envelope. |
| `AC-SHELL-MODEL-021` | A watch with no policy presents its single surface and crown strip correctly. |
| `AC-SHELL-MODEL-022` | Safety policy cannot be replaced at runtime on a spaceship; on an EV it requires an update gate. |
| `AC-SHELL-MODEL-023` | Policy timeout applies the default policy and records the failure; no screen reset. |
| `AC-SHELL-MODEL-024` | A policy that attempts to reject a valid commit is recorded as a defect. |