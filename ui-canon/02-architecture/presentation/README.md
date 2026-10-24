---
id: ARCH-PRESENT-INDEX
title: Presentation
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-000]
children:
  - 01-still.md
  - 02-commit.md
  - 03-authority.md
  - 04-policy.md
  - 05-executor.md
  - 06-input-ownership.md
  - 07-rejections.md
  - 08-crash-recovery.md
  - 09-numbered-truth.md
  - 10-observation.md
  - 11-damage-declaration.md
  - 12-present-intent.md
  - 13-buffer-lifetime.md
  - 14-acceptance.md
  - 15-open-questions.md
  - 16-changelog.md
  - 17-references.md
---

# Presentation

> How a visible fact becomes true, stays true, and stops being true. The presentation
> authority is the only owner of "what the user is seeing." Everything else — policy,
> executor, app, shell — produces inputs, plans, or pixels. None of them owns the truth.

**Scope:** the numbered still, the commit, the authority, the optional policy, the
replaceable executor, input ownership, rejections, crash recovery, observation rights,
damage declaration, present intent, and buffer lifetime.

**Non-goals:** rendering algorithms, GPU/CPU paths, protocol field definitions, component
anatomy, shell layout, app flows. Those belong to `rendering/`, `protocol/`,
`03-framework/`, `04-shell/`, `05-apps/`.

---

## 1. The single question this branch answers

> What is the user seeing right now, who vouches for it, and how does it change?

Every file below answers a sub-question of that. If a sentence in this branch cannot be
traced to a numbered still, it does not belong here.

---

## 2. The presentation truth in one page

```text
  PRODUCER (app, shell, system service)
        │
        │  commit: buffer + damage + present intent + fence + optional semantics
        ▼
  ┌──────────────────────────────────────────────────────────────────┐
  │ PRESENTATION AUTHORITY  (mandatory, never absent)                │
  │  • validates the commit against invariants                       │
  │  • assigns the next still number                                 │
  │  • stores the current numbered still                             │
  │  • produces named rejections (never silent drops)                │
  │  • owns input ownership and focus owner                           │
  │  • tracks buffer lifetime and observation rights                 │
  └───────────────┬──────────────────────────────┬───────────────────┘
                  │                              │
                  │ policy query (optional)       │ present intent
                  ▼                              ▼
  ┌──────────────────────────────────┐  ┌───────────────────────────────┐
  │ POLICY (optional)                │  │ EXECUTOR (replaceable)        │
  │ layout · stacking · arbitration  │  │ scanout · plane · GPU · CPU   │
  │ produces a plan, never pixels    │  │ remote encoder · headless sink│
  │ may be absent, local, or remote  │  │ produces pixels, never truth  │
  └──────────────────────────────────┘  └───────────────────────────────┘
```

The authority is the only component that may say "the current still is N." Policy and
executor may advise, plan, and present, but they never write the truth. This is
`LAW-005` (authority mandatory, policy optional) and `LAW-001` (one fact, one owner).

---

## 3. Directory map

| File | Question it answers |
|---|---|
| [01-still.md](01-still.md) | What is a numbered still, and what does it carry? |
| [02-commit.md](02-commit.md) | What is a commit, and what must it declare? |
| [03-authority.md](03-authority.md) | What does the authority validate, number, and own? |
| [04-policy.md](04-policy.md) | When does policy exist, and what may it decide? |
| [05-executor.md](05-executor.md) | How does a still become visible, and on which paths? |
| [06-input-ownership.md](06-input-ownership.md) | Who owns input, and how are capture leases scoped? |
| [07-rejections.md](07-rejections.md) | What are the named failure classes, and what does the user see? |
| [08-crash-recovery.md](08-crash-recovery.md) | What survives when policy or executor dies? |
| [09-numbered-truth.md](09-numbered-truth.md) | How do still numbers enable forensics, remote output, and crash recovery? |
| [10-observation.md](10-observation.md) | Who may observe a still, and on what terms? |
| [11-damage-declaration.md](11-damage-declaration.md) | Why is damage declared, never detected? |
| [12-present-intent.md](12-present-intent.md) | When does the producer want the commit visible? |
| [13-buffer-lifetime.md](13-buffer-lifetime.md) | How long does a buffer live, and who may read it? |
| [14-acceptance.md](14-acceptance.md) | How is the whole branch proved? |
| [15-open-questions.md](15-open-questions.md) | What is unresolved, owned, and due? |
| [16-changelog.md](16-changelog.md) | What changed? |
| [17-references.md](17-references.md) | What is the evidence, with limits? |

---

## 4. The laws this branch applies

| Law | Where it is enforced |
|---|---|
| `LAW-001` one fact, one owner | `02-ownership.md` (architecture root), `03-authority.md` here |
| `LAW-002` pixels never cross a contract boundary | `protocol/09-handles-lifetimes.md`, `13-buffer-lifetime.md` here |
| `LAW-003` declared, not detected | `11-damage-declaration.md` here, `rendering/02-damage.md` |
| `LAW-004` idle is silent | `performance/03-idle.md`, `10-performance.md` (foundations) |
| `LAW-005` every visible state is a numbered still | `01-still.md`, `09-numbered-truth.md` here |
| `LAW-006` authority mandatory, policy optional | `03-authority.md`, `04-policy.md` here |
| `LAW-007` depth communicates hierarchy | `01-foundations/depth/` |
| `LAW-008` motion explains change | `01-foundations/motion/` |
| `LAW-009` accessibility is structural | `01-foundations/accessibility/`, `05-apps/_standard/06-accessibility.md` |
| `LAW-010` no permanent chrome without a timeless job | `04-shell/` |
| `LAW-011` honesty over polish | `05-apps/_standard/09-failure.md` |
| `LAW-012` design before code | `08-process/` |

---

## 5. The invariant that makes everything else possible

**A numbered still is atomic.** Pixels, hit map, accessibility snapshot, input ownership,
and buffer lifetime are committed together and numbered together. There is no "the
pixels are at still 42 but the hit map is at 43." This invariant is what removes whole
classes of bugs: a moved window with stale hit targets, a screen reader describing a
gone control, a buffer recycled while visible.

The authority is the only component that may assign a still number. The producer
declares; the authority numbers. The executor presents; it does not number. Policy
plans; it does not number. This is `ADR-0001`.

---

## 6. What is intentionally absent

- `n/a — no rendering algorithm. Rendering is `rendering/` and its executors.`
- `n/a — no GPU/CPU specifics. Those are implementation details of executors.`
- `n/a — no component or app anatomy. Those belong to `03-framework/` and `05-apps/`.`
- `n/a — no schema field definitions. Those are `protocol/` and `protocol/schemas/*.capnp`.`
- `n/a — no shell layout. That is `04-shell/`.`

---

## 7. Parent and children

- Parent: `docs/ui-canon/02-architecture/README.md`.
- Canon inputs: `00-canon/02-design-laws.md`, `00-canon/03-glossary.md`,
  `00-canon/04-decision-log.md`, `00-canon/06-document-system.md`.
- Contract inputs: `protocol/schemas/compositor.capnp`, `surface.capnp`, `display.capnp`,
  `framebuffer.capnp`.
- Process input: `08-process/02-completeness-contract.md`.
- Children: see `children:` above and each leaf file.

---

## 8. Coverage declaration

| Sub-question | File | Complete? |
|---|---|---|
| What is a still? | `01-still.md` | yes |
| What is a commit? | `02-commit.md` | yes |
| What does the authority do? | `03-authority.md` | yes |
| When does policy exist? | `04-policy.md` | yes |
| How does a still become visible? | `05-executor.md` | yes |
| Who owns input? | `06-input-ownership.md` | yes |
| What are the named rejections? | `07-rejections.md` | yes |
| What survives a crash? | `08-crash-recovery.md` | yes |
| Why numbered stills? | `09-numbered-truth.md` | yes |
| Who may observe? | `10-observation.md` | yes |
| Why declared damage? | `11-damage-declaration.md` | yes |
| When is it visible? | `12-present-intent.md` | yes |
| How long does a buffer live? | `13-buffer-lifetime.md` | yes |
| How is it proved? | `14-acceptance.md` | yes |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-000` | Every file listed in `children` exists; every file in the directory is listed; no `TODO` or empty section. |
| `AC-ARCH-PRESENT-001` | A kill of the policy leaves stills intact and input leases expiring. |
| `AC-ARCH-PRESENT-002` | A kill of the executor leaves the still and the authority intact. |
| `AC-ARCH-PRESENT-003` | Every commit produces either a numbered still or a named rejection. |
| `AC-ARCH-PRESENT-004` | No observer reads a buffer without a capability. |
| `AC-ARCH-PRESENT-005` | No two commits share a still number. |
| `AC-ARCH-PRESENT-006` | No commit is silently dropped. |
