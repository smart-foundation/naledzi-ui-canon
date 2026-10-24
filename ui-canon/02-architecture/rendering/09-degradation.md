---
id: ARCH-REND-DEGRADATION
title: Degradation
kind: architecture
entity: rendering
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-REND-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-REND-DEG-001, AC-REND-DEG-002]
---

# Degradation

> Ordered ladder; correctness first; never hide primary action or warning.
> Degradation is designed, not improvised.

---

## 1. Ordered ladder

When a budget is exceeded or a path fails, the system gives up, in order:

1. Decorative motion/parallax.
2. Non-essential animations.
3. High-resolution textures / supersampling.
4. Secondary surfaces (thumbnails, previews).
5. Frame rate (down to declared minimum).
6. Resolution (down to declared minimum).

Correctness (primary action, warnings, safety indicators) is never given up.
`LAW-011` (honesty): degraded state is shown as degraded, not hidden.

---

## 2. Never hide primary action or warning

Safety-critical indicators (EV, spaceship) never degrade. Warnings are never
obscured by animation or occlusion (`ADR-0017`). The degradation ladder
stops before touching safety content.

---

## 3. Honest degradation

A degraded still is recorded as degraded in the still history. The user sees an
honest state (lower fidelity, not a fake). `NOT REPORTED` is valid for
unavailable metrics.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-REND-DEG-001` | Degradation follows the ladder order; correctness never given up. |
| `AC-REND-DEG-002` | Safety indicators never degrade. |
| `AC-REND-DEG-003` | Degraded stills are recorded as degraded. |

---

## 5. References

See `13-references.md`.