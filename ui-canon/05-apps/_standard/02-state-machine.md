---
id: APP-STATE-MACHINE
title: The Universal App State Machine
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Apps Guild
depends: [APP-STANDARD, LAW-011, LAW-018]
acceptance: [AC-APP-STANDARD-007]
---

# The Universal App State Machine

> Every app is in exactly one named state. Every state is reachable, testable, linkable and
> exitable. There are no "special cases" outside the machine.

---

## 1. The states

### 1.1 Lifecycle states

| State | Meaning | The user sees | The app must |
|---|---|---|---|
| `unavailable` | The app cannot run: not installed, unsupported envelope, missing required service | A clear explanation and a path (install, update, go back) | Never fake a shell |
| `loading` | The first meaningful content is being acquired | A skeleton that matches the final layout, or a determinate progress with a label | Never block the whole system; never spin forever |
| `ready` | The app can do its job | The content and its actions | Be fully interactive |
| `empty` | The app is ready, but there is no content yet | A purposeful empty state with the first action | Never look broken; never show a fake list |
| `error` | The requested operation failed | What failed, why if known, and what to do | Preserve data; offer retry or recovery |
| `offline` | The local app is usable, the remote peer is not | Local content plus an honest connection state | Keep working locally; queue or defer remote work |
| `denied` | A required capability was refused | What is blocked, why, and how to request it | Offer the request path; degrade if possible |
| `degraded` | The app works with reduced capability | What is missing and what still works | Never hide the reduction |
| `closing` | The app is saving, flushing or handing off | A short, honest progress state | Never lose committed work |
| `closed` | The app is no longer running | Nothing | Leave the still coherent for the policy |

### 1.2 Ready substates

`ready` is not one state. It has a mode:

| Substates | Meaning |
|---|---|
| `idle` | No active operation; waiting for the user |
| `busy` | A background operation is running; the UI remains usable unless declared blocking |
| `editing` | The user is changing content; dirty state is tracked |
| `selecting` | One or more items are selected; selection actions are available |
| `dragging` | A drag is in progress; a capture lease is held |
| `presenting` | A transient layer (sheet, dialog, palette) is open |

Rules:

- `busy` does not mean "block everything". A blocking operation is a declared exception with
  a reason.
- `editing` has a dirty indicator and a save/discard path.
- `selecting` has a clear count, a select-all path and an escape path.
- `dragging` has a visible ghost, a drop target preview and a cancel path.
- `presenting` traps focus only if modal; otherwise it is dismissible and non-blocking.

---

## 2. Transitions

The table is normative. An implementation may add substates, but it may not remove a
transition or change its guard.

| From | Trigger | Guard | To | Side effects |
|---|---|---|---|---|
| `unavailable` | Install / enable succeeds | Capability granted | `loading` | Register commands |
| `unavailable` | User leaves | — | `closed` | — |
| `loading` | Content acquired | Non-empty | `ready` | Announce ready |
| `loading` | Content acquired | Empty | `empty` | Announce empty |
| `loading` | Failure | Retryable | `error` | Preserve partial data |
| `loading` | Failure | Not retryable | `error` | Explain the dead end |
| `loading` | Capability denied | — | `denied` | Offer request path |
| `loading` | Network unavailable | Local data exists | `offline` | Load local data |
| `loading` | Timeout | — | `error` | Offer retry |
| `ready` | Operation starts | — | `ready/busy` | Show honest progress |
| `ready` | Edit starts | — | `ready/editing` | Mark dirty on change |
| `ready` | Selection starts | — | `ready/selecting` | Show selection actions |
| `ready` | Drag starts | Capture lease granted | `ready/dragging` | Show ghost and targets |
| `ready` | Layer opens | — | `ready/presenting` | Move focus into layer |
| `ready` | Content becomes empty | — | `empty` | Announce empty |
| `ready` | Remote peer lost | Local data exists | `offline` | Show connection state |
| `ready` | Capability revoked | Required | `denied` | Stop the operation honestly |
| `ready` | Partial failure | Some features work | `degraded` | Name what is missing |
| `empty` | First action succeeds | Content exists | `ready` | Announce ready |
| `empty` | First action fails | — | `error` | Preserve intent |
| `error` | Retry succeeds | — | `ready` | — |
| `error` | User edits/recovery | — | `ready` | Preserve data |
| `error` | User leaves | — | `closed` | — |
| `offline` | Peer returns | — | `ready` | Reconcile, do not replay blindly |
| `offline` | Local action | — | `offline` | Queue or mark pending |
| `denied` | Capability granted | — | `loading` | Resume |
| `denied` | User declines | — | `degraded` or `closed` | Explain the limitation |
| `degraded` | Capability returns | — | `ready` | Announce recovery |
| `ready/*` | Close | Unsaved changes | `ready/presenting` (confirm) | Ask save/discard/cancel |
| `ready/*` | Close | Clean | `closing` | Flush |
| `closing` | Flush complete | — | `closed` | Release capabilities |

---

## 3. Rules

### 3.1 Every state is addressable

Each state has a stable identifier. It can be:

- linked to (deep link),
- restored after a crash,
- captured as a still for testing,
- reached directly in a test.

A state that cannot be addressed is a private mode, and private modes are where bugs hide.

### 3.2 No modal loading

`loading` occupies the content region with a skeleton or progress. It does not block the
whole app unless the app cannot function at all, and then it says why.

### 3.3 Empty is not error; error is not empty

- `empty` means "nothing here yet; here is the first action."
- `error` means "something failed; here is what and why."
- A failed load that leaves no content is `error`, not `empty`.
- An empty successful load is `empty`, not `error`.

### 3.4 Offline is a state, not a failure

If local data exists, the app is `offline`, not `error`. Local work continues. Remote work is
queued or deferred with a visible state. Reconnection reconciles; it never blindly replays
an action whose result is unknown.

### 3.5 Denied is a state with a request path

A denied capability is not a crash and not a silent absence. The app says what is blocked,
why, and how to request it. If a degraded path exists, it is offered.

### 3.6 Degraded names the loss

`degraded` always states what is missing and what still works. "Some features unavailable"
is not acceptable.

### 3.7 Optimistic updates have rollback

An optimistic update must have a rollback path and a visible failure state. The UI never
keeps a change the system rejected.

### 3.8 Long operations are cancellable or explained

If an operation can take longer than one second, it has determinate progress or an
indeterminate state with a label. If it can be cancelled, cancel is visible. If it cannot,
the app says why.

### 3.9 Unsaved work is protected

Closing, navigating away or losing the surface with unsaved changes prompts save / discard /
cancel. A crash preserves a recovery draft. The user is never silently robbed.

### 3.10 Restore is a state

After a crash or restart, the app restores to a complete state, not to a loading shell. The
restored state is announced to assistive tech.

---

## 4. Per-envelope notes

| Envelope | State differences |
|---|---|
| Watch | `loading` is a single skeleton card; `error` is one sentence and one action; `presenting` is a full-screen sheet |
| Phone | Standard; sheets for context; back gesture maps to the previous state |
| Tablet | Context may be a side panel; `presenting` may be a popover |
| Desktop | Multiple windows; `closed` leaves the still for the strip; `busy` never freezes the window |
| TV | Focus is the primary state; `loading` must be visible from 3 m; `error` must be readable and dismissible with Back |
| EV | Safety state overrides app state; `degraded` must not hide a critical indicator; `loading` must never block a protected zone |
| Spaceship | Deterministic timing; `error` includes a recovery procedure; redundancy state is explicit |
| IoT | Often headless; `unavailable` must be honest; no infinite retry |
| Remote browser | `offline` is normal; reconnection state is visible; no full-screen spinner |

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-APP-STATE-001` | Every state in the table is reachable in a test harness. |
| `AC-APP-STATE-002` | Every state has an exit; no dead end except an explicit `closed`. |
| `AC-APP-STATE-003` | Empty and error are visually and semantically distinct. |
| `AC-APP-STATE-004` | Offline preserves local work and reconciles on return. |
| `AC-APP-STATE-005` | Denied shows a request path or a declared degraded path. |
| `AC-APP-STATE-006` | Unsaved changes are protected on close, navigate and crash. |
| `AC-APP-STATE-007` | Restore lands on a complete state, not a loading shell. |
| `AC-APP-STATE-008` | Every state is announced correctly to assistive tech. |
