---
id: ARCH-PERF-MEASUREMENT
title: Measurement
kind: architecture
entity: performance
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PERF-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PERF-MEAS-001, AC-PERF-MEAS-002]
---

# Measurement

> Instruments, p95, reference devices, reproducible scenarios. Measurement is
> standardized so results are comparable.

---

## 1. Instruments

Measurement uses OS-provided instruments (`diagnostics.capnp`): frame timing,
wakeup counts, memory, message rates, GPU time. Instruments are capability-
gated and auditable.

---

## 2. p95

Budgets are evaluated at p95 over a reproducible scenario, not at the mean or
best case. p95 captures tail latency that affects user perception.

---

## 3. Reference devices

Each envelope has a declared reference device (weakest supported). Budgets are
measured on that device. Results are published with device, OS version, and
scenario.

---

## 4. Reproducible scenarios

Scenarios are scripted flows with fixed inputs, fixed data, and fixed timing.
They are version-controlled and re-run on every change. `FrameMetrics`
(`surface.capnp`) provides per-surface frame tracking for measurement.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PERF-MEAS-001` | Budgets measured at p95 on reference device. |
| `AC-PERF-MEAS-002` | Scenarios are scripted and reproducible. |

---

## 6. Open questions

See `06-open-questions.md`.

---

## 7. References

See `08-references.md`. `diagnostics.capnp`, `FrameMetrics` in `surface.capnp`.