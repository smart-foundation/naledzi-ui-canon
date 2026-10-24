# Naledzi — Agent Operating Rules

This file governs **how agents work in this repo**. It is binding on every agent. It is
about method, not architecture.

For what the system *is*: read `docs/NALEDZI.md` and the contracts in
`protocol/schemas/*.capnp`. Those are the durable artefacts. Everything else — services,
kernel, drivers, harnesses — is an implementation that may be replaced.

---

## 0. Establish ground truth before you act

**This file contains no facts about the code.** Facts rot; procedures do not. Any statement
here that an edit could invalidate does not belong here — and if you find one, that is a
defect in this file, not in your reading of it.

- **Derive, do not recall.** Locate the code, read it, cite `file:line`. A summary is not
  evidence — not this file, not a plan, not a prior agent's report, not a chat transcript.
- **The code wins.** If a document and the code disagree, the code is correct and the
  document is a bug. Fix the document in the same change, or record it as a gap.
- **Verify before repeating.** A claim you have not checked in this session is a hypothesis.
  Say so when you pass it on.
- **Stale documentation is a defect.** Finding one is a finding. Report it and either fix it
  or record it — do not quietly work around it and leave it to mislead the next agent.

**Where things live**

| You need | Look here |
|---|---|
| Architecture intent | `docs/NALEDZI.md` |
| The contract (durable, authoritative) | `protocol/schemas/*.capnp` |
| Which services actually run | `services.toml` |
| Work in flight | `.kilo/plans/` (per-agent detail: `.kilo/plans/agent-<name>.md`) |
| The spec and its progress | `progress/` |
| Whether the kernel booted | `scripts/boot-verify.sh` — one definition, read it there |
| Current implementation state | generated reports, not prose |

When a current-state answer is needed, generate it or read the code. Do not copy a number
out of a document and trust it.

---

## 1. Contract discipline

These are rules for how you write code. They exist because the system is built so that any
implementation can be iterated or disposed of, infinitely, without affecting anything else.

- **Never name another service as a literal.** You do not know that a peer exists. Resolve
  through discovery and treat absence as normal.
- **Never reach into another implementation's internals.** You speak its schema or nothing.
- **Never assume an implementation detail is a contract term.** "It is a fixed binary loaded
  at boot" is an implementation detail.
- **Never let one implementation shape the contract.** If a schema field only makes sense for
  one implementation, the field is wrong.
- **Never add a second authority for a fact the contract already carries.** The contract is
  final; implementations are disposable.

**The test:** does this make the system more or less able to throw away an implementation?
If it hardcodes knowledge of a peer's existence, it makes the system less disposable and it
is wrong.

---

## 2. Build policy

- **Workspace-wide builds are forbidden.** `cargo check --workspace` and
  `cargo build --workspace` are slow and structurally broken in this repo. Do not attempt to
  make the workspace green, and do not "just try it once".
- **Check only what changed**, by explicit `-p`:

  ```bash
  cargo check --target x86_64-unknown-none -p naledzi -p system-service -p smart-shell
  ```

- **The kernel crate is `naledzi`.** Other kernel trees exist in this repo; they are not the
  target and do not compile. Do not build them.
- **The enabled service set is whatever `services.toml` lists.** Read it. Do not assume a
  count, and do not assume a service that is present in the tree is enabled.
- `cargo check` before `cargo build`. Skip `cargo build` until you actually need an ISO.
- The kernel needs `RUSTFLAGS="-Crelocation-model=static"`; services do not. Do not leak
  that flag into services.
- **Schema changes regenerate bindings** via `build.rs`. After editing anything in
  `protocol/schemas/`, re-check the crates that depend on it. This is the one case where
  re-checking something you did not touch is correct.
- **Design the contract fully, then land it once.** Every crate with a `build.rs`
  recompiles its capnp bindings on any shared-schema change. Never iterate a schema field
  by field.

---

## 3. Never rebuild what already verified

This is the most-wasted resource in agent-driven work on this repo. **Re-verify only when a
build input actually changed.**

**None of these is a reason to rebuild:**

- You are unsure whether the previous run succeeded → read the report or the log. Reading
  is free.
- You just read the code and feel uncertain → reading is not compiling.
- "It's quick to check." It is not — it re-runs every dependent `build.rs`.
- You changed something and are unsure if it mattered → `git diff --name-only` answers
  instantly.
- You cannot find the previous output → that is a documentation gap, not a build trigger.

**A changed input is:** a source file you edited, a `Cargo.toml` / `build.rs` / schema file
in the dependency chain, or a toolchain change. Nothing else.

The correct response to "did this already verify?" is to **look at the recorded result** —
the agent report under `.kilo/plans/`, the build log under `target/` — not to run it again.
Cargo's fingerprints already make unchanged crates free, so a redundant build mostly
produces heat and a log that looks like progress.

If you genuinely cannot tell whether a prior run happened, write that in your report and
move on. Do not resolve the ambiguity by building.

Other build rules:

- One `cargo check` per logical change, never one per hypothesis.
- `cargo check` answers compile questions. Never `cargo build` "to see if it works".
- Never re-run a check that just passed.
- Build an ISO only when the stage's verification genuinely requires booting.
- QEMU runs are short and headless with `-no-reboot`. One per stage, asserted fully.

---

## 4. One build at a time — the machine matters more than the work

The box lives somewhere hot. Sustained compilation raises CPU package temperature, starves
RAM, and can crash the machine. A crashed machine loses more than an unfinished plan.

**Use `scripts/build.sh`, never cargo directly.** It enforces everything below.

- **All builds go through `flock /tmp/naledzi-build.lock`.** Parallel agents at cargo's
  default job count is the OOM. If the lock is held, **wait**, and meanwhile do editing and
  reading, which cost nothing.
- **Half the machine left in reserve.** Raise the job count only if you want the wall-clock
  and the machine is coping; drop it if the machine feels slow or unstable.
- **Temperature is reported, never enforced.** The box is in a hot climate and will never sit
  at a cool idle, so a low hard limit would block all work permanently. `x86_pkg_temp` is
  readable from `/sys/class/thermal/thermal_zone*/temp` with no `lm-sensors` install. We warn
  and otherwise continue — the CPU protects itself by throttling and then shutting down. If
  the machine feels slow, close other heat sources; do not let a temperature reading veto a
  build.
- **The memory gate is real and does block:** do not start a release build under a few GB of
  `MemAvailable`. LTO with `codegen-units=1` will spike past that, and unlike temperature
  this one is a genuine OOM risk you can actually avoid.
- **Dev builds never use LTO.** `scripts/build.sh` exports the dev profile overrides. The
  workspace's release-oriented dev profile is right for shipping and pure waste for a test
  build.
- **Never `cargo clean`.** It destroys every other agent's incremental state and forces full
  recompiles. Clear a cache only when it is provably wrong, and say why.

**Orchestration:** agents edit in parallel (free), builds are strictly serialized (bounded
load). Never use separate git worktrees for this work — separate `target/` dirs mean a cold
rebuild each, which is exactly the waste these rules exist to prevent.

---

## 5. Machine resources

- The workspace profile sets aggressive LTO and small codegen units. **Release builds are
  memory-hungry. Only ever one release build at a time.** If two agents are active,
  coordinate: `cargo check` is fine in parallel, `cargo build --release` is not.
- Before a release build, check `free -m`. If available memory is low, do not start one.
- Do not `cargo clean`.
- Cargo takes a lock on `target/`. Concurrent invocations serialize rather than corrupt —
  that is safe, but parallel agents should scope to **disjoint crates** to avoid waiting on
  each other.

---

## 6. Honesty rules

The system must never lie about itself. This is the project's core rule and it is not
negotiable.

- **Never fabricate a value.** If a field has no producer, it renders `N/A` with a reason.
  Never a default, never a plausible-looking literal.
- **No machine-state string literal in code.** No hardcoded product name, no hardcoded
  architecture string, no hardcoded version, no hardcoded physical size, no invented
  process name, no invented device. Real data comes from the boot manifest, from hardware,
  or from the service that owns it.
- **Do not weaken an assertion to make it pass.** If a total does not add up because the
  allocator has a cap, fix the allocator.
- **Report failures plainly.** A stage that does not compile is reported as not compiling.
  Do not report partial success as success.
- **If you cannot verify something, say so explicitly** rather than implying it works.
- **Honest absence beats confident invention.** "Not reported: no producer" is a valid
  answer. A made-up number is not.

---

## 7. Zero-cycle discipline

Adding a cycle is a real cost — this OS targets flight and spacecraft hardware. Before
adding work to a hot path, exhaust the alternatives:

| Instead of | Do this |
|---|---|
| Runtime capability check per call | Make capability compile-time. Attenuate at link/load; a command you lack is not in your table. |
| Per-channel fault-resume table | Recover the owner from the faulting RIP against image ranges the kernel already holds. |
| `rdtsc` sampling for CPU% | Don't sample while no real processes exist. A cheaper number is not a truer one. |
| CR3 switch per dispatch | One page table per **trust domain**, not per service. Intra-group cost is zero. |
| CPUID / EDID per query | Enumerate once at boot, cache in the identity struct. |
| Synchronous IPC round-trip | Fire-and-forget where the reply is not needed. |

If you add a cost, state in your report what it buys and why it cannot be removed.

---

## 8. Non-destructive

- **Never `git stash`** — stash is shared and destroys other agents' work. Use
  `git checkout -- <path>` to discard your own changes.
- **Revert whole, don't layer.** A broken change is reverted as a unit, not patched over
  incrementally.
- **Do not touch `BACKUPS_NOT_TO_TOUCHED/`** — preserved deliberately.
- Do not delete files you did not create. If dead code must go, say so in your report first.
- Do not `git commit`, `git push`, or create branches unless explicitly asked.

---

## 9. Documentation is part of the work

- **Update the report as you go, not at the end.** If you finish a stage, its report is
  current before you move on. Do not batch documentation for later.
- The spec and its progress live in `progress/`. The plan lives in `.kilo/plans/` — read the
  active one there rather than assuming a filename. Per-agent detail goes in
  `.kilo/plans/agent-<name>.md`.
- Record for each stage: what changed, which `file:line`, what was verified, how, and what
  remains. Cite `file:line` for every claim.
- **Do not defer and do not cut scope.** If something is not built, it is not built — say so.
  Do not mark it "later" or "out of scope" to make a stage look finished.
- **Do not write facts that will rot.** If a report needs a current-state number, generate
  it or cite the command that produced it.

---

## 10. Verification

- **Assert, don't eyeball.** A stage is verified by a check that can fail, with the output
  recorded. "It looked right in the log" is not verification.
- **Drive the shell over a pty.** `-serial file:` gives no input channel, so any assertion
  requiring a typed command cannot run that way. Use the pty harness in `scripts/` so
  commands can be sent and replies read.
- **The boot markers live in `scripts/boot-verify.sh`.** That file is the single definition
  of "the kernel booted", shared by every boot script. Read the markers there; do not
  hardcode them anywhere else, and do not grep for markers the kernel does not print.
- **A build gate must fail when a service fails.** If you touch the service build script,
  confirm it exits non-zero when a service is missing.
- **Honest verification includes honest failure.** If a check fails, report the failure and
  its cause. Do not weaken the check to make it pass, and do not report a partial result as
  a pass.
