---
title: "Smart UI Framework"
subtitle: "Complete Product and Engineering Specification"
author: "Smart Foundation"
date: "21 October 2026"
version: "2.0"
status: "Normative implementation baseline"
---

**Version:** 2.0  
**Status:** Normative implementation baseline  
**Implementation status:** Specification baseline; implementation is not yet certified against it

## Contents

- [01 — Executive definition](#sec-01)
- [02 — Product goals](#sec-02)
- [03 — Non-goals](#sec-03)
- [04 — Design principles](#sec-04)
- [05 — Naming and package strategy](#sec-05)
- [06 — Architecture and ownership](#sec-06)
- [07 — Crate internals and public API](#sec-07)
- [08 — Smart Protocol integration](#sec-08)
- [09 — Application developer experience](#sec-09)
- [10 — Universal command palette and actions](#sec-10)
- [11 — UX component and interaction contract](#sec-11)
- [12 — Adaptive UI for a multi-device ecosystem](#sec-12)
- [13 — Appearance and design-token system](#sec-13)
- [14 — Rendering and the MirUI integration](#sec-14)
- [15 — Zero-cost and resource discipline](#sec-15)
- [16 — Application lifecycle, persistence and faults](#sec-16)
- [17 — Rust implementation standards](#sec-17)
- [18 — Testing and release gates](#sec-18)
- [19 — Implementation sequence](#sec-19)
- [20 — Acceptance criteria for the finished framework](#sec-20)
- [21 — Decisions that are intentionally deferred](#sec-21)
- [22 — Remote browser sessions and multi-output architecture](#sec-22)
- [23 — Normative requirement model and traceability](#sec-23)
- [24 — Application archetypes and standard shells](#sec-24)
- [25 — Complete standard widget and UX inventory](#sec-25)
- [26 — Layout and adaptive composition specification](#sec-26)
- [27 — Application state, commands and service work](#sec-27)
- [28 — Universal command system: canonical specification](#sec-28)
- [29 — Appearance, style recipes and theme format](#sec-29)
- [30 — Motion and interaction polish](#sec-30)
- [31 — Typography, icons, assets and internationalisation](#sec-31)
- [32 — Input, focus, gestures and accessibility](#sec-32)
- [33 — Rendering architecture, panels and high-complexity applications](#sec-33)
- [34 — Multi-output and remote-browser OS architecture — expanded requirements](#sec-34)
- [35 — Resource profiles, memory and performance budgets](#sec-35)
- [36 — Developer tooling, documentation and app completeness](#sec-36)
- [37 — Rust implementation and public API shape](#sec-37)
- [38 — Compatibility, evolution and migration](#sec-38)
- [39 — Implementation plan and release gates](#sec-39)
- [40 — Finished-framework conformance checklist](#sec-40)
- [41 — Decisions, constraints and deliberately excluded complexity](#sec-41)
- [42 — Glossary](#sec-42)
- [43 — Source basis and implementation references](#sec-43)

This is the complete normative product and engineering specification for Smart UI. It defines the application developer model, standard component inventory, interaction semantics, token system, adaptive layout, MirUI integration, Smart Protocol boundaries, local and remote output architecture, resource rules, implementation sequence and release conformance. Requirements in this document are targets to implement; they are not assertions that all capabilities already exist in MirUI, Smart Protocol or Naledzi.

The words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT** and **MAY** are normative. A requirement marked MUST is a release-blocking requirement unless a documented exception is approved in a specification revision.

# 1. Executive definition {#sec-01}

Smart UI is the single, cohesive, portable application framework used to build the Smart Foundation application ecosystem. It combines a deliberate UX model, an adaptable design system, application-level services and MirUI's ECS-driven UI machinery into one developer-facing framework.

Smart UI is not an operating system, window manager, compositor, package manager, new protocol, component-only styling library or second ECS. It is the application framework that allows many applications of different complexity to share one interaction language and appearance system while remaining portable across operating systems and device classes.

The framework's permanent external interoperability boundary is Smart Protocol. MirUI is an implementation choice inside Smart UI. Naledzi is one host for the framework, not its definition. The same app architecture MUST remain usable on another host that implements the required Smart Protocol contracts and a compatible application ABI/runtime. Physical displays, embedded panels and authenticated browser sessions are all presentation outputs; no application or host implementation may assume one fixed display or one global input focus.

The core design decision is deliberately simple:

> **One framework. One ECS. One system scheduler. One interaction model. One appearance model. One canonical contract source.**

Separate responsibilities internally when doing so clarifies ownership, but do not split them into crates, runtimes, registries, tree models or schedulers without a concrete independent-build, deployment, ownership or dependency requirement.

# 2. Product goals {#sec-02}

Smart UI MUST:

1. Make it straightforward to build small, polished applications and remain capable of supporting complex editors, browsers, media applications, creative tools and system utilities.
2. Provide consistent default UX, a discoverable command palette in every application, a common command/action model and standard interaction behaviours.
3. Use MirUI directly for ECS, composition, layout, hit testing, rendering, animation and other capabilities it already supplies well.
4. Consume canonical Smart Protocol schemas and generated bindings; it MUST NOT manually recreate protocol structures or bypass contracted service boundaries.
5. Keep Naledzi-specific implementation details out of the application-facing API.
6. Adapt to changing viewport constraints and available input modalities without making business logic depend on device brand or operating system.
7. Make appearance replaceable: geometry, colors, typography, density, motion and surface treatment MUST be theme-controlled rather than embedded in app logic.
8. Treat `no_std` compatibility, predictable memory use, low overhead and avoiding redundant work as design constraints rather than later optimisations.
9. Keep the public API cohesive, idiomatic Rust, unsurprising and small enough that developers can learn it without understanding the framework internals.
10. Permit advanced applications to use lower-level MirUI capabilities when standard UX primitives are not sufficient, without forcing every app through an opaque high-level abstraction.
11. Make a complete authenticated remote OS session in a browser a first-class output: interactive, multi-window, low-latency, secure and based on incremental structured presentation updates rather than whole-screen VNC-style frame streaming as the default path. Support multiple local and remote outputs concurrently.

# 3. Non-goals {#sec-03}

Smart UI MUST NOT become:

- A second OS service layer or a replacement for Smart Protocol.
- A new general-purpose ECS, reactive runtime, retained-tree engine or layout engine competing with MirUI.
- A separate crate for every conceptual module or target platform.
- A framework that requires every application to use a prescribed navigation style or identical page structure.
- A web DOM/CSS compatibility layer or an automatic port of desktop assumptions to mobile and embedded devices. The browser remote client is a purpose-built Smart UI output using the portable presentation model; it is not an attempt to emulate a general browser DOM or CSS.
- A theme that permanently fixes a brand palette, corner radius, font or motion curve in application code.
- A collection of decorative widgets without defined semantics, keyboard/input behaviour, state handling and accessibility meaning.
- A promise that every application binary runs unchanged on every CPU/ABI. Portability requires a compatible executable format/runtime and the Smart Protocol capabilities that the app needs.
- A hard-real-time framework by claim alone. Real-time suitability must follow from bounded work, predictable resource limits and measurements on target systems.

# 4. Design principles {#sec-04}

The framework applies the ten principles commonly associated with Dieter Rams as engineering rules, not as a decorative brand exercise.

1. **Innovative:** allow new rendering backends, input modes, surface types and visual treatments without redesigning the whole application API.
2. **Useful:** every default component and behaviour must solve a real task. Visual effects are never a substitute for function.
3. **Aesthetic:** the default system must be carefully art-directed, typographically coherent, proportionate and visually calm. Aesthetic quality is a product requirement, while its concrete values remain configurable.
4. **Understandable:** the API and UI should make available actions and consequences clear. A developer should not need to understand the scheduler to add a command or build a form.
5. **Unobtrusive:** app logic remains visible and direct. The framework does not impose needless lifecycle layers, hidden state machines or elaborate configuration merely to render a view.
6. **Honest:** unsupported operations and denied capabilities are shown as such. No fake success, silent fallbacks that change semantics or fabricated device features.
7. **Long-lasting:** stable semantic contracts outlive visual trends and replaceable implementation details.
8. **Thorough down to the last detail:** interaction states, focus, errors, cancellation, resizing, suspension, text editing and accessibility are designed together—not patched independently in every app.
9. **Environmentally conscious:** avoid wasteful redraws, needless copies, excessive idle wakeups, permanent background animation and unbounded allocations. On constrained devices, resource use is an explicit part of UX quality.
10. **As little design as possible:** expose the smallest API and abstraction set that solves the real problem. Do not add architecture merely to make diagrams symmetrical.

The governing test for every new abstraction is: **does it remove real complexity from applications or protect a necessary boundary?** If not, do not add it.

# 5. Naming and package strategy {#sec-05}

## 5.1 One public framework crate

The public package is `smart-ui`. It is the single cohesive framework dependency for application authors. Its feature flags select capabilities within the package. Its internal modules are not separate packages by default.

The repository MUST NOT create `smart-ui-core`, `smart-ui-ux`, `smart-ui-theme`, `smart-app-runtime`, `smart-ui-host`, or one crate per device merely to mirror conceptual layers. Those responsibilities live as modules within `smart-ui` until an actual constraint proves a separate package necessary.

A second crate is permitted only when at least one concrete reason exists: it must compile independently, it must run/deploy independently, it needs a dependency graph that the main crate cannot support, or it has a genuinely separate ownership/version boundary. The reason must be written down before creating it.

Rust procedural macros cannot be defined in an ordinary library crate. Smart UI SHOULD therefore use plain Rust APIs and MirUI's existing authoring facilities rather than introduce a Smart UI proc-macro crate by default. A future macro package requires a specific, demonstrated ergonomic win and is not part of the initial architecture.

## 5.2 Canonical terminology

- **Smart UI:** the complete application framework.
- **MirUI:** the internal ECS-driven UI/rendering engine.
- **Smart Protocol:** the canonical interoperation schemas and contracts.
- **Application:** an installable/runnable program using Smart UI.
- **Command:** a named, discoverable action which may be invoked from the palette, keyboard shortcut, menu or contextual UI.
- **Appearance:** the resolved visual rules applied to semantic components.
- **Host:** the environment providing contracted services and a renderable surface.

Names MUST be consistent across documentation, code and examples. Do not invent synonyms for the same concept in separate modules.

# 6. Architecture and ownership {#sec-06}

## 6.1 Logical architecture

```text
Smart UI applications (domain logic remains authoritative on the host)
        │
        ▼
smart-ui public API — one cohesive framework crate
        │
        ▼
MirUI (one ECS world, one scheduler, one layout/render pipeline)
        │
        ├── Local output(s) ── contracted surface/buffer/input ──┐
        │                                                        │
        └── Remote presentation deltas ── Smart Protocol ── Browser output client
                                                                 │
                       Host OS services and session authority ────┘
```

This is a logical separation, not a mandate for separate crates or separate runtime layers. Most of the framework remains in one Rust crate. App code calls a coherent API; internal modules preserve clear ownership.

## 6.2 MirUI owns

Smart UI MUST use MirUI for the functions MirUI already implements and can satisfy:

- ECS entities, components, resources, queries and system scheduling.
- UI composition facilities and declarative widget construction where appropriate.
- Layout, geometry, hit testing, visual-state propagation and dirty-region machinery.
- Rendering abstractions and available software/GPU backends.
- Animation primitives and frame-driven systems.

Smart UI MUST NOT mirror MirUI's UI entities into a second retained widget tree, create another ECS, introduce another general system scheduler or maintain a competing animation runtime. If a missing capability is real, add the smallest compatible extension or upstream contribution.

## 6.3 Smart UI owns

Smart UI adds only the application-level capabilities that make apps consistent and practical:

- Application bootstrap conventions and a small, explicit app context.
- Standard commands, command palette and shortcut discoverability.
- Standard UX components and interaction semantics.
- The design-token and appearance-resolution model.
- Device/environment-aware composition helpers.
- Consistent error presentation, cancellation, loading and empty-state conventions.
- Integration glue between canonical Smart Protocol clients and application UX.
- Testing helpers for application actions, input and appearance.

It does not replace app-specific domain models. An application remains responsible for its own business state and rules.

## 6.4 Smart Protocol owns

Smart Protocol defines the shape and meaning of data crossing component boundaries. Framework code MUST use generated types from `smart-foundation/smart-protocol-official`, following the repository's `vendor.sh` process and pinning the upstream revision.

No manually duplicated Cap'n Proto structs, stringly typed shadow protocols, local OS-specific shortcuts or alternative permission authorities are permitted where the canonical contract exists.

The framework's service client layer is a convenience over the official contract; it must preserve contract semantics, result/error values and capability checks. It MUST NOT imply that a UI action authorises a service operation.

## 6.5 Host responsibilities

A host implementation provides the contracted mechanisms necessary to run the app: application activation/lifecycle, surface creation, buffer access, frame commits, input events, text input, clipboard and accessibility integration as supported by its contracts.

Naledzi-specific code is an implementation of this host boundary, not a dependency that spreads throughout Smart UI. The app should not need `cfg(target_os = "naledzi")` in its business logic. The host boundary MUST support more than one presentation output, including an authenticated remote browser output. An output owns its viewport, scale, input endpoint/seat and presentation state; it does not own or duplicate the application's authoritative domain state.

# 7. Crate internals and public API {#sec-07}

The crate may organise modules such as `app`, `command`, `ux`, `appearance`, `adaptive`, `protocol`, `host` and `testing`. These are module boundaries, not mandated package splits. Avoid making every internal helper public. Public API must be intentional and documented.

The prelude MUST remain small and stable. It should expose common application construction, semantic UX primitives, command definitions and appearance types; backend-specific and advanced MirUI APIs remain in canonical module paths.

The public API SHOULD favour:

- Concrete types and explicit errors over string-based registries.
- Builder defaults for common cases, with direct setters for important choices.
- Plain Rust structs, enums, traits and functions.
- Immutable presentation descriptions plus explicit state/actions where possible.
- Borrowing and typed IDs instead of unnecessary clones or generic `Value` maps.
- Clear escape hatches to MirUI without exposing MirUI implementation types in every common signature.

The framework MUST avoid a sprawling configuration object where every setting has an optional override. Sensible defaults should make a useful application possible with few decisions; advanced configuration is added only when a real app requires it.

# 8. Smart Protocol integration {#sec-08}

## 8.1 Schema ownership map

The framework must consume only schemas needed for its responsibilities and use the official schema source for every binding.

- **`app.capnp`:** application lifecycle/status integration and app-management UX where appropriate. Lifecycle APIs map to canonical states/events; this schema is not a widget-description format.
- **`appindex.capnp`:** app discovery, launch and search clients for launchers, app browsers and related suite applications. Launch is not defined by `app.capnp` alone.
- **`manifest.capnp`:** bundle entry points, ABIs, dependencies, requested capabilities, assets and locale declarations where needed. Theme bundles may use its `theme` shape.
- **`compositor.capnp`:** host surface/session operations, surface metadata, frame/buffer commits and contracted surface/accessibility facilities. It is also the current home of a minimal `RemoteAccessConfig`; the existing toggle (`enabled`, authentication requirement and connection limit) is not by itself a complete remote-output session contract.
- **`buffer.capnp`:** buffer allocation/ownership and shared-buffer paths when supported and authorised. Bulk payloads must use contracted buffer/data-handle paths where suitable rather than inline, repeatedly copied screen-sized messages.
- **`input.capnp`:** device or input-state integration where the service contract applies. Raw per-surface events still arrive through the host's defined event path.
- **`ime.capnp`:** text-input sessions, preedit/commit and supported input methods. Do not add a parallel private IME protocol.
- **`accessibility.capnp`:** accessibility semantics, tree/events/actions and preferences. Keep UI semantics in components so the host can publish them.
- **`clipboard.capnp`:** clipboard operations only through granted capabilities; no silent direct OS clipboard bypass.
- **`intent.capnp`:** intent resolution and action/deep-link dispatch where appropriate.
- **Domain schemas** (files, web/network, media, audio, etc.): used by individual applications that need those services. The core framework must not implement every domain service.

The exact required generated schema set MUST be recorded in a reproducible vendoring manifest. Do not automatically compile every schema into every app solely for convenience; do not omit required schema dependencies either. Generated code may be kept in the repository or produced in the build, according to the established Smart Protocol workflow, but generation must be reproducible and checked for drift.

## 8.2 `app.capnp` is an app contract, not a widget schema

`app.capnp` covers running-app queries, opening resources, focus/minimise/close operations, detailed app information, lifecycle state/events, resource usage, instances, cross-app messages, permissions, resource limits, health and crash-recovery operations. The application index separately covers app discovery, search and launch. The framework MUST respect these boundaries.

A file-manager button does not directly manipulate process state. A system task manager can use the app-management client. The user's in-app command registry represents user actions; it does not duplicate `AppService` or grant permissions.

## 8.3 No contract bypass

All OS-owned operations cross the relevant Smart Protocol contract. Smart UI may make local calculations and local state changes without IPC; it must not call privileged host APIs directly to skip the contract. Capability grants are checked by the actual provider/security boundary, not merely by the UI. Remote browser output is subject to the same rule. Authentication/session authority must use the canonical identity and security contracts, and the output endpoint must have an explicit, versioned Smart Protocol contract for session creation, output negotiation, input routing, incremental presentation updates, acknowledgements/backpressure, reconnect/resynchronisation and revocation. Do not hide this as a Naledzi-only websocket API.

## 8.4 Portability condition

An application is portable when its dependencies are limited to stable Smart Protocol contracts, its declared runtime/ABI and assets, and the Smart UI/MirUI requirements. A different OS must implement compatible contracts and the required capabilities. The framework MUST give explicit errors or supported degraded behaviour when an optional feature is absent; it MUST NOT invent success.

# 9. Application developer experience {#sec-09}

## 9.1 Application authoring model

The normative authoring path has five steps: declare application identity, construct one app-owned domain model, register commands, compose the UI using Smart UI components over MirUI's existing composition facilities, and start the app through the host. The standard palette, appearance resolution and common interaction systems are installed by default.

The following is the target API contract. Names and semantics are prescribed by this specification; implementation must make the examples compile as integration tests against the chosen pinned MirUI revision. `SmartApp` is a cohesive wrapper around MirUI and the Smart Protocol host integration, not a second runtime. `#[compose]` and `ui!` are MirUI's existing composition facilities; Smart UI must not invent another UI tree or add a proc-macro crate just to author standard layouts.

```rust
use smart_ui::prelude::*;
use mirui::prelude::ui;

#[model]
struct NotesState {
    #[observe]
    title: String,
    #[observe]
    body: String,
    #[observe]
    dirty: bool,
}

#[model]
impl NotesState {
    fn new_note(&mut self) {
        self.title = String::from("Untitled");
        self.body.clear();
        self.dirty = false;
    }
}

#[compose]
fn notes_content(notes: model!(NotesState)) {
    ui! {
        Column (grow: 1.0, padding: Padding::all(16)) {
            Row (height: 44) {
                Text(text: ${ notes.title() })
                Spacer()
                Button(text: "Save", command: "document.save")
            }
            TextArea(value: ${ notes.body() }, label: "Note text", grow: 1.0)
            StatusBar(text: ${ if notes.dirty() { "Unsaved changes" } else { "Saved" } })
        }
    };
}

fn main() -> Result<(), RunError> {
    let mut app = SmartApp::new(AppMetadata::new("org.smart.notes", "Notes"));
    let notes = app.add_model(NotesState {
        title: String::from("Untitled"),
        body: String::new(),
        dirty: false,
    }).finish();

    app.commands_mut().register(
        Command::new("document.new", "New note")
            .group("Document")
            .shortcut(Shortcut::primary("N"))
            .invoke(commands::new_note),
    );
    app.commands_mut().register(
        Command::new("document.save", "Save note")
            .group("Document")
            .shortcut(Shortcut::primary("S"))
            .enabled_when(conditions::document_is_dirty)
            .invoke(commands::save_note),
    );

    app.set_content(notes_content(notes));
    app.run()
}
```

The example establishes the intended idiom rather than limiting apps to this shape: `SmartApp` supplies the stable application entry point; app state stays in one owner; `Command` entries are shared by the palette, shortcut help, menus and buttons; MirUI's composition model owns the actual UI entities; components obtain appearance from tokens; service-backed handlers use generated Smart Protocol clients through the app context. `TextArea`, `StatusBar` and `command` bindings shown here are standard Smart UI facilities to implement, not claims that MirUI currently ships those exact widgets or modifier signatures today. The crate's first release must make this and the remaining canonical examples compile; if a signature is changed to match MirUI's real API, the whole specification and all examples must be updated together.

The domain model belongs to the application. Smart UI owns only presentation state where that is genuinely UI state (focus, pressed state, open popover, palette query, scroll offset). It must not duplicate canonical service data into multiple shadow models.

## 9.2 Levels of use

The framework supports three levels without different architectures:

1. **Standard application:** uses provided app shell, controls, commands, appearance and adaptive patterns.
2. **Custom application:** composes lower-level Smart UI and MirUI views while keeping the same command, appearance, accessibility and host rules.
3. **Advanced/creative application:** builds custom canvases, timelines, node editors, docking/panels or high-performance visualisations using MirUI's lower-level rendering and systems where needed.

These are usage styles, not packages or mutually exclusive products.

## 9.3 Errors and async work

Service operations return typed outcomes or explicit errors. UI work must not block the frame loop while waiting for potentially slow service calls. The framework provides a small, target-appropriate completion/cancellation pattern; it must not require a heavyweight async runtime merely to construct a view. Hosts may adapt completion delivery to their execution model.

The framework standardises pending, success, empty, denied, unavailable, cancelled and failed presentation without pretending that a request succeeded. Long operations must expose cancellation when the underlying contract supports it.

# 10. Universal command palette and actions {#sec-10}

## 10.1 Mandatory default

**Every Smart UI application MUST include the standard in-app command palette by default.** An application may extend its contents, but MUST NOT replace it with an incompatible bespoke palette. The palette is part of the standard framework shell, not an optional add-on.

On keyboard-capable environments, the default invocation is `Mod+K`, where `Mod` resolves to the platform's primary command modifier (for example, Command on Apple-style keyboards or Control on common PC keyboards). The key binding is configurable and discoverable. Escape closes the palette; up/down moves selection; Enter executes; typing narrows results; focus is placed in the query field and returned to the prior target when the palette closes. Pointer, touch, switch, voice or other host-supported input can invoke it through an accessible control or registered system action.

This in-app palette is distinct from an OS-wide palette. A system-wide palette requires a separate host-level capability and permission; Smart UI MUST NOT request global input capture simply to offer an in-app palette.

## 10.2 One command registry

Commands are the common representation for actions exposed in the palette, keyboard shortcuts, menus, toolbar actions, contextual menus and accessibility action listings. The same command must not be reimplemented separately for each surface.

A command descriptor contains, at minimum:

- Stable typed/local identifier.
- Human-readable title and optional description.
- Group/category and search keywords.
- Optional shortcut.
- Availability/enabled state and a concise disabled reason where useful.
- Invocation function/action binding.
- Optional contextual relevance and destructive-action metadata.

The registry SHOULD support static command descriptors and direct typed registration. Dynamic command contribution is allowed when a real plugin or dynamic document model needs it, but static commands must not incur dynamic allocation or virtual dispatch on every keystroke or frame.

## 10.3 Palette behaviour

The palette MUST support:

- Fuzzy or tolerant matching over title, keywords and group, with predictable relevance ordering.
- Keyboard/pointer/touch navigation, selection, focus restoration and cancellation.
- Clear grouping and no-result states.
- Visible shortcut hints.
- Disabled commands with a useful reason rather than silent disappearance when discoverability matters.
- Contextual commands for the current selection/document/panel where appropriate.
- Navigation commands and actions, not just global settings.
- Theming and accessibility semantics from the same UX/token system.
- Reduced-motion and compact-screen presentations.

It SHOULD be able to register application-local commands plus framework-standard commands. Examples include open/new/save, search, switch view, navigate to section, show shortcuts, change appearance, toggle panels and focus a named panel. The framework must not invent commands that are meaningless for a given app.

Command execution MUST re-check live availability and the required capability at execution time. A stale result row or visible shortcut is not authorisation. Destructive and externally visible actions follow the application's confirmation policy; the framework should not add confirmation dialogs to harmless actions by default.

## 10.4 Shortcut consistency

Shortcut handling is centralised. The same command has the same shortcut wherever it appears. Conflicts are detected during registration; there is no silent last-writer-wins behaviour. Platform conventions may alter the modifier or reserved keys, but must not fork application logic.

# 11. UX component and interaction contract {#sec-11}

Smart UI should ship a deliberately coherent core, not an enormous catalogue of loosely related widgets. Every standard component includes appearance, state transitions, pointer/touch handling, keyboard/focus behaviour where applicable, accessibility semantics and documented failure/disabled states.

## 11.1 Core application structure

Provide reusable patterns for:

- Application root and content surface.
- Header/title area and tool/action bar.
- Navigation rail, compact navigation and navigation list.
- Lists, grids, detail views and master-detail composition.
- Tabs and segmented selection where semantically appropriate.
- Responsive split views and resizable panels.
- Dialogs, popovers, menus, sheets and confirmation prompts.
- Status messages, inline errors, banners and progress indicators.
- Search fields, forms and validated inputs.
- Scroll containers, virtualised long lists and large result sets.
- Command palette and shortcut help.
- Dockable or collapsible panels for advanced creative applications.

The shell pattern is a starting point, not an imposed layout for every application. A game, media surface, drawing app or automotive instrument view may use a bespoke root while still using the same command, appearance, text and accessibility contracts.

## 11.2 Standard controls

Initial core controls include buttons, icon buttons, text fields, multiline editors, checkboxes, switches, radio selection, sliders, select/picker controls, tabs, tooltips, menus, list rows, cards/surfaces, separators, progress/loading indicators, dialogs, scroll areas and empty/error states. Additional specialist controls are justified by actual suite applications and should reuse core interaction and appearance behaviours.

## 11.3 Panels and creative layouts

The framework must support multiple independently composed panels within an application: sidebars, inspectors, tool panes, content canvases, timelines, property panels and context panels. Panel allocation/resizing/visibility are local UI operations; global windows and surface lifecycle remain host responsibilities.

Docking is an advanced layout feature, not a mandatory dependency for ordinary apps. Implement a minimal split/panel composition first. Add persistent docking layouts only once a reference application requires them. The panel system must not introduce a second scene graph or layout engine.

## 11.4 Interaction state

Controls use a small, standard state vocabulary: enabled, hovered, pressed, focused, selected, expanded/collapsed, disabled, pending/busy, error and validation state where appropriate. Components should share common state-transition rules and communicate state changes visually and accessibly.

States are not all colours. Focus requires a visible focus treatment; disabled content must remain understandable; error states include a message or reachable explanation; busy actions prevent accidental duplicate submission when that is semantically necessary.

## 11.5 Navigation and history

Provide small primitives for in-app navigation, back/forward where the app has navigation history, and deep-link/intent entry. Do not force all applications into a router abstraction. Navigation state must be explicit, local and compatible with the app's lifecycle/session restoration rules.

## 11.6 Forms and validation

Form controls standardise labels, hints, errors, required state, invalid value treatment and submission feedback. Validation remains domain-owned. A reusable validator may be used when useful, but the framework must not turn a form into a multi-layer schema engine merely to display a field.

## 11.7 Accessibility semantics

Components carry role, accessible name/description, value, state and actions. The host integration maps them to the canonical accessibility contract. Keyboard access, focus visibility, text scaling and reduced-motion preference are core capabilities, not optional visual polish.

# 12. Adaptive UI for a multi-device ecosystem {#sec-12}

Smart UI targets desktops, phones, tablets, watches, automotive/EV surfaces, embedded displays and future device classes. Its foundation is shared semantics and adaptive composition, not identical screen layouts.

## 12.1 Adapt to facts, not device stereotypes

Layouts SHOULD respond to available logical extent, safe/inset regions, scale factor, orientation, input capabilities, interaction precision, accessibility preferences and host-provided context. Avoid business logic such as `if_is_iphone` or hard-coded operating-system names.

Use a small set of viewport/space classes if needed (for example, compact, regular, expanded), based primarily on available constraints. Thresholds must be documented and centralised; applications should not implement their own inconsistent breakpoint systems.

## 12.2 Adaptive composition rules

- Collapse navigation affordances when space is limited while preserving the same destinations and commands.
- Reflow multi-column layouts to a single primary flow when width is insufficient.
- Preserve task state while adapting layout across resize, rotation, unfold/fold and host changes.
- Let watch-like surfaces prioritise short, glanceable tasks without banning deeper workflows on capable devices.
- Let automotive profiles honour host-reported safety/distraction constraints and available input; applications must not infer driver safety state from appearance alone.
- Use input capabilities to expose suitable interaction mechanisms. A pointer is not assumed on touch-only devices; touch is not assumed on desktop; voice/rotary/gesture support is opt-in by host capability.

## 12.3 One app model, multiple compositions

Apps MAY provide alternative compact/expanded compositions when the information architecture truly differs. These compositions use the same application state, command IDs, accessibility semantics and design tokens. Repeatedly duplicating the entire app per device is prohibited unless there is a genuine product-level reason.


## 12.4 Outputs are peers; a browser is a real output

An output is a presentation endpoint, not a global screen singleton. One application instance and its authoritative domain state MAY be presented on multiple outputs concurrently. Each output has its own viewport, scale, safe regions, output capabilities, refresh/presentation timing, pointer/touch/keyboard endpoint and focus context. The framework MUST not force a remote browser to mirror the physical display geometry or steal the local keyboard focus.

A remote login normally creates an authenticated remote user session with its own virtual output and input seat. An explicitly authorised attach/mirror mode MAY expose an existing session, but it is not the only mode and must not silently take over local focus. Layout is resolved for each output from actual constraints; business data and command semantics remain shared where the same app instance is shared.

# 13. Appearance and design-token system {#sec-13}

## 13.1 Separation of semantics and visual choices

The appearance system is owned by Smart UI and is independent of MirUI's concrete theme representation. Smart UI resolves its semantic tokens into the corresponding MirUI styles/components. MirUI does not dictate the permanent shape of the Smart Foundation visual language.

Application logic uses semantic roles such as `surface.canvas`, `text.primary`, `action.primary`, `focus.visible`, `control.radius` or `motion.standard`. It must not hard-code a particular hex colour, radius or duration in app behaviour.

The implementation MUST make a clear distinction between:

- **Semantic tokens:** what a value means to the UI.
- **Theme values:** concrete values for a specific appearance.
- **Component recipes:** how a semantic control combines tokens and states.
- **Rendering:** how MirUI/backend draws the resolved result.

## 13.2 Token families

### Color

Roles MUST cover neutral surface levels, primary/secondary text, muted text, borders, dividers, primary and secondary accents, on-accent foregrounds, focus, selection, success, warning, error, info, overlay/backdrop and disabled states. Accent colours must remain distinct from the neutral tonal background system. A vibrant accent is used intentionally for actions, focus and selected states—not washed across every background.

### Geometry and spacing

Tokens cover spacing scale, control height, icon size, padding, gaps, corner treatment, panel radius, card radius, field/button radius, divider thickness and hit-target dimensions. Generous rounded corners are the default theme direction; sharp/square profiles remain possible without changing app code. Components use a coherent spacing scale rather than arbitrary per-app values.

### Typography

Typography tokens define family roles, size, weight, line height, letter spacing and density behaviour for display, title, body, label, caption, code and numeric data. The framework MUST support scaling and avoid clipping under larger text sizes. Font shaping, fallback, selection geometry and text input are treated as a text-system requirement, not merely drawing labels.

The implementation must select and document bundled font families based on legibility, language coverage, visual fit and licensing. Fonts are assets resolved through the framework's font resource mechanism, not individually hard-coded by apps.

### Motion

Motion tokens cover duration, easing/spring profile, distance/scale, opacity transition and reduced-motion behaviour. Motion communicates causality and hierarchy, never delays a user's action. All animations must be interruptible/retargetable where practical, and input must remain responsive during animation.

Initial design targets may include fast feedback around 100–160 ms, standard transitions around 180–280 ms and longer spatial transitions around 280–380 ms. These are starting tokens, not immutable guarantees. Reduced-motion settings must remove or shorten non-essential movement while preserving state communication.

### Surface/material

Tokens and component recipes may describe elevation, shadow, opacity, translucency, blur request, border treatment and overlay depth. Expensive host-dependent effects are optional. Unsupported blur or GPU effects degrade to a documented surface treatment without breaking content, contrast or input.

### Density and device scale

Density profiles affect component dimensions, spacing, content amount and target sizes. Scale factor and logical extent come from the host. Device-specific tuning is configuration/data, not duplicate widget implementations.

### Focus and accessibility

Focus ring shape, width, contrast and offset are tokens. State feedback must remain distinguishable without relying on colour alone. High-contrast and reduced-motion preferences take priority over decorative theme settings.

## 13.3 Default visual direction

The initial default should be modern, distinctive, neutral and visually calm:

- Near-black or very dark neutral canvas surfaces.
- Clearly separated grey tonal layers, not green-tinted backgrounds.
- A vivid, configurable accent for primary actions, focus and selection.
- A complementary secondary accent used sparingly.
- Generously rounded cards, fields and panels as the default theme.
- Crisp iconography, deliberate whitespace and clean typography.
- Restrained elevation and translucency; effects must explain layering rather than decorate every surface.

These are the default theme's starting values. They are not permanent framework rules. A theme may be light, dark, high-contrast, sharp-cornered, soft, playful or specialised while maintaining the same semantic API.

## 13.4 Theme model and inheritance

Themes use a versioned, data-driven representation with a stable semantic token vocabulary. Component recipes apply defaults and state variants. Theme overrides follow an explicit precedence rule: framework defaults → selected theme → application-level permitted overrides → transient interaction state. Host accessibility preferences can override theme values when necessary for legibility or reduced motion.

The active theme is resolved once when it changes and cached in a compact form. Style resolution must not parse arbitrary theme text, allocate maps or perform dynamic token lookup for every primitive every frame.

Missing required tokens are development errors and must be reported visibly/logged; release behaviour uses a well-defined safe fallback. It must not silently render arbitrary magenta or another debug colour as normal product behaviour.

## 13.5 Theme packaging and portability

Smart Protocol's `manifest.capnp` defines a `theme` bundle shape and supports asset declarations. Smart UI SHOULD package themes as versioned asset bundles with a documented token schema and declared compatibility version. The manifest describes the bundle; the token grammar itself belongs to Smart UI unless a cross-implementation interchange requirement justifies a protocol-level contract.

A theme MUST NOT contain executable code. It is data, assets and constrained component-token values. Untrusted themes cannot request system permissions, invoke commands or alter app behaviour.

# 14. Rendering and the MirUI integration {#sec-14}

## 14.1 Single rendering pipeline

MirUI remains the only general UI renderer/ECS pipeline inside the framework. Smart UI semantic components resolve to MirUI components, views and drawing facilities. The framework does not rasterise its own second widget layer and then forward the result through MirUI unless a specific host surface requires an explicit offscreen texture.

## 14.2 Host surfaces and buffers

The native integration uses the host's Smart Protocol compositor/surface and buffer contracts. Buffer ownership, lifetime, synchronisation, format, damage and commit rules must follow those contracts. When a compatible shared buffer provides a safe zero-copy route, use it. Do not promise zero-copy when GPU/CPU domains, pixel formats, cache coherence, security or host semantics require conversion/copying.

The surface integration MUST avoid accidental full-frame copies and full-frame redraws when dirty-region updates are supported. It must handle resize, scale changes, surface loss, suspension and reacquisition of buffers without corrupting UI state.

## 14.3 Renderer and backend selection

MirUI's software and GPU rendering facilities can serve different targets. Backend choice should be resolved during build or host initialisation when known. Runtime polymorphism is allowed at an explicit host boundary when the platform truly needs it; it must not be inserted into every draw operation without cause.

A software renderer is a valid low-resource path, not evidence that GPU support is unnecessary. A GPU backend is not assumed to exist because the build includes a GPU crate. Host capability must determine what is actually available.

## 14.4 Panels and heavy content

Large custom drawing surfaces (waveforms, timelines, image canvases, maps, node graphs) must be able to render efficiently through MirUI without creating one ECS entity for every pixel or sample. Use virtualised/aggregated drawing, cached assets, bounded work and specialised draw paths where appropriate. The semantic panel remains a UI control, while its content renderer may be specialised.


## 14.5 Browser-based live OS session (not VNC)

A browser is a first-class output and can host a complete authenticated Smart OS session. Smart UI supports two explicit paths: browser-native execution for portable apps (preferred) and structured remote presentation for apps that must execute on the host. The browser is not just a viewer of the physical display.

In browser-native mode, a compatible Smart UI application entry point runs in the browser runtime (for example, WASM). Local presentation behaviour—focus, palette search, text cursor, selection, hover, basic layout and interaction animation—runs locally for immediate response. Operations that depend on OS resources cross the authenticated Smart Protocol service channel, and the host remains authoritative for permissions, persistent state and outcomes. The same application source can target native and browser-compatible runtimes where its dependencies allow it; manifest entry points declare the available ABIs/runtime hints.

In host-executed mode, the browser receives a versioned structured presentation stream derived from the app's UI state. The browser applies revisioned deltas and renders semantic controls locally. A heavy custom surface may use a negotiated per-surface stream, but whole-desktop framebuffer streaming is not the normal architecture.

Local and remote outputs have independent viewport/layout/focus/input-seat state. Host services and application state are not duplicated merely because a user adds an output. The remote contract must define authentication/session creation, output capabilities, input routing, asset/data transfer, revisions, flow control, reconnect, resynchronisation and revocation; `RemoteAccessConfig` alone is not sufficient. The detailed remote requirements and contract gaps are specified in Section 34.

# 15. Zero-cost and resource discipline {#sec-15}

Zero-cost is defined as **no abstraction overhead when the abstraction adds no necessary work**, plus explicit minimisation of unavoidable work. It does not mean that IPC, rendering, font shaping or cross-memory-domain transfers literally cost nothing. Remote rendering is opt-in per output: local-only apps perform no remote diff serialization. For remote outputs, generate deltas from already-known state, reuse buffers, avoid full-state snapshots except initial attach/resynchronisation, and never build a second authoritative UI runtime merely to transmit it.

The following rules are mandatory:

1. **No duplicate UI model.** MirUI ECS is the authoritative UI composition state. Do not maintain a second tree or sync layer.
2. **No per-frame reconstruction.** Static composition is created once and updated through meaningful state changes. Do not rebuild the app tree every frame.
3. **No repeated dynamic lookup in hot paths.** Resolve theme tokens, command descriptors and renderer capabilities into cached/typed structures outside the inner drawing loop.
4. **No abstraction tax on simple controls.** Avoid virtual dispatch, heap allocation and cloning in per-control/per-pixel paths when compile-time composition or borrowed data suffices.
5. **No redundant rendering or copying.** Dirty-region rendering and suitable shared buffers are preferred where supported; preserve correct fallbacks.
6. **Bound resource growth.** Fixed-capacity or reservable storage is used for frame scratch, event queues and command search in constrained profiles. Overflow is explicit and handled, never memory corruption or silent data loss.
7. **No hidden runtime requirement.** The core must not require an async executor, platform webview, browser engine or `std` merely to define and compose controls.
8. **No busy loops.** Idle applications do not continuously render or schedule timers without reason. Active animation requests frames only while needed.
9. **No surprise background work.** Subscriptions, event streams, timers and callbacks have explicit lifecycle/cancellation ownership.
10. **Measure release builds.** Performance decisions are validated in release mode on representative target profiles; debug build speed is not the benchmark.

## 15.1 `no_std` and allocation

The core SHOULD build with `no_std` and `alloc` where the selected MirUI APIs and generated contract/runtime dependencies allow it. `no_std` does not automatically mean heapless. A constrained target can use bounded capacities/static assets and a predictable allocator; full dynamic application UI may require `alloc`.

Cargo features MUST be explicit. The OS-target build MUST disable default features that pull in `std` and enable only required capabilities. Host-specific facilities are opt-in features within the same package, not separate framework crates.

At the time of this specification, MirUI's repository manifest declares version 0.51.0, Rust Edition 2024 and `rust-version = 1.85`; its default feature set includes `log-stderr`, which enables `std`. The integration must pin the reviewed revision and explicitly choose features rather than inherit defaults. The current stable Rust toolchain on 21 October 2026 is 1.99.1. The framework should use stable Rust and Edition 2024 practices; its MSRV is a deliberate compatibility decision and must be documented rather than drifting accidentally.

## 15.2 Allocations and state

Static commands, standard controls and core state transitions SHOULD be allocation-free after construction. Dynamic data such as document contents, lists, accessibility strings or user-created panels may allocate as required. The framework distinguishes one-time growth from recurring frame cost.

Where dynamic models are needed, capacity is reserved based on real collection growth or explicit limits. Do not add a universal object pool, arena, custom allocator or memory manager unless measured behaviour requires it.

# 16. Application lifecycle, persistence and faults {#sec-16}

Application startup, activation, backgrounding, suspension, resumption, termination and crash recovery must align with host lifecycle semantics and Smart Protocol's canonical app state/events. Do not invent an independent lifecycle state machine that conflicts with `app.capnp`.

The framework provides hooks only where the application needs to save/restore its own state or pause work. A typical app should not need to manually wire every lifecycle event just to start. Event delivery and subscriptions are cancelled when the owning scope or application ends. Remote browser sessions follow the same lifecycle authority: authentication, session attach, suspend/resume, disconnect, reconnect and revocation are explicit. A browser tab is a client/output, not the owner of the remote app process. Loss of the tab or network must not silently terminate a valid application or report unsaved state as persisted.

Persistent app data is accessed through the relevant Smart Protocol service and typed resource references. The framework must not assume POSIX paths, a particular filesystem, a home-directory layout, a window manager implementation or a specific package format beyond the declared contract/manifest.

Service loss, surface loss, rejected capabilities, cancelled requests, malformed data and allocation failures must have explicit handling. A UI may retain a locally editable draft during a recoverable service outage, but must not report that it persisted data until the provider confirms success.

# 17. Rust implementation standards {#sec-17}

- Use stable Rust; no nightly-only feature is allowed in the supported build without an explicitly approved exception.
- Use Rust Edition 2024 unless a documented compatibility requirement dictates otherwise.
- Keep dependencies minimal and capability-gated. Audit `std` leakage through transitive dependencies for `no_std` profiles.
- Prefer safe Rust. `unsafe` is confined to small, documented boundary code with a clear invariant and tests. Rendering/buffer FFI code must state ownership, aliasing, alignment and lifetime constraints.
- Avoid panics in normal runtime failure paths. Return typed errors for missing capabilities, rejected contracts, malformed assets, capacity overflow and failed surface operations. Panics may be reserved for violated programmer invariants that cannot be represented as ordinary errors.
- Do not use stringly typed service names, action names or internal state where stable typed identifiers are practical. Human-facing labels remain text and localisable.
- Do not hide allocations, IO, IPC or blocking work inside apparently trivial getters or render functions.
- Separate app logic from rendering side effects. Commands produce explicit state changes/service requests; render systems consume presentation state.
- Keep dependencies and APIs pinned/reviewed. Upstream MirUI changes are integrated deliberately, never by building production from an unpinned moving branch.
- Enforce formatting, lints and tests in CI. Lints should catch real correctness and API issues, not become a substitute for readable design.

# 18. Testing and release gates {#sec-18}

The quality process is evidence-driven and intentionally small. Do not create thousands of checks that duplicate the same property. Each gate must protect an actual contract, user-visible behaviour or critical performance property.

## 18.1 Required release gates

1. **Reproducible contracts:** `vendor.sh` and generation reproduce the pinned schema bindings; no hand-edited generated type drift.
2. **Build profiles:** the hosted build works, and the intended `no_std` profile builds with explicit features and no accidental `std` dependency.
3. **Native vertical slice:** a Smart UI application launches via a compatible host, creates a surface, draws, receives input, edits text, commits a buffer and exits cleanly through the contracts.
4. **Command palette:** every app gets the common palette; keyboard and non-keyboard invocation works where supported; command availability/capabilities are rechecked at execution.
5. **Appearance independence:** changing the theme changes colours, shapes, typography/density/motion where defined without changing application business logic or duplicating component implementations.
6. **One application end-to-end:** a real reference app reads or writes a real service resource, handles success/failure/cancellation and remains responsive during work.
7. **Accessibility and focus:** semantic tree/actions map correctly, keyboard focus is visible, text scale/reduced motion behave as specified and important controls remain operable.
8. **Resource/performance evidence:** release build demonstrates no recurring tree reconstruction, no avoidable per-frame allocation on the static reference screen, no needless idle redraw, and bounded failure behaviour under the selected target profile.
9. **Host substitution:** the same app source is run against at least two compatible host implementations or a real host plus an independent contract test harness. App logic contains no Naledzi-only assumptions.
10. **Remote browser output:** login establishes a real authorised OS user session; launcher, system surfaces and ordinary Smart UI apps work in the browser without whole-screen VNC streaming. Host-side domain logic remains authoritative.
11. **Concurrent outputs:** a physical display and at least one browser output can be active at the same time with independent viewport/input-seat/focus state and no unintended local-focus theft.
12. **Remote correctness under stress:** deltas resynchronise after reconnect, queues remain bounded under latency/jitter, revoked sessions immediately lose input authority, and private surfaces follow policy.
13. **Latency evidence:** client-local feedback and host round trips are measured separately on declared network profiles; stale frame backlog does not grow during sustained input.

These are gates, not a request to validate every possible app before starting. Add regression tests when a real bug or meaningful failure mode is discovered.

## 18.2 Test structure

- Unit tests: token resolution, command matching, shortcut conflicts, state transitions and layout rules.
- Deterministic interaction tests: scripted input, keyboard/focus, palette commands, dialog cancellation and error states.
- Rendering snapshots: representative components and responsive states, with controlled fonts/assets and tolerance for backend-specific raster differences where required.
- Contract tests: generated client/server interoperability and correct handling of result/error/capability outcomes.
- Integration tests: real surface, input, text-input, buffer commits and app lifecycle on the target host.
- Performance tests: release-mode frame work, allocations, dirty-region efficiency, command search latency, text-heavy views and constrained-memory behaviour.

# 19. Implementation sequence {#sec-19}

The sequence deliberately produces working capability early and avoids a giant UX architecture built before a real app exists.

## Phase 1 — establish the seam

- Pin MirUI and review the exact APIs used.
- Define the one-crate public API and internal module ownership.
- Set explicit Cargo feature profiles, including the actual `no_std` profile.
- Pin and generate the required Smart Protocol schema set through `vendor.sh`.
- Implement the narrow host integration needed for a real surface, buffer commits and input.
- Audit the current Smart Protocol remote-access/output contracts; specify the missing remote session and presentation-delta semantics before any Naledzi-specific transport is written.

**Exit condition:** one minimal app renders and receives input through the contracted host path without Naledzi-specific code in its application logic.

## Phase 2 — make the framework useful

- Implement app bootstrap/context, lifecycle hooks and typed error handling.
- Implement the shared command registry and mandatory command palette.
- Implement core common controls, focus/navigation, text-input and accessibility mappings.
- Establish the semantic token model and the initial near-black/neutral/vivid-accent theme.

**Exit condition:** a small but real app can be built with few lines of setup, has a working palette, and can change appearance without changing business logic.

## Phase 3 — prove reuse

- Build one reference app that exercises forms, lists, navigation, editing, service calls, errors, state restoration and theme changes.
- Add adaptive compact/regular/expanded compositions without introducing a global device-class router.
- Add panels/split views needed by an actual use case.
- Measure frame costs and remove avoidable allocations/copies found by the real workload.
- Add the portable presentation delta/remote-output path as an output adapter; do not fork the app model or introduce a second host-side ECS.

**Exit condition:** the same app logic operates across two materially different surface/input profiles and remains consistent in behaviour.

## Phase 4 — expand through real product needs

Add richer controls, virtualised content, docking, custom drawing, media/creative patterns and more input modalities as actual suite applications require them. Features must extend the existing interaction/token model rather than create parallel systems. The browser remote OS client is an explicit product deliverable, not a deferred experiment: implement authenticated login, the full system shell, window/app surfaces, input/text/clipboard/accessibility, reconnect and multi-output operation.

**Exit condition:** new apps are built primarily by composing established framework primitives, with limited per-app host glue and no repeated reinvention of core UX.

# 20. Acceptance criteria for the finished framework {#sec-20}

Smart UI is ready for broad suite adoption when all of the following are true:

- It is one cohesive public framework dependency, with no unnecessary crate fragmentation.
- MirUI remains the sole ECS and general UI rendering engine.
- Contract clients and generated types originate from the official Smart Protocol schemas through a reproducible pinned workflow.
- App lifecycle, app-index/launch, manifests, compositor/buffer paths, input/text input, clipboard and accessibility are integrated only where the framework's role requires them and exactly according to their contract ownership.
- No application needs Naledzi-specific conditionals for ordinary lifecycle, service requests, surfaces or input.
- Every app gets the standard command palette and central command/shortcut discoverability.
- Standard components include coherent keyboard, touch/pointer, focus, error, disabled, busy and accessibility behaviours.
- A single semantic design system controls colour, geometry, typography, material, motion, density and focus presentation.
- The default theme is polished and contemporary, with near-black neutral surfaces, grey tonal hierarchy, vivid configurable accents and generously rounded geometry; all values remain replaceable.
- Core builds with explicit `no_std`-compatible features where dependency constraints permit; resource-heavy host features are opt-in.
- Static UI does not reconstruct its component tree or perform avoidable recurring allocation on every frame.
- Buffer reuse, damage tracking and low-cost rendering are used where host contracts and backend capabilities support them.
- Failure and missing-capability paths are visible and honest; the framework never fakes success.
- Developers can build both simple apps and specialised creative apps without switching to a competing framework architecture.
- Adding a new app is primarily an application-domain task, not a redesign of the framework's command palette, theme, focus engine, surface adapter or lifecycle layer.
- The browser can provide a complete authenticated OS session, including system shell and ordinary apps, through revisioned structured presentation updates rather than whole-desktop framebuffer streaming as the default.
- Multiple physical and remote outputs coexist; each has independent presentation geometry and input context while sharing only the application/session state intended to be shared.
- The remote output contract is canonical in Smart Protocol; the browser client does not rely on a Naledzi-only private endpoint or bypass the auth/capability model.

# 21. Decisions that are intentionally deferred {#sec-21}

The following are deliberately not fixed by this specification until a real implementation need is demonstrated:

- Exact public Rust method signatures beyond the API principles and sketches in this document.
- Exact colour hex values, font bundles and final animation curves.
- A global plugin/extension ABI for third-party dynamic code.
- A general-purpose docking persistence format.
- A framework-wide asynchronous executor.
- A protocol-level theme schema.
- The exact Smart Protocol schema-file placement for remote output semantics. The requirement is not deferred: a canonical contract is mandatory. Decide whether to extend the compositor/output schema or introduce one narrowly owned remote-output schema after checking the current schema ownership map.
- A mandatory GPU backend for every target.

Deferral here is not a blank cheque to add complexity. Each decision must be resolved using the smallest implementation that satisfies a real application and preserves the principles above.

# 22. Remote browser sessions and multi-output architecture {#sec-22}

Remote browser access is a first-class output, not a remote-desktop add-on. The product objective is an authenticated browser session in which the user can interact with the full supported OS experience with local, immediate UI feedback and host-authorised service operations.

The default path for portable Smart UI applications is browser-native execution of a compatible app entry point, with OS data and privileged services accessed through the authenticated Smart Protocol channel. Applications that must remain host-executed use a structured presentation mode with versioned semantic deltas. Per-surface media/graphics streaming remains available for content that genuinely requires it. Whole-screen VNC-style streaming is not the default.

Every output owns its viewport, scale, safe area, focus context, input seat and presentation capabilities. Local displays and multiple remote sessions may coexist without implicit focus takeover or state leakage. The browser cannot bypass service contracts, permissions or private-surface policy.

The existing compositor schema's `RemoteAccessConfig` is only a basic remote-access configuration; it does not define a complete interoperable browser session. Canonical Smart Protocol work is required for session handshake, output negotiation, browser-compatible app entry selection, input routing, remote presentation revisions/deltas, transfer, backpressure, reconnect, resynchronisation and revocation. Section 34 gives the detailed two-mode architecture and requirements.

# 23. Normative requirement model and traceability {#sec-23}

This section adds a concrete, auditable implementation model. Requirements should be tracked by stable IDs so implementation, examples and tests can point to the same obligation. IDs are part of the specification, not part of the Rust API.

- **ARCH-*** defines ownership and architecture.
- **API-*** defines the developer-facing public API.
- **UX-*** defines component and interaction behaviour.
- **CMD-*** defines the universal command system.
- **THEME-*** defines appearance tokens and themes.
- **OUT-*** defines local, remote and multi-output behaviour.
- **PROTO-*** defines Smart Protocol integration.
- **PERF-*** defines resource and performance invariants.
- **A11Y-*** defines accessibility requirements.
- **TEST-*** defines release evidence.

A requirement is complete when the implementation exists, the representative test exists, and the developer documentation shows the idiomatic way to use it. An API that exists but is undocumented is incomplete. Documentation for behaviour that is not implemented is not evidence of completion.

| Rule | Meaning | Required handling |
|:-----|:-----------------------|:----------------------------------------------------|
| MUST | Required for conformance | Blocks release if absent, unless formally revised |
| MUST NOT | Prohibited architecture or behaviour | Any occurrence is a defect |
| SHOULD | Default direction with a concrete reason for deviation | Document the trade-off where not followed |
| MAY | Optional capability | Do not imply support unless the target reports it |

Every implementation PR should reference relevant requirement IDs. The aim is not paperwork; it is to prevent the framework from slowly accumulating multiple interpretations of the same behaviour.

# 24. Application archetypes and standard shells {#sec-24}

Smart UI is intended to support an open-ended number of applications. Therefore, it defines reusable archetypes, not a finite catalogue of products. An archetype is a starting composition of existing primitives and command behaviours. It MUST NOT become a separate runtime or force the application to fit a rigid template.

## 24.1 Standard archetypes

| Archetype | Typical contents | Default framework support |
|:----------------|:---------------------------|:----------------------------------|
| Focused utility | Title, one primary workflow, status/feedback | `UtilityShell`, content slot, primary action, command palette |
| Document application | Document identity, editing area, document actions, unsaved-change state | `DocumentShell`, save/revert commands, dirty state hook, document tabs where useful |
| Browser/library/catalog | Search, filters, collection/list, item details | Search field, filter chips, virtual list, detail panel, empty/loading/error states |
| Settings/preferences | Category navigation, grouped fields, reset/restore actions | `SettingsShell`, setting rows, grouped sections, per-setting validation and reset |
| Data management | Tree/list/grid, inspector, bulk selection, operations | Selection model, data table/list, inspector panel, batch action pattern |
| Creative workspace | Canvas/timeline/node graph, tools, inspector, asset browser, panels | Dockable panel primitives, command/action system, custom canvas, context menus, shortcuts |
| Media | Playback/stream surface, timeline/progress, queue/library | Media controls, timeline and scrubber, output-aware sizing, playback state patterns |
| Communication | Conversation list, active conversation, composer, attachments | Split view, incremental list, message composer, notifications and attachment affordances |
| Launcher/shell | Search, app catalog, pinned/recent items, actions | App index client, command palette, responsive launcher layout |
| Dashboard/monitor | Summary, charts or visualisations, filters and details | Metric cards, chart canvas extension point, data refresh lifecycle |
| Automotive/embedded | Task-focused information, large targets, limited interaction | High-contrast recipes, distraction-aware presentation modes supplied by host policy, voice/rotary adaptation |
| Watch/compact | Current task, short flows, glanceable values, one primary action | Compact composition recipe, paged/navigation primitives, explicit exit/back behavior |

These shells compose the same widgets. They MUST NOT copy component implementations into archetype-specific versions. A `SettingsShell` may choose a single-column layout on a narrow output and a navigation-plus-detail layout when width permits, but individual setting rows retain the same validation, accessibility and command semantics.

## 24.2 Shell contract

A shell is a composition helper. It MAY provide a standard arrangement, but the application retains ownership of its content and business state. Each shell MUST:

1. Include the standard command palette entry point and action registry.
2. Expose a stable place for application identity/title and the main content.
3. Provide a consistent way to expose app-level actions and contextual actions.
4. Respect the host's available viewport, insets, input capabilities and appearance preferences.
5. Not assume that the host has a desktop title bar, mouse, physical keyboard or single display.
6. Keep optional chrome optional. A shell used for a full-screen watch task or automotive surface must not be forced to show a desktop-style top bar.
7. Provide predictable focus entry and focus return when overlays are opened or closed.

## 24.3 Developer choice without visual fragmentation

Applications may choose different structures because their tasks differ. Consistency comes from shared typography, control semantics, spacing rules, state transitions, command registration, keyboard actions and token resolution—not from making every screen a row of identical cards. Cards MUST be used only when grouping or separation adds meaning; they are not the default wrapper for every piece of content.

# 25. Complete standard widget and UX inventory {#sec-25}

This catalogue defines the expected standard library. It is grouped by purpose. The listed widgets are parts of one `smart-ui` public API and one MirUI world; they are not standalone packages. The catalogue describes the product contract, not a claim that all widgets are implemented today.

All interactive widgets MUST have a semantic role, state model, action binding, focus behavior where applicable, accessibility description, and defined disabled/error/loading behaviour. All controls MUST derive visual properties from appearance tokens. None may bake in a specific palette or corner radius.

## 25.1 Structural and layout widgets

| Widget | Purpose and required behaviour | Common use |
|:------------------|:-----------------------------------------------------|:--------------------------|
| `AppSurface` | Root presentation surface; resolves app appearance, safe area/insets, scale, output profile and default text styles | Application root |
| `Column` | Vertical layout, spacing, alignment, minimum/maximum constraints and optional growth | Forms, settings, navigation |
| `Row` | Horizontal layout with wrapping/overflow strategy explicitly chosen | Toolbars, action rows |
| `Stack` | Layers children in declared z-order; hit testing follows visible interaction order | Overlays, canvas annotations |
| `Flow` | Wraps items based on available inline space without hard-coded device breakpoints | Chips, tags, adaptable tool groups |
| `Grid` | Two-dimensional arrangement with declared sizing policy and optional responsive column rules | Gallery, catalog, dashboards |
| `Spacer` | Consumes available layout space without drawing or handling input | Push actions to edge |
| `Divider` | Visual and semantic separation; token-based thickness/insets | Groups, menus, lists |
| `Inset` | Applies named or explicit spacing tokens around content | Platform safe area, section padding |
| `ScrollView` | Single-axis or two-axis scrolling, clipping, trackpad/touch input, keyboard navigation and optional inertia | Long content and canvases |
| `VirtualList` | Renders visible range plus a bounded overscan; stable key identity; preserves scroll anchor on data updates | Large collections |
| `VirtualGrid` | Grid equivalent of `VirtualList`; bounded realised items | Image or product collections |
| `SplitView` | Divides space between panes, has keyboard-accessible divider and declared collapse rules | Master/detail, editor/sidebar |
| `DockLayout` | Places panels in named regions, supports resize, hide/show and restoreable layout state | Creative tools and IDEs |
| `Panel` | Named region with optional header, actions, content and collapse state; not automatically a card | Inspector, asset browser |
| `Viewport` | Establishes transform, clipping, coordinate space and input mapping for custom-rendered content | Canvas, map, timeline |
| `SafeArea` | Consumes host-provided unsafe/inset geometry; does not guess notches or vehicle cut-outs | Mobile, embedded screens |
| `AspectBox` | Maintains a ratio or reports natural size within explicit constraints | Video, images, preview panes |
| `ResponsiveSlot` | Selects among explicitly authored compositions according to available constraints/capabilities, not OS name | Wide/narrow composition |

Structural widgets MUST declare sizing semantics. `Auto`, `Content`, fixed logical dimensions, percentages and flexible growth have clear and documented meanings. Layout MUST detect impossible constraints deterministically and follow a documented overflow policy; it must not silently create unbounded re-layout loops.

## 25.2 Text, labels and typography widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Text` | Static or data-bound text; semantic style token; correct wrapping, clipping policy, selection policy and accessible text |
| `Heading` | Heading level/role plus typography token; not merely a larger font size |
| `Paragraph` | Body text with multiline layout, optional selection/copy and inline emphasis where supported |
| `Caption` | Secondary text semantic; remains readable under high contrast and scaling |
| `CodeText` | Monospaced text, predictable whitespace and selection; optional syntax spans without changing accessibility text order |
| `Link` | Navigable/actionable text with explicit destination/action, keyboard and focus semantics, visited/disabled states where relevant |
| `RichText` | Runs of styled text with a single semantic source and text-selection mapping |
| `Icon` | Resolves a named/typed asset or vector; explicit meaning or decorative status; optical alignment token |
| `Avatar` | Image/initials fallback; accessible name; privacy-safe fallback and bounded decoding |
| `Badge` | Compact status/category mark; never solely communicates meaning through color |
| `KbdHint` | Displays a registered keyboard shortcut from the same shortcut registry |
| `CodeBlock` | Scrollable/selectable code presentation, line wrapping policy and optional line numbers; virtualize large files |

Text MUST use a shared font-resource and fallback policy. Components MUST NOT hard-code a private font stack. Font metrics used for layout and glyph shaping used for rendering must agree sufficiently to prevent clipped descenders, layout jumps and incorrect selection geometry.

## 25.3 Action and command widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Button` | Primary, secondary, quiet, destructive and icon variants via semantic style; pending/disabled states; activation event exactly once per accepted activation |
| `IconButton` | Button semantics plus required accessible label/tooltip on pointer-oriented surfaces |
| `SplitButton` | Primary action plus separate menu affordance; keyboard navigation distinguishes action from menu |
| `ToggleButton` | Pressed/on state exposed semantically; state change is not inferred from colour alone |
| `ButtonGroup` | Groups related controls; defines selection semantics if mutually exclusive |
| `CommandItem` | A command registry projection used in palette, menu, toolbar and contextual action surfaces |
| `MenuBar` | Optional menu hierarchy for interfaces where it improves discoverability; maps entries to registered commands |
| `Menu` / `MenuItem` | Keyboard traversal, typeahead where appropriate, submenu semantics and deterministic dismissal |
| `ContextMenu` | Bound to a target and an action set; opened by pointer, keyboard or touch equivalent; actions still use canonical command handlers |
| `Toolbar` | Groups high-frequency actions; supports overflow rather than clipping or silently dropping actions |
| `ActionBar` | Context-sensitive action group for selection/document/record state |
| `CommandPalette` | Mandatory standard palette backed by the command registry, specified in Section 10 and Section 29 addenda |

## 25.4 Input and editing widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `TextField` | Single-line editing; selection, cursor motion, undo/redo where supported, paste, IME composition, validation, placeholder and clear affordance |
| `TextArea` | Multiline editing, scroll, selection, keyboard shortcuts, optional line wrapping and resize policy |
| `SearchField` | TextField plus search semantics, optional clear, query debounce policy and explicit submit/change events |
| `NumberField` | Locale-aware parse/format, range/step rules and visible invalid input; no silent coercion without feedback |
| `Slider` | Range, step and current value; keyboard, pointer, touch and supported rotary semantics; accessible value text |
| `RangeSlider` | Two ordered handles; prevents or defines crossing; keyboard and accessibility expose both values |
| `ProgressBar` | Determinate or indeterminate state, accessible progress value, no fake percentage for unknown work |
| `Stepper` | Increment/decrement within declared bounds; alternative direct entry where appropriate |
| `Checkbox` | Checked/unchecked/mixed states where semantically valid; label activation; accessible state |
| `RadioGroup` / `Radio` | One selection from a finite group, arrow-key movement and group-level accessibility semantics |
| `Switch` | Immediate binary setting, explicit on/off semantics and descriptive label; not used for destructive actions requiring confirmation |
| `Select` | Selection from options with keyboard navigation, typeahead where feasible and appropriate popup placement |
| `Combobox` | Searchable/selectable option set; distinguishes text input from committed selection |
| `DatePicker` | Locale-aware date input/calendar, bounded navigation and keyboard operation; availability/validation clearly stated |
| `TimePicker` | Locale-aware time selection and valid increments |
| `ColorPicker` | Color selection with accessible numeric/alternate input, alpha support only when meaningful, and no theme hard-coding |
| `FileReferenceField` | Selects a protocol resource reference through a contracted picker/provider; the field itself does not invent paths or bypass permission checks |
| `TokenField` | Adds/removes typed values; backspace, focus and multi-value announcements are consistent |
| `RichEditor` | Text editing core with document model owned by app; formatting commands, selection and IME integration; framework MUST NOT pretend to supply a complete word processor merely by naming this widget |

Every form input MUST support labels, optional description/help, required state, validation feedback, disabled/read-only distinction and a stable semantic identifier. An invalid field MUST preserve user input unless the user explicitly requests a reset.

## 25.5 Selection, navigation and hierarchy widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Tabs` / `Tab` | Keyboard navigation, active tab semantics, optional lazy content and stable identity |
| `Breadcrumbs` | Navigable hierarchy where hierarchy genuinely exists; hide/condense under constrained space without losing access to parent locations |
| `NavigationRail` | Compact navigation with explicit selected item and labels/accessible descriptions |
| `NavigationBar` | Touch-friendly top-level navigation for compact layouts; not forced into desktop layouts |
| `TreeView` / `TreeItem` | Expansion, keyboard traversal, selection and virtualisation for large trees |
| `ListView` / `ListItem` | Stable keyed items, selection and secondary-action convention; no unnecessary nested cards |
| `Accordion` | Expand/collapse group with announced state and consistent focus management |
| `Pagination` | Page/position model for server-paginated data; preserves filters and sort state |
| `Pager` | Step-by-step or swipeable page navigation; explicit progress and exit behaviour |
| `CommandLink` | Routes to an in-app screen/intent or performs a registered command; it does not act as an untyped string URL dispatcher |

## 25.6 Data display and analysis widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Table` | Column definitions, typed cell presentation, row selection, sort/filter integration, keyboard navigation and virtualisation for large data |
| `DataGrid` | Editable or selectable cells only where declared; stable row/column identity, bounded layout work and clear cell focus model |
| `KeyValueList` | Label/value semantics, predictable alignment and support for long values/copy where appropriate |
| `PropertyInspector` | Editable or read-only structured properties; groups, validation and change events are explicit |
| `StatValue` | Value, unit, optional trend and accessible text representation |
| `ChartView` | Core chart semantics and labels backed by app data; custom GPU/vector implementation may be provided for high-volume visualisation |
| `Timeline` | Zoom/scroll, cursor/time mapping, selection and keyboard/alternate input operation; data and editing domain remain app-owned |
| `LogView` | Virtualised entries, follow-tail policy, filtering and copy; ingestion remains an app/service concern |
| `DiffView` | Clearly associated before/after lines or values; long content virtualised |
| `ImageView` | Fit/fill/original-scale modes, zoom/pan as enabled, alt semantics and image decode limits |
| `MediaView` | Output-aware visual surface and playback controls; streaming/codec engine supplied by application or domain service |
| `CanvasView` | Custom drawing surface with explicit transform, hit-testing contract, pointer/gesture handling and accessible alternative controls |
| `NodeGraph` | Optional higher-level composition for connected nodes; stable graph model owned by app, keyboard selection and pan/zoom rules |
| `SplitDiff` | Two coordinated views with shared navigation and independent scrolling only when explicitly selected |

Widgets such as `ChartView`, `Timeline`, `CanvasView` and `NodeGraph` are extensible drawing/input surfaces, not mandates to implement every domain feature in the core. The standard contract should cover embedding, focus, input routing, accessibility summary, clipping, scaling, cancellation and resource ownership; specialised semantics may be supplied by application-specific code using MirUI's advanced APIs.

## 25.7 Feedback and status widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Spinner` | Indeterminate progress only; animation stops when no longer visible/needed or under reduced-motion policy |
| `Skeleton` | Temporary loading representation that does not imply data is available |
| `EmptyState` | Explains that no content exists and offers a valid next action when one exists |
| `ErrorState` | Shows a real failure, recovery path and non-sensitive details; no fabricated success |
| `InlineError` | Associates error with the relevant field/control and accessible announcement |
| `Toast` | Brief, non-critical feedback; bounded queue, deduplication and dismissal; never sole delivery for destructive/critical/security events |
| `Banner` | Persistent inline status with severity and optional action; not overused for ordinary messages |
| `Dialog` | Explicit modal boundary, initial focus, focus trap where appropriate, Escape/cancel rules and return focus |
| `AlertDialog` | Confirmation for consequential/destructive actions; clear default/cancel action and meaningful consequence text |
| `Popover` | Anchored transient content; placement collision handling, focus policy and dismissal rules |
| `Tooltip` | Supplemental description; delay and keyboard focus support; no essential information available only on hover |
| `Drawer` / `Sheet` | Transient or persistent side/bottom content; responsive placement and accessible dismissal |
| `NotificationCard` | Structured in-app notification with title, body, severity and actions; OS delivery via notification contract, not a private service |
| `ProgressDialog` | Used only when a blocking decision really is required; long work SHOULD remain in a non-blocking task surface |
| `StatusBar` | Displays meaningful state such as connection, selection count or save state; no unrelated noise |

## 25.8 Panel, docking and creative workspace widgets

| Widget | Required behaviour |
|:-------------------------|:---------------------------------------------------------------------------|
| `Workspace` | Hosts a set of named panels and main content; stores only layout preferences, not duplicated document state |
| `DockPanel` | Can be docked, tabbed, resized, hidden or restored if enabled by the workspace; state schema versioned and recoverable |
| `PanelHeader` | Title, optional icon and action slots; correct accessible names for controls |
| `PanelTabs` | Switches panel content; stable identities and explicit close/dirty-state rules when panels represent documents |
| `InspectorPanel` | Displays contextual details for current selection; updates from app's authoritative selection/model |
| `AssetBrowser` | Lists/searches assets through caller-provided source; not a hidden filesystem implementation |
| `ToolPalette` | Tool selection with semantic selected state and registered shortcut hints |
| `Ruler` | Scale-aware axis presentation and optional markers; input behaviour defined if draggable |
| `Minimap` | Navigation overview linked to a primary viewport; avoids expensive full redraws on every move |
| `ZoomControl` | Zoom steps, direct value and fit/reset actions; respects per-output scale separately from content zoom |
| `FloatingPanel` | Movable/anchored presentation panel within host-supported bounds; keyboard/accessible move and close affordances |
| `Splitter` | Resizable boundary with min/max, keyboard adjustments and collapse targets |
| `InspectorSection` | Named expandable set of related properties; stable order and accessible heading semantics |

Docking and floating panels MUST remain an optional capability. The framework must not impose a desktop panel metaphor on a watch, vehicle cluster or simple mobile application. The same content components can be composed into different shells.

## 25.9 Shared states every interactive component must define

Every component defines only states meaningful to that component, but the vocabulary and visible treatment come from one state model:

- `enabled` and `disabled`;
- `hovered` where the input modality supports hover;
- `focused` and `focus-visible` as distinct concepts where useful;
- `pressed` for an activation currently being engaged;
- `selected` for a persistent selection;
- `checked` or `expanded` when semantically applicable;
- `busy`/`pending` while an action is in progress;
- `invalid`/`error` when data or an operation is invalid;
- `read-only` when a value can be inspected but not changed;
- `active` where it differs from selected/focused;
- `dragging`/`drop-target` for eligible objects.

A component must not encode two distinct semantics into the same state just because the styles look similar. The default theme can make focused and selected controls share an accent, but the semantic properties remain distinct.

# 26. Layout and adaptive composition specification {#sec-26}

The layout system must make ordinary layouts easy and complex layouts possible without a large, speculative rule engine. It builds on MirUI's existing layout and fixed-point geometry capabilities. Smart UI adds a small vocabulary of reusable composition helpers and design-token constraints; it does not implement a second layout engine.

## 26.1 Core sizing vocabulary

All standard containers support these sizing concepts where applicable:

- **Fixed logical size:** exact logical size before output scale transformation.
- **Content size:** intrinsic size from content, bounded by explicit limits.
- **Fill/flexible:** consume available space according to a growth factor.
- **Percentage:** a proportion of a well-defined parent axis; invalid when the parent basis is undefined and must fall back according to documented constraint rules.
- **Minimum/maximum:** hard bounds with predictable clipping/scroll/collapse outcomes.
- **Aspect ratio:** optional constraint when preserving visual proportion matters.

Layout calculations MUST use MirUI's geometry types and coordinate transforms. Widget implementations MUST NOT convert between unrelated pixel/unit models independently.

## 26.2 Small layout primitive set

The standard layout toolkit should be based on `Column`, `Row`, `Stack`, `Flow`, `Grid`, `ScrollView`, `SplitView`, `DockLayout`, `Viewport`, `Inset` and `ResponsiveSlot`. Additional convenience helpers may be added only when they materially reduce repeated, error-prone composition code. Each helper desugars into MirUI's existing layout/components where possible.

Smart UI MUST NOT introduce an independent cascade engine, CSS-like selector system, constraint solver, breakpoint DSL, hidden layout registry or second retained tree for ordinary app layouts. Advanced custom layout MAY be defined using explicit custom components and MirUI APIs.

## 26.3 Constraint-driven adaptation

Composition rules respond to current available width/height, safe areas, scale factor, pixel density if reported, input capabilities, accessibility preferences and output capabilities. Device names are not layout facts.

A layout may choose between these patterns:

- navigation beside detail vs navigation as an overlay;
- persistent inspector vs a transient sheet;
- full toolbar vs overflow menu;
- two-column vs one-column form;
- grid vs list;
- side panel vs bottom panel;
- large target controls vs compact controls;
- desktop multi-pane vs focused full-screen composition.

The change must preserve content and action availability. It must not create or destroy app domain data merely because the viewport changes.

## 26.4 Avoid oscillation and unstable layout

Responsive measurement is bounded. A component must not alternate between sizes due to its own computed child dimensions; cycles in layout dependencies are rejected during construction where detectable or resolved deterministically with a documented error in development. Text scale, font loading and image intrinsic-size changes must invalidate only affected layout subtrees when supported by MirUI's invalidation model.

`ResponsiveSlot` MUST select from already authored compositions using declarative constraints. It MUST NOT run arbitrary side-effectful code during repeated measurement. Layout selection should be stable around thresholds through explicit hysteresis only where the transition itself can oscillate; such hysteresis must be token/configuration-backed and testable.

## 26.5 Scroll contract

Scrolling supports wheel, touch drag, keyboard, scrollbar and supported rotary input. Inertia and elastic overscroll are theme/interaction preferences, not hard requirements for all target profiles. Overscroll effects can be disabled for reduced motion, automotive mode or low-resource targets. Nested scroll views must have deterministic gesture handoff, and scroll position restoration uses a stable item key/anchor when collections mutate.

## 26.6 Focus order is separate from layout order only when justified

The default focus order follows a logical traversal associated with the composition order and semantic hierarchy. Developers may override focus order for complex controls, but must declare it explicitly and test it. Absolute visual positioning must not accidentally make focus navigation incoherent. Tab/arrow semantics are group-specific and documented.

# 27. Application state, commands and service work {#sec-27}

This section defines a simple model for keeping app logic, UI state and protocol operations separate without adding a second state framework.

## 27.1 Three categories of state

1. **Domain state:** the application's authoritative data and rules, such as a document model, playlist, project graph or local draft. It belongs to the application. If the canonical data resides in a Smart Protocol service, the service remains authoritative and the app holds only the necessary working view/cache.
2. **Presentation state:** current focus, open palette query, selected panel, scroll offset, expanded group, local selection and similar UI interaction details. MirUI components/resources should hold this state where practical.
3. **Host/session state:** app lifecycle, granted capabilities, user identity, output viewport, surface, focus seat, input source, session restoration and platform preferences. Host state enters through Smart Protocol or the explicit host adapter.

A framework-level state container must not clone a full authoritative domain model merely to drive rendering. Reactive updates should identify the fields/components affected and invalidate the minimum relevant views. If a domain model is registered as a MirUI model to bind to widgets, it remains one model instance; it is not copied into per-widget shadow state.

## 27.2 Commands are the application action boundary

A command is a stable action description plus availability and invocation. It is not necessarily an OS protocol method. One command can call local domain logic, invoke a Smart Protocol service, navigate within the app, or open an overlay. If an operation crosses a host boundary, the handler calls the relevant generated client and propagates its typed result.

Command handlers MUST be explicit and testable. A command may be disabled because the selected object is read-only, there is no selection, a required capability is absent, or another operation is pending. The disabled reason should be human-readable when displayed by the palette or menu. The command must not report enabled and then silently do nothing.

## 27.3 Asynchronous work without a heavyweight runtime mandate

The framework needs a target-compatible way to represent operations which finish later. It MUST NOT require a heavyweight async runtime just to build a normal application. The host integration can poll or deliver completions; the public API presents a stable operation handle with status and cancellation where available. Native, embedded and browser runtimes may execute work differently internally.

The API should use a pattern equivalent to:

- start an operation with a typed request;
- return a lightweight operation handle;
- publish pending/progress/status changes when meaningful;
- allow cancellation if the operation and contract support cancellation;
- deliver a typed result or typed error exactly once;
- ignore or explicitly reject stale completion if the user has changed the relevant document/selection context;
- release subscriptions, buffers and temporary storage on completion or cancellation.

A command that requires disk/network/service access must not block a frame update. CPU-heavy work uses a host-supported worker or task execution capability with bounded messages; it must not mutate the UI world unsafely from arbitrary concurrent contexts.

## 27.4 Pending, failure and recovery semantics

The framework standardises states for `idle`, `pending`, `succeeded`, `failed`, `cancelled` and `unavailable` where applicable. It must distinguish an empty successful result from an error. It must distinguish denied permission from a missing service. It must distinguish timeout from cancellation. Retry is explicit and is allowed only where the operation is safe to repeat or has an idempotency contract.

No widget automatically retries a destructive or state-changing operation without knowing the operation's idempotency semantics. The presentation layer must not guess whether a timeout means the operation failed on the provider; when outcome is unknown, present that uncertainty and offer a safe way to refresh/query state.

## 27.5 Data presentation and efficient lists

List/table components accept an iterator/query-backed source or app-owned view model using stable item identity. The framework must not eagerly clone every record simply to draw a list. UI formatting is kept separate from stored domain values, especially for dates, quantities, currencies and locale-sensitive values. Collection changes should preserve selection and viewport where meaningful.

## 27.6 Persistence and restoration

Smart UI does not itself guarantee persistence for all application state. It provides a versioned app-state hook so the application can persist the small set of state it owns, and it uses relevant lifecycle contracts to save or restore. Durable application data belongs to its domain service or storage contract. Window/panel arrangement, last-used tab, scroll anchor and unsent drafts are separate classes of state and must have documented retention and privacy rules.

# 28. Universal command system: canonical specification {#sec-28}

The command palette is not a decorative optional feature. It is the default discovery mechanism across applications and one projection of the same action registry used by menus, shortcut hints, context menus and automation where permitted.

## 28.1 Default invocation

The default keyboard shortcut is `Mod+K`; `Mod` resolves to the platform's primary command modifier. The shortcut is configurable and must be exposed by the keyboard-shortcut help view. Environments without a physical keyboard provide a reachable visible action. A host may offer a system-wide palette, but this in-app palette must work without global input capture.

## 28.2 Required palette layout and content

The standard palette includes:

- an automatically focused query field;
- recent/frequent commands when that history is enabled by policy;
- search results grouped by meaningful category;
- title, optional supporting text and shortcut hint;
- clear enabled/disabled semantics, including a concise disabled reason;
- keyboard, pointer and touch-equivalent activation;
- loading/empty/error handling for asynchronous providers;
- a deterministic close/cancel behaviour with focus restored to the previous valid target.

The default matching should combine prefix matching, token matching and fuzzy matching with stable scoring. Recent usage can adjust ordering only modestly; it must not make command order unpredictable. User-entered queries should not be transmitted to a remote service unless an explicitly documented remote command provider requires it and policy permits that transmission.

## 28.3 Universal framework commands

Every application automatically gets the following applicable commands, provided their operation is implemented:

- Open command palette.
- Show keyboard shortcuts.
- Show application information/about information where the bundle supplies it.
- Open application help/documentation when supplied.
- Open application settings only when the app has settings.
- Toggle or select appearance only when the host/app policy allows user choice.
- Report an issue/diagnostic information only if an actual handler exists.
- Navigate back/forward only when the app has an applicable navigation history.
- Cancel current operation when a cancellable operation is active.

These are conditional actions, not fake placeholders. The command registry must not show actions whose handler does not exist. The command palette itself is always present.

## 28.4 Command metadata

The command model includes a stable identifier, localized title, optional subtitle/description, group, search keywords, optional shortcut, availability, invocation, optional parameter schema, optional destructive classification, optional icon token and optional context predicate. IDs must be stable across releases if they are used for persisted shortcut configuration or remote invocation. Renaming visible text does not change the ID.

Commands MUST NOT use raw strings as the sole authority for critical routing or permission decisions. Local command IDs can be typed/newtyped in Rust. If they cross a process or remote session boundary, they are serialized in the agreed versioned presentation/action contract and resolved again on the host.

## 28.5 Shortcut conflict resolution

The resolver uses a documented precedence: active text editor or specialised canvas may claim explicitly declared local shortcuts; focused widget commands apply next; application commands apply next; host/global shortcuts are managed by the host. `Escape` first cancels/dismisses the most local transient interaction that owns it, then follows the documented fallback. Conflicts must be surfaced by a developer-time validation report or test, not silently resolved by registration order.

## 28.6 Command contexts

Commands may declare contexts such as `global`, `document-open`, `text-edit`, `selection-present`, `panel-focused` or an app-owned typed context. Contexts control availability and presentation; they do not act as security capabilities. Provider security still decides whether service operations are authorised.

## 28.7 Command palette as shared UX

The same command record powers:

- palette rows;
- menu entries;
- toolbar actions;
- contextual action menus;
- keyboard shortcut hints;
- the shortcuts/help page;
- accessibility action names when applicable;
- optional automation/test invocation through a controlled test interface.

Every projection is generated from the registry. Do not create separate callbacks for the toolbar and palette that drift in behaviour.

# 29. Appearance, style recipes and theme format {#sec-29}

The default aesthetic is intentionally modern, neutral and generous, with dark tonal layers and a vivid accent. This is a default theme, not a universal identity imposed on every app. Smart UI must be visually coherent by default but flexible by architecture.

## 29.1 Appearance is a semantic model

The application asks for semantic roles and interaction states. The appearance resolver maps them to MirUI styles and rendering inputs. Business logic never branches on a hex colour, radius, shadow depth or animation duration. Theme change changes presentation only and must not reset application data, navigation, selection or in-progress editing.

## 29.2 Token families

### Colour roles

The standard semantic palette needs roles equivalent to:

- `canvas`, `surface`, `surface-raised`, `surface-sunken`, `surface-overlay`, `surface-inverted`;
- `text-primary`, `text-secondary`, `text-tertiary`, `text-inverted`, `text-disabled`;
- `border-subtle`, `border-strong`, `separator`, `focus-ring`;
- `accent`, `accent-hover`, `accent-pressed`, `accent-container`, `on-accent`;
- `accent-secondary`, `accent-tertiary` and their compatible foreground roles when the theme uses them;
- `success`, `warning`, `danger`, `info` and their foreground/container roles;
- `selection`, `selection-text`, `scrim`, `shadow`;
- optional domain tones such as chart series, syntax colors and waveform/selection colours, with contrast requirements.

Names are semantic. A token called `accent` does not promise green, blue or any particular hue. Grey-tonal neutrals must preserve distinguishable hierarchy; dark themes must not collapse all layers into black-on-black, and vibrant accents must not flood every surface.

### Geometry and spacing

The geometry tokens need semantic radii (`radius-none`, `radius-control`, `radius-card`, `radius-panel`, `radius-pill`, `radius-dialog`), border widths, icon sizes, control heights and hit-target minimums. Spacing uses a coherent base scale with named roles (`space-1`, `space-2`, etc.; `space-inline`, `space-control`, `space-section`, `space-page`). A theme may choose shapes beyond rounded rectangles, including square, chamfered or pill-like recipes. Shape selection must not change hit testing or semantic roles.

### Typography

Tokens cover family roles (`ui`, `ui-emphasis`, `mono`, optional `display`), text styles (`display`, `title`, `heading`, `body`, `body-emphasis`, `label`, `caption`, `code`, `numeric`), weight, size, line height, letter spacing and maximum text measure where relevant. Font sizing supports platform/output scaling and user preferences. No component owns a private hard-coded type scale.

### Surface and depth

Tokens describe border treatment, elevation level, shadow recipe, blur/translucency request, noise/texture policy and overlay opacity. The compositor determines whether an effect is supported and safe. If blur is not available, the fallback must remain legible and preserve hierarchy; the theme must not require blur for text contrast or essential grouping.

### Motion

Tokens define duration roles (`instant`, `micro`, `short`, `standard`, `long`, `spatial`), easing curves, spring profiles, stagger limits and reduced-motion substitutions. Component code refers to the role, not a literal `Duration::from_millis(247)`.

### Density and sizing

Density profiles include `comfortable`, `compact` and optional `glanceable` or `touch` recipes. Density is not the same thing as display scale. Output scale changes physical rendering resolution; density changes spacing and component sizing policy. Controls must remain usable within declared target profiles.

### Focus, selection and state

State tokens cover focus ring shape/width/offset, selected fills/borders, hover overlays, pressed response, disabled contrast and validation feedback. Focus appearance must remain visible in themes with low-contrast surfaces.

## 29.3 Default theme characteristics

The default theme MUST begin with:

- near-black or very dark neutral canvas;
- clearly differentiated charcoal/grey tonal surfaces;
- a vivid, configurable accent reserved for meaningful actions, focus, selection and limited emphasis;
- readable neutral text with multiple hierarchy levels;
- generous rounded corners on common controls and major panels;
- careful spacing, not a card around every item;
- soft, controlled elevation and optional translucency in selective surfaces;
- smooth typography with correct metrics, shaping and fallback;
- motion that makes state changes feel responsive without delaying interaction.

The exact colour values and radii are theme implementation values and may evolve. The long-lived architecture is the semantic token names and their behaviour. The default theme SHOULD include a light counterpart and high-contrast/reduced-motion variants without requiring separate widget implementations.

## 29.4 Component style recipes

A recipe maps semantic component types and states to tokens. For a button, it may select padding, background/foreground, border, radius, typography, focus ring and state transitions. For a field it also defines label, helper/error spacing, read-only/disabled appearance and invalid state. For a panel it selects header spacing, separator and optional elevation. Recipes must be resolved before the render hot path or cached by component/style identity and state.

App developers can override a recipe at app scope, component-family scope or a specific instance. Overrides are explicit and token-backed. Arbitrary raw colors may be used for domain visualisations or exceptional content, but standard controls should use semantic tokens.

## 29.5 Theme inheritance and override rules

Theme composition has a simple order: framework base recipe → active theme token set → app-level semantic overrides → intentional component override. The rules MUST be deterministic. Theme changes invalidate derived styles and affected regions; they do not re-run unrelated app side effects. Missing tokens are a development-time error and have a visible diagnostic fallback; release builds may use a defined safe fallback, but must emit diagnostic evidence.

Avoid arbitrary multi-parent theme inheritance, CSS selector specificity, runtime expression languages and cascades whose final value depends on discovery order. The system needs variants, not a general stylesheet engine.

## 29.6 Theme assets and persistence

A theme bundle can use the `theme` bundle shape supported by `manifest.capnp`, with versioned asset metadata, preview images, icons, fonts and token data. It MUST declare a theme-format version. Unknown optional tokens are ignored only when their names are in a namespaced extension section; unknown required semantic roles cause a clear compatibility error. Themes are data assets, not executable plugins by default.

User-selected theme ID, density and accessibility preferences are persisted by the appropriate host settings contract. The framework does not write settings through private OS storage APIs. An app can set an in-app preview without persisting a system-wide theme change.

# 30. Motion and interaction polish {#sec-30}

Motion is part of the shared UX model and must be token-driven, interruption-safe and resource-aware. It is not an excuse to animate everything.

## 30.1 Motion categories

- **Micro feedback:** press/hover/focus/selection response.
- **State transition:** expanding a group, switching tabs, revealing validation.
- **Spatial transition:** opening/closing a panel, moving between related views, docking/undocking.
- **Progress:** indeterminate work, playback, timeline/cursor movement.
- **Ambient motion:** optional decorative movement; disabled or reduced under constrained profiles and never necessary to understand the interface.

Each category maps to named timing/easing/spring tokens. The application specifies the meaningful state change; the framework chooses the default motion recipe.

## 30.2 Required motion behaviour

1. Motion begins promptly after the triggering input.
2. A new target retargets or interrupts an ongoing animation safely; stale animations must not overwrite newer state.
3. Completion callbacks fire at most once and only when the declared transition completes or is explicitly cancelled according to its contract.
4. Animations cannot be the only way an operation communicates success/failure.
5. Theme changes can update motion tokens without reconstructing the ECS world.
6. Hidden or inactive views do not wastefully run decorative animations.
7. Reduced-motion preference substitutes instant/state-based transitions or a simplified fade/colour change.
8. Automotive or other policy-constrained outputs can disable motion effects that increase distraction.
9. Spring/inertia systems are stable under frame-time variation and use bounded delta-time handling after suspend/resume.
10. Critical state changes must not wait for an animation to finish before becoming authoritative.

## 30.3 Effects and translucency

Blur, backdrop blur, shadows, glow, gradients, particles and 3D transforms are optional effects. They must have explicit performance profiles and graceful degradation. A standard form must remain attractive and usable with effects disabled. Per-frame full-screen blur, animated noise or unbounded particle systems are prohibited in the default framework controls. Creative apps may implement richer effects in their custom surfaces under declared resource constraints.

# 31. Typography, icons, assets and internationalisation {#sec-31}

## 31.1 Text shaping and resources

The framework MUST route text through MirUI's shaped-text facilities where they meet the requirements. It must support font fallback, bidirectional text, script shaping, ligatures/kerning where appropriate, combining marks, emoji policy, selection geometry, caret geometry and scale-aware rendering. Text layout measurement and painting must use the same font resource/version. Async font loading must not leave layout in an inconsistent state; use stable fallback metrics or invalidate and relayout the affected subtree safely.

Font resources are registered by logical family/role, not copied into every widget. An app may provide licensed font assets; fallback and missing-glyph behaviour is explicit. Do not bundle a font solely because it looks attractive without recording its licence and coverage.

## 31.2 Icons

Icons use typed/named assets with consistent optical sizing, alignment and semantic descriptions. A named icon is not a raw path string interpreted by every widget. The icon pipeline supports vector or raster resources as the renderer allows. Icons used as the sole control label require an accessible name. Decorative icons are omitted from accessible naming to prevent repetitive announcements.

## 31.3 Asset loading

Assets are looked up through an app/resource catalogue associated with the bundle/manifest. The app must not depend on arbitrary host paths. Images and fonts are decoded with explicit size/dimension limits and lifecycle ownership. Large assets are loaded asynchronously and can be cancelled when no longer required. Stable immutable assets may be shared/cached; mutable buffers have a clear owner and lifetime.

## 31.4 Localisation

Visible strings must be localisable and must not be assembled by concatenating translated fragments. Numeric/date/time/currency formatting uses locale-aware formatters supplied by the framework/host capability. Command titles and keyboard hints use the same localisation mechanism as ordinary controls. Layouts tolerate text expansion and right-to-left layouts; visual order, reading order and command identifiers remain stable. User-generated content is not passed through developer-string localisation.

## 31.5 Directionality and text editing

Bidirectional text and script shaping are required at framework level. A text editor must distinguish physical key positions from committed text, support IME preedit/commit, preserve correct cursor/selection indices, handle composition cancellation and return focus safely. Text offsets must have one documented convention at the public API and must be mapped carefully when the renderer uses glyph clusters. Do not expose glyph indices as user-visible character indices.

# 32. Input, focus, gestures and accessibility {#sec-32}

## 32.1 Unified input semantics

The same action should have the same result regardless of whether input originates from pointer, keyboard, touch, switch, voice, rotary or another negotiated modality. The framework translates host events into semantic intents; it does not treat every device as a mouse. Device-specific input remains possible for specialised apps but must not be required to use a basic button, list, menu, text field or command palette.

## 32.2 Pointer and touch

Pointer input defines enter/leave, down/up, click, drag, capture, cancellation and hover only where supported. A click is accepted only when the active press/release sequence meets documented conditions; cancellation due to focus loss, surface loss or drag-out must not trigger unexpected commands. Touch hit targets meet the active density/accessibility profile. Gestures must not unexpectedly steal from a text selection or nested scroll container.

## 32.3 Keyboard and shortcuts

The framework separates physical key identity, modifiers, text input and committed characters. This avoids treating key labels as physical positions and supports alternate keyboard layouts. Shortcut registration is centralised. `Tab`/`Shift+Tab` move focus predictably; arrows operate in the focused component's defined navigation model; `Enter`/`Space` activate controls according to their semantics; `Escape` cancels the nearest eligible transient interaction. Text editing commands do not conflict indiscriminately with app commands.

## 32.4 Focus management

Focus is a property of an input seat/output context, not a single global boolean for an application across all displays. Every focusable element has stable identity during an active composition. Opening a modal overlay captures focus according to its scope, exposes only valid targets where appropriate, and returns focus to a still-existing prior target on closure. If the target no longer exists, focus falls back to the nearest valid ancestor or documented focus root.

## 32.5 Accessibility mapping

Every standard component defines role, name, description, value, relevant state, parent-child relationships and available actions. The Smart Protocol accessibility tree/action contracts are the interoperability target. The app's accessible semantics must not be derived only by scraping painted pixels. Layout bounds are exported in the negotiated output coordinate space and updated when the structure or meaningful geometry changes.

Required behaviours include keyboard navigation, focus visibility, screen-reader names/roles/states, text selection where applicable, live announcements for meaningful status/validation changes, scalable text and high-contrast support. Controls must not rely exclusively on color, position, motion, or sound to communicate essential meaning.

## 32.6 Accessibility tree efficiency

The accessibility tree is derived from semantic component data. Updates are incremental when supported by the host contract; stable node identities survive harmless visual updates. Hidden decorative descendants are excluded. Large virtual lists expose the current visible/accessible range with a way to navigate the full logical collection. Publishing a new tree must not require expensive full-tree reconstruction on every pointer movement.

## 32.7 Preferences

Reduced motion, high contrast, text scale, input modality preferences and theme preference are host/user settings where a canonical contract exists. Smart UI responds to them but must not silently change the user's global preference when an app merely previews an alternative. Automotive distraction policies and accessibility overrides are applied according to host policy and cannot be bypassed by a theme.

# 33. Rendering architecture, panels and high-complexity applications {#sec-33}

## 33.1 Standard rendering path

A standard Smart UI component is represented with MirUI entities/components and painted by MirUI's rendering machinery. There is one authoritative in-process ECS for an application UI instance. Standard controls do not each own their own drawing loop. Dirty/invalidation state flows into the engine's existing update/render model.

## 33.2 Custom content surfaces

High-complexity apps may need a custom renderer for 3D viewport, waveform, video, code minimap, timeline, map, chart or node graph. Smart UI defines a consistent embedding contract: surface extent, scale/transform, clipping, input ownership, focus integration, accessibility alternative, frame/lifecycle hooks and resource ownership. It does not mandate a single GPU strategy for every domain.

Custom content must integrate with standard panels and layouts. A timeline view should coexist with the command palette, shortcuts, focus system and themes rather than becoming a window that ignores the rest of the framework. Its drawing path may be specialised; its application-level command and host-service boundaries remain canonical.

## 33.3 Panels and docking

The panel system MUST be declarative at the layout level and persistent only for user arrangement preferences. It needs predictable panel identity, default region, constraints, optional collapse, hide/show state, tab grouping and a serialisable versioned arrangement. If a saved arrangement references removed panel IDs, the restore algorithm discards those nodes safely, preserves valid panels and falls back to the default layout. It must never prevent the app from launching because one panel layout is corrupt.

Panel focus, command contexts and selection are explicit. A hidden panel does not continue expensive animations or unbounded polling. Panels may receive app commands but cannot assume that a desktop docking environment exists.

## 33.4 Software and GPU backends

The application-facing UX must not branch on a particular renderer. Feature selection belongs in the host/build configuration. A software renderer is useful for constrained devices and deterministic tests; GPU rendering is useful for high-throughput visualisation, effects and demanding animation. The framework uses the same semantic layout and input behaviour across them. Backend-specific features are negotiated and guarded with supported fallbacks.

## 33.5 Scheduling and frame ownership

MirUI's scheduler owns MirUI system order. Smart UI may register required systems/plugins through documented APIs, but it must not create another frame scheduler. Each expensive system documents its frequency/trigger and resource access. Work unrelated to the current frame should be event-driven or off the frame path. A surface commit follows the buffer producer/consumer and fence semantics in the host contract; the framework must not reuse a buffer before its use is completed.

# 34. Multi-output and remote-browser OS architecture — expanded requirements {#sec-34}

Remote access is a first-class OS output. The intended user experience is a real interactive Smart OS session in a browser, not a video of another screen. The architecture supports independent local outputs and browser sessions concurrently.

## 34.1 Output is a capability-bearing endpoint

An output endpoint includes a negotiated viewport, logical scale, safe insets, available input modalities, rendering features, accessibility channel, presentation rate/clock where available, color/display properties where applicable, and resource policy. Physical display, embedded panel, remote browser and future output types implement the same logical output boundary. There is no global assumption that the application has one width/height or one focused element.

Outputs do not automatically share all input or focus state. Each input seat/session has explicit ownership. Multiple outputs may show the same application state if policy and app semantics allow it, or run separate app instances/sessions. Per-output presentation state is distinct from domain state.

## 34.2 Two remote execution paths, one Smart UI model

The framework supports two modes and chooses explicitly by manifest capability and negotiated host support. It must not force all apps through the more expensive mode.

**Mode A — browser-native Smart UI execution (preferred for portable suite applications).** The same application source is built for its native/runtime target and a browser-compatible target such as WebAssembly where supported. The browser runs the application's UI and interaction logic locally for that remote session. OS-owned data, persistence, privileged actions and services remain behind Smart Protocol service contracts exposed through an authenticated remote service channel. The browser UI responds to local typing, pointer movement, selection and ordinary interaction without waiting for a round trip for every pixel. Mutating operations are submitted to the authoritative service, and the UI reconciles with the confirmed result. `manifest.capnp` already has entry-point and runtime hint concepts that can describe multiple runtime-specific entries; exact packaging rules must be specified by the package/manifest workflow.

**Mode B — remote presentation of a host-executed application.** For applications that cannot execute in the browser runtime or that must run in a host session, the host exports a structured presentation stream for the Smart UI components it can represent. The browser maintains a derived presentation replica and sends input/actions back to the host. It receives revisioned component/property/semantic updates and asset references, not raw screenshots for the whole OS. Custom high-rate surfaces may use a negotiated per-surface graphics/video stream when semantic transport is inappropriate.

These modes are not separate frameworks. They share component semantics, command identifiers, appearance tokens, accessibility meanings, app manifest conventions and Smart Protocol service semantics. Mode A is preferred for newly developed Smart UI apps because it delivers local input responsiveness and avoids serialising a remote UI tree at every interaction. Mode B provides interoperability for host-resident UI that cannot run in the browser.

## 34.3 The authority model

The browser session is not trusted merely because it is a valid renderer. The host remains authoritative for identity, permissions, persistent data, service results, app installation, lifecycle policy and protected resources. A browser app may optimistically update presentation-only state (pressed feedback, selection highlight, local cursor/caret preview) but must reconcile service-backed changes with confirmed outcomes. It must not report that a file was saved or a permission granted until the provider confirms it.

Each remote session is authenticated and gets a scoped service context. Browser clients receive only granted operations and opaque handles/tokens needed for those operations. They never receive a host process handle, raw internal pointer or unscoped capability. Cross-origin browser restrictions, cookie/session policy and token storage must be part of the deployment design; authentication tokens must not be placed in URL query strings.

## 34.4 Smart Protocol contract requirements

Existing `compositor.capnp` provides surface/session, commit/damage/frame signal, accessibility-related structures and a basic `RemoteAccessConfig` (`enabled`, `requireAuth`, `maxConnections`). This does not itself define complete remote OS sessions. A contract gap remains and must be addressed in the official schema repository before declaring remote output interoperable.

The remote-output contract needs, at minimum:

- session create/attach/close and authentication/session binding;
- handshake with protocol version, supported output modes, runtime/ABI modes, presentation capabilities and policy limits;
- creation of a distinct remote output and input seat;
- viewport, scale, safe-inset and capability change notifications;
- subscription and cancellation semantics for presentation/service events;
- typed action/input events with ordering, timestamps/sequence numbers and cancellation;
- presentation snapshot plus revisioned delta stream for Mode B;
- acknowledgement, bounded flow control, backpressure and stale-revision recovery;
- app/bundle/asset negotiation for Mode A, including compatibility/runtime requirements;
- contracted bulk transfer for large assets and media/custom surfaces;
- session suspend/resume, reconnect/resynchronisation and explicit revocation;
- output privacy/surface access controls and audit-relevant session identity;
- clear error/status variants including unsupported capability and degraded acceptance.

This must be specified in the canonical Smart Protocol. It may extend the compositor/output domain or use a narrowly scoped dedicated schema after a schema ownership review. Do not implement it as a Naledzi-only private websocket contract. Transport binding (for example, a secure WebSocket or WebTransport mapping) is replaceable and subordinate to the typed protocol semantics.

## 34.5 Structured message stream and zero-copy rules

For Mode B, initial attachment and resynchronisation may send a full snapshot. Normal interaction sends incremental changes to semantic nodes, relevant properties, actions, geometry, accessibility state and assets. Each message carries the session/output identity and monotonically meaningful revision/sequence data. The client rejects stale or out-of-order deltas and requests a new snapshot if continuity cannot be proven.

For Mode A, Smart UI application code runs locally in the browser target, so ordinary component rendering does not cross the network. The network path transports Smart Protocol requests/results, subscriptions, data handles/transfers and application-domain payloads. Service clients multiplex where appropriate and maintain bounded queues. A request's Cap'n Proto type is the contract; a transport adapter frames/transmits it. Cap'n Proto alone does not provide identity, encryption, permission enforcement, congestion control, delivery guarantees or the browser runtime, so those responsibilities must be defined at their proper layer.

Bulk binary content MUST use a negotiated data/buffer transfer mechanism rather than base64 inside JSON. Large custom rendering payloads may use per-surface streams. Whole-screen video encoding is not the default for normal Smart UI applications.

## 34.6 Responsiveness goals

A browser UI should not wait for a network round-trip to update local focus, pressed state, command palette filtering, cursor movement, selection highlight, hover response, ordinary layout, local animation or scroll feedback. These effects are local to the browser output. Service-backed results remain confirmed by the host. For host-executed Mode B components, controls may use safe local presentation feedback but must not commit an authoritative state change before host acceptance.

The system coalesces superseded viewport and pointer-move events, avoids replaying stale scroll positions, preserves ordering for keyboard/text/command events, bounds message queues, drops stale non-semantic frame updates, and applies backpressure to data transfer. A poor network cannot be made physically zero-latency; the target is to ensure most visible interaction remains local and immediate while remote service actions show honest progress/status.

## 34.7 Multiple outputs and user sessions

A remote browser login normally creates its own authorised output/session. Attaching to an existing signed-in desktop is a separate explicit mode and must not steal its keyboard focus or merge clipboard/input state without policy. Local screens and one or more remote outputs may be active simultaneously under resource policy. Per-output state includes viewport, scale, open transient overlays, focused target for that input seat and rendering profile. Domain/document state may be shared only through the application's model and service semantics, not through accidental sharing of MirUI component identity.

## 34.8 Recovery and reconnection

A remote client maintains the last acknowledged revision and negotiated session identifier. When the network drops, the client shows connection state honestly and stops sending mutating actions unless a safe offline queue contract exists. On reconnect, the host revalidates identity, capability grants and session expiry. It either resumes from a compatible revision or sends a fresh snapshot. Actions whose result was unknown must be queried or reconciled before retry, not blindly replayed.

## 34.9 Remote output threat boundaries

Threats include stolen sessions, cross-user window/clipboard leakage, replayed commands, stale capability use, malicious browser messages, oversized payloads, slow-client resource exhaustion, surface capture outside policy and confused-deputy actions through the host. Controls include session scoping, secure transport, expiry/revocation, host-authoritative authorization, bounded payloads/queues, output access control, per-session resource limits, explicit audit events where defined and no reuse of global process/window privileges by the browser.

## 34.10 Remote completion criteria

Remote mode is not complete when a login page appears. It is complete only when the authorised browser session can discover/launch applications, interact with the system UI, use the command palette, enter multilingual text, handle files through service contracts, receive accessibility information, coexist with local outputs, reconnect/resynchronise, and close/revoke cleanly. At least one representative app must run in Mode A and one host-executed/custom-surface path must be demonstrated for Mode B or explicitly documented as unsupported in the first release. Measured latency, update rate, queue bounds, memory and behaviour under disconnection must accompany performance claims.

# 35. Resource profiles, memory and performance budgets {#sec-35}

Zero-cost is a design rule: abstractions should compile away or do not add work when they are not used; routine UI work must not allocate, copy, poll or redraw unnecessarily. It is not a claim that rendering, IPC or network interaction has literally zero physical cost.

## 35.1 Resource profiles

Targets differ significantly. The same app model is portable, but a watch, automotive controller, phone, desktop and browser session have different feasible budgets. The framework supports profile selection rather than defining a different architecture for each target.

| Profile | Expected behaviour |
|:-----------------|:-------------------------------------------------------------------------------|
| `constrained` | Bounded allocations, software-rendering-compatible controls, limited texture/animation effects, no ambient animation by default |
| `compact` | Small viewport and limited interaction; reduced panel chrome, accessible targets and short task flows |
| `balanced` | Default general-purpose profile with common effects and normal animation |
| `high-throughput` | Allows advanced custom surfaces, higher-rate rendering and larger resource budgets when host capabilities permit |
| `remote` | Local browser feedback, network-aware batching, bounded queues and adaptive custom-surface streaming |
| `safety-critical` | Effects and interaction patterns constrained by host policy; bounded work and explicit failure modes; not a claim of certification by itself |

Profiles are hints/constraints chosen by the host and app; they do not permit the app to exceed granted capabilities. Applications may request a profile suitable for their workload; the host can clamp it to available resources/policy.

## 35.2 Allocation rules

- A steady-state frame with no changed content SHOULD perform no allocations in the ordinary control path.
- Reuse MirUI's retained component/storage and prepared layout/render data where its API guarantees are valid.
- Static command lists, theme token tables and immutable assets SHOULD be constructed once.
- Repeated strings, accessibility nodes and style resolutions must not be recreated blindly every frame.
- Virtual lists allocate/materialise only a bounded visible range plus overscan.
- Temporary buffers have explicit ownership and capacity; unexpected capacity exhaustion returns a defined error or drops only safely coalescible presentation updates.
- Allocator failure behaviour must be documented per target. The framework must not assume allocation failure is impossible merely because `alloc` is available.

## 35.3 Copy and transport rules

No full-domain-model clone per widget. No full presentation tree clone per local display. No full-screen CPU buffer copy for every ordinary remote UI action. Shared-memory or handle-based transfers are used only when the host contract, alignment, lifetime, synchronisation and capability grants support them. A copy is justified when required by format conversion, process isolation, network transport, non-coherent memory or data ownership; each such copy belongs to a clearly named boundary.

## 35.4 Frame and event work

- Input dispatch performs bounded matching and must not scan every entity when MirUI has a suitable index/query.
- Layout updates are restricted to affected subtrees when possible.
- Damage regions are bounded and merged using a deterministic policy. Excessively fragmented damage may collapse to a full-region repaint when that is cheaper.
- Idle applications do not spin their own frame loop when no animation, input, output change or pending frame request exists.
- Animation systems skip empty component sets and stop scheduling when no active animation remains.
- Work launched from input handlers must be bounded; expensive operations are asynchronous.
- Time-step handling clamps or resynchronises after suspend/resume so animations do not jump across a long sleep interval.

## 35.5 Performance evidence

Performance claims must specify target hardware/profile, surface size, theme/effects, visible entity count, interaction scenario and whether the run includes protocol/network overhead. Report frame-time distribution, allocations, peak memory, copied bytes, redraw area and remote queue/latency metrics where relevant. An average FPS number alone is insufficient. No global performance number can certify all targets.

# 36. Developer tooling, documentation and app completeness {#sec-36}

Smart UI succeeds when developers can finish polished apps with low friction. The public API is not complete until there are complete examples, interaction docs, theme recipes and testing support.

## 36.1 Required examples

The repository must contain working, build-tested examples for:

1. Minimal utility with one action and no manual window/render loop.
2. Command-rich application demonstrating palette, shortcuts, contexts and disabled reasons.
3. Document app with unsaved changes, save/undo/redo, async operation and recovery states.
4. Settings app with grouped forms, validation, reset and appearance preview.
5. Searchable/paginated list with loading/empty/error states and large-data virtualisation.
6. Master/detail application adapting from wide to narrow output.
7. Dockable multi-panel workspace using shared commands and state.
8. Custom canvas/timeline example using MirUI advanced drawing/input facilities.
9. Theme authoring example with different colors and geometry but unchanged app code.
10. Native host output example using canonical compositor/buffer/input integration.
11. Browser/WebAssembly remote-session example calling authenticated Smart Protocol services.
12. A test example that exercises actions without relying on pixel screenshots alone.

Every example must compile in CI and be kept in sync with the public API. Do not publish pseudo-code in the reference docs as if it were executable.

## 36.2 Component gallery

A runnable component gallery must enumerate every standard widget and display its states: default, hover where applicable, focus, selected/checked, disabled, pending, invalid, read-only and high-contrast/reduced-motion modes where relevant. It must allow theme switching and viewport/profile switching. Its purpose is engineering verification and developer discovery, not a substitute for tests.

## 36.3 Error and diagnostic support

Development builds should make duplicate command IDs, shortcut conflicts, unknown tokens, missing required assets, invalid layout cycles, dangling panel IDs and accessibility omissions easy to diagnose. Diagnostics identify the responsible app/component and stable requirement IDs where relevant. Production UI must not expose secrets, internal paths or sensitive stack traces to ordinary users.

## 36.4 App authoring steps

A developer's ordinary workflow should be:

1. Declare app identity, manifest, entry points, required capabilities, assets and locales.
2. Define domain state and service adapters using generated Smart Protocol types.
3. Define the standard command set and keyboard shortcuts.
4. Compose a shell and content using standard Smart UI components/MirUI authoring.
5. Connect component actions to local domain functions or typed service requests.
6. Configure app-specific token/recipe overrides only where needed.
7. Build and run under target/profile, use the component gallery and keyboard/pointer/touch testing.
8. Run formatting, lint, tests, protocol-generation drift checks, `no_std`/WASM feature checks, asset/manifest verification and accessibility checks.
9. Package and sign/publish according to the Smart Protocol bundle workflow.

The simple app case should not require a developer to understand host internals, ECS scheduling details, Cap'n Proto wire layout, buffer alignment or remote session framing. Those should remain framework/platform implementation responsibilities until the app needs an advanced facility.

# 37. Rust implementation and public API shape {#sec-37}

The public API is one cohesive set of ordinary Rust types and functions. Standard composition uses MirUI's existing `#[model]`, `#[compose]` and `ui!` facilities where appropriate. Smart UI defines the missing application/command/UX types and integrates them into the one MirUI world. It does not require a Smart UI procedural-macro crate, a declarative shadow tree or another reactive runtime.

The following names define the target public API surface. They are not claimed to exist in the repository yet; implementation is responsible for making them real, documented and compile-tested. The implementation may adjust low-level signatures if MirUI's concrete constraints require it, but the observable semantics and developer workflow below are normative and changes must be reflected in this specification.

### Required public concepts

| Type or function | Contract |
|:-----------------|:-------------------------------------------------------------------------------|
| `SmartApp` | One app bootstrap/runtime facade that wraps MirUI and the host adapter; creates no parallel scheduler or ECS |
| `AppMetadata` | App ID, human-readable name and optional description/icon/locales; must correspond with bundle manifest identity |
| `AppContext` | Scoped access to granted Smart Protocol service clients, lifecycle, output environment, operation delivery and diagnostics |
| `CommandId` | Stable app-local command identifier; persisted/remote IDs remain stable across releases |
| `Command` | Title, group, keywords, shortcut, availability, handler and optional parameter/destructive metadata |
| `CommandRegistry` | The single source for palette, shortcut help, menus, toolbars, context menus and optional test invocation |
| `Appearance` | Selection of host/system/app appearance plus permitted scoped overrides |
| `Theme` / `ThemeTokens` | Versioned semantic token values; no application dependency on raw visual values |
| `AppSurface` and shell compositions | Standard root setup and UX composition using MirUI |
| `Operation<T>` | Lightweight status/result/cancellation representation for work which completes later; no forced heavyweight async runtime |
| `HostOutputInfo` | Read-only negotiated view of available viewport, scale, insets, inputs and rendering capabilities |
| `ResourceRef` or schema-specific typed reference | Uses canonical generated Smart Protocol types for resources; must not invent a parallel generic handle where a typed schema exists |

### API design rules

- The common application path has one obvious bootstrap and one `run` call.
- Default setup installs the command palette, core focus/shortcut rules, appearance resolver and lifecycle hooks automatically.
- Generated Smart Protocol types are passed through the framework or wrapped only in ergonomic clients which preserve their errors and semantics.
- Application domain state can be ordinary Rust state or a registered MirUI model; there is no second store that mirrors it.
- Standard controls are typed, composable and accessible, with explicit action/command binding and sensible defaults.
- Service work returns typed outcomes; expected service failures are not panics.
- No public API forces every app to configure every optional renderer, input device, color, geometry token or lifecycle hook.
- The prelude is small. Advanced MirUI draw primitives and low-level host/protocol APIs remain explicitly namespaced.
- Native and browser-target code share app and view source where dependencies permit; host-specific functionality is explicit and capability-checked.
- Target-specific features are detected/negotiated, not inferred from operating-system strings in business logic.

### Public API stability

The final public signatures must be established before 1.0 and covered by compile tests. Examples in the docs are source code, not illustrative pseudocode. A change in builder names, return types or view composition must update examples and migration notes in the same change. The framework must not claim developer ergonomics based on sketches that do not compile.

# 38. Compatibility, evolution and migration {#sec-38}

Smart UI has two different compatibility surfaces: the stable application-facing framework API and the external Smart Protocol contracts. They evolve independently, and the framework must not mix their versioning.

## 38.1 Framework API

The library follows semantic versioning once a 1.0 API is published. Before 1.0, releases may break APIs but must document migration steps and keep the normative spec accurate. Major API decisions should be driven by a concrete use case, not speculative abstraction. Public components and tokens need deprecation periods when practical. Internal modules remain private unless consumers have a real reason to depend on them.

## 38.2 Smart Protocol compatibility

Smart UI pins a schema revision at build/vendor time and consumes generated bindings. At runtime, schema/service version negotiation and capability discovery follow the applicable contracts. Unknown optional enum variants or metadata are handled according to canonical protocol rules; unknown required semantics fail clearly. Never silently map a new required operation to an unrelated old operation.

## 38.3 Theme compatibility

Theme files are versioned data. Adding an optional token is compatible when a defined fallback exists; changing the meaning of an existing token is not. Token renames need a migration alias or a version bump. A theme must either load with well-defined optional fallbacks or report a clear incompatibility, never mix token values accidentally because IDs changed.

## 38.4 App-state compatibility

Saved panel arrangements and presentation preferences include a format version and app/component identifiers. Unknown optional panels are skipped and valid data is preserved. Critical domain state must be migrated by the app/service that owns it, not by a generic UI layout restore routine.

## 38.5 MirUI dependency updates

Smart UI pins a known MirUI revision and upgrades deliberately. An update is qualified against the framework examples, feature matrix, renderer output, command/focus tests, text-selection tests and allocation/performance baselines. Smart UI must not fork MirUI pre-emptively. When a gap is found, first determine whether it is a missing upstream capability, integration defect or a genuine incompatible design. Maintain a small patch set only when necessary and record a plan to upstream or remove it.

# 39. Implementation plan and release gates {#sec-39}

The framework should be built in vertical slices so every phase produces a usable result. Avoid implementing the whole widget catalogue before proving the rendering and protocol seams.

## Phase A — freeze the foundation

Deliver:
- Pin MirUI revision and record exact features for native `no_std`, development desktop and WASM builds.
- Create the single `smart-ui` crate/module layout.
- Establish generated Smart Protocol bindings and reproducible vendor/schema drift checks.
- Document ownership: one ECS, one scheduler, one UI state model, one command registry and one appearance resolver.
- Add one running MirUI-backed app on a development surface.

Exit condition: no duplicate ECS/layout/scheduler/tree has been introduced; the app uses the real MirUI API and builds from a pinned dependency set.

## Phase B — first end-to-end app

Deliver:
- App identity/configuration and lifecycle hook.
- Standard `AppSurface`, simple layout primitives and core controls.
- Token/recipe resolution with light/dark and one custom theme.
- Command registry and mandatory palette.
- Focus/keyboard and pointer interactions.
- Typed service client integration through a real Smart Protocol request.

Exit condition: the reference utility app launches, uses one contracted service, exposes its commands through palette/shortcut/menu projections, and switches themes without changing app code.

## Phase C — complete everyday UX

Deliver:
- TextField/TextArea with IME and clipboard contract integration.
- Lists/tables and virtualisation.
- Forms/validation, menus, dialogs, toasts, empty/error/loading states.
- Accessibility tree mapping and focus navigation.
- Adaptive layouts for narrow and wide output profiles.
- Lifecycle suspend/resume and state restoration.

Exit condition: a realistic data-management app is usable through keyboard and touch, has complete operation/error states, and uses the same components at narrow and wide sizes.

## Phase D — advanced applications

Deliver:
- Split/dock panels and persistent arrangement.
- Custom canvas/viewport embedding contract.
- Timeline/node-graph or other complex visual sample.
- High-performance and constrained resource profiles.
- Asset/font loading, caching, localisation and RTL verification.

Exit condition: the same framework supports a standard app and a complex app without a second runtime or per-app theme/command infrastructure.

## Phase E — remote browser output

Deliver:
- Canonical Smart Protocol remote-output/session contract after schema review.
- Authenticated browser session and remote input seat.
- Browser-compatible Smart UI runtime/app entry points for portable applications.
- Remote Smart Protocol service transport and credential/session policy.
- Explicit host-executed structured presentation mode for apps that need it.
- Revisioned updates, backpressure, reconnection, resynchronisation, and per-surface stream fallback for appropriate heavy content.

Exit condition: the browser runs a complete supported Smart OS session, common interactions are local and responsive, OS actions remain host-authorised, local outputs continue to work, and a network interruption can recover without corrupting state.

## Phase F — production hardening

Deliver:
- Memory/performance profiles and measured baselines.
- Fuzz/property tests for input sequences, layout constraints and remote message decoding.
- API compatibility and theme migration policy.
- Documentation, runnable component gallery and app templates/examples.
- Package/manifest verification and release automation appropriate to the existing repository.

Exit condition: release requirements below are met with reproducible evidence.

# 40. Finished-framework conformance checklist {#sec-40}

The framework is ready for adoption by the application suite when these statements are true. This is a focused checklist, not an invitation to delay work with endless speculative tests.

### Architecture
- [ ] One cohesive `smart-ui` public crate is the ordinary application dependency.
- [ ] MirUI owns ECS, scheduler, layout/render pipeline; Smart UI does not duplicate them.
- [ ] There is no shadow widget tree or parallel reactive store for normal UI.
- [ ] All OS-owned operations use generated Smart Protocol clients and provider-enforced capabilities.
- [ ] Naledzi-specific implementation code is confined to host integration, not app business logic.

### Developer experience and UX
- [ ] A useful minimal app can be authored with one obvious bootstrap path.
- [ ] The command palette is available in every app and derives from the common command registry.
- [ ] The widget catalogue is implemented/documented at the stated scope, with unsupported advanced domain widgets clearly identified as extension points.
- [ ] Common components define behaviour, focus, errors, disabled/pending state and accessibility semantics.
- [ ] Layout adapts to constraints and capabilities rather than hard-coded operating-system names.
- [ ] The same app can compose a simple mobile view and a wider multi-pane view without duplicating domain state.

### Appearance and motion
- [ ] Default theme uses neutral tonal surfaces, a configurable vivid accent, generous rounded geometry and restrained effects.
- [ ] Components consume tokens/recipes; application logic does not depend on literal colors/radii/timings.
- [ ] Multiple themes with materially different palettes and shape treatments run without app source changes.
- [ ] Motion can be reduced/disabled globally and per host profile; interaction remains understandable.
- [ ] Typography, font fallback, bidi shaping, text scaling and IME behaviour are integrated rather than implemented separately per widget.

### Protocol and portability
- [ ] Generated schemas match the pinned official Smart Protocol revision.
- [ ] Lifecycle, discovery, manifest, buffers, compositor, input, IME, clipboard and accessibility contracts are used only within their correct ownership.
- [ ] App and theme bundles declare runtime/ABI and assets sufficiently for the package layer to select compatible entry points.
- [ ] No capability is granted because a UI component requested it; host providers enforce authority.
- [ ] A compatible non-Naledzi host can use the framework by implementing the required contracts and runtime ABI.

### Performance and robustness
- [ ] Standard no-change frames do not allocate or redraw without cause in the supported profile.
- [ ] Large lists are virtualised; expensive work does not block the frame/input loop.
- [ ] Buffer ownership/fences prevent premature reuse; all queues and large payload sizes are bounded.
- [ ] `no_std` configurations select compatible features with default `std`-enabling features disabled where necessary.
- [ ] Failure, cancellation, missing capability, reconnect and suspend/resume behaviour are defined and tested.

### Remote and multiple outputs
- [ ] At least one browser-native app entry point runs in a remote browser OS session.
- [ ] Remote authentication/session authority and OS service calls use the canonical contract/security model.
- [ ] Remote UI uses local rendering/interaction for browser-executable apps, not whole-screen VNC capture as the normal path.
- [ ] Host-executed apps have a defined structured-presentation or explicit per-surface-stream policy.
- [ ] Local and remote outputs can coexist without accidental focus, input or clipboard leakage.
- [ ] Deltas, backpressure, revisions, reconnect and resynchronisation have defined contracts.

### Documentation and release
- [ ] All reference examples compile in CI.
- [ ] Component gallery covers core states, themes, input and output profiles.
- [ ] API changes, schema changes and token-format changes have explicit versioning/migration rules.
- [ ] Source revision, build features, conformance results and performance test conditions are recorded for each release.

# 41. Decisions, constraints and deliberately excluded complexity {#sec-41}

This specification makes a number of explicit exclusions to prevent the framework from being rebuilt as an overengineered system.

1. No separate crate for each logical module.
2. No second ECS, retained tree, scheduler, signal runtime or animation engine.
3. No CSS/cascade compatibility layer.
4. No arbitrary remote execution of Rust closures or UI handlers over the wire.
5. No app-level direct privileged host API bypass.
6. No theme-defined business logic or executable theme bundles by default.
7. No global keyboard capture as a precondition for the in-app command palette.
8. No assumption that every device is a desktop with a window, mouse and keyboard.
9. No whole-screen VNC stream as the default browser OS architecture.
10. No promise of zero network latency or zero cost across process/network boundaries; instead eliminate redundant work and make costs bounded, measured and explicit.
11. No claim of real-time or safety certification without target-specific engineering and certification evidence.
12. No demand to implement every conceivable domain-specific visualisation in the core. The framework provides excellent extension points and standard UX integration.
13. No endless validation programme disconnected from real use. Tests are tied to explicit requirements, real reference applications and observed failure modes.

An architecture review must justify each proposed abstraction against this list. If it duplicates an existing MirUI or Smart Protocol capability, it must demonstrate a material reason before being accepted.

# 42. Glossary {#sec-42}

| Term | Meaning |
|:--------------------|:-------------------------------------------------------------------------------|
| App/domain state | Application-owned data and rules; authoritative state may be in an OS service |
| Presentation state | Focus, selection, scroll offset, open overlay and related UI-only state |
| Appearance | Resolved visual rules for token roles, geometry, typography, surface, density and motion |
| Command | Named action with availability/handler exposed in palette and other projections |
| Host | Operating environment providing Smart Protocol services, surfaces, buffers and lifecycle |
| Output | Presentation endpoint with viewport/capabilities/input-seat state |
| Remote OS session | Authenticated, independent or explicitly attached browser-facing session to the OS |
| Mode A | Browser executes a compatible Smart UI application entry point locally, with authoritative OS services remote |
| Mode B | Browser displays revisioned structured presentation from a host-executed app |
| Semantic component | Component with an interaction/accessibility meaning beyond painted pixels |
| Smart Protocol | Canonical typed interoperability schemas and service contracts |
| Smart UI | Cohesive app framework for UX, command, appearance, adaptation and host integration |
| MirUI | ECS-driven UI and rendering engine used inside Smart UI |
| Token | Named semantic appearance value resolved by active theme/profile |
| Recipe | Mapping from component role and state to appearance tokens and style properties |
| Capability | Authority granted/checked by the host/provider; never conferred by a UI element |

# 43. Source basis and implementation references {#sec-43}

This specification uses the following public sources for current architecture facts. The product requirements in this document are normative decisions for Smart UI and must not be mistaken for already-implemented MirUI or Smart Protocol features. Upstream revisions must be pinned during implementation because default branches change.

- MirUI repository and documentation: https://github.com/W-Mai/mirui
- MirUI package/features: https://github.com/W-Mai/mirui/blob/main/Cargo.toml
- MirUI ECS/View implementation: https://github.com/W-Mai/mirui/blob/main/src/ui/view.rs
- MirUI theme implementation: https://github.com/W-Mai/mirui/blob/main/src/ui/theme.rs
- Smart Protocol schema inventory: https://github.com/smart-foundation/smart-protocol-official/blob/master/docs/SCHEMAS.md
- Application lifecycle and management: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/app.capnp
- Application discovery and launch: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/appindex.capnp
- Bundle entry points, dependencies, capabilities and assets: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/manifest.capnp
- Compositor surface, buffer commits, frame signals and current basic remote config: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/compositor.capnp
- Window/output operations: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/windowmanager.capnp
- Buffer and shared-memory/data-buffer mechanisms: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/buffer.capnp
- Input contract: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/input.capnp
- IME/text input: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/ime.capnp
- Accessibility contract: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/accessibility.capnp
- Clipboard contract: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/clipboard.capnp
- Intent dispatch: https://github.com/smart-foundation/smart-protocol-official/blob/master/schema/intent.capnp


**End of Smart UI Framework Specification v2.0.**
