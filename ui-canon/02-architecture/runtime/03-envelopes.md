---
id: ARCH-RUNTIME-ENVELOPES
title: Envelopes (Runtime)
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-ENV-001, AC-RUNTIME-ENV-002]
---

# Envelopes (Runtime)

> Device profile, resource profile, policy presence. An envelope is a device
> class with its own constraints; the runtime adapts to it.

---

## 1. Device profile

An envelope declares its device profile: display, input, power, safety,
performance constraints. `device.capnp`, `display.capnp`, `sensor.capnp` carry
hardware facts with validity flags. The runtime reads these to configure
services, budgets, and degradation.

---

## 2. Resource profile

A resource profile classifies the device: constrained, compact, balanced,
high-throughput, remote, safety-critical. The profile selects default budgets,
degradation ladder parameters, and which services run locally.

---

## 3. Policy presence

Policy presence is envelope-dependent (`presentation/04-policy.md` §2). A
watch may have no policy; an EV has a safety-reviewed one; a spacecraft has a
frozen deterministic one. The runtime starts policy only if the envelope's
profile calls for it.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-ENV-001` | Runtime configures services/budgets from the envelope profile. |
| `AC-RUNTIME-ENV-002` | Policy starts only if the envelope profile requires it. |

---

## 5. Open questions

See `08-open-questions.md`.

---

## 6. References

See `10-references.md`.