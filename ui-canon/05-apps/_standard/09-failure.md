---
id: APP-FAILURE
title: Failure, Edge Cases and Recovery
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Reliability Guild
depends: [APP-STATE-MACHINE, LAW-011, LAW-015]
acceptance: [AC-APP-STANDARD-014]
---

# Failure, Edge Cases and Recovery

> The rare case is not rare at scale. If it is not designed, it will be designed by the
> crash.

---

## 1. The failure contract

Every failure message answers four questions, in this order:

1. **What happened?** In plain language, no codes first.
2. **Why?** If known. If unknown, say so honestly.
3. **What is safe?** The user's data, the committed work, the current state.
4. **What now?** Retry, recover, request, leave, or a declared dead end.

Example:

> **Could not save “Notes”.** The disk is full.
> Your text is still here. Free some space, then try again.
> [ Free space ] [ Save to another location ] [ Keep editing ]

A failure that says only "Something went wrong" is a defect.

---

## 2. Taxonomy

| Class | Example | Default state | Recovery |
|---|---|---|---|
| **Validation** | Invalid email, empty required field | `ready/editing` | Inline message at the field; focus moves to it |
| **Not found** | File deleted, contact missing | `empty` or `error` | Explain; offer search or back |
| **Permission denied** | Camera off, file access refused | `denied` | Request path or degraded alternative |
| **Network unavailable** | No connection, server unreachable | `offline` | Local work continues; queue or retry |
| **Timeout** | Request exceeded its budget | `error` | Retry with backoff; explain |
| **Conflict** | Two edits to the same item | `ready/presenting` | Show both; ask; never silently overwrite |
| **Quota** | Storage full, plan limit | `error` | Name the limit; offer cleanup/export |
| **Corrupt** | Unreadable file, bad index | `error` | Preserve the original; offer repair/export |
| **Unavailable** | Service missing, feature unsupported | `unavailable` or `degraded` | Name what is missing; offer a path |
| **Crash** | Process died | `error` on return | Restore draft; explain; report if opted in |
| **Partial** | Some items synced, some not | `degraded` | Mark per item; reconcile; never fake complete |
| **Safety** | Warning, alarm, protected zone | `degraded` or alarm state | Follow the safety protocol; never hide |

---

## 3. Message anatomy

```
┌──────────────────────────────────────────────────────────────┐
│  !  Could not open “budget.csv”                              │
│                                                              │
│     The file is damaged or is not a supported format.        │
│     Your original file has not been changed.                 │
│                                                              │
│     [ Try again ]   [ Open as text ]   [ Cancel ]            │
└──────────────────────────────────────────────────────────────┘
```

Rules:

- The title names the object and the action.
- The body explains cause and data safety.
- Actions are verbs; the safe action is first, the destructive action is last and visually
  separated.
- The error is announced assertively to assistive tech.
- The error does not steal focus unless it blocks the task.
- The error is not a dead end unless it says so.

---

## 4. Recovery patterns

| Pattern | Use when | Rules |
|---|---|---|
| **Inline** | A field or small action failed | Keep context; focus the field; no modal |
| **Banner** | A non-blocking system condition | Persistent until resolved or dismissed; announced |
| **Sheet** | A task failed but the app is usable | Dismissible; preserves the task |
| **Dialog** | A destructive or blocking decision | Rare; explicit; focus trapped; safe action default |
| **Retry with backoff** | Transient failure | Bounded; visible attempt count; cancel |
| **Queue and resume** | Offline or deferred work | Visible pending state; reconcile on return |
| **Draft** | Unsaved work at risk | Auto-save or recovery draft; never silent loss |
| **Repair** | Corrupt data | Preserve original; explain; offer export |
| **Degrade** | A feature is unavailable | Name the loss; keep the core task |
| **Leave** | No recovery is possible | Explain why; preserve what can be preserved |

---

## 5. Data preservation

- A failed save never destroys the last good copy.
- A crash preserves a recovery draft, or says it could not.
- A conflict never silently overwrites.
- A delete is reversible (trash/undo) unless the user explicitly chooses permanent deletion.
- An export is possible before a destructive repair.
- A network failure never discards local edits.
- A power loss leaves the filesystem consistent; the app recovers to the last committed
  state.

---

## 6. Retry and backoff

- Retries are bounded and visible.
- Backoff is exponential with a ceiling and jitter.
- A retry never repeats a non-idempotent action blindly. If the result is unknown, the app
  reconciles first.
- The user can cancel a retry loop.
- A permanent failure is not retried forever.

---

## 7. The rare-case register

Every app's `10-failure.md` includes a table of the rare cases it has considered. At
minimum:

| Case | Handled? | Behaviour |
|---|---|---|
| First run, no data | yes | Empty state with first action |
| No network on first run | yes | Local-first; explain remote features |
| Capability denied at first run | yes | Denied state with request path |
| Storage full during save | yes | Draft preserved; cleanup path |
| File deleted while open | yes | Stale marker; save-as; no silent overwrite |
| Two windows edit the same item | yes | Conflict state; no last-writer-wins |
| Very long text / huge list | yes | Truncation, virtualization, search |
| Zero items after a filter | yes | Empty-filter state with clear-filter action |
| Invalid input in every field | yes | Inline errors; focus first invalid |
| Rapid repeated activation | yes | Idempotent; debounced; no duplicate action |
| App killed mid-drag | yes | Capture lease expires; no stuck pointer |
| Display disconnected | yes | Still preserved; output returns |
| Theme/service missing | yes | Monochrome fallback; honest |
| Locale with RTL | yes | Mirrored layout; icons audited |
| 200% text | yes | Reflow; no clipped content |
| Reduced motion | yes | State change preserved; travel removed |
| Screen reader only | yes | Full flow with transcript |
| Low battery | yes | Degrade non-essential work; preserve data |
| Thermal throttling | yes | Degrade motion/effects; keep task |
| Time zone change | yes | Recompute; never rewrite stored instants |
| Clock skew | yes | Mark uncertain; do not fabricate order |
| Multiple users | yes | Capability-scoped; no cross-user leakage |
| Guest / kiosk | yes | Restricted scope; explicit exit |
| Update during work | yes | Defer or save; never lose work |
| Rollback after update | yes | Data schema compatible or migrated |
| Corrupt settings | yes | Safe defaults; explain; reset path |
| Unsupported hardware | yes | Honest unavailable state |

An app may add cases. It may not remove one without an ADR.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-APP-FAIL-001` | Every failure message answers what/why/safe/what-now. |
| `AC-APP-FAIL-002` | Every error state has a recovery or a declared dead end. |
| `AC-APP-FAIL-003` | No failure destroys the last good data. |
| `AC-APP-FAIL-004` | Retries are bounded, visible and cancellable. |
| `AC-APP-FAIL-005` | The rare-case register is complete and tested. |
| `AC-APP-FAIL-006` | A crash restores a complete state or a recovery draft. |
| `AC-APP-FAIL-007` | Conflicts are shown, never silently overwritten. |
