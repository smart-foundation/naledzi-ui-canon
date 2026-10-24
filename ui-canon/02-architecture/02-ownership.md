---
id: ARCH-OWNERSHIP-01
title: Fact Ownership
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, ARCH-MODEL-01]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-OWN-001, AC-ARCH-OWN-002, AC-ARCH-OWN-003]
---

# Fact Ownership

> This file is the map required by LAW-001. Every architectural fact appears exactly
> once below with one owner. If an implementation holds the same fact, it is a derived
> view and MUST be invalidated by the owner's event, never synchronized by polling.

---

## 1. Ownership table

Notation: **O** = owner; **D** = permitted derived view; **H** = history only (never
current truth). A cell not marked is forbidden.

### 1.1 Identity

| Fact | Owner (O) | Permitted elsewhere | Contract anchor | Notes |
|---|---|---|---|---|
| Session identity | session service; `T.SessionId` minted at handshake | D in authority; D in app | `compositor.capnp:53-58`, `types.capnp:6` | app receives its own ID; it does not mint one |
| Surface identity | surface owner; `T.SurfaceId` minted by authority | D everywhere | `surface.capnp:42`, `types.capnp:7` | surface ID is stable across stills |
| Buffer identity | buffer service; `T.BufferId` | D in producer and executor | `types.capnp:8`, `buffer.capnp:242-251` | `BufferId.addr` is a contract defect; see G-02 |
| Output identity | display service; `T.OutputId` | D in authority, policy, executor | `types.capnp:9`, `display.capnp:289-376` | logical vs physical mapping is display-owned |
| Device identity | device service; `T.DeviceId` | D in ecosystem roles | `device.capnp:27-58` | stringly device IDs in session handoff are a gap; G-05 |
| Application identity | package/launch service; `T.AppId` | D in session | `types.capnp:30` | handshake carries it (`compositor.capnp:48`) |
| Still number | presentation authority | H in audit | no schema field — G-01 | monotonic per domain, never reused |
| Frame identity (producer) | producing session; `frameId` | D in authority | `compositor.capnp:531` | producer may reuse after ack; authority keeps history |

### 1.2 Declaration

| Fact | O | Permitted elsewhere | Contract anchor | Notes |
|---|---|---|---|---|
| Surface role | creating session, validated by authority | D in policy | `surface.capnp:323-336`, `compositor.capnp:354-380` | role change is a new declaration, not a mutation |
| Geometry and scale | producing session | D in policy/executor | `surface.capnp:201-216` | authority validates against limits |
| Placement hint | producing session | D in policy | `compositor.capnp:391-400` | hint, not command |
| Buffer format | producing session, validated against buffer | D in executor | `compositor.capnp:533` | mismatch is a rejection |
| Damage | producing session | D in executor; never inferred | `compositor.capnp:534,543-554` | `omitted` means full-surface fallback; G-03 |
| Present intent | producing session | D in authority | `compositor.capnp:564-570` | earliest/latest semantics below |
| Fence | producing session | D in authority/executor | `compositor.capnp:536`, `surface.capnp:168-171` | two shapes; G-04 |
| Transform | producing session | D in executor | `compositor.capnp:537`, `types.capnp:367-376` | applied exactly once |
| Colour space / HDR metadata | producing session | D in display/executor | `display.capnp:441-477` | absence means SDR, declared |
| Opacity / input region | producing session | D in authority | declared per surface role | used by hit map and composition |
| Accessibility tree | producing session, via accessibility service | D in authority snapshot | `surface.capnp:4` | authority numbers the snapshot, does not edit it |
| Clipboard content | clipboard service | D to reader on grant | `clipboard.capnp:18-87` | never copied into UI state |
| Notification content | notification service | D to presenter | `notification.capnp:132-176` | presenter may redact, not rewrite |

### 1.3 Decision

| Fact | O | Permitted elsewhere | Contract anchor | Notes |
|---|---|---|---|---|
| Commit accepted/rejected | presentation authority | H in audit | `compositor.capnp:408-416` | typed result |
| Still validity | presentation authority | H | G-01 | includes degraded flag and reasons |
| Focus owner | presentation authority after policy | D in input service | no single field — G-06 | must be in still |
| Input grab ownership | input service, granted by authority | D in policy | `input.capnp:62-65` | no TTL field; G-07 |
| Stacking order | policy, accepted by authority | D in executor | `compositor.capnp:458-476` | default order if policy absent |
| Output mode | display service, requested by authority | D in executor | `display.capnp:289-376` | authority cannot invent a mode |
| Degradation level | authority, informed by executor | D to user | `rendering/09-degradation.md` | must be visible, not silent |
| Handoff acceptance | target device's authority | D in source | `session.capnp:184-208` | opaque state; target validates |
| Conflict winner | declared merge strategy | H | `session.capnp:344-352` | never last-writer-wins by accident |

### 1.4 Observation

Observation is the only category where a cache is normal. Every observation MUST carry
`observedAt` and a validity flag, or MUST be treated as absent.

| Observation | O | Validity rule | Contract anchor |
|---|---|---|---|
| Actual refresh rate | display/executor | `refreshRateValid` false ⇒ unknown | `display.capnp:267-376` |
| Physical size | display | `physicalSizeValid` false ⇒ no panel | `display.capnp:267-376` |
| EDID | display | empty ⇒ none read | `display.capnp:267-376` |
| Present time / frame period | executor | timestamp is an observation, not a promise | `compositor.capnp:579-587` |
| Dropped frames | executor | counter resets are declared | `compositor.capnp:579-587` |
| Buffer residency | buffer/GPU service | must name the device | `gpu.capnp:94-103` |
| Thermal state | power/device service | enum, not a guess | `power.capnp:191-199` |
| Service health | discovery | state + fault counters | `discovery.capnp:171-219` |
| Network latency/jitter | network service | measured window | `network.capnp:380-460` |

---

## 2. Derived views: the only legal caches

A derived view is legal only if all four conditions hold:

1. it is labelled derived in the implementation;
2. it is invalidated by an event from the owner, not by a timeout;
3. it never outlives the owner's epoch (session, device generation, output generation);
4. deleting it does not change behaviour except for latency.

```
owner event ──► invalidate ──► rebuild from owner ──► serve
      │
      └── if no event and no owner: serve ABSENT, never stale
```

**MUST NOT.** A derived view MUST NOT be used to answer "what is true now?" after the
owner's epoch has changed. An epoch change is: session end, device trust change
(`device.capnp:102-109`), output hotplug, policy replacement, or authority restart.

**Test (AC-ARCH-OWN-002).** Delete every derived view at an arbitrary instant. The system
MUST continue to present; the next still MAY be late, but it MUST NOT be wrong, and no
still may contain a fact that the owner would not confirm.

---

## 3. The seven duplicate-fact defects

The schema currently contains seven places where a fact has two representations. This
corpus treats them as defects, chooses one canonical meaning for architecture purposes,
and records a proposed change. It does not edit the schema.

| ID | Duplicate | Canonical for this corpus | Contract gap |
|---|---|---|---|
| G-01 | still number absent | authority-minted monotonic `UInt64`, recorded in audit | no field |
| G-02 | `BufferId.addr/size` alongside handle | handle + region are canonical; `addr` MUST NOT be used as identity | `types.capnp:8` |
| G-03 | `DamageOption` in two files, `custom` opaque | `full` fallback when omitted; rects only when declared | `compositor.capnp:543-554`, `surface.capnp:138-145` |
| G-04 | `SyncFence` native vs handle | fence handle on any cross-process path; native only in-process | `compositor.capnp:572-577`, `surface.capnp:168-171` |
| G-05 | device identity as `Text` in handoff | typed `T.DeviceId` is canonical; text is a display name | `session.capnp:184-240` |
| G-06 | focus owner has no schema field | authority records focus in still; input service derives | none |
| G-07 | input grab has no expiry | authority MUST revoke on session end, focus change, or explicit release | `input.capnp:62-65` |

---

## 4. Ownership across a link

When authority, policy, and executor are on different devices, ownership does not move;
only the **representation** moves.

- The still number is minted by the authority, even if the executor is remote.
- A remote executor's local frame counter is an observation, not a still number.
- A remote policy's plan is a proposal; the authority accepts or rejects it.
- A remote buffer handle is valid only within the transport session that created it;
  it is not a global name.
- Device identity for a remote peer comes from the device service, authenticated as in
  `security/05-remote-trust.md`, never from a string in the payload.

```
Device A (authority)                 Device B (executor)
  still 900 ────────────────────────► decode → display
      ▲                                   │
      └──── present(fence, evidence) ◄────┘
            B's frame counter is NOT still 900
```

**MUST.** The authority MUST record, for a remote still, which peer, which transport
session, and which evidence establishes "presented". If evidence is unavailable, the
still is `sent`, not `presented`, and the UI MUST NOT claim otherwise.

---

## 5. Ownership of absence

Absence is a fact and has an owner:

| Absence | Owner of the absence | How it is declared |
|---|---|---|
| No panel | display service | `physicalSizeValid=false` |
| No EDID | display service | empty EDID list |
| Unknown refresh | display service | `refreshRateValid=false` |
| No policy service | discovery | absence of descriptor is normal; default policy applies |
| No GPU | GPU service | capability list lacks acceleration |
| No remote peer | ecosystem presence | `reachable=false` with last-seen |
| No clipboard owner | clipboard service | empty content, not an error |
| No notification presenter | notification service | queue holds; no delivery claim |

**MUST NOT.** A consumer MUST NOT convert absence into a zero, a default, or a
plausible value. Rendering `0 Hz`, `0 mm`, `0 devices`, or `0 ms` for an unknown is a
lie and is forbidden by the honesty rules.

---

## 6. Acceptance

- **AC-ARCH-OWN-001** — For every row in §1, a test deletes the derived view and asserts
  that the next still is either valid or explicitly degraded, never silently wrong.
- **AC-ARCH-OWN-002** — Epoch change test: kill policy, hotplug output, revoke device
  trust, restart authority. No still after the epoch may carry a pre-epoch fact.
- **AC-ARCH-OWN-003** — Absence test: for each row in §5, force the absence and assert
  the UI renders the declared absence, not a numeric zero.

Traceability: `08-acceptance.md`.
