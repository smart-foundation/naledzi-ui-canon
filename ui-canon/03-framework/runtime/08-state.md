---
id: FW-RUNTIME-STATE
title: "State: app state, restore, persistence, crash recovery"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, APP-STANDARD]
supersedes: []
superseded_by: []
acceptance: [AC-FW-STATE-001]
---

# State

> App state is owned by the app's domain model. The framework provides restore, persistence
> hooks and crash recovery. It never owns domain state (FW-LAW-001).

---

## 1. App state

- FW-STATE-001. An app declares its state model in `02-model.md` (APP-STANDARD). The
  framework consumes it; it does not impose one.
- FW-STATE-002. Transient presentation state (hover, press, open, scroll offset) may live in
  components; domain state must not.
- FW-STATE-003. State changes produce declared damage and update the accessibility snapshot
  in the same still (LAW-005, LAW-009).

## 2. Restore

- FW-STATE-004. An app can be restored to its last committed state after a crash or
  restart, using its own persistence format.
- FW-STATE-005. Restore lands on a complete, addressable state (LAW-018), never on a
  loading shell with no context.
- FW-STATE-006. If restore fails, the app starts fresh and records the reason (honest
  absence); it never fakes a restored state.

## 3. Persistence

- FW-STATE-007. Persistence is the app's responsibility; the framework provides hooks
  (save/restore callbacks) and a storage capability handle.
- FW-STATE-008. Writes are atomic (write to temp, rename) and crash-safe.
- FW-STATE-009. Persistence never blocks the UI thread; it runs at idle priority
  (`09-scheduler.md`).
- FW-STATE-010. No persistence of ephemeral presentation state unless the app declares it.

## 4. Crash recovery

- FW-STATE-011. A crash of the app process leaves the authority's last still visible
  (LAW-006, LAW-015); input leases expire safely.
- FW-STATE-012. A new app instance can adopt the current truth and resume.
- FW-STATE-013. Unsaved work is recovered from the last committed buffer where possible;
  otherwise the user is told what was lost and why.

## 5. Multi-instance

- FW-STATE-014. An app may run multiple instances; each owns its own state and buffer.
- FW-STATE-015. Instances share no mutable state; coordination goes through capabilities.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-STATE-001` | Kill an app mid-edit; relaunch; work is recovered or the loss is honestly reported. |
| `AC-FW-STATE-002` | Restore lands on a complete state with context. |
| `AC-FW-STATE-003` | Idle persistence writes do not delay frames. |