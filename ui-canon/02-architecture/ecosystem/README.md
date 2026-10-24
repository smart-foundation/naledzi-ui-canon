---
id: ARCH-ECO-INDEX
title: Ecosystem
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-ECO-000]
children:
  - 01-discovery-and-pairing.md
  - 02-continuity-and-handoff.md
  - 03-shared-clipboard.md
  - 04-remote-output.md
  - 05-remote-input.md
  - 06-sync-and-conflict.md
  - 07-identity-and-trust.md
  - 08-notifications-across-devices.md
  - 09-space-and-window-continuity.md
  - 10-zero-copy-across-devices.md
  - 11-failure.md
  - 12-acceptance.md
  - 13-open-questions.md
  - 14-changelog.md
  - 15-references.md
---

# Ecosystem

> One OS across phone, PC, tablet, watch, TV, car, spacecraft, IoT, spatial,
> remote. Devices are peers. Local-first; remote is a peer.

---

## 1. The single question

> How do independent devices produce one continuous, honest still?

---

## 2. Directory map

| File | Question |
|---|---|
| `01-discovery-and-pairing.md` | how devices find each other without names; trust; QR/NFC/code; revocation |
| `02-continuity-and-handoff.md` | continue editing, call/media handoff, focus transfer; state ownership; conflict |
| `03-shared-clipboard.md` | formats, privacy, expiry, cross-device paste, sensitive content |
| `04-remote-output.md` | phone as display for PC, PC as compute for phone, TV cast, car projection; structured stills, not VNC |
| `05-remote-input.md` | phone as keyboard/pointer/gamepad, PC as keyboard for TV, latency, capture leases |
| `06-sync-and-conflict.md` | local-first, CRDT/version vectors, conflict UX, no last-writer-wins |
| `07-identity-and-trust.md` | account optional, device identity, session scope, multi-user, guest |
| `08-notifications-across-devices.md` | where a notification lands, dedupe, quiet hours, safety overrides |
| `09-space-and-window-continuity.md` | window/space transfer, layout adaptation, focus |
| `10-zero-copy-across-devices.md` | when zero-copy impossible; declared copies, compression, colour |
| `11-failure.md` | partition, stale peer, version skew, revoked device, clock skew |
| `12-acceptance.md` | AC index |
| `13-open-questions.md` | unresolved |
| `14-changelog.md` | creation record |
| `15-references.md` | evidence |

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-ECO-000` | Branch coverage complete. |

---

## 4. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Contract inputs: `discovery.capnp`, `tunnel.capnp`, `network.capnp`, `clipboard.capnp`,
  `notification.capnp`, `remote`-related schemas, `sync`-related.