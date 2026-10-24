@0xa1b2c3d4e5f60031;

using T = import "types.capnp";
using import "power.capnp".PowerState;

# ══════════════════════════════════════════════════════════════════════
# Shell — TWO surfaces, deliberately.
#
# This file carries two interfaces, and the reason they are both here is the
# single most important thing to understand about it:
#
#   Session       (ordinals @0–@75) — the DESKTOP SESSION surface. What a
#                 graphical/compositor session aggregates: launcher apps,
#                 notifications, clipboard, tray, audio/network/power state,
#                 display, search, settings, portals, events, and the
#                 multi-modal input family (voice, wake-word, gesture,
#                 brief, accessibility, context bubbles).
#
#   ShellService  (ordinals @0–@44) — the COMMAND INTERPRETER surface. How
#                 input becomes execution: execute, complete, history,
#                 aliases, variables, environment, jobs, undo, scripts,
#                 watchers, bookmarks, guided mode, natural-language
#                 interpretation.
#
# These are not two drafts of one interface. They answer different questions:
# "what is on screen and what state is the session in" versus "run this and
# tell me what happened". A compositor asks the first. A REPL asks the second.
# Merging them would produce a 127-method interface with no single audience,
# which is the shape every schema in this repo has drifted toward and the
# reason none of them is small.
#
# ── The reconciliation, stated so nothing is deleted by silence ──────────
#
# The `ShellService` design (progress/batch-001.md:34) does not cover
# clipboard, Bluetooth, voice, wake-word, gesture, accessibility, or the six
# paginated methods. That is CORRECT AND INTENTIONAL — those are session
# concerns, and the designed interpreter surface has no business answering
# "what is in the clipboard". They are KEPT in `Session` at their existing
# ordinals (@13–@19 clipboard, @28–@29 Bluetooth, @55–@61 pagination,
# @62–@75 multi-modal/voice/gesture/accessibility).
#
# Nothing was removed from this file to make the two designs agree. The
# designed surface was added alongside, in its own namespace of concerns.
# If a future agent believes a method is redundant, the redundancy must be
# demonstrated by two callers, not by noticing the method is absent from a
# document written before it existed.
#
# ── Two mode enums, on different axes ───────────────────────────────────
#
#   ShellSessionMode (@62/@63, existing) — INPUT MODALITY. How the user
#       communicates: text, voice, gesture, combined. "Which device am I?"
#
#   ShellMode (ShellService, new) — EXECUTION MODE. How the interpreter runs:
#       interactive, script, batch, guided. "How is this input being run?"
#
# A voice-driven session is `ShellSessionMode.voice` running in
# `ShellMode.interactive`. Collapsing them would lose one of the two answers.
#
#
# Improvements beyond the original schema:
#   - PowerState imported from power.capnp (was duplicated).
#   - applicationId uses T.AppId (was raw Text).
#   - processIds uses List(T.ProcessId) (was List(UInt32)).
#   - snoozeNotification duration uses T.Duration (was raw UInt64 ms).
#   - TrayIcon.id uses T.TrayIconId (was raw Text).
#   - activateTrayIcon uses T.TrayIconId (was raw Text).
#   - nightLight temperature documented as Mirek (1000000/K).
#   - timeRemaining uses T.Duration (was raw UInt32 seconds).
#   - shutdownImminent uses T.Duration (was raw UInt32 seconds).
#   - All enums have custom/other variants for forward compatibility.
#   - ShellEventStream already has cancel method.
#   - notificationImageData uses T.DataHandle for large payloads.
#   - PickedFile.path uses T.FilePath (was raw Text).
#   - saveFilePicker returns T.FilePath (was raw Text).
#   - ShellSettingValue union has custom variant for forward compat.
#   - Paginated list methods added for launcher, notifications, clipboard.
#   - BluetoothDevice.address uses T.BluetoothAddress (was raw Text).
#   - SearchResult.icon uses T.DataHandle (was raw Text).
#   - ShellEventStream.next renamed to pull (canonical subscription pattern).
# ══════════════════════════════════════════════════════════════════════

interface Session {

    struct HandshakeRequest {
        applicationId @0 :T.AppId;
        version       @1 :T.Version;
        capabilities  @2 :List(ShellCapability);
        metadata      @3 :List(T.Meta);
    }

    struct HandshakeResponse {
        sessionId @0 :T.SessionId;
        shell     @1 :ShellInfo;
        granted   @2 :List(ShellCapability);
        denied    @3 :List(ShellCapability);
        result    @4 :HandshakeResult;
    }

    enum HandshakeResult {
        accepted         @0;
        acceptedDegraded @1;
        rejected         @2;
        custom           @3;
    }

    struct ShellInfo {
        name         @0 :Text;
        version      @1 :T.Version;
        capabilities @2 :List(ShellCapability);
        metadata     @3 :List(T.Meta);
    }

    handshake @0 (request :HandshakeRequest)
               -> (response :HandshakeResponse);

    # -- Launcher --

    listApps    @1  (filter :ApplicationFilter)
                 -> (apps :List(ApplicationEntry));
    findApps    @2  (query :Text)
                 -> (apps :List(ApplicationEntry));
    startApp    @3  (applicationId :T.AppId, arguments :List(Text))
                 -> (result :T.VoidResult);
    stopApp     @4  (applicationId :T.AppId)
                 -> (result :T.VoidResult);

    # -- Notifications --

    listNotifications       @5  () -> (notifications :List(Notification));
    dismissNotification     @6  (id :T.NotificationId)
                              -> (result :T.VoidResult);
    dismissAllNotifications @7  () -> (result :T.VoidResult);
    invokeNotification      @8  (id :T.NotificationId, actionKey :Text)
                              -> (result :T.VoidResult);
    getDoNotDisturb         @9  () -> (enabled :Bool);
    setDoNotDisturb         @10 (enabled :Bool) -> (result :T.VoidResult);
    snoozeNotification      @11 (id :T.NotificationId, duration :T.Duration)
                              -> (result :T.VoidResult);
    sendNotification        @12 (notification :Notification)
                              -> (id :T.NotificationId);

    # -- Clipboard --

    getClipboard        @13 () -> (entry :ClipboardEntry);
    getClipboardHistory @14 (limit :UInt32) -> (entries :List(ClipboardEntry));
    setClipboard        @15 (entry :ClipboardEntry) -> (result :T.VoidResult);
    clearClipboard      @16 () -> (result :T.VoidResult);
    pinClipboard        @17 (id :T.ClipboardId) -> (result :T.VoidResult);
    unpinClipboard      @18 (id :T.ClipboardId) -> (result :T.VoidResult);
    deleteClipboard     @19 (id :T.ClipboardId) -> (result :T.VoidResult);

    # -- System Tray --

    listTrayIcons       @20 () -> (icons :List(TrayIcon));
    activateTrayIcon    @21 (id :T.TrayIconId) -> (result :T.VoidResult);

    # -- System State --

    getAudioState       @22 () -> (state :AudioState);
    setAudioVolume      @23 (sink :Text, level :UInt8) -> (result :T.VoidResult);
    setAudioMute        @24 (sink :Text, muted :Bool) -> (result :T.VoidResult);
    getNetworkState     @25 () -> (state :NetworkState);
    getPowerState       @26 () -> (state :PowerState);
    setPowerProfile     @27 (profile :PowerProfile) -> (result :T.VoidResult);
    getBluetoothState   @28 () -> (state :BluetoothState);
    setBluetoothEnabled @29 (enabled :Bool) -> (result :T.VoidResult);

    # -- Display --

    getBrightness       @30 () -> (level :UInt8);
    setBrightness       @31 (level :UInt8) -> (result :T.VoidResult);
    # Night light temperature in Mirek (1000000 / color_temperature_kelvin).
    # Lower values = warmer (more orange), higher = cooler (more blue).
    getNightLight       @32 () -> (active :Bool, temperatureMirek :UInt16);
    setNightLight       @33 (active :Bool, temperatureMirek :UInt16)
                          -> (result :T.VoidResult);

    # -- Search --

    search              @34 (query :Text, maxResults :UInt32)
                          -> (results :List(SearchResult));

    # -- Session Management --

    logoutSession       @35 () -> (result :T.VoidResult);
    shutdownSession     @36 () -> (result :T.VoidResult);
    rebootSession       @37 () -> (result :T.VoidResult);
    suspendSession      @38 () -> (result :T.VoidResult);
    hibernateSession    @39 () -> (result :T.VoidResult);
    lockSession         @40 () -> (result :T.VoidResult);
    canShutdownSession  @41 () -> (can :Bool);
    canRebootSession    @42 () -> (can :Bool);
    canSuspendSession   @43 () -> (can :Bool);
    inhibitSleep        @44 (reason :Text) -> (handle :T.InhibitHandle);
    uninhibitSleep      @45 (handle :T.InhibitHandle) -> (result :T.VoidResult);

    # -- Portals --

    openFilePicker      @46 (filter :FilePickerFilter, allowMultiple :Bool)
                          -> (files :List(PickedFile));
    saveFilePicker      @47 (suggestedName :Text, filter :FilePickerFilter)
                          -> (path :T.FilePath);
    openColorPicker     @48 (initialColor :T.Color) -> (color :T.Color);
    openUri             @49 (uri :Text) -> (result :T.VoidResult);

    # -- Settings --

    getSetting          @50 (key :Text) -> (value :ShellSettingValue);
    setSetting          @51 (key :Text, value :ShellSettingValue) -> (result :T.VoidResult);
    listSettings        @52 (filter :SettingFilter) -> (settings :List(ShellSetting));

    # -- Events --

    subscribe           @53 (filter :ShellEventFilter)
                          -> (stream :ShellEventStream);

    # -- Query --

    query               @54 (query :ShellQuery) -> (result :ShellQueryResult);

    # -- Paginated Launcher --

    listAppsPaginated   @55 (filter :ApplicationFilter, pagination :T.Pagination)
                          -> (apps :List(ApplicationEntry), total :UInt64);
    findAppsPaginated   @56 (query :Text, pagination :T.Pagination)
                          -> (apps :List(ApplicationEntry), total :UInt64);

    # -- Paginated Notifications --

    listNotificationsPaginated @57 (pagination :T.Pagination)
                          -> (notifications :List(Notification), total :UInt64);

    # -- Paginated Clipboard History --

    getClipboardHistoryPaginated @58 (pagination :T.Pagination)
                          -> (entries :List(ClipboardEntry), total :UInt64);

    # -- Paginated Tray --

    listTrayIconsPaginated @59 (pagination :T.Pagination)
                          -> (icons :List(TrayIcon), total :UInt64);

    # -- Paginated Search --

    searchPaginated @60 (query :Text, pagination :T.Pagination)
                          -> (results :List(SearchResult), total :UInt64);

    # -- Paginated Settings --

    listSettingsPaginated @61 (filter :SettingFilter, pagination :T.Pagination)
                          -> (settings :List(ShellSetting), total :UInt64);

    # ─── Multi-Modal Session ───────────────────────────────────

    # Get current session mode.
    getSessionMode @62 () -> (mode :ShellSessionMode);

    # Set session mode (text, voice, gesture, multiModal, brief).
    setSessionMode @63 (mode :ShellSessionMode) -> (result :T.VoidResult);

    # ─── AI-First Completion ───────────────────────────────────

    # Get AI-powered semantic completions.
    getAiCompletion @64 (request :AiCompletionRequest) -> (results :List(AiCompletionResult));

    # ─── Cross-Device Handoff ──────────────────────────────────

    # Handoff shell state to another device.
    handoff @65 (request :HandoffRequest) -> (result :HandoffResult);

    # ─── Voice Shell ───────────────────────────────────────────

    # Process a spoken command (screenless devices).
    processVoiceCommand @66 (audio :T.DataHandle, language :T.Language) -> (result :VoiceShellResult);

    # Stream intermediate voice results.
    processVoiceCommandStream @67 (audio :T.DataHandle, language :T.Language) -> (stream :VoiceShellResultStream);

    # Subscribe to wake word detection.
    subscribeWakeWord @68 () -> (subscription :WakeWordSubscription);

    # ─── Gesture Navigation ────────────────────────────────────

    # Process a gesture command (AR/VR/watch/car).
    processGesture @69 (event :GestureEvent) -> (result :ShellAction);

    # ─── Brief Mode ────────────────────────────────────────────

    # Execute a command in brief mode (returns description, not stream).
    executeBrief @70 (command :Text) -> (result :BriefResult);

    # ─── Accessibility ─────────────────────────────────────────

    # Get current accessibility mode.
    getAccessibilityMode @71 () -> (mode :AccessibilityMode);

    # Set accessibility mode.
    setAccessibilityMode @72 (mode :AccessibilityMode) -> (result :T.VoidResult);

    # ─── Context Bubbles ───────────────────────────────────────

    # Show a context bubble (hover tooltip, quick action).
    showContextBubble @73 (bubble :ContextBubble) -> T.VoidResult;

    # Dismiss a context bubble.
    dismissContextBubble @74 (bubbleId :Text) -> T.VoidResult;

    # ─── Batch Event Pull ──────────────────────────────────────

    # Pull multiple events at once (reduces IPC overhead).
    pullBatch @75 (stream :ShellEventStream, maxEvents :UInt32) -> (events :List(ShellEvent));
}

# ══════════════════════════════════════════════════════════════════════
# SHELL SERVICE — the command interpreter surface
#
# The second interface in this file, and deliberately separate from Session
# above. See the file header for why these are two interfaces rather than one
# and one of them redundant.
#
# Where Session aggregates desktop state, this executes input. The split is
# by audience: a compositor calls Session, a REPL (or a script runner, or a
# voice pipeline) calls ShellService.
#
# Ordinals are fresh (@0–@50, from progress/batch-001.md:34). Nothing is
# renumbered and nothing is deprecated: Session's existing surface is intact.
# ══════════════════════════════════════════════════════════════════════

interface ShellService {
    # Get current interpreter state.
    getState @0 () -> (state :ShellState);

    # Start a new shell session.
    start @1 (config :ShellConfig) -> (session :ShellSession);

    # End the current shell session.
    end @2 (sessionId :UInt64) -> T.VoidResult;

    # Execute a command (from interactive or script mode).
    execute @3 (input :CommandInput) -> (result :ShellCommandResult);

    # Execute a natural language request (AI-assisted interpretation).
    interpret @4 (request :NaturalLanguageRequest) -> (interpreted :InterpretedCommand);

    # Confirm and execute an interpreted command.
    confirmAndExecute @5 (interpreted :InterpretedCommand, confirm :Bool) -> (result :ShellCommandResult);

    # ── Completion ──────────────────────────────────────────────────────

    # Get completions for partial input.
    complete @6 (input :Text, cursorPosition :UInt32) -> (completions :List(Completion));

    # Get completions for a selector path.
    completeSelector @7 (selector :Text) -> (completions :List(SelectorCompletion));

    # Get completions for a specific domain.
    completeDomain @8 (domain :Text, partial :Text) -> (completions :List(DomainCompletion));

    # ── History ─────────────────────────────────────────────────────────
    #
    # Distinct from Session's shell-side analytics types (CommandHistoryEntry
    # at the bottom of this file), which answer "which commands do I use
    # most often" — an analytics question. These answer "what did I run, in
    # what order, and what happened", which is a history question and needs
    # per-invocation detail the analytics type deliberately drops.

    getHistory @9 (filter :HistoryFilter, pagination :T.Pagination)
               -> (entries :List(HistoryEntry), totalCount :UInt32);

    searchHistory @10 (pattern :Text, pagination :T.Pagination)
                  -> (entries :List(HistoryEntry), totalCount :UInt32);

    clearHistory @11 () -> T.VoidResult;

    pinHistoryEntry @12 (entryId :UInt64) -> T.VoidResult;

    # ── Aliases ─────────────────────────────────────────────────────────
    # cli.capnp has CommandAlias for the same concept. This is the SHELL's
    # own alias table (set/remove at runtime, with a use count); cli.capnp's
    # is the execution service's read view of aliases. Overlapping names,
    # different owners — see the note on HistoryEntry above.

    setAlias @13 (name :Text, expansion :Text) -> T.VoidResult;
    removeAlias @14 (name :Text) -> T.VoidResult;
    listAliases @15 () -> (aliases :List(Alias));

    # ── Variables ───────────────────────────────────────────────────────

    setVariable @16 (name :Text, value :Text) -> T.VoidResult;
    # Returns `exists` rather than an error for an unset variable, for the
    # same reason discovery.resolve does: "not set" is an answer, not a fault.
    getVariable @17 (name :Text) -> (value :Text, exists :Bool);
    listVariables @18 () -> (variables :List(ShellVariable));

    # ── Environment ─────────────────────────────────────────────────────
    # Same `exists` convention as getVariable.

    getEnv @19 (name :Text) -> (value :Text, exists :Bool);
    setEnv @20 (name :Text, value :Text) -> T.VoidResult;
    listEnv @21 () -> (env :List(EnvVariable));

    # ── Jobs ────────────────────────────────────────────────────────────

    listJobs @22 () -> (jobs :List(Job));
    fg @23 (jobId :UInt32) -> T.VoidResult;
    bg @24 (jobId :UInt32) -> T.VoidResult;
    cancelJob @25 (jobId :UInt32) -> T.VoidResult;
    waitForJob @26 (jobId :UInt32, timeout :T.Duration) -> (result :ShellCommandResult);

    # ── Undo ────────────────────────────────────────────────────────────

    undo @27 () -> (result :UndoResult);
    redo @28 () -> (result :UndoResult);
    getUndoStack @29 () -> (stack :List(UndoEntry));

    # ── Prompts ─────────────────────────────────────────────────────────
    #
    # Reuses Session's existing getSetting/setSetting (@50/@51) rather than
    # duplicating it. A prompt is a setting; having both getPrompt and
    # getSetting("prompt") means two answers to one question, and only one of
    # them will be current. ShellConfig.prompt (@3) is the session-start
    # value for that same setting.
    #
    # DELIBERATELY ABSENT: the design's getPrompt @30 / setPrompt @31.
    # Cap'n Proto requires sequential ordinals, so omitting them shifts every
    # later method down by two rather than leaving a hole. The mapping is:
    #   design @30 getPrompt     — omitted, see above
    #   design @31 setPrompt     — omitted, see above
    #   design @32 runScript    — here @30
    #   ... through design @46 isUndoable — here @44
    #   design @47-@50 snapshots — omitted, see below
    # So this interface runs @0–@44 where the design ran @0–@50. The six
    # missing methods are named at their design ordinals so a reader holding
    # the design can find them.

    # ── Script Mode ─────────────────────────────────────────────────────

    runScript @30 (path :Text, args :List(Text)) -> (result :ShellCommandResult);
    validateScript @31 (path :Text) -> (errors :List(ScriptError));
    getScriptContext @32 () -> (context :ScriptContext);

    # ── Watchers ────────────────────────────────────────────────────────

    listWatchers @33 () -> (watchers :List(WatcherInfo));
    cancelWatcher @34 (watcherId :UInt64) -> T.VoidResult;

    # ── Bookmarks ───────────────────────────────────────────────────────

    bookmark @35 (command :Text, label :Text) -> T.VoidResult;
    listBookmarks @36 () -> (bookmarks :List(Bookmark));
    runBookmark @37 (bookmarkId :UInt64) -> (result :ShellCommandResult);
    removeBookmark @38 (bookmarkId :UInt64) -> T.VoidResult;

    # ── Guided Mode (for non-technical users) ───────────────────────────

    enterGuidedMode @39 (domain :Text) -> (guide :GuidedSession);
    guideNext @40 (sessionId :UInt64) -> (step :GuidedStep);
    guideInput @41 (sessionId :UInt64, input :Text) -> (result :GuidedStepResult);
    exitGuidedMode @42 (sessionId :UInt64) -> T.VoidResult;

    # ── Undoable Operations Registry ────────────────────────────────────

    registerUndoable @43 (operation :UndoableOperation) -> T.VoidResult;
    isUndoable @44 (command :Text) -> (undoable :Bool, description :Text);

    # ── Session Snapshots — NOT LANDED ──────────────────────────────────
    #
    # The design's @47 saveSnapshot, @48 restoreSnapshot, @49 listSnapshots,
    # @50 deleteSnapshot are omitted, and this is a decision rather than an
    # oversight: Session already has ShellSessionState (further down this
    # file) and nothing in this repo saves or restores shell state. Landing
    # four methods that persist nothing would be four methods that always
    # return an empty list — the schema equivalent of a hardcoded string.
    # They belong with the storage that backs them.
    #
    # When they land, they should be snapshots of LOCAL interpreter state
    # (variables, aliases, cwd, env) — distinct from Session's
    # ShellSessionState, which is a cross-device handoff (apps, windows,
    # workspaces). Different contents, different lifetime, same word.
}

# ══════════════════════════════════════════════════════════════════════
# INTERPRETER STATE AND CONFIGURATION
# ══════════════════════════════════════════════════════════════════════

# Execution mode. NOT the same axis as ShellSessionMode (input modality) —
# see the file header.
enum ShellMode {
    interactive @0;      # Normal interactive mode
    guided @1;           # Guided mode for non-technical users
    script @2;           # Script execution mode
    batch @3;            # Non-interactive batch mode
    remote @4;           # Remote shell session
    voice @5;            # Voice interface mode
    minimal @6;          # Minimal mode (low resources)
    custom @7;
}

struct ShellState {
    sessionId @0 :UInt64;
    mode @1 :ShellMode;
    # Absolute path of the working directory. Always absolute, never "~/x" —
    # the shell resolves the tilde, and reporting the unresolved form would
    # make a client display a path that does not exist.
    currentDirectory @2 :T.FilePath;
    # Exit status of the last command. T.ExitStatus, not a raw Int32:
    # cli.capnp:169 already rejected raw exit codes and this schema does not
    # reintroduce them through the back door.
    lastExitStatus @3 :T.ExitStatus;
    lastCommand @4 :Text;
    activeJobs @5 :UInt32;
    activeWatchers @6 :UInt32;
    uptime @7 :T.Duration;
    commandCount @8 :UInt64;
    undoStackSize @9 :UInt32;
    # User this session runs as. T.UserId, not Text — the untyped version
    # invited callers to pass a username where a numeric id was expected.
    userId @10 :T.UserId;
    aiAssistEnabled @11 :Bool;
    theme @12 :ShellTheme;
}

struct ShellConfig {
    mode @0 :ShellMode;
    theme @1 :ShellTheme;
    historySize @2 :UInt32;
    # Initial prompt configuration. At runtime the prompt is a shell setting
    # and is read/written through Session.getSetting/setSetting (@50/@51).
    prompt @3 :PromptConfig;
    aiAssistEnabled @4 :Bool;
    # Ask confirmation for destructive operations.
    confirmDestructive @5 :Bool;
    autoCorrect @6 :Bool;              # Suggest corrections for typos
    smartSuggestions @7 :Bool;         # Context-aware suggestions
    verboseErrors @8 :Bool;            # Detailed error messages
    colorOutput @9 :Bool;              # Colored output
    compactMode @10 :Bool;             # Compact output for small terminals
    # Maximum undo levels (0 = unlimited).
    maxUndoLevels @11 :UInt32;
    keybindings @12 :KeyBindingProfile;
    defaultFormat @13 :OutputFormat;
}

struct ShellSession {
    sessionId @0 :UInt64;
    config @1 :ShellConfig;
    startedAt @2 :T.Timestamp;
    # Capabilities the session was actually granted, after handshake
    # attenuation. NOT what the shell supports — a session that was refused
    # clipboard still runs, and claiming otherwise is the same
    # supported-vs-granted confusion system.capnp's SystemCapability warns
    # about.
    granted @3 :List(ShellCapability);
    # Capabilities the handshake refused, with the reason. Populated
    # alongside `granted`; empty means nothing was refused.
    denied @4 :List(ShellCapability);
}

# ══════════════════════════════════════════════════════════════════════
# EXECUTION
# ══════════════════════════════════════════════════════════════════════

struct CommandInput {
    text @0 :Text;
    # Whether this came from an interactive session (affects confirmation
    # prompts and history recording, not execution).
    interactive @1 :Bool;
    # Suppress confirmation prompts. A script setting, not a caller override.
    force @2 :Bool;
    format @3 :OutputFormat;
    # Piped stdin for this command.
    pipeInput @4 :Data;
    # Zero duration means no timeout. A caller wanting "never time out" and a
    # caller who forgot to set it are indistinguishable here, which is why
    # this is spelled out rather than left to convention.
    timeout @5 :T.Duration;
}

# Named ShellCommandResult, not CommandResult: cli.capnp already owns
# CommandResult for the execution service. Two types, one name, different
# owners is how a client ends up reading the wrong one.
struct ShellCommandResult {
    # Structured exit status. Not a raw Int32 — see ShellState.lastExitStatus.
    exitStatus @0 :T.ExitStatus;
    # Human-readable output.
    output @1 :Text;
    # Structured data output, in the format `format` named. Empty when the
    # command produced no structured output — which is most of them.
    data @2 :Data;
    # Error message, populated when exitStatus is a failure.
    error @3 :Text;
    # Suggested fix, when the shell has one. Empty means it does not; a
    # generic "try --help" here would be noise on every failure.
    suggestion @4 :Text;
    duration @5 :T.Duration;
    # Whether this command can be undone.
    undoable @6 :Bool;
    # The command that reverses it. Empty when `undoable` is false.
    undoCommand @7 :Text;
    # Non-fatal warnings.
    warnings @8 :List(Text);
    # Output was truncated to fit. Always paired with totalItems so a client
    # can say "showing 100 of 4000" instead of silently showing a prefix.
    truncated @9 :Bool;
    totalItems @10 :UInt32;
}

# ── Natural language ──────────────────────────────────────────────────

struct NaturalLanguageRequest {
    text @0 :Text;
    context @1 :InterpretContext;
    # Execute without asking when confidence is at or above
    # confidenceThreshold. Both false and a zero threshold must be handled:
    # zero here means "never auto-execute", not "no threshold".
    autoExecute @2 :Bool;
    confidenceThreshold @3 :Float32;
}

struct InterpretContext {
    currentDirectory @0 :T.FilePath;
    recentCommands @1 :List(Text);
    # What the user is currently working with.
    currentDomain @2 :Text;
    availableApps @3 :List(T.AppId);
    # Brief system-state summary for the interpreter's benefit.
    systemState @4 :Text;
}

struct InterpretedCommand {
    commands @0 :List(Text);
    # Confidence in [0,1]. This is the interpreter's own estimate and is
    # explicitly not a probability; a client must not present it as one.
    confidence @1 :Float32;
    # What will happen, in words.
    explanation @2 :Text;
    destructive @3 :Bool;
    domains @4 :List(Text);
    requiresConfirmation @5 :Bool;
    # Alternatives offered when confidence is low. Empty is meaningful: the
    # interpreter had exactly one reading.
    alternatives @6 :List(InterpretedCommand);
    # How to reverse this, when it is reversible. Empty when it is not.
    undoDescription @7 :Text;
}

# ── Completion ────────────────────────────────────────────────────────

struct Completion {
    text @0 :Text;
    description @1 :Text;
    kind @2 :CompletionKind;
    # Whether this completion takes a value after it.
    requiresValue @3 :Bool;
    valueExample @4 :Text;
    # Relevance for sorting. Higher sorts first; the shell decides the scale,
    # so only relative order is meaningful.
    relevance @5 :Float32;
}

enum CompletionKind {
    command @0;
    domain @1;
    action @2;
    selector @3;
    file @4;
    directory @5;
    app @6;
    service @7;
    process @8;
    window @9;
    device @10;
    value @11;
    flag @12;
    alias @13;
    variable @14;
    keyword @15;
    naturalLanguage @16;
    custom @17;
}

struct SelectorCompletion {
    path @0 :Text;
    # Current value, when readable. `currentValueValid` false means the
    # selector exists but could not be read — different from "it is empty",
    # which is a real value a client should show.
    currentValue @1 :Text;
    currentValueValid @2 :Bool;
    valueType @3 :Text;
    description @4 :Text;
}

struct DomainCompletion {
    command @0 :Text;
    description @1 :Text;
    syntax @2 :Text;
    examples @3 :List(Text);
}

# ── History ───────────────────────────────────────────────────────────
#
# Per-invocation history. See the note on ShellService.getHistory for how this
# differs from the analytics types at the bottom of this file.

struct HistoryEntry {
    id @0 :UInt64;
    command @1 :Text;
    timestamp @2 :T.Timestamp;
    exitStatus @3 :T.ExitStatus;
    duration @4 :T.Duration;
    directory @5 :T.FilePath;
    pinned @6 :Bool;
    tags @7 :List(Text);
}

struct HistoryFilter {
    # Substring match. Empty matches everything — stated because a caller
    # passing "" and a caller forgetting the field are otherwise
    # indistinguishable.
    pattern @0 :Text;
    # Exit status to filter by. `filterByStatus` false means "any status",
    # which is why this is not a magic sentinel value.
    exitStatus @1 :T.ExitStatus;
    filterByStatus @2 :Bool;
    directory @3 :T.FilePath;
    since @4 :T.Timestamp;
    tags @5 :List(Text);
    pinnedOnly @6 :Bool;
}

# ── Aliases, variables, environment ───────────────────────────────────

struct Alias {
    name @0 :Text;
    expansion @1 :Text;
    useCount @2 :UInt64;
    createdAt @3 :T.Timestamp;
}

struct ShellVariable {
    name @0 :Text;
    value @1 :Text;
    exported @2 :Bool;
    readOnly @3 :Bool;
    # Where this value came from: "user", "script", "default", or a specific
    # file path. Free text because it names sources this schema does not
    # enumerate, and an enum here would be a second authority on a concept
    # (setting provenance) that session.capnp's SettingSource already owns.
    source @4 :Text;
}

struct EnvVariable {
    name @0 :Text;
    value @1 :Text;
    # "system", "shell", or an application name.
    source @2 :Text;
}

# ── Jobs ──────────────────────────────────────────────────────────────

struct Job {
    id @0 :UInt32;
    command @1 :Text;
    # The process behind this job. A shell-internal job has no process, so
    # `pidValid` is false and `pid` is meaningless — a shell that can run a
    # job without a pid cannot invent one.
    pid @2 :T.ProcessId;
    pidValid @6 :Bool;
    state @3 :JobState;
    startedAt @4 :T.Timestamp;
    hasOutput @5 :Bool;
    # Last N lines. Empty with hasOutput true means output exists but no
    # preview was captured, which is different from "no output".
    outputPreview @7 :Text;
}

enum JobState {
    running @0;
    # Suspended (SIGTSTP or equivalent) — still exists, not running.
    stopped @1;
    completed @2;
    failed @3;
    cancelled @4;
    custom @5;
}

# ── Undo ──────────────────────────────────────────────────────────────

struct UndoResult {
    success @0 :Bool;
    # What was undone or redone.
    description @1 :Text;
    # The command that was undone.
    command @2 :Text;
    # Why it failed. Populated when success is false.
    error @3 :Text;
}

struct UndoEntry {
    id @0 :UInt64;
    command @1 :Text;
    description @2 :Text;
    timestamp @3 :T.Timestamp;
    domain @4 :Text;
    # Whether this can be undone. An entry that reached the undo stack but is
    # not reversible is normal — `undo` skips it and says so.
    undoable @5 :Bool;
    reverseCommand @6 :Text;
}

struct UndoableOperation {
    command @0 :Text;
    description @1 :Text;
    domain @2 :Text;
    undoCommand @3 :Text;
    # Some operations are only reversible within a window.
    expiresAt @4 :T.Timestamp;
}

# ── Watchers, bookmarks, scripts ──────────────────────────────────────

struct WatcherInfo {
    id @0 :UInt64;
    domain @1 :Text;
    command @2 :Text;
    startedAt @3 :T.Timestamp;
    eventCount @4 :UInt64;
    lastEvent @5 :T.Timestamp;
    # Whether the watcher has already expired by its own condition. Distinct
    # from cancelled, which means something stopped it deliberately.
    expired @6 :Bool;
}

struct Bookmark {
    id @0 :UInt64;
    label @1 :Text;
    command @2 :Text;
    createdAt @3 :T.Timestamp;
    useCount @4 :UInt64;
    tags @5 :List(Text);
}

struct ScriptError {
    line @0 :UInt32;
    column @1 :UInt32;
    message @2 :Text;
    severity @3 :ScriptSeverity;
}

enum ScriptSeverity {
    error @0;
    warning @1;
    info @2;
    hint @3;
    custom @4;
}

struct ScriptContext {
    path @0 :T.FilePath;
    line @1 :UInt32;
    variables @2 :List(ShellVariable);
    # Nested script call stack, innermost last.
    callStack @3 :List(T.FilePath);
}

# ── Theme ──────────────────────────────────────────────────────────────
#
# shell.capnp already defines ShellThemingPipeline and ThemeSource further
# down for the SESSION's theme handling. These describe the interpreter's own
# output styling — a narrower thing, and deliberately so.

struct ShellTheme {
    name @0 :Text;
    accent @1 :Text;
    successColor @2 :Text;
    errorColor @3 :Text;
    warningColor @4 :Text;
    infoColor @5 :Text;
    mutedColor @6 :Text;
    unicode @7 :Bool;
    emoji @8 :Bool;
    tableStyle @9 :TableStyle;
}

enum TableStyle {
    rounded @0;
    sharp @1;
    double @2;
    ascii @3;
    minimal @4;
    custom @5;
}

enum OutputFormat {
    human @0;          # Formatted for a person (default)
    json @1;
    tsv @2;
    capnp @3;           # Raw capnp binary
    raw @4;             # Raw text, for piping to legacy tools
    minimal @5;         # Values only
    custom @6;
}

enum KeyBindingProfile {
    emacs @0;
    vi @1;
    custom @2;
}

# ── Prompt (session-start value only; see ShellService's note) ─────────

struct PromptConfig {
    # Template with ${user}, ${hostname}, ${cwd}, ${git_branch},
    # ${exit_code}, ${battery}, ${time}, ${job_count}, ${depth}.
    template @0 :Text;
    rightTemplate @1 :Text;
    # Prompt character. Empty means "the shell's default", NOT "no prompt" —
    # a shell that shows nothing is a distinct state and needs its own value.
    char @2 :Text;
    errorChar @3 :Text;
    showGit @4 :Bool;
    showBattery @5 :Bool;
    showTime @6 :Bool;
    showJobs @7 :Bool;
    showDuration @8 :Bool;
    # Minimum duration before the prompt shows one. Seconds as Float32, as
    # designed; note this is a Float where ShellState.uptime is a
    # T.Duration, because the value is a UI threshold rather than an interval
    # the shell measures.
    durationThreshold @9 :Float32;
    # Multi-line prompt; each entry is one template.
    lines @10 :List(Text);
}

# ── Guided mode ───────────────────────────────────────────────────────

struct GuidedSession {
    sessionId @0 :UInt64;
    domain @1 :Text;
    description @2 :Text;
    totalSteps @3 :UInt32;
    currentStep @4 :UInt32;
}

struct GuidedStep {
    stepNumber @0 :UInt32;
    title @1 :Text;
    description @2 :Text;
    inputType @3 :GuidedInputType;
    options @4 :List(GuidedOption);
    example @5 :Text;
    optional @6 :Bool;
    defaultValue @7 :Text;
    # Validation pattern, when this step validates its input. Empty means the
    # step accepts anything.
    validation @8 :Text;
}

enum GuidedInputType {
    text @0;
    number @1;
    boolean @2;
    choice @3;
    file @4;
    color @5;
    confirm @6;
    custom @7;
}

struct GuidedOption {
    value @0 :Text;
    label @1 :Text;
    description @2 :Text;
    recommended @3 :Bool;
}

struct GuidedStepResult {
    continue @0 :Bool;
    step @1 :GuidedStep;
    # The command built from every input so far.
    previewCommand @2 :Text;
    # Progress in [0,1].
    progress @3 :Float32;
    finalStep @4 :Bool;
}

# ══════════════════════════════════════════════════════════════════════
# APP REGISTRY
# ══════════════════════════════════════════════════════════════════════

struct ApplicationEntry {
    applicationId @0  :T.AppId;
    name          @1  :Text;
    description   @2  :Text;
    icon          @3  :T.DataHandle;
    category      @4  :ApplicationCategory;
    keywords      @5  :List(Text);
    executable    @6  :Text;
    terminal      @7  :Bool;
    running       @8  :Bool;
    processIds    @9  :List(T.ProcessId);
    windowIds     @10 :List(T.WindowId);
    favorite      @11 :Bool;
    lastLaunched  @12 :T.Timestamp;
    desktopFile   @13 :Text;
    metadata      @14 :List(T.Meta);
}

enum ApplicationCategory {
    utility      @0;
    development  @1;
    office       @2;
    graphics     @3;
    audioVideo   @4;
    network      @5;
    system       @6;
    game         @7;
    other        @8;
    custom       @9;
}

struct ApplicationFilter {
    category @0 :ApplicationCategory;
    running  @1 :T.BoolFilter;
    favorite @2 :T.BoolFilter;
}

# ══════════════════════════════════════════════════════════════════════
# NOTIFICATIONS
# ══════════════════════════════════════════════════════════════════════

struct Notification {
    id             @0  :T.NotificationId;
    applicationName @1  :Text;
    applicationIcon @2  :T.DataHandle;
    summary        @3  :Text;
    body           @4  :Text;
    urgency        @5  :Urgency;
    timestamp      @6  :T.Timestamp;
    category       @7  :Text;
    transient      @8  :Bool;
    imageData      @9  :T.DataHandle;
    actions        @10 :List(NotificationAction);
    dismissable    @11 :Bool;
}

struct NotificationAction {
    key   @0 :Text;
    label @1 :Text;
}

enum Urgency {
    low      @0;
    normal   @1;
    critical @2;
    custom   @3;
}

# ══════════════════════════════════════════════════════════════════════
# CLIPBOARD
# ══════════════════════════════════════════════════════════════════════

struct ClipboardEntry {
    id              @0 :T.ClipboardId;
    contentType     @1 :ClipboardContentType;
    text            @2 :Text;
    imageData       @3 :T.DataHandle;
    richText        @4 :T.DataHandle;
    binary          @5 :T.DataHandle;
    mimeType        @6 :Text;
    uriList         @7 :List(Text);
    sourceApplication @8 :Text;
    timestamp       @9 :T.Timestamp;
    pinned          @10 :Bool;
}

enum ClipboardContentType {
    text     @0;
    uri      @1;
    uriList  @2;
    image    @3;
    richText @4;
    binary   @5;
    empty    @6;
    custom   @7;
}

# ══════════════════════════════════════════════════════════════════════
# SYSTEM TRAY
# ══════════════════════════════════════════════════════════════════════

struct TrayIcon {
    id      @0 :T.TrayIconId;
    title   @1 :Text;
    iconName @2 :Text;
    status  @3 :TrayStatus;
    tooltip @4 :Text;
    menu    @5 :List(TrayMenuItem);
}

enum TrayStatus {
    active         @0;
    passive        @1;
    needsAttention @2;
    custom         @3;
}

struct TrayMenuItem {
    key      @0 :Text;
    label    @1 :Text;
    icon     @2 :Text;
    enabled  @3 :Bool;
    toggle   @4 :Bool;
    checked  @5 :Bool;
    children @6 :List(TrayMenuItem);
}

# ══════════════════════════════════════════════════════════════════════
# SYSTEM STATE
# ══════════════════════════════════════════════════════════════════════

struct AudioState {
    sinks   @0 :List(AudioSink);
    sources @1 :List(AudioSource);
}

struct AudioSink {
    name   @0 :Text;
    # Volume level 0-100.
    volume @1 :UInt8;
    muted  @2 :Bool;
    icon   @3 :Text;
}

struct AudioSource {
    name   @0 :Text;
    # Volume level 0-100.
    volume @1 :UInt8;
    muted  @2 :Bool;
    icon   @3 :Text;
}

struct NetworkState {
    connected @0 :Bool;
    type      @1 :NetworkType;
    ssid      @2 :Text;
    # Signal strength 0-100.
    signal    @3 :UInt8;
    ipAddress @4 :Text;
}

enum NetworkType {
    none     @0;
    wifi     @1;
    ethernet @2;
    cellular @3;
    vpn      @4;
    custom   @5;
}

# PowerState imported from power.capnp (canonical source).
# Use import "power.capnp".PowerState directly.

enum PowerProfile {
    performance @0;
    balanced    @1;
    powerSaver  @2;
    custom      @3;
}

struct BluetoothState {
    enabled @0 :Bool;
    devices @1 :List(BluetoothDevice);
}

struct BluetoothDevice {
    address   @0 :T.BluetoothAddress;
    name      @1 :Text;
    connected @2 :Bool;
    type      @3 :BluetoothDeviceType;
    # Battery level 0-100.
    battery   @4 :UInt8;
    paired    @5 :Bool;
}

enum BluetoothDeviceType {
    unknown    @0;
    headphones @1;
    headset    @2;
    keyboard   @3;
    mouse      @4;
    controller @5;
    phone      @6;
    other      @7;
    custom     @8;
}

# ══════════════════════════════════════════════════════════════════════
# SEARCH
# ══════════════════════════════════════════════════════════════════════

struct SearchResult {
    name        @0 :Text;
    description @1 :Text;
    icon        @2 :T.DataHandle;
    kind        @3 :SearchResultKind;
    action      @4 :Text;
    score       @5 :Float32;
}

enum SearchResultKind {
    app     @0;
    file    @1;
    setting @2;
    contact @3;
    action  @4;
    other   @5;
    custom  @6;
}

# ══════════════════════════════════════════════════════════════════════
# PORTALS
# ══════════════════════════════════════════════════════════════════════

struct FilePickerFilter {
    name       @0 :Text;
    extensions @1 :List(Text);
    mimeTypes  @2 :List(Text);
}

struct PickedFile {
    path     @0 :T.FilePath;
    name     @1 :Text;
    mimeType @2 :Text;
    size     @3 :UInt64;
}

# ══════════════════════════════════════════════════════════════════════
# SETTINGS (Shell-local subset — canonical settings are in settings.capnp)
# ══════════════════════════════════════════════════════════════════════

struct ShellSettingValue {
    union {
        text    @0 :Text;
        integer @1 :Int64;
        real    @2 :Float64;
        boolean @3 :Bool;
        custom  @4 :Data;
    }
}

struct ShellSetting {
    key      @0 :Text;
    value    @1 :ShellSettingValue;
    source   @2 :SettingSource;
    metadata @3 :List(T.Meta);
}

enum SettingSource {
    system      @0;
    user        @1;
    application @2;
    systemDefault @3;
    custom      @4;
}

struct SettingFilter {
    source @0 :SettingSource;
    prefix @1 :Text;
}

# ══════════════════════════════════════════════════════════════════════
# EVENTS
# ══════════════════════════════════════════════════════════════════════

interface ShellEventStream {
    pull   @0 () -> (event :ShellEvent);
    cancel @1 () -> T.VoidResult;
}

struct ShellEventFilter {
    kinds @0 :List(ShellEventKind);
}

enum ShellEventKind {
    launcherEvents     @0;
    notificationEvents @1;
    clipboardEvents    @2;
    trayEvents         @3;
    audioEvents        @4;
    networkEvents      @5;
    powerEvents        @6;
    searchEvents       @7;
    sessionEvents      @8;
    bluetoothEvents    @9;
    settingsEvents    @10;
    custom            @11;
}

struct ShellEvent {
    union {
    appStarted             @0  :ApplicationEntry;
    appStopped             @1  :ApplicationEntry;
    appRegistered          @2  :ApplicationEntry;
    appUnregistered        @3  :T.AppId;

    notificationReceived   @4  :Notification;
    notificationDismissed  @5  :T.NotificationId;
    allNotificationsDismissed @6 :Void;
    doNotDisturbChanged    @7  :Bool;

    clipboardChanged       @8  :ClipboardEntry;
    clipboardCleared       @9  :Void;

    trayIconAdded          @10 :TrayIcon;
    trayIconRemoved        @11 :T.TrayIconId;
    trayIconChanged        @12 :TrayIcon;

    audioStateChanged      @13 :AudioState;
    networkStateChanged    @14 :NetworkState;
    powerStateChanged      @15 :PowerState;
    bluetoothStateChanged  @16 :BluetoothState;

    searchResults          @17 :List(SearchResult);

    sessionLocking         @18 :Void;
    sessionLocked          @19 :Void;
    sessionUnlocked        @20 :Void;
    shutdownImminent       @21 :T.Duration;

    settingChanged         @22 :ShellSetting;

    custom                 @23 :UnknownShellEvent;
    }
}

struct UnknownShellEvent {
    typeId  @0 :UInt64;
    payload @1 :Data;
}

# ══════════════════════════════════════════════════════════════════════
# QUERY
# ══════════════════════════════════════════════════════════════════════

struct ShellQuery {
    union {
        appById           @0 :T.AppId;
        appsByCategory    @1 :ApplicationCategory;
        runningApps       @2 :Void;
        favoriteApps      @3 :Void;
        shellCapabilities @4 :Void;
        custom            @5 :CustomQuery;
    }
}

struct CustomQuery {
    name       @0 :Text;
    parameters @1 :List(T.Meta);
}

struct ShellQueryResult {
    union {
        app          @0 :ApplicationEntry;
        apps         @1 :List(ApplicationEntry);
        capabilities @2 :List(ShellCapability);
        custom       @3 :List(T.Meta);
        notFound     @4 :Void;
    }
}

# ══════════════════════════════════════════════════════════════════════
# CAPABILITIES
# ══════════════════════════════════════════════════════════════════════

enum ShellCapability {
    manageLauncher       @0;
    manageNotifications  @1;
    manageClipboard      @2;
    manageTray           @3;
    readAudioState       @4;
    controlAudio         @5;
    readNetworkState     @6;
    readPowerState       @7;
    controlPowerProfile  @8;
    controlBrightness    @9;
    controlNightLight   @10;
    searchUniversal     @11;
    controlSession      @12;
    controlBluetooth    @13;
    usePortals          @14;
    manageSettings      @15;
    voiceShell          @16;
    gestureNavigation   @17;
    aiCompletion        @18;
    crossDeviceHandoff  @19;
    contextBubbles      @20;
    accessibility       @21;
    custom              @22;
}

# ══════════════════════════════════════════════════════════════
# MULTI-MODAL SESSION
# ══════════════════════════════════════════════════════════════

enum ShellSessionMode {
    text         @0;  # traditional keyboard/terminal
    voice        @1;  # voice-only, screenless
    gesture      @2;  # gesture-only, AR/VR/watch
    multiModal   @3;  # combined voice+text+gesture
    brief        @4;  # one-shot, description-only
    custom       @5;
}

# ══════════════════════════════════════════════════════════════
# AI-FIRST COMPLETION
# ══════════════════════════════════════════════════════════════

struct AiCompletionRequest {
    partialInput @0 :Text;
    context      @1 :AiCompletionContext;
    maxResults   @2 :UInt32;
}

struct AiCompletionContext {
    recentCommands @0 :List(Text);
    currentApp     @1 :T.AppId;
    timeOfDay      @2 :T.Timestamp;
    location       @3 :Text;
    mode           @4 :ShellSessionMode;
}

struct AiCompletionResult {
    suggestion    @0 :Text;
    description   @1 :Text;
    confidence    @2 :Float32;
    action        @3 :ShellAction;
    source        @4 :AiCompletionSource;
}

enum AiCompletionSource {
    history       @0;
    semantic      @1;
    contextual    @2;
    predictive    @3;
    custom        @4;
}

struct ShellAction {
    union {
        appLaunch    @0 :T.AppId;
        shellCommand @1 :Text;
        uriOpen      @2 :T.Uri;
        settingChange @3 :ShellSetting;
        custom       @4 :Data;
    }
}

# ══════════════════════════════════════════════════════════════
# CROSS-DEVICE HANDOFF
# ══════════════════════════════════════════════════════════════

struct HandoffRequest {
    sourceDevice  @0 :Text;
    targetDevice  @1 :Text;
    sessionId     @2 :T.SessionId;
    transferData  @3 :HandoffData;
}

struct HandoffData {
    runningApps   @0 :List(T.AppId);
    clipboard     @1 :ClipboardEntry;
    searchContext @2 :Text;
    shellState    @3 :List(ShellSetting);
}

struct HandoffResult {
    accepted    @0 :Bool;
    reason      @1 :Text;
    migratedAt  @2 :T.Timestamp;
}

# ══════════════════════════════════════════════════════════════
# VOICE SHELL
# ══════════════════════════════════════════════════════════════

struct VoiceShellResult {
    recognizedText @0 :Text;
    confidence     @1 :Float32;
    action         @2 :ShellAction;
    spokenResponse @3 :Text;
    audioResponse  @4 :T.DataHandle;
}

interface VoiceShellResultStream {
    pull @0 () -> (result :VoiceShellResult, done :Bool);
    cancel @1 () -> T.VoidResult;
}

interface WakeWordSubscription {
    pull @0 () -> (detected :Bool, confidence :Float32);
    cancel @1 () -> T.VoidResult;
}

# ══════════════════════════════════════════════════════════════
# GESTURE NAVIGATION
# ══════════════════════════════════════════════════════════════

enum GestureCommand {
    swipeLeft      @0;
    swipeRight     @1;
    swipeUp        @2;
    swipeDown      @3;
    pinchIn        @4;
    pinchOut       @5;
    tap            @6;
    doubleTap      @7;
    longPress      @8;
    rotate         @9;
    point          @10;
    grab           @11;
    custom         @12;
}

struct GestureEvent {
    command     @0 :GestureCommand;
    position    @1 :T.Vec2;
    velocity    @2 :T.Vec2;
    timestamp   @3 :T.Timestamp;
    source      @4 :GestureSource;
}

enum GestureSource {
    touchscreen @0;
    trackpad    @1;
    handTracking @2;
    eyeTracking @3;
    controller  @4;
    custom      @5;
}

# ══════════════════════════════════════════════════════════════
# BRIEF MODE
# ══════════════════════════════════════════════════════════════

struct BriefResult {
    summary     @0 :Text;
    icon        @1 :T.DataHandle;
    action      @2 :ShellAction;
    confidence  @3 :Float32;
}

# ══════════════════════════════════════════════════════════════
# ACCESSIBILITY
# ══════════════════════════════════════════════════════════════

struct AccessibilityMode {
    screenReader     @0 :Bool;
    highContrast     @1 :Bool;
    largeText        @2 :Bool;
    magnification    @3 :Float32;
    captions         @4 :Bool;
    reducedMotion    @5 :Bool;
    stickyKeys       @6 :Bool;
    custom           @7 :Data;
}

# ══════════════════════════════════════════════════════════════
# CONTEXT BUBBLES
# ══════════════════════════════════════════════════════════════

struct ContextBubble {
    id          @0 :Text;
    anchorSurface @1 :T.SurfaceId;
    position    @2 :T.Vec2i;
    content     @3 :BubbleContent;
    lifetime    @4 :T.Duration;
    interactive @5 :Bool;
}

struct BubbleContent {
    union {
        text        @0 :Text;
        richText    @1 :T.DataHandle;
        image       @2 :T.DataHandle;
        appPreview  @3 :T.AppId;
        custom      @4 :Data;
    }
}

# ── Shell Plugin System (audit-8 What's Still Missing) ──
struct ShellPluginInfo {
    id @0 :Text;
    name @1 :Text;
    version @2 :T.Version;
    capabilities @3 :List(Text);
    enabled @4 :Bool;
}

# ── Shell Analytics / Usage Tracking (audit-8 What's Still Missing) ──
struct ShellAnalytics {
    appsLaunched @0 :UInt64;
    commandsExecuted @1 :UInt64;
    searchQueries @2 :UInt64;
    sessionDuration @3 :T.Duration;
    topApps @4 :List(T.AppId);
}

# ── Shell Theming Pipeline (audit-8 What's Still Missing) ──
struct ShellThemingPipeline {
    themeSource @0 :ThemeSource;
    dynamicColor @1 :Bool;
    customTheme @2 :Text;
}

enum ThemeSource {
    system @0;
    wallpaper @1;
    manual @2;
    custom @3;
}

# ── Multi-User Shell (audit-8 What's Still Missing) ──
struct MultiUserConfig {
    activeUser @0 :T.UserId;
    users @1 :List(UserProfile);
    switchAllowed @2 :Bool;
}

struct UserProfile {
    userId @0 :T.UserId;
    name @1 :Text;
    icon @2 :T.DataHandle;
    isCurrent @3 :Bool;
}

# ── AR Spatial Shell (audit-9 What's Still Missing) ──
struct ArSpatialShell {
    shellId @0 :Text;
    position @1 :T.Vec3;
    rotation @2 :T.Vec4;
    anchorType @3 :ArAnchorType;
    elements @4 :List(ArShellElement);
}

enum ArAnchorType {
    world @0;
    plane @1;
    object @2;
    face @3;
    other @4;
    custom @5;
}

struct ArShellElement {
    elementId @0 :Text;
    type @1 :ArElementType;
    position @2 :T.Vec3;
    scale @3 :T.Vec3;
    visible @4 :Bool;
}

enum ArElementType {
    panel @0;
    button @1;
    text @2;
    image @3;
    model @4;
    other @5;
    custom @6;
}

# ── Car Split-Screen Zones (audit-9 What's Still Missing) ──
struct CarSplitScreenConfig {
    zones @0 :List(CarScreenZone);
    driverZone @1 :Text;
    passengerZones @2 :List(Text);
}

struct CarScreenZone {
    zoneId @0 :Text;
    role @1 :CarZoneRole;
    bounds @2 :T.Rect;
    contentTypes @3 :List(CarContentType);
    maxApps @4 :UInt8;
}

enum CarZoneRole {
    driver @0;
    frontPassenger @1;
    rearLeft @2;
    rearRight @3;
    rearCenter @4;
    other @5;
    custom @6;
}

enum CarContentType {
    navigation @0;
    media @1;
    phone @2;
    climate @3;
    vehicle @4;
    other @5;
    custom @6;
}

# ── Shell Session Persistence (audit-9 What's Still Missing) ──
struct ShellSessionState {
    sessionId @0 :T.SessionId;
    savedAt @1 :T.Timestamp;
    runningApps @2 :List(T.AppId);
    clipboard @3 :ClipboardEntry;
    settings @4 :List(ShellSetting);
    openWindows @5 :List(T.WindowId);
    workspaces @6 :List(T.WorkspaceId);
}

# ── Shell Notification Grouping (audit-9 What's Still Missing) ──
struct NotificationGroup {
    groupId @0 :Text;
    notifications @1 :List(Notification);
    summary @2 :Text;
    count @3 :UInt32;
    lastUpdated @4 :T.Timestamp;
    conversationThread @5 :Bool;
}

# ── Shell Command History with Analytics (audit-9 What's Still Missing) ──
struct CommandHistoryEntry {
    command @0 :Text;
    timestamp @1 :T.Timestamp;
    frequency @2 :UInt64;
    lastUsed @3 :T.Timestamp;
    frecency @4 :Float32;
}

struct CommandHistoryAnalytics {
    totalCommands @0 :UInt64;
    uniqueCommands @1 :UInt64;
    topCommands @2 :List(CommandHistoryEntry);
    sessionDuration @3 :T.Duration;
}

# ── Shell Accessibility Tree Exposure (audit-9 What's Still Missing) ──
struct ShellAccessibilityTree {
    tree @0 :ShellAccessibilityNode;
    generatedAt @1 :T.Timestamp;
}

struct ShellAccessibilityNode {
    id @0 :Text;
    role @1 :Text;
    name @2 :Text;
    description @3 :Text;
    children @4 :List(ShellAccessibilityNode);
}
