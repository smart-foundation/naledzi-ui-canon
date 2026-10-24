---
id: APP-CAPABILITIES
title: App Capabilities
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Security Guild
depends: [APP-STANDARD, LAW-002, LAW-019]
acceptance: [AC-APP-STANDARD-013]
---

# App Capabilities

> An app receives a right, not an address. It receives it for a reason, for a scope, for a
> lifetime, and it can lose it.

---

## 1. The manifest

Every app declares a capability manifest in `09-capabilities.md`:

```markdown
## Required
| Capability | Why | Scope | Lifetime |
|---|---|---|---|
| `CAP-FILES-READ` | Open the user's documents | user-selected files | until app closes |
| `CAP-FILES-WRITE` | Save documents | user-selected files | until app closes |

## Optional
| Capability | Why | Trigger | If denied |
|---|---|---|---|
| `CAP-CAMERA-CAPTURE` | Attach a photo | user taps Attach → Camera | file picker remains |

## Refused
| Capability | Why not |
|---|---|
| `CAP-LOCATION-FINE` | The app has no location feature |
| `CAP-CONTACTS-READ` | Not needed for the domain |

## Observation rights
| Right | Default | Visible indicator | Revocable |
|---|---|---|---|
| thumbnails in strip | on | yes, in the strip's privacy panel | yes |
| screen capture | off | yes | yes |
| clipboard read | on paste | yes | yes |
```

---

## 2. The rules

### 2.1 Least authority

The app requests the smallest capability that completes the task. It does not request a
directory when it needs one file; it does not request continuous location when it needs a
one-shot fix; it does not request background execution when it needs a foreground task.

### 2.2 Explicit observation

Any capability that observes the user — camera, microphone, screen, clipboard, location,
contacts, thumbnails — is:

- off by default unless it is the app's visible primary function;
- indicated while active;
- revocable at any time;
- scoped to the current task where possible;
- never used to train or upload without explicit, separate consent.

### 2.3 Revocation is real

A capability can be revoked while the app is running. The app must:

- notice the revocation;
- stop the operation;
- preserve the user's data;
- move to `denied` or `degraded`;
- explain what happened and how to restore it.

It must not crash, silently continue, or fake the result.

### 2.4 No ambient authority

The app does not inherit the shell's, the policy's or another app's capabilities. It cannot
use a global name to reach a resource. It cannot retain a capability after the session ends
unless the grant is persistent and declared.

### 2.5 Data ownership

- The user owns the data.
- The app declares where data lives, how long it is kept and how it is deleted.
- Deleting an app does not silently delete user data; the user is asked.
- Export is always possible in an open, documented format.
- No telemetry without an explicit, revocable choice.

---

## 3. Denied behaviour

When a capability is denied:

1. The app enters `denied` for the feature, not necessarily the whole app.
2. It states what is blocked, why, and how to request it.
3. If a degraded path exists, it offers it.
4. It does not retry in a loop.
5. It does not pretend the feature worked.

Example:

> **Camera access is off.** You can attach a photo from Files instead.
> [ Open Settings ] [ Choose a file ]

---

## 4. Capability IDs

Capabilities use stable IDs, not free-form strings:

```
CAP-FILES-READ
CAP-FILES-WRITE
CAP-FILES-DELETE
CAP-NETWORK-OUTBOUND
CAP-NETWORK-LISTEN
CAP-CAMERA-CAPTURE
CAP-MICROPHONE-RECORD
CAP-LOCATION-ONESHOT
CAP-LOCATION-CONTINUOUS
CAP-CONTACTS-READ
CAP-CALENDAR-READ
CAP-NOTIFICATIONS-POST
CAP-CLIPBOARD-READ
CAP-CLIPBOARD-WRITE
CAP-SCREEN-OBSERVE
CAP-INPUT-CAPTURE
CAP-BACKGROUND-RUN
CAP-STORAGE-PERSIST
CAP-DEVICE-PAIR
```

An app may not invent a capability ID. New IDs are added to the contract and the canon
together.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-APP-CAP-001` | The manifest lists required, optional and refused capabilities. |
| `AC-APP-CAP-002` | No capability is requested without a declared use. |
| `AC-APP-CAP-003` | Observation capabilities are off by default, indicated and revocable. |
| `AC-APP-CAP-004` | Revocation mid-operation is handled without crash or fake success. |
| `AC-APP-CAP-005` | Denied shows a reason and a path. |
| `AC-APP-CAP-006` | The app cannot reach a resource without a granted capability. |
| `AC-APP-CAP-007` | User data is exportable and not silently deleted. |
| `AC-APP-CAP-008` | No telemetry without explicit consent. |
