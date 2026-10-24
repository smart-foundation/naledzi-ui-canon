---
id: ARCH-README
title: Architecture — Manifest
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, DOC-SYSTEM, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-README-001]
children:
  - 01-model.md
  - 02-ownership.md
  - 03-paths.md
  - 04-buffer-lifecycle.md
  - 05-failure-taxonomy.md
  - 06-timelessness.md
  - 07-open-questions.md
  - 08-acceptance.md
  - presentation/README.md
  - rendering/README.md
  - protocol/README.md
  - runtime/README.md
  - security/README.md
  - performance/README.md
  - ecosystem/README.md
---

# Architecture — Manifest

> The architecture is not a compositor. It is the set of contracts by which a visible
> fact becomes true, stays true, and stops being true. Everything else — a process, a
> scanout engine, a GPU driver, a remote encoder — is an executor that may be replaced.

This subtree answers one question per file: **what must be true for a still to be
presented, and who owns each part of that truth?** It is binding on `03-framework`,
`04-shell`, `05-apps`, `06-envelopes`, and every implementation under `services/` and
`kernel/`.

---

## 1. Reading order

Enter at any leaf. The spine is:

```
01-model.md                 authority / policy / executor; the numbered still
02-ownership.md             one fact, one owner, for every architectural fact
03-paths.md                 architecture × path matrix (scanout, plane, GPU, CPU, remote, headless)
04-buffer-lifecycle.md      every buffer state, every transition, every owner
05-failure-taxonomy.md      every failure class and what remains true
06-timelessness.md          why none of this names a product, bus, or vendor
07-open-questions.md        schema gaps and conflicts this corpus refuses to paper over
08-acceptance.md            the AC index for the whole subtree
```

Then the seven branches:

| Branch | Question it answers |
|---|---|
| `presentation/` | What is a still, who may commit one, and what may the user observe? |
| `rendering/` | How does declared content become pixels on each path, and what is never assumed? |
| `protocol/` | What crosses the contract boundary, in what envelope, with what authority? |
| `runtime/` | Which processes exist, how are they supervised, and how does state survive? |
| `security/` | What may be observed, injected, captured, or revoked, and by whom? |
| `performance/` | What are the budgets, how are they measured, and how does the system degrade honestly? |
| `ecosystem/` | How do independent devices produce one continuous, honest still? |

---

## 2. The laws this subtree applies

The architecture does not create new laws. It applies `00-canon/02-design-laws.md`
without exception. The five that shape every file below:

1. **LAW-001 — one fact, one owner.** `02-ownership.md` is the map; any second copy is a
   defect, not a cache.
2. **LAW-002 — pixels never cross the contract boundary.** The contract carries handles,
   geometry, timing, and declarations, never pixel arrays. `protocol/09-handles-lifetimes.md`
   is the enforcement point.
3. **LAW-003 — declared, not detected.** Damage, colour, HDR, scale, and intent are
   declared by an owner; the executor may reject a declaration but MUST NOT invent one.
   `presentation/11-damage-declaration.md` and `rendering/02-damage.md` are the enforcement
   points.
4. **LAW-004 — idle is silent.** No periodic work without a declared need.
   `performance/03-idle.md` is the enforcement point.
5. **LAW-005 — authority mandatory, policy optional.** Validation, numbering, and truth
   are mandatory. Layout, stacking, and arbitration are optional policy that may be absent,
   replaced, or remote.

The full conflict hierarchy is in `00-canon/02-design-laws.md`. Where this subtree and a
schema disagree, **the schema wins** and the disagreement is recorded in
`07-open-questions.md` as a contract gap or a proposed change. No file in this subtree
edits a schema.

---

## 3. The three-part decomposition

Every architectural sentence in this subtree resolves to one of three roles. They are
roles, not processes; one process may hold all three on a small device, and three
machines may hold one each across a link.

```
┌──────────────────────────────────────────────────────────────────────┐
│ PRESENTATION AUTHORITY                                               │
│ mandatory · validates · numbers · owns the still · never renders     │
│  • session identity and capability set                               │
│  • commit acceptance/rejection                                       │
│  • still number and still history                                    │
│  • input ownership and focus owner                                   │
│  • truth of what the user is seeing                                  │
└───────────────┬──────────────────────────────────┬───────────────────┘
                │ declared still                   │ policy query
                ▼                                  ▼
┌──────────────────────────────────┐  ┌───────────────────────────────┐
│ POLICY (optional)                │  │ EXECUTOR (replaceable)        │
│ layout · stacking · arbitration  │  │ scanout · plane · GPU · CPU   │
│ may be absent, local, or remote  │  │ remote encoder · headless sink│
│ produces a plan, never pixels    │  │ produces pixels, never truth  │
└──────────────────────────────────┘  └───────────────────────────────┘
```

- **Authority** is mandatory on every device that presents. A device with no authority
  is a peripheral, not a presenter. `presentation/03-authority.md`.
- **Policy** is optional. With no policy the authority applies the declared placement
  hints and a total order; with policy the plan is an input, never an override of
  validation. `presentation/04-policy.md`.
- **Executor** is replaceable. The contract names what it must do, never how. A CPU
  rasterizer and a scanout engine are interchangeable if both satisfy the same
  acceptance. `presentation/05-executor.md`.

---

## 4. What "complete" means here

This subtree is governed by `08-process/02-completeness-contract.md`. Concretely:

- Every architecture path in `03-paths.md` has a file section and an acceptance row.
- Every buffer state in `04-buffer-lifecycle.md` has an owner, an entry condition, an
  exit condition, and a failure edge.
- Every failure in `05-failure-taxonomy.md` states what the user sees and what the
  authority still guarantees.
- Every envelope in `ecosystem/envelopes/` has the same chapter skeleton, with no
  "similar to phone" substitutions.
- Every normative claim about a wire fact cites `protocol/schemas/<file>.capnp:<line>`.

A claim without a citation is a design note, not a contract claim. A claim that the
schema contradicts is listed in `07-open-questions.md`; it is never silently resolved in
prose.

---

## 5. Files intentionally absent

`n/a — no architecture file may define pixel values, component anatomy, shell layout, or
app flows; those belong to `03-framework`, `04-shell`, `05-apps`, and `06-envelopes`.`

`n/a — no architecture file may modify `protocol/schemas/*.capnp`; proposals live in
`07-open-questions.md` and require a contract change outside this subtree.`

---

## 6. Parent and children

- Parent: `docs/ui-canon/README.md`.
- Canon inputs: `00-canon/02-design-laws.md`, `00-canon/03-glossary.md`,
  `00-canon/04-decision-log.md`, `00-canon/06-document-system.md`.
- Process input: `08-process/02-completeness-contract.md`.
- Contract input: `protocol/schemas/*.capnp` (authoritative over every sentence here).
- Children: see `children:` above and each branch README.

---

## 7. Coverage declaration

| Area | Files | Complete? |
|---|---|---|
| Model, ownership, paths, buffers, failures, timelessness, acceptance | 8 | yes |
| Presentation | 16 | yes |
| Rendering | 17 | yes |
| Protocol | 15 | yes |
| Runtime | 14 | yes |
| Security | 12 | yes |
| Performance | 10 | yes |
| Ecosystem (including 10 envelopes) | 28 | yes |

"Complete" means every question named in the branch manifest has a leaf file with
normative rules and acceptance. It does not mean the schema is complete; see
`07-open-questions.md` for the seven contract gaps this corpus found.
