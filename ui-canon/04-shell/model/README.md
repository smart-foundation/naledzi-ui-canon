---
id: SHELL-MODEL-INDEX
title: Shell Model
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, ARCH-PRESENT-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-000]
children:
  - 01-what-the-shell-is.md
  - 02-policy.md
  - 03-surfaces.md
  - 04-focus.md
  - 05-spaces.md
  - 06-multi-window.md
  - 07-system-ui.md
  - 08-acceptance.md
---

# Shell Model

> The shell is not a compositor and not a window manager in the legacy sense. It is the
> optional policy plus the mandatory system surfaces that live at `system` elevation. This
> directory defines what it is, what it owns, and what it must never do.

**Scope:** the conceptual model of the shell: identity, policy, surfaces, focus, spaces,
multi-window, and the boundary between system-drawn and app-drawn UI.

**Non-goals:** rendering, commit numbering, buffer lifetimes (those are `presentation/`
and `rendering/`); app internals (`05-apps/`); envelope-specific layout
(`06-envelopes/`).

---

## 1. The single question this branch answers

> What is the shell, what does it own, and where does it stop?

---

## 2. The model in one page

```text
   ┌──────────────────────────────────────────────────────────────┐
   │  PRESENTATION AUTHORITY  (mandatory; owns truth)             │
   └──────────────┬───────────────────────────────┬──────────────┘
                  │ plan (optional)               │ present intent
                  ▼                               ▼
   ┌──────────────────────────────┐   ┌──────────────────────────┐
   │  SHELL POLICY (optional)     │   │  EXECUTOR (replaceable)  │
   │  placement · stacking · focus │   │  scanout · planes · GPU  │
   │  arbitration · spaces        │   │  remote · headless       │
   └──────────────┬───────────────┘   └──────────────────────────┘
                  │
                  │ system surfaces (commits at system elevation)
                  ▼
   ┌──────────────────────────────────────────────────────────────┐
   │  STATUS RAIL · STRIP · LOCK · NOTIFICATIONS · PALETTE HOST  │
   │  (mandatory in form; per-envelope in content)                │
   └──────────────────────────────────────────────────────────────┘
```

---

## 3. Directory map

| File | Question |
|---|---|
| [01-what-the-shell-is.md](01-what-the-shell-is.md) | What is the shell, and what is it not? |
| [02-policy.md](02-policy.md) | When is policy present, and what may it decide? |
| [03-surfaces.md](03-surfaces.md) | What is a surface, a window, a still, a card? |
| [04-focus.md](04-focus.md) | Who owns focus, how is it restored, cross-device? |
| [05-spaces.md](05-spaces.md) | What are spaces, how do they transition and persist? |
| [06-multi-window.md](06-multi-window.md) | Split, tiling, floating, fullscreen, PiP, multi-display |
| [07-system-ui.md](07-system-ui.md) | What does the system draw vs the app? |
| [08-acceptance.md](08-acceptance.md) | How is the model proved? |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-MODEL-001` | Killing the shell policy leaves stills intact and input leases expiring. |
| `AC-SHELL-MODEL-002` | A watch with no policy still presents its single surface correctly. |
| `AC-SHELL-MODEL-003` | System surfaces commit at `system` elevation and are never drawn by an app. |