@0xa1b2c3d4e5f6001f;

using T = import "types.capnp";

interface CliService {
    # Execute a command synchronously and return the result.
    execute @0 (request :CommandRequest) -> (result :CommandResult);

    # Execute a command in the background, returning a job handle.
    spawnBackground @1 (request :CommandRequest) -> (jobId :T.JobId);

    # Poll a background job's status (non-blocking).
    getJobStatus @2 (jobId :T.JobId) -> (status :JobStatus);

    # Kill a running background job.
    killJob @3 (jobId :T.JobId) -> T.VoidResult;

    # Command history with pagination.
    getHistory @4 (pagination :T.Pagination) -> (entries :List(CommandHistoryEntry), totalCount :UInt32);
    clearHistory @5 () -> T.VoidResult;

    # Tab-completion suggestions for a partial input.
    getCompletions @6 (partial :Text) -> (completions :List(Text));

    # Descriptive metadata for a command (help text, arguments, options).
    getCommandInfo @7 (command :Text) -> (info :CommandInfo);

    # Audit-7: execute with streaming stdout/stderr.
    executeStreaming @8 (request :CommandRequest) -> (stream :StreamingOutput);

    # Audit-7: list command aliases.
    listAliases @9 () -> (aliases :List(CommandAlias));

    # Audit-7: create a named command script.
    createScript @10 (script :CommandScript) -> (scriptId :Text);

    # Audit-7: check permission before execution.
    checkPermission @11 (command :Text) -> (result :T.BoolResult);

    # Audit-9: get command history analytics.
    getHistoryAnalytics @12 () -> (analytics :CommandHistoryAnalytics);

    # Audit-9: execute a command pipeline (stdout -> stdin).
    executePipeline @13 (steps :List(CommandPipelineStep)) -> (result :CommandResult);

    # Audit-10: execute a command interactively (stdin negotiation enabled).
    executeInteractive @14 (request :CommandRequest) -> (session :InteractiveSession);

    # Audit-10: send user input to an interactive session.
    sendInput @15 (sessionId :Text, input :InteractiveInput) -> T.VoidResult;

    # Audit-10: poll for interactive prompts from a running session.
    pollPrompt @16 (sessionId :Text) -> (prompt :InteractivePrompt);

    # ─── Command registry ─────────────────────────────────────────
    # The registry is the authority on what commands exist and what each one
    # needs. These four methods exist because a client that guesses is a
    # client that lies: "help" must not list a command that cannot run, and
    # the reason it cannot run must be nameable, not "unknown".
    #
    # NOTE ON SHAPE: these take no `command` string and return a whole list.
    # A per-command getCommandInfo already exists (@7). These are the
    # registry-wide views — what exists, what is unavailable and why, and how
    # to parse it — not a second per-command accessor.

    # Every registered command, with what it needs to run.
    listCommands @17 (pagination :T.Pagination)
                -> (commands :List(CommandRegistration), total :UInt32);

    # Registered commands that cannot currently run, and why.
    listUnavailable @18 (pagination :T.Pagination)
                   -> (commands :List(CommandRegistration), total :UInt32);

    # The grammar a client parses user input against.
    getSyntax @19 () -> (syntax :SyntaxReference);
}

# ══════════════════════════════════════════════════════════════════════
# Command registry
# ══════════════════════════════════════════════════════════════════════

# One registered command, and what it takes to run it.
#
# This is a REGISTRATION, not an invocation result: it is answerable without
# running anything. `capability` is the authority the caller must hold; the
# zero-cycle rule applies here — a command you lack the capability for is not
# in your table at all, so nothing checks at run time (plan §"Zero-cycle
# rules": "Attenuation at link/load").
struct CommandRegistration {
    # The path the user types, e.g. "system info" or "ps -a". The full
    # command line including its subcommand — `command` alone would be
    # ambiguous the moment a command has subcommands.
    commandPath @0 :Text;

    # The capability handle required to invoke it. Zero means no capability
    # is required, which is a real and common case (a bare `help`), and is
    # distinct from "the registry did not record one".
    methodId @1 :UInt32;

    # The capability that gates this command, as a protocol capability
    # target string (the same textual addressing capability.capnp uses, so
    # there is one authority on capability naming and not two).
    capability @2 :Text;

    # How this command should be presented — grouping, ordering, one-line
    # summary. Kept out of CommandInfo (@7) because presentation is a
    # property of the command's place in the registry, not of its arguments.
    presentation @3 :CommandPresentation;

    # Why this command is not currently runnable, when it is not. Empty when
    # it is runnable — never a placeholder string standing in for an answer.
    unavailableReason @4 :AvailabilityReason;
}

struct CommandPresentation {
    # Domain this command belongs to ("system", "process", "storage").
    domain @0 :Text;
    # Human one-line summary for help listings.
    summary @1 :Text;
    # Sort key within the domain. Lower sorts first.
    order @2 :UInt32;
    # Whether a bare invocation (no arguments) is meaningful, so a client can
    # decide whether to run it to see usage or refuse and ask for help.
    noArgsValid @3 :Bool;
}

# Why a command is not available. An enum, not a string, so a client can
# branch on it and so "we do not know" is a distinguishable state.
enum AvailabilityReason {
    # The command is available.
    available @0;
    # The calling entity lacks the capability this command requires.
    capabilityDenied @1;
    # A required backing service is not registered or not healthy. `detail`
    # names it.
    serviceUnavailable @2;
    # The command exists only on this platform or architecture.
    unsupportedPlatform @3;
    # The registry has no answer — explicitly distinct from every other case,
    # so a gap is visible rather than disguised as one of the above.
    unknown @4;
    # Held back deliberately by configuration.
    disabledByPolicy @5;
    custom @6;
}

# Where a client should look to learn the command grammar.
#
# The grammar is not inlined into this schema on purpose: the syntax is a
# property of the running system's command set, and duplicating it here would
# create a second authority that drifts. This points at the authority.
struct SyntaxReference {
    # Machine-readable grammar document (the CLI's own parser spec). Empty
    # only when the registry has no grammar to publish, which a client must
    # treat as "cannot validate input" rather than "anything is valid".
    grammar @0 :Text;

    # Version of the grammar document, so a client can tell whether its
    # cached copy is stale.
    version @1 :T.Version;

    # Domains the grammar covers. A client that knows a domain is missing can
    # say so instead of silently offering no completions for it.
    domains @2 :List(DomainInfo);
}

# One command domain ("system", "process", "storage", …).
struct DomainInfo {
    # Stable domain identifier, matching CommandPresentation.domain.
    id @0 :Text;
    # Human label for menus.
    label @1 :Text;
    # One-line description.
    description @2 :Text;
    # Registered commands in this domain.
    commandCount @3 :UInt32;
    # How many of those are currently unavailable.
    unavailableCount @4 :UInt32;
}

# Audit-9: command history analytics.
struct CommandHistoryAnalytics {
    # Most used commands.
    mostUsed @0 :List(CommandUsageStats);
    # Error rate by command.
    errorRates @1 :List(CommandErrorRate);
    # Total commands executed.
    totalExecuted @2 :UInt64;
    # Total commands failed.
    totalFailed @3 :UInt64;
}

struct CommandUsageStats {
    command @0 :Text;
    count @1 :UInt64;
}

struct CommandErrorRate {
    command @0 :Text;
    totalRuns @1 :UInt64;
    failures @2 :UInt64;
    errorRate @3 :Float32;
}

# Audit-9: a step in a command pipeline.
struct CommandPipelineStep {
    # The command to execute.
    command @0 :Text;
    # Arguments for this step.
    args @1 :List(Text);
    # Pipe mode: how stdout connects to next step's stdin.
    pipeMode @2 :PipeMode;
}

enum PipeMode {
    # Pipe stdout to next step's stdin.
    pipe @0;
    # Redirect stdout to file.
    redirect @1;
    # Append stdout to file.
    append @2;
    # No redirection.
    none @3;
    custom @4;
}

struct CommandRequest {
    # The command name or path. Backend resolves via its own search rules
    # (PATH-like resolution, alias tables, built-in commands).
    command @0 :Text;
    # Positional arguments.
    args @1 :List(Text);
    # Environment variables (key-value pairs).
    env @2 :T.StringMap;
    # Working directory. Backend interprets according to its filesystem model.
    cwd @3 :Text;
    # Standard input data. Use T.DataHandle for large payloads.
    stdin @4 :T.DataHandle;
    # Audit-7: command timeout (null = no timeout).
    timeout @5 :T.Duration;
    # Audit-7: environment inheritance mode.
    environmentMode @6 :EnvironmentMode;
    # Audit-7: resource limits for the command.
    resourceLimits @7 :ResourceLimits;
    # Audit-9: structured output format.
    outputFormat @8 :CommandOutputFormat;
    # Audit-9: workspace/directory context for the command.
    workspace @9 :CommandWorkspace;
}

# Audit-9: structured output format for command stdout.
enum CommandOutputFormat {
    raw @0;       # Raw bytes (default)
    utf8 @1;      # UTF-8 text
    json @2;      # JSON-structured output
    yaml @3;      # YAML-structured output
    xml @4;       # XML-structured output
    custom @5;
}

# Audit-9: command workspace context.
struct CommandWorkspace {
    # Workspace name/identifier.
    name @0 :Text;
    # Workspace root path.
    root @1 :Text;
    # Workspace-specific environment overlay.
    env @2 :T.StringMap;
}

# Audit-7: how environment variables are handled.
enum EnvironmentMode {
    replace @0;    # Replace entire environment (default, backward-compatible)
    inherit @1;    # Inherit parent environment, override with env map
    merge @2;      # Merge env map on top of inherited environment
    clean @3;      # Empty environment (no inheritance)
}

# Audit-7: resource limits for command execution.
struct ResourceLimits {
    # Maximum CPU time (null = unlimited).
    cpuTime @0 :T.Duration;
    # Maximum memory usage in bytes (0 = unlimited).
    memoryBytes @1 :UInt64;
    # Maximum file size in bytes (0 = unlimited).
    fileSize @2 :UInt64;
    # Maximum number of open file descriptors (0 = unlimited).
    openFiles @3 :UInt32;
    # Maximum wall-clock time (null = unlimited).
    wallTime @4 :T.Duration;
}

struct CommandResult {
    # Structured exit status — no raw exit codes.
    exitStatus @0 :T.ExitStatus;
    # Standard output. Use T.DataHandle for potentially large output.
    stdout @1 :T.DataHandle;
    # Standard error. Use T.DataHandle for potentially large output.
    stderr @2 :T.DataHandle;
    # Wall-clock duration of command execution.
    duration @3 :T.Duration;
}

struct CommandHistoryEntry {
    command @0 :Text;
    timestamp @1 :T.Timestamp;
    exitStatus @2 :T.ExitStatus;
    duration @3 :T.Duration;
}

struct JobStatus {
    state @0 :JobState;
    # Only valid when state is completed or failed.
    result @1 :CommandResult;
}

enum JobState {
    running @0;
    completed @1;
    failed @2;
    killed @3;
    custom @4;
}

struct CommandInfo {
    command @0 :Text;
    description @1 :Text;
    args @2 :List(CommandArg);
    options @3 :List(CommandOption);
}

struct CommandArg {
    name @0 :Text;
    description @1 :Text;
    required @2 :Bool;
    variadic @3 :Bool;
}

struct CommandOption {
    short @0 :Text;
    long @1 :Text;
    description @2 :Text;
    value @3 :Text;
    # Audit-9: typed option value for better type safety.
    typedValue @4 :TypedOptionValue;
}

# Audit-9: typed option value for better type safety.
struct TypedOptionValue {
    union {
        bool @0 :Bool;
        int @1 :Int64;
        float @2 :Float64;
        text @3 :Text;
        list @4 :List(Text);
        custom @5 :Data;
    }
}

# Audit-7: streaming output interface for real-time stdout/stderr.
interface StreamingOutput {
    # Pull the next output chunk.
    pull @0 () -> (chunk :OutputChunk);

    # Cancel the streaming output and terminate the command.
    cancel @1 () -> T.VoidResult;
}

# Audit-7: output chunk from streaming execution.
struct OutputChunk {
    # The output data.
    data @0 :T.DataHandle;
    # Whether this is stdout (true) or stderr (false).
    isStderr @1 :Bool;
    # Whether the command has finished.
    finished @2 :Bool;
    # Exit status (only present when finished = true).
    exitStatus @3 :T.ExitStatus;
}

# Audit-7: command alias mapping.
struct CommandAlias {
    # The alias name (e.g., "ll").
    name @0 :Text;
    # The target command and arguments.
    target @1 :Text;
    # Human-readable description.
    description @2 :Text;
}

# Audit-7: named sequence of commands.
struct CommandScript {
    # Script name.
    name @0 :Text;
    # Human-readable description.
    description @1 :Text;
    # Ordered list of commands to execute.
    steps @2 :List(CommandScriptStep);
    # Whether to stop on first failure.
    stopOnError @3 :Bool;
}

# Audit-7: a single step in a command script.
struct CommandScriptStep {
    # The command to execute.
    command @0 :Text;
    # Arguments for this step.
    args @1 :List(Text);
    # Working directory override (null = inherit from request).
    cwd @2 :Text;
    # Whether to skip this step if the previous step failed.
    skipOnError @3 :Bool;
}

# Audit-10: interactive session handle for stdin negotiation.
struct InteractiveSession {
    sessionId @0 :Text;
    pid @1 :T.ProcessId;
}

# Audit-10: user input to send to an interactive session.
struct InteractiveInput {
    union {
        text @0 :Text;
        line @1 :Text;
        key @2 :InteractiveKey;
        custom @3 :Data;
    }
}

# Audit-10: a single key event for interactive input.
struct InteractiveKey {
    # Key name (e.g., "enter", "tab", "ctrl-c").
    name @0 :Text;
    # Whether a modifier key is held.
    ctrl @1 :Bool;
    alt @2 :Bool;
    shift @3 :Bool;
}

# Audit-10: interactive prompt from a running command.
struct InteractivePrompt {
    # Whether a prompt is currently active.
    active @0 :Bool;
    # Prompt message (e.g., "Enter password: ").
    message @1 :Text;
    # Expected input type.
    inputType @2 :InteractiveInputType;
    # Whether input is required (null = optional).
    required @3 :Bool;
}

enum InteractiveInputType {
    text @0;
    password @1;
    confirm @2;
    choice @3;
    path @4;
    custom @5;
}
