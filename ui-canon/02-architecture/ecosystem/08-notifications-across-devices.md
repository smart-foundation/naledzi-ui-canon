---
id: ARCH-ECO-NOTIF
title: Notifications Across Devices
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-NOTIF-001, AC-ECO-NOTIF-002]
---

# Notifications Across Devices

> Where a notification lands, dedupe, quiet hours, safety overrides. A
> notification is delivered to the device the person is using, with safety
> overrides.

---

## 1. Delivery

A notification is delivered to the device the person is actively using (focus
heuristic) or to all paired devices for safety-critical ones. Deduplication
prevents the same notification appearing twice. `notification.capnp` carries
contracts.

---

## 2. Quiet hours

Quiet hours are respected per device and per user. Safety notifications
override quiet hours.

---

## 3. Safety overrides

Safety-critical notifications (EV, spaceship, health) override quiet hours,
focus, and device selection. They are delivered everywhere.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-NOTIF-001` | Dedupe prevents duplicate delivery. |
| `AC-ECO-NOTIF-002` | Safety notification overrides quiet hours. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `notification.capnp`.