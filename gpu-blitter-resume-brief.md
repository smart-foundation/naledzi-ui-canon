# GPU blitter session — resume brief

Recovered 2026-10-22 from the lost **kilo** session (it was in `kilo.db`, not `opencode.db`).

## Session identity

| field | value |
|---|---|
| session id | `ses_eb1d58bcfffentA4qBMXC7lp1a` |
| slug | `misty-knight` |
| auto title | "Orchestrator role definition" (misleading — auto-generated) |
| app | kilo 7.8.8 (current binary: 7.8.15) |
| directory | `/home/lufuno/naledzi` |
| branch at the time | `audit-005-execution` |
| created / last active | 2026-10-18 08:39:27 → 09:32:58 |
| role | root orchestrator session (`kilo_board` row holds the objective) |
| JSON backup | `~/.local/share/kilo/backups/gpu-blitter-session.json` |

## Resume commands

```bash
cd ~/naledzi
kilo --session ses_eb1d58bcfffentA4qBMXC7lp1a          # resume in place
kilo --session ses_eb1d58bcfffentA4qBMXC7lp1a --fork   # resume as a fork (safer)
kilo session list                                       # confirm it is still listed
```

Child subagent sessions (all under the same root, Oct 18):

- `ses_eb1d54fefffeS56AibxEY8ZtYY` Research GPU/Intel GPU support in Naledzi OS (@explore)
- `ses_eb1d29bdaffezuo0BaYm2FIw1p` Continue research on Naledzi GPU architecture (@explore)
- `ses_eb1cf88ceffey7WTUBn3sirjKB` Research GPU driver feasibility in Naledzi (@explore)
- `ses_eb1c51631ffeFK1VnWLz4WXR2z` Build gpu-intel and HAL service (@agent_smartengineer)
- `ses_eb1c3f915ffevOJEIEMuZOocQ7` Build ISO with gpu-intel and run QEMU boot test (@agent_smartengineer)

## The original objective (verbatim from the user)

> "i am building new rust based os, currently everythig renders from cpu, i have simple ask, is it
> possible to write basic driver which renders via gpu intel gpu, even though not 100% features, but
> that we shift rendering to gpu, i recorn it must be possible, there is difference between full
> suport and basic ... this design uses contract based os, i am not trying to be full, but we need to
> remove overhead from the cpu side, currently we do have console, also i dont know oif the gpu schema
> is good enough or if some changes are needed, this is real micro kernel, everything is disposable is
> it possible. use subagent for research and reading files ur orchestrator only."

Second key question (09:12): CPU as fallback? how fast is the GPU blitter? is the GPU abstraction
sufficient? Goal: **GPUs adapt to our API, not our API to GPUs** — apps/services never recompile
when the GPU backend changes. Is the design timeless?

## Research conclusions reached in that session

1. **The `gpu-intel` driver is real hardware code**, not a stub — `uspace/servers/gpu-intel/src/main.rs`
   (1132 lines today, 1150 then): PCI walk via HAL, MMIO BAR0 map (16 MiB), display pipeline A
   programming (PIPEACONF, HTOTAL_A, DSPADDR, DSPCNTR), a **real blitter ring buffer** with
   `XY_COLOR_BLT` / `XY_SRC_COPY_BLT` commands, hardware cursor, 3D render ring wired but
   GuC firmware upload deferred. `supports_graphics=false`, `supports_compute=false` — honest, only 2D.
2. **`gpu.capnp` is sufficient.** `GpuProvider` already has `getCapabilities`, `allocateBuffer`,
   `createSurface`, `presentToSurface`, `submitCommandBuffer`, fences, `GpuVendor` enum. No schema
   change needed to shift rendering.
3. **Blitter speed:** on real Intel HW the blitter is memory-bandwidth bound — roughly **5–10x faster
   than CPU** for fills/copies at 1024x768. Caveat: the driver **spins polling `RING_HEAD`**
   (`ring_wait_idle`) instead of using GPU interrupts, so it trades CPU polling for GPU speed.
   Net win on large blits, marginal on small ones.
4. **CPU is the fallback by design.** Consumers resolve the GPU by *role* through discovery; if no
   driver publishes under the GPU role, they fall back to CPU rendering.
5. **One design crack found — `gpu.capnp:231` `vendorCommand @20`.** It leaks register-level knowledge
   into the contract, breaking "GPUs adapt to our API". Recommendation was to remove it, or explicitly
   mark it out-of-contract / diagnostics-only. **Still open — `vendorCommand` is still in the schema.**
6. **Timelessness assessment:** contract is durable, backends are disposable (new crate + one
   `services.toml` entry), HAL hides the platform. One scaling risk: the fixed `buffers: [u64; 64]`
   bump table carved from the framebuffer's last 16 KiB — correctly isolated inside the driver impl,
   not in the contract.
7. **What actually blocks "render via GPU" today:** the *consumer* side. `display-fb-embedded` and the
   console still blit glyphs with CPU writes to the framebuffer. The driver exposes `presentToSurface`;
   the console/compositor are not wired to it. QEMU needs `-device i915 -display gtk,gl=on` (the
   AGENTS.md invocation uses `-display none`, so there is no display at all).
8. **Root cause of the last failure** (`[gpu-intel] init failed: no peer declared the hal-bridge role`):
   `seed_from_kernel` in `uspace/servers/discovery/src/state.rs:94` registers only *names* from the
   kernel image table. Role tags are set only when a service explicitly calls discovery `register` with
   tags (`handlers.rs:56-57`). The `ipc_service!` macro (`uspace/services/ipc-service/src/lib.rs:638`)
   only calls `publish_handler(name, dispatch)` — it never sends a `register` RPC to discovery. So the
   discovery service never learns "hal-bridge" carries the "hal-bridge" role. Design gap, not a code bug.
   Fix options: (a) each service calls discovery `register` with its own role tags in `_start`, or
   (b) discovery auto-assigns each published handler name as a role tag (what the "self-declare"
   comment at `handlers.rs:287-291` implies was intended but never wired).

## Where the session stopped

The last message was the root-cause writeup above (09:32:37). The user's last instruction was
"orchestrate not do it urself it fails redispatch" — the investigation was to be **redispatched to a
subagent, not run inline**. That redispatch never happened; the session died there.

Plan board state left in the DB:

```
0 [completed] (high) Change HAL service role from "hal" to "hal-bridge" (hal/src/main.rs:951)
1 [completed] (high) Uncomment gpu-intel entry in services.toml
2 [completed] (high) Build gpu-intel crate and verify compilation
3 [completed] (high) Build HAL service with new role name and verify
4 [cancelled] (high) Run QEMU boot test with gpu-intel enabled
```

Item 4 was cancelled deliberately: another agent was working in a different session on the same tree
and the user did not want a collision.

## STATE DRIFT since 2026-10-18 — re-check before acting

The two edits that session made **have since been reverted by later work**. Do not assume the tree
still matches the session.

| session change | state now (HEAD `8b36e033`, branch `audit-005-execution`) |
|---|---|
| HAL role `"hal"` -> `"hal-bridge"` | **REVERTED.** `uspace/servers/hal/src/main.rs:1014` is `ipc_service!(Server, Server::const_new(), "hal", 0x10000, Server::runtime_init);` and `:228` announces `"hal"`. Reverted by commit `25271e0a` ("By the owner 5"). |
| uncomment `[services.gpu-intel]` in `services.toml` | **REMOVED.** `services.toml` has no gpu entry at all. Removed by commit `2f31e635`. |
| `gpu-intel` crate | still present: `uspace/servers/gpu-intel/src/main.rs`, 1132 lines. Blitter ring + XY_ opcodes intact. |

So the role mismatch is **live again**: gpu-intel still looks up `"hal-bridge"`
(`uspace/servers/gpu-intel/src/main.rs:58` `const ROLE_HAL: &str = "hal-bridge";`) while HAL
publishes `"hal"`. That is exactly the failure the session diagnosed.

Also verify before relying on it: `git log -S hal-bridge -- uspace/servers/hal/src/main.rs`
(commits `25271e0a`, `1f4f67e5`).

## Next steps, in order

1. **Redispatch the discovery role-tag investigation to a subagent** (the session's last instruction).
   Target: `uspace/servers/discovery/src/state.rs:94` (`seed_from_kernel`) and
   `uspace/servers/discovery/src/handlers.rs:56-57, 287-291`, plus
   `uspace/services/ipc-service/src/lib.rs:638` (`ipc_service!`). Decide fix (a) vs (b).
2. **Decide the HAL role question** — keep `"hal"` and change gpu-intel's `ROLE_HAL` to `"hal"`, or
   re-apply `"hal-bridge"`. Pick one and make both sides agree; do not re-apply the rename blindly,
   since it was deliberately reverted once already.
3. **Re-enable `[services.gpu-intel]`** in `services.toml` if the driver should boot.
4. **Wire the consumer side** — console / `display-fb-embedded` -> `GpuProvider.presentToSurface`.
   This is the actual "shift rendering to GPU" work; everything else is plumbing.
5. **Resolve `gpu.capnp:231` `vendorCommand @20`** — remove it or fence it off as diagnostics-only.
   This is the one design change the session explicitly recommended.
6. **QEMU run** with `-device i915 -display gtk,gl=on` (the AGENTS.md `-display none` invocation
   cannot show GPU output). Verify in the serial log: `[gpu-intel] found Intel ...`,
   `BAR0 mapped ...`, `display pipeline A up`, `blitter ring up`, `render ring up`.

## Related plan files

- `~/naledzi/.kilo/plans/agent-gpu-intel.md` — compile verification for gpu-intel + hal-service
- `~/naledzi/.kilo/plans/1787996276799-login-console-gpu-foundation-plan.md` — the standing
  "real GPU work, console foundation, contract-first" plan (non-negotiable design rules, phases)
- `~/naledzi/protocol/schemas/gpu.capnp` — the contract
- `~/naledzi/protocol/schemas/system.capnp:397, 781` — the CPU-blitter fallback capability flags
