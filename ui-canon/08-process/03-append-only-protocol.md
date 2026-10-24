---
id: PROC-APPEND-ONLY
title: The Append-Only Protocol
kind: process
entity: process
status: canon
normative: true
version: 0.1.0
owner: Canon Editor
depends: [PROC-MASTER-BRIEF, PROC-COMPLETENESS, DOC-SYSTEM]
acceptance: [AC-PROC-APPEND-001]
---

# The Append-Only Protocol

> A rewrite is a deletion with better manners. The corpus grows by addition. When direction
> changes, the old direction stays, marked, because the reason it was rejected is part of
> the design.

---

## 1. The rule

**Add. Do not overwrite.**

When new work changes an existing document:

1. Prefer a **new file** that extends, supersedes or corrects the old one.
2. If the change belongs in the same file, **append a dated section** and mark the old
   section `Superseded by §N` or `Extended by §N`.
3. Never silently delete a paragraph, table, decision, frame or source.
4. Never replace a file wholesale to "clean it up".
5. Never overwrite another agent's file. If it is wrong, write a correction file and link
   it.

A deletion is allowed only when:

- the content is provably duplicated in another file and the link is recorded;
- the content is factually wrong and the correction is recorded in the changelog with the
  old text preserved in an `archive/` or a `Superseded` section;
- a gate explicitly approves the removal, with an ADR.

---

## 2. File patterns

### 2.1 Extend

```text
03-behaviour.md                 (existing)
03-behaviour-addendum-01.md     (new, extends it)
```

The addendum starts with:

```yaml
extends: 03-behaviour.md
reason: <why the original did not cover this>
```

### 2.2 Supersede

```text
04-decision-log.md              (existing, append-only)
ADR-0023-...                    (new decision)
```

The old ADR is marked `Superseded by ADR-0023`; it is not deleted.

### 2.3 Correct

```text
05-layout.md                    (existing)
05-layout-correction-01.md      (new, corrects a specific claim)
```

The correction names the exact section, the old claim, the new claim and the evidence.

### 2.4 Archive

```text
archive/
├── 2026-10-22-old-tree.md
└── README.md
```

Archived files keep their original content and a note explaining why they were archived.

---

## 3. Shared documents

The following are **append-only** unless an ADR explicitly authorises a change:

- `README.md` at any level;
- `00-canon/02-design-laws.md`;
- `00-canon/04-decision-log.md`;
- `00-canon/06-document-system.md`;
- `08-process/00-master-brief.md`;
- `08-process/02-completeness-contract.md`;
- any `references/` bibliography;
- any `11-acceptance.md` evidence table.

Changes to these are made by:

- appending a new section;
- appending a new ADR;
- adding a new addendum file;
- adding a row to a table (never deleting an old row).

---

## 4. Agents

Every agent MUST:

- treat every existing file as read-only unless it is explicitly assigned to that agent;
- create new files rather than rewriting assigned files that already exist;
- append to an assigned file only when the new content is additive and the old content
  remains intact;
- record every new file in its report;
- report any deletion it believes is necessary, and wait for approval;
- never "normalise", "reformat" or "simplify" another agent's prose.

If an agent finds a contradiction, it writes `conflict-<topic>.md` with both claims, the
evidence and a proposed resolution. It does not delete the losing claim.

---

## 5. The diff test

Before saving, an agent asks:

1. Does this change remove a sentence that another person might need?
2. Does it remove a state, frame, source, decision or rare case?
3. Does it replace a file that another agent owns?
4. Does it collapse two questions into one?
5. Does it "clean up" without adding evidence?

If any answer is yes, the change is wrong. Append instead.

---

## 6. Why this matters

The corpus is a design memory. The value of a rejected idea is that it was rejected for a
reason. The value of an old frame is that it shows what changed. The value of a source is
that it can be re-checked. A rewrite destroys all three.

The OS is meant to be timeless. A corpus that deletes its own history cannot be.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-PROC-APPEND-001` | No shared file is rewritten without an ADR. |
| `AC-PROC-APPEND-002` | Every superseded section is marked and preserved. |
| `AC-PROC-APPEND-003` | Every correction names the old claim and the evidence. |
| `AC-PROC-APPEND-004` | No agent deletes another agent's file. |
| `AC-PROC-APPEND-005` | Every deletion has an archive copy and a changelog entry. |
| `AC-PROC-APPEND-006` | The diff test is recorded for any destructive change. |
