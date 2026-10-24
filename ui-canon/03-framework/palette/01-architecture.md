---
id: FW-PALETTE-ARCH
title: Palette architecture
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-001]
---

# Palette architecture

> The palette is the universal command surface: find and invoke any command from anywhere.
> It is a foundation, not an optional app (master brief §2).

---

## 1. What the palette is

The palette is an overlay at elevation `overlay` that aggregates every command registered
by the app, the shell and the system, and lets the person reach any of them by typing,
speaking, or navigating. It is the single answer to "what can I do here, and how do I do it
without remembering where it lives?".

It is **not** an app launcher only. It is every command, search and action, ranked and
context-aware (palette/README §1).

## 2. The model in one page

```text
  command registry (app + shell + system commands, stable IDs)
        |
        v
  context filter (global / app / selection / object)
        |
        v
  matcher (fuzzy, tokenised, locale-aware)
        |
        v
  ranker (recency, frequency, context, capability, safety)
        |
        v
  palette overlay (input field + result list + preview + key hints)
        |
        v
  dispatch (command handler, capability check, undo entry)
```

- The registry is the single source. Menus, toolbars, shortcuts and palette all project from
  it (`Smart UI` §10.2).
- The palette never invents a command. A command that is not registered cannot be invoked.
- Dispatch goes through the capability layer; a denied command shows its reason, not a silent
  no-op.

## 3. Ownership

| Fact | Owner |
|---|---|
| Command IDs, labels, shortcuts, availability, handlers | The registering app/shell/system surface |
| Ranking weights and recency | Palette |
| Context resolution (global/app/selection/object) | Palette, using the active focus and selection |
| Input text and preview | Palette |
| Capability enforcement | Capability layer (framework) |
| Accessibility tree for the palette | Framework semantic tree (runtime/07) |

## 4. Envelope behaviour

| Envelope | Invocation | Shape | Dismissal |
|---|---|---|---|
| Watch | Crown press or voice | Full-screen list, one result visible | Crown back / escape |
| Phone | Swipe down or key | Full-screen sheet | Swipe down / back |
| Tablet | Key or gesture | Centred overlay, 60% width | Outside tap / escape |
| Desktop | Ctrl/Cmd+K or menu | Centred overlay, 40% width | Outside click / escape |
| TV | Remote search button | Full-screen, d-pad navigable | Back |
| EV | Voice-first, touch secondary | Large targets, driver-safe | Voice cancel / back |
| Spaceship | Procedure-keyed | Deterministic list, no animation | Confirm/cancel |
| IoT | n/a — reason: no text input surface | n/a |
| Spatial | Anchored to gaze/focus | Floating panel | Gaze away / pinch |
| Remote browser | Keyboard | Browser-native overlay | Escape |

## 5. States

The palette implements the cross-cutting state vocabulary (framework README §6): default,
focus, pressed, selected, disabled (command unavailable), loading (async search), empty
(no results), error (registry failure), reduced motion, high contrast, 200% text, RTL,
long content, remote/d-pad, screen reader.

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-FW-PALETTE-ARCH-001` | Every registered command is reachable from the palette on every envelope that supports text input. |
| `AC-FW-PALETTE-ARCH-002` | A denied command displays its reason and a path to request the capability. |
