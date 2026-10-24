---
id: SHELL-STRIP-INDEX
title: Strip
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-000]
children:
  - 01-model.md
  - 02-cards.md
  - 03-ordering.md
  - 04-magnification.md
  - 05-fan-out.md
  - 06-invocation.md
  - 07-privacy.md
  - 08-performance.md
  - 09-failure.md
  - 10-acceptance.md
---

# Strip

> The strip is a **summon-only depth reel of live stills**. It replaces the dock
> (`ADR-0006`). It is a launcher and a switcher in one surface: cards with real content,
> magnification via one spring, privacy-controlled. Pulling it up fans out into the full
> spatial switcher. It is never permanently visible.

**Scope:** model, cards, ordering, magnification, fan-out, invocation, privacy,
performance, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app internals (`05-apps/`); thumbnails as a
second copy of app content (forbidden by `LAW-001`).

---

## 1. The single question this branch answers

> How does a person see what exists and move between it, without permanent chrome?

---

## 2. The model in one page

```text
   hidden (cost zero)  ──edge summon──►  reel (cards, magnification)  ──pull up──►  fan-out (spatial switcher)
            ▲                                  │  one spring                       │ search, group, close, move
            │                                  │                                    │
            └──────────── dismiss ──────────────┴──────────── dismiss ────────────────┘
```

- Hidden: zero messages, zero wakeups, zero GPU time (`LAW-004`).
- Reel: a horizontal (or envelope-appropriate) reel of cards; one spring magnifies the
  card under focus/proximity.
- Fan-out: the full spatial switcher with grouping, search, close, move-to-space.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What the strip is; summon-only depth reel |
| [02-cards.md](02-cards.md) | Card content, title, state, privacy, live vs frozen, badges |
| [03-ordering.md](03-ordering.md) | Recency vs user-arranged; per-window vs per-app; spaces |
| [04-magnification.md](04-magnification.md) | One spring, proximity, focus, reduced motion |
| [05-fan-out.md](05-fan-out.md) | Spatial switcher, grouping, search, close, move to space |
| [06-invocation.md](06-invocation.md) | Edge, keyboard, gesture, remote, voice, watch crown |
| [07-privacy.md](07-privacy.md) | Blanking, sensitive apps, screen capture, thumbnails |
| [08-performance.md](08-performance.md) | Commit-driven thumbnails, idle zero, memory |
| [09-failure.md](09-failure.md) | Failure and recovery |
| [10-acceptance.md](10-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-STRIP-001` | Hidden strip costs zero messages/wakeups/GPU over one hour. |
| `AC-SHELL-STRIP-002` | Strip updates only on commit, never on a timer. |