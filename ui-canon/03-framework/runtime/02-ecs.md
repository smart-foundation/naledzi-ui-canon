---
id: FW-RUNTIME-ECS
title: "ECS: entities, components, systems, scheduling, determinism"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-ECS-001]
---

# ECS

> One ECS per app. No second ECS anywhere (LAW-001, APP-STANDARD §1).

---

## 1. Entities

An entity is an opaque id. It carries no data and no behaviour. It is a handle into the
world's component storage. Entities are created and destroyed through commands, never by
direct mutation of storage (`src/ecs/entity.rs`, `src/ecs/commands.rs`).

Rules:

- FW-ECS-001. An entity MUST NOT be reused for a different logical object within the same
  frame; reuse across frames is permitted only after the entity's components are fully
  removed and the change is committed.
- FW-ECS-002. An entity's identity is local to its app process. It never crosses a contract
  boundary (LAW-002); only semantic facts and buffer handles do.
- FW-ECS-003. The framework assigns stable semantic ids (component role, command id) that
  are independent of entity ids, so a restored app can re-bind.

## 2. Components

A component is plain data attached to an entity. It has no methods and no authority.

- FW-ECS-004. Components MUST be `Copy`/`Clone` where possible and MUST NOT hold
  `Rc`/`Arc` to shared mutable state; shared state goes through resources.
- FW-ECS-005. A component MUST NOT own domain state. Domain state lives in the app's domain
  model; the component reflects it (FW-LAW-001).
- FW-ECS-006. Visual state (hover, press, open) MAY be component data; domain state MUST NOT.
- FW-ECS-007. Component storage is sparse-set based (`src/ecs/sparse_set.rs`); iteration
  is over the smallest relevant set.

## 3. Systems

A system reads components and resources and writes commands. It does not mutate storage
directly except through commands (deferred application).

- FW-ECS-008. Systems MUST be deterministic given the same inputs and the same frame's
  component state.
- FW-ECS-009. A system MUST NOT perform I/O, allocate on the hot path beyond declared
  budgets, or block.
- FW-ECS-010. System order within a frame is declared, not inferred from registration
  order alone; the scheduler resolves it (`09-scheduler.md`).
- FW-ECS-011. A system that needs a resource that is absent MUST treat absence as a normal
  state (honest absence), not panic.

## 4. Commands and resources

- Commands are queued and applied at defined points (end of system set) so reads during a
  frame see a consistent world (`src/ecs/commands.rs`).
- Resources are singleton data owned by the world (theme, clock, input queue). They are
  explicit inputs; no ambient global state (LAW-019).
- FW-ECS-012. A command that cannot be applied (missing entity, type mismatch) is recorded
  as a failure with a reason, never silently dropped.

## 5. Scheduling

- One scheduler per app, owned by MirUI (`src/ecs/system.rs`, `src/ecs/system/param.rs`).
- Frame phases: input -> update -> layout -> render -> commit. A phase boundary is a
  consistency point.
- FW-ECS-013. No system may schedule frames when nothing changed (LAW-004). Animation is
  the only legitimate self-scheduling source, and it settles.
- FW-ECS-014. Background work runs at idle priority and MUST NOT delay frame commit
  (`09-scheduler.md`).

## 6. Determinism

- FW-ECS-015. Given identical inputs and identical initial state, two runs produce
  identical entity/component state and identical declared damage. Rendering differences
  due to font availability or float non-associativity are recorded as known limits.
- FW-ECS-016. Iteration order over entities is stable (sorted by entity id) unless a system
  explicitly opts into an unordered pass and documents why.
- FW-ECS-017. Time advances only through the injected clock (`clock.capnp`), never
  `std::time` or platform timers, so replays are reproducible.

## 7. No second ECS

- FW-ECS-018. An app, a component library, or a shell MUST NOT instantiate a second ECS,
  a parallel entity store, or a "view model tree" that shadows the world.
- FW-ECS-019. Derived views (sorted lists, filtered subsets) are computed on demand from
  the world; they are not stored as a second source of truth.
- FW-ECS-020. If a subsystem needs its own storage (e.g. a text buffer's internal rope),
  it is an implementation detail of that component and MUST NOT be exposed as an entity
  store.

## 8. Bundles

MirUI supports bundles for spawning an entity with a set of components atomically
(`src/ecs/bundle.rs`). The framework uses bundles for component recipes (e.g. a button
spawns with layout, visual, focus, semantic node) so partial entities never exist.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-ECS-001` | An app with two independent components in one world passes a determinism replay test (same inputs -> same state + damage). |
| `AC-FW-ECS-002` | No second entity store exists in the app (audit). |
| `AC-FW-ECS-003` | Idle app schedules zero frames. |