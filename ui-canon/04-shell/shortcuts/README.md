---
id: SHELL-SHORTCUTS-INDEX
title: Shortcuts
kind: shell
entity: shortcuts
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, APP-INPUT]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-SHORTCUT-000]
children:
  - 01-model.md
  - 02-registry.md
  - 03-default-bindings.md
  - 04-palette-integration.md
  - 05-discoverability.md
  - 06-per-envelope.md
  - 07-accessibility.md
  - 08-failure.md
  - 09-acceptance.md
---

# Shortcuts

> Shortcuts are **accelerators, never the only path** (`ADR-0021`). They bind to stable
> command IDs, are discoverable in the palette, remappable, and shown in context. There
> is no global shortcut that exists only as a secret.

**Scope:** model, registry, default bindings, palette integration, discoverability,
per-envelope, accessibility, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app-private binding tables that override system
bindings silently.

---

## 1. The single question this branch answers

> How does a person invoke any command quickly without memorising secrets, and how does
> the same command stay reachable on every device?

---

## 2. The model in one page

```text
    COMMAND ID (stable, app/system-owned)
        │
        ▼
    SHORTCUT REGISTRY  (global; conflict resolution; scope)
        │
        ▼
    BINDING TABLE  (per envelope; user-remappable)
        │
        ▼
    PALETTE  (discoverable list of every command + its shortcut)
```

- A shortcut is a binding from a key/gesture/voice phrase to a command ID.
- The command ID is the truth; the binding is a preference.
- Every command has a visible path; the shortcut is an accelerator (`LAW-009` adjacent:
  shortcuts are not the only path).

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What a shortcut is; command IDs; scope |
| [02-registry.md](02-registry.md) | Global registry; conflict resolution |
| [03-default-bindings.md](03-default-bindings.md) | Default key bindings per verb |
| [04-palette-integration.md](04-palette-integration.md) | Palette shows and invokes shortcuts |
| [05-discoverability.md](05-discoverability.md) | How shortcuts are learned |
| [06-per-envelope.md](06-per-envelope.md) | Bindings per envelope |
| [07-accessibility.md](07-accessibility.md) | Non-keyboard paths |
| [08-failure.md](08-failure.md) | Conflicts, missing bindings, remap errors |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SHORTCUT-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-SHORTCUT-001` | Every shortcut has a discoverable command and non-shortcut path. |
| `AC-SHELL-SHORTCUT-002` | Conflict resolution is deterministic. |