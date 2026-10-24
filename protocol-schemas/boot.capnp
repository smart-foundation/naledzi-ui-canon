@0xa1b2c3d4e5f6003a;

# ═══════════════════════════════════════════════════════════════════════
# Boot - handoff from bootloader to OS, and OS to apps
#
# Stage-transitioning artifacts: firmware/bootloader hands off to kernel;
# kernel announces startup to init; init announces state to apps.
# Each stage produces a BootManifest that the next stage consumes.
# Backends may add stages or fold them; the protocol is timeless.
#
# All identifiers are typed. All durations use T.Duration.
# All timestamps use T.Timestamp. All errors use T.Error.
# Architecture is typed enum with Text fallback.
#
# The ONLY well-known capability in Naledzi:
#   Handle 1 in every process's capability table = KernelService.
#   The kernel MUST place this at handle 1 before entering userspace.
#   This is the bootstrap capability — no other handles are hardcoded.
# ═══════════════════════════════════════════════════════════════════════

using T = import "types.capnp";
using K = import "kernel.capnp";
using FB = import "framebuffer.capnp";

    struct IpcChannel {
        requestArenaVaddr @0 :UInt64;
        requestArenaSize @1 :UInt32;
        replyArenaVaddr @2 :UInt64;
        replyArenaSize @3 :UInt32;
    }

struct BootManifest {
    # Identifier of the producing stage.
    producer @0 :BootStage;
    # Identifier of the intended next stage.
    nextStage @1 :BootStage;
    # Time the producer started.
    startedAt @2 :T.Timestamp;
    # Time the handoff fired.
    finishedAt @3 :T.Timestamp;
    # Duration of this stage.
    duration @4 :T.Duration;

    # Memory plan the next stage inherits.
    memory @5 :List(MemoryRange);

    # Storage devices discovered.
    devices @6 :List(StorageDevice);

    # Logical CPUs / cores available.
    compute @7 :List(ComputeNode);

    # Persistent variables / boot args.
    args @8 :T.StringMap;

    # Optional initrd or initial filesystem blob.
    # For blobs >1KB, use a reference handle instead.
    initrd @9 :BootBlob;

    # Negotiated log level.
    logLevel @10 :T.LogLevel;

    # Capabilities / authority handed to next stage.
    capabilities @11 :List(BootCapability);

    # Firmware information.
    firmware @12 :FirmwareInfo;

    # Boot mode.
    bootMode @13 :BootMode;

    # Secure boot state.
    secureBoot @14 :SecureBootState;

    # Boot diagnostics (timing, warnings).
    diagnostics @15 :List(BootDiagnostic);

    # Partition tables discovered on block devices.
    partitionTables @16 :List(PartitionTable);

    # Network boot information (if applicable).
    networkBoot @17 :NetworkBootInfo;

    # Device tree blob (ARM/RISC-V systems).
    deviceTree @18 :DeviceTreeBlob;

    # Hardware devices discovered.
    hardware @19 :List(HardwareDevice);

    # ACPI tables discovered.
    acpiTables @20 :List(AcpiTable);

    # SMBIOS entries discovered.
    smbios @21 :List(SmbiosEntry);

    # DMI system information.
    dmi @22 :DmiInfo;

    # Bootloader information.
    bootloader @23 :BootloaderInfo;

    # TPM capability.
    tpmCapability @24 :TpmCapability;

    # Initrd metadata (format, compression, modules).
    initrdMetadata @25 :InitrdMetadata;

    # Serial devices discovered.
    serialDevices @26 :List(SerialDevice);

    # Audit-7: boot optimization and resilience.
    # Per-stage timing profile for boot optimization.
    profile @27 :BootStageProfile;
    # Typed boot environment (bareMetal, container, vm, etc.).
    environment @28 :BootEnvironment;
    # Ordered failover chains for boot resilience.
    failoverChains @29 :List(FailoverChain);
    # Capability requests from each stage.
    capabilityRequests @30 :List(BootCapabilityRequest);

    # ── Naledzi Bootstrap ─────────────────────────────────────────────────
    # The ONLY hardcoded capability in Naledzi.
    # Every process's capability table at handle 1 is KernelService.
    # The kernel places this here so init and all subsequent processes
    # can immediately call spawn(), exec(), mapRegion(), etc.
    # All other capabilities are dynamic — issued by KernelService or services.
    kernelService @31 :K.KernelService;
    # Framebuffer (mode + physical address). The kernel renders the boot
    # screen from this; in the SAS model the kernel maps the physical
    # range via HHDM and writes pixels.
    framebuffer @32 :FB.Framebuffer;
    # The boot path exposes a long-lived capnp BootService peer channel
    # (request/response). The kernel reads this capability from the manifest
    # and calls methods on it (handOff, state, subscribe, configureCompute,
    # enableHardwareDevice, etc.) — never via a side-channel Rust API.
    bootService @33 :BootService;
    # IPC channels mapped to userspace-accessible shared memory.
    # The kernel populates this list so init can discover channel addresses.
    channels @34 :List(IpcChannel);
    # All userland images the bootloader handed us.
    userlandImages @35 :List(T.UserlandImage);
    # Isolation boundaries declared at boot.
    isolationManifest @36 :List(T.IsolatedScope);
    # Binary data blobs referenced by UserlandImage.moduleIndex.
    modules @37 :List(Module);
    # Virtual address where kernel places BootstrapInfo for each service.
    bootstrapVaddr @38 :UInt64;

    # ── Kernel selection ────────────────────────────────────────────────────
    # Which kernel envelopes this boot offers, and which one was chosen.
    #
    # This was previously a struct nobody referenced: KernelSelection existed
    # (boot.capnp:1194) and the only entry was a hardcoded literal in the
    # bootloader. That combination is the worst of both — a schema that
    # describes a menu the menu does not have, and a selection that is a
    # string in a build script rather than data anyone can read at runtime.
    #
    # Carrying it here makes boot-time envelope selection expressible without
    # inventing anything: `available` is what the bootloader found, `selected`
    # is what it actually chose, and `defaultIndex` is what it would have
    # chosen with no input. All three are populated from the same enumeration.
    #
    # `selected` and `defaultIndex` are the honesty-critical pair. A manifest
    # that lists one envelope and selects nothing is telling you the truth
    # ("no choice was made"); a manifest that selects index 0 of 1 is claiming
    # a decision was taken when none was. Both are representable, which is the
    # point — `selectedPresent` distinguishes them.
    kernels @39 :KernelSelectionSet;

    # How the kernel should schedule the services this manifest names.
    #
    # The build states the intent; the kernel carries it out. A service
    # that is not listed keeps the default class (an IPC service), and
    # the kernel says so in its own log rather than guessing.
    serviceSchedule @40 :List(ServiceSchedule);
}

# What the build says about how one service should be scheduled.
#
# The class is a property of the *service*, not of the kernel: the
# kernel does not decide which services matter, the build that ships
# them does. Three classes, lowest number first:
#
#   0 = kernel-critical: the machine cannot run without this service.
#   1 = IPC service: a client may be waiting for it.
#   2 = ordinary: it is on nobody's critical path.
struct ServiceSchedule {
    # Index into `BootManifest.userlandImages`.
    imageIndex @0 :UInt32;

    # The scheduling class: 0 = kernel-critical, 1 = IPC service,
    # 2 = ordinary.
    priority @1 :UInt16;
}

# The boot-time kernel menu.
#
# `available` is an enumeration, not a hardcoded list. `selectedPresent` is
# false on an unattended boot where no menu was shown and no default was
# applied by a selection step — the kernel was reached by falling through, and
# saying so is more useful than claiming a choice was made.
struct KernelSelectionSet {
    # Every envelope this boot can hand control to, in menu order.
    available @0 :List(KernelSelection);

    # Index into `available` of the envelope control was actually passed to.
    # Meaningful only when `selectedPresent` is true; a client that reads this
    # without checking the flag will index whatever happens to be at that
    # position, which is the exact failure this flag exists to prevent.
    selectedIndex @1 :UInt32;
    selectedPresent @2 :Bool;

    # Index the boot flow would have chosen with no user input. Separate from
    # selectedIndex because they differ whenever a human (or a supervisor)
    # overrode the default, and "the default was overridden" is worth knowing.
    defaultIndex @3 :UInt32;
    defaultPresent @4 :Bool;

    # Why the selection came out as it did, for a boot log. Empty is not an
    # acceptable value for an override — record the source, so a boot that
    # entered an unexpected kernel can be explained after the fact.
    selectedBy @5 :KernelSelectionSource;
}

enum KernelSelectionSource {
    # Nothing selected: single-envelope boot, control fell through. This is
    # the common case on a normal boot and is stated, not implied.
    fallthrough @0;
    # The default entry of `available`, applied without user input.
    defaultEntry @1;
    # A human chose from the boot menu.
    interactiveMenu @2;
    # A supervisor, hypervisor or configuration chose it.
    externalRequest @3;
    # Previous boot failed; this was a failover.
    failover @4;
    custom @5;
}

struct BootBlob {
    union {
        inline @0 :Data;
        reference @1 :BootBlobRef;
    }
    # Metadata about the blob (format, compression, modules).
    metadata @2 :InitrdMetadata;
}

struct BootBlobRef {
    handle @0 :UInt64;
    sizeBytes @1 :UInt64;
    hash @2 :Data;
    format @3 :Text;
}

enum BootStage {
    firmware @0;
    bootloader @1;
    kernel @2;
    init @3;
    userspace @4;
    custom @5;
    # Audit-7: extended boot stages for container/VM/embedded.
    container @6;
    hypervisor @7;
    wasm @8;
    embedded @9;
}

struct MemoryRange {
    base @0 :UInt64;
    length @1 :UInt64;
    kind @2 :MemoryKind;
    # Typed memory flags instead of raw UInt32.
    flags @3 :MemoryFlags;
}

struct MemoryFlags {
    cacheable @0 :Bool;
    writeCombining @1 :Bool;
    writeProtected @2 :Bool;
    executeDisabled @3 :Bool;
    nonVolatile @4 :Bool;
}

enum MemoryKind {
    ram @0;
    rom @1;
    mmio @2;
    acpi @3;
    persistent @4;
    reserved @5;
    unusable @6;
    device @7;
    bootloader @8;
    kernel @9;
    user @10;
    custom @11;
}

struct StorageDevice {
    id @0 :Text;
    # Backend-assigned device identifier (opaque to the protocol).
    deviceId @1 :Text;
    kind @2 :StorageKind;
    sectors @3 :UInt64;
    sectorBytes @4 :UInt32;
    # Typed capabilities instead of List(Text).
    capabilities @5 :List(StorageCapability);
    # Human-readable name.
    name @6 :Text;
    # Total size in bytes.
    sizeBytes @7 :UInt64;
    # Storage bus protocol.
    bus @8 :StorageBus;
    # Partition table on this device (if applicable).
    partitionTable @9 :PartitionTable;
    # Bus-specific info (backend populates the relevant one).
    # NVMe-specific info (if bus is nvme).
    nvmeInfo @10 :NvmeInfo;
    # AHCI-specific info (if bus is ahci).
    ahciInfo @11 :AhciInfo;
    # SCSI-specific info (if bus is scsi).
    scsiInfo @12 :ScsiInfo;
}

enum StorageKind {
    block @0;
    network @1;
    memory @2;
    optical @3;
    virtual @4;
    removable @5;
    persistent @6;
    custom @7;
}

enum StorageCapability {
    read @0;
    write @1;
    trim @2;
    flush @3;
    secureErase @4;
    cache @5;
    custom @6;
}

enum StorageBus {
    nvme @0;
    ahci @1;
    ide @2;
    scsi @3;
    virtio @4;
    sd @5;
    emmc @6;
    fsblk @7;
    usb @8;
    fcoe @9;
    custom @10;
}

struct NvmeInfo {
    controllerId @0 :UInt32;
    namespaceId @1 :UInt32;
    queueCount @2 :UInt32;
    maxTransferSize @3 :UInt32;
    nvmeVersion @4 :Text;
    lbaFormat @5 :UInt32;
    utilization @6 :UInt64;
}

struct AhciInfo {
    port @0 :UInt32;
    deviceType @1 :Text;
    commandListDepth @2 :UInt32;
    signature @3 :UInt32;
}

struct ScsiInfo {
    targetId @0 :UInt32;
    lun @1 :UInt32;
    vendor @2 :Text;
    product @3 :Text;
    revision @4 :Text;
    scsiVersion @5 :Text;
}

enum PartitionTableKind {
    gpt @0;
    mbr @1;
    apt @2;
    sun @3;
    custom @4;
}

struct PartitionTable {
    kind @0 :PartitionTableKind;
    diskGuid @1 :Text;
    entryCount @2 :UInt32;
    backupLba @3 :UInt64;
    currentLba @4 :UInt64;
    partitions @5 :List(Partition);
}

struct Partition {
    index @0 :UInt32;
    typeGuid @1 :Text;
    uniqueGuid @2 :Text;
    firstLba @3 :UInt64;
    lastLba @4 :UInt64;
    sizeBytes @5 :UInt64;
    name @6 :Text;
    attributes @7 :UInt64;
    bootable @8 :Bool;
    filesystem @9 :Text;
}

struct ComputeNode {
    id @0 :Text;
    # Typed architecture enum with Text fallback.
    arch @1 :Architecture;
    vendor @2 :Text;
    cores @3 :UInt32;
    threads @4 :UInt32;
    # Typed CPU feature flags.
    features @5 :List(CpuFeature);
    # Clock speed in MHz (0 if unknown).
    clockMhz @6 :UInt32;
    # L1 cache size in bytes (0 if unknown).
    l1CacheBytes @7 :UInt32;
    # L2 cache size in bytes (0 if unknown).
    l2CacheBytes @8 :UInt32;
}

enum Architecture {
    x86 @0;
    x8664 @1;
    arm32 @2;
    aarch64 @3;
    riscv32 @4;
    riscv64 @5;
    wasm32 @6;
    wasm64 @7;
    ppc64 @8;
    s390x @9;
    unknown @10;
    custom @11;
}

enum CpuFeature {
    sse @0;
    sse2 @1;
    sse3 @2;
    ssse3 @3;
    sse41 @4;
    sse42 @5;
    avx @6;
    avx2 @7;
    avx512 @8;
    neon @9;
    fp16 @10;
    atomics @11;
    riscvV @12;
    wasmSimd @13;
    custom @14;
}

struct FirmwareInfo {
    vendor @0 :Text;
    version @1 :Text;
    # Firmware type.
    kind @2 :FirmwareKind;
    # UEFI/BIOS/Libreboot/coreboot version string.
    firmwareVersion @3 :Text;
    # Secure boot database status.
    secureBootDb @4 :Text;
}

enum FirmwareKind {
    uefi @0;
    bios @1;
    coreboot @2;
    libreboot @3;
    uBoot @4;
    bareMetal @5;
    custom @6;
}

enum BootMode {
    normal @0;
    recovery @1;
    safe @2;
    diagnostic @3;
    maintenance @4;
    custom @5;
}

struct SecureBootState {
    enabled @0 :Bool;
    # Whether the boot chain is verified.
    verified @1 :Bool;
    # TPM PCR measurements (if available).
    pcrMeasurements @2 :List(PcrMeasurement);
    # Signing key database status.
    keyDatabaseStatus @3 :Text;
    # TPM version detected.
    tpmVersion @4 :TpmVersion;
    # TPM capability information.
    tpmCapability @5 :TpmCapability;
    # Attestation quote (if available).
    attestation @6 :AttestationQuote;
    # Audit-7: chain-of-trust attestation items.
    chainItems @7 :List(BootChainItem);
    # Audit-7: boot policy (required/optional stages).
    policy @8 :BootPolicy;
    # Audit-7: typed boot environment.
    environment @9 :BootEnvironment;
}

struct PcrMeasurement {
    index @0 :UInt32;
    algorithm @1 :Text;
    digest @2 :Data;
}

enum TpmVersion {
    tpm12 @0;
    tpm20 @1;
    custom @2;
}

enum TpmAlgorithm {
    sha1 @0;
    sha256 @1;
    sha384 @2;
    sha512 @3;
    custom @4;
}

struct TpmCapability {
    version @0 :TpmVersion;
    pcrBanks @1 :List(TpmPcrBank);
    nvStorage @2 :Bool;
    keyStorage @3 :Bool;
    attestation @4 :Bool;
}

struct TpmPcrBank {
    algorithm @0 :TpmAlgorithm;
    pcrCount @1 :UInt32;
}

struct AttestationQuote {
    pcrSelection @0 :List(UInt32);
    pcrValues @1 :List(Data);
    signature @2 :Data;
    timestamp @3 :T.Timestamp;
}

enum BootloaderKind {
    grub @0;
    grub2 @1;
    refind @2;
    shim @3;
    uBoot @4;
    barebox @5;
    custom @6;
    limine @7;
}

struct BootloaderInfo {
    kind @0 :BootloaderKind;
    version @1 :Text;
    configPath @2 :Text;
    secureBootChain @3 :Bool;
    shimTrustAnchor @4 :Text;
    hhdmOffset @5 :UInt64;
}

enum NetworkBootMethod {
    pxe @0;
    http @1;
    ipxe @2;
    iscsi @3;
    custom @4;
}

struct NetworkBootInfo {
    method @0 :NetworkBootMethod;
    dhcpLease @1 :DhcpLease;
    serverAddress @2 :Text;
    bootFile @3 :Text;
    httpUrl @4 :Text;
    proxy @5 :Text;
}

struct DhcpLease {
    ip @0 :Text;
    subnet @1 :Text;
    gateway @2 :Text;
    dns @3 :List(Text);
    leaseTime @4 :T.Duration;
    serverName @5 :Text;
}

struct DeviceTreeBlob {
    handle @0 :UInt64;
    sizeBytes @1 :UInt64;
    hash @2 :Data;
    compatible @3 :List(Text);
    overlay @4 :Bool;
}

struct HardwareDevice {
    id @0 :Text;
    class @1 :Text;
    vendor @2 :Text;
    model @3 :Text;
    drivers @4 :List(Text);
    dtCompatible @5 :List(Text);
    acpiPath @6 :Text;
}

struct AcpiTable {
    signature @0 :Text;
    oemId @1 :Text;
    revision @2 :UInt32;
    sizeBytes @3 :UInt32;
    handle @4 :UInt64;
}

struct SmbiosEntry {
    type @0 :UInt32;
    length @1 :UInt32;
    handle @2 :UInt16;
    data @3 :Data;
}

struct DmiInfo {
    systemManufacturer @0 :Text;
    systemProductName @1 :Text;
    biosVersion @2 :Text;
    biosVendor @3 :Text;
    chassisType @4 :Text;
    chassisManufacturer @5 :Text;
    boardManufacturer @6 :Text;
    boardProductName @7 :Text;
}

enum InitrdFormat {
    cpioGz @0;
    cpioXz @1;
    cpioZstd @2;
    erofs @3;
    squashfs @4;
    none @5;
    custom @6;
}

struct InitrdMetadata {
    format @0 :InitrdFormat;
    compression @1 :Text;
    sizeBytes @2 :UInt64;
    hash @3 :Data;
    rootFilesystem @4 :Text;
    kernelModules @5 :List(Text);
}

enum UartParity {
    none @0;
    odd @1;
    even @2;
    mark @3;
    space @4;
    custom @5;
}

enum UartFlowControl {
    none @0;
    hardware @1;
    software @2;
    custom @3;
}

struct UartConfig {
    baudRate @0 :UInt32;
    dataBits @1 :UInt8;
    stopBits @2 :UInt8;
    parity @3 :UartParity;
    flowControl @4 :UartFlowControl;
}

struct SerialDevice {
    port @0 :Text;
    irq @1 :UInt32;
    dmaChannel @2 :UInt32;
    uartConfig @3 :UartConfig;
    fifoDepth @4 :UInt32;
}

struct BootDiagnostic {
    stage @0 :BootStage;
    message @1 :Text;
    level @2 :T.LogLevel;
    timestamp @3 :T.Timestamp;
    # Duration of the operation being diagnosed.
    duration @4 :T.Duration;
}

struct BootState {
    # Currently active stage.
    currentStage @0 :BootStage;
    # All stages that have completed.
    completed @1 :List(BootStage);
    # All stages remaining.
    pending @2 :List(BootStage);
    # Total boot time so far.
    totalDuration @3 :T.Duration;
}

# Capability filter extension for boot - which authority level a stage holds.
struct BootAuthority {
    level @0 :AuthorityLevel;
    # Specific stage tokens available.
    stages @1 :List(BootStage);
}

enum AuthorityLevel {
    firmware @0;
    bootloader @1;
    kernel @2;
    init @3;
    userspace @4;
    custom @5;
}

enum BootCapability {
    readMemory @0;
    writeMemory @1;
    readStorage @2;
    writeStorage @3;
    executeCode @4;
    accessDevice @5;
    configureCompute @6;
    modifyBootArgs @7;
    networkAccess @8;
    custom @9;
}

# Boot service — user-facing boot state and configuration.
# Methods report REAL data read verbatim from the BootManifest handoff
# (bootloader→kernel→init). The boot service never fabricates values: it
# reports exactly what the firmware/bootloader handed us. capnp is the
# only contract; no host files are read by this service.
interface BootService {
    # Get the current boot information (firmware, bootloader, timing, arch).
    getInfo @0 () -> (info :BootInfo);

    # Get boot parameters (timeout, menu, quiet/debug flags, cmdline).
    getParameters @1 () -> (params :BootParameters);

    # Set boot parameters (applied on the next boot).
    setParameters @2 (params :BootParameters) -> T.VoidResult;

    # List boot entries (OS/kernel options).
    listEntries @3 () -> (entries :List(BootEntry));

    # Get the default boot entry.
    getDefaultEntry @4 () -> (entry :BootEntry);

    # Set the default boot entry.
    setDefaultEntry @5 (entryId :Text) -> T.VoidResult;

    # Set the boot entry for the next boot only (one-shot).
    setNextBootEntry @6 (entryId :Text) -> T.VoidResult;

    # Get boot log, filtered.
    getBootLog @7 (filter :BootLogFilter) -> (entries :List(BootLogEntry), total :UInt32);

    # Get boot splash configuration.
    getSplashConfig @8 () -> (config :BootSplashConfig);

    # Set boot splash configuration.
    setSplashConfig @9 (config :BootSplashConfig) -> T.VoidResult;

    # Enable/disable recovery mode on the next boot.
    setRecoveryMode @10 (enable :Bool) -> T.VoidResult;

    # Get recovery mode status.
    getRecoveryMode @11 () -> (enabled :Bool, reason :Text);

    # Get secure boot status.
    getSecureBoot @12 () -> (status :SecureBootStatus);

    # List secure boot keys.
    listSecureBootKeys @13 () -> (keys :List(SecureBootKey));

    # Get boot attempt counters (for A/B slot rotation).
    getBootAttempts @14 () -> (attempts :BootAttempts);

    # Mark the current boot as successful (resets the A/B attempt counter).
    markBootSuccessful @15 () -> T.VoidResult;

    # Subscribe to boot events.
    subscribe @16 () -> (subscription :BootSubscription);
}

# ── Boot Info ───────────────────────────────────────────────────────────
# Real boot facts, populated verbatim from the BootManifest handoff.

struct BootInfo {
    # Unique boot identifier (derived from the manifest's startedAt timestamp
    # — stable and unique per physical boot, needs no extra kernel field).
    bootId @0 :UInt64;
    # Boot method (how we got here).
    method @1 :BootMethod;
    # Firmware type.
    firmware @2 :FirmwareType;
    # Firmware version string (vendor-provided, verbatim).
    firmwareVersion @3 :Text;
    # Bootloader name (verbatim from manifest).
    bootloader @4 :Text;
    # Bootloader version (verbatim from manifest).
    bootloaderVersion @5 :Text;
    # Kernel command line (from the manifest args map).
    kernelCommandLine @6 :Text;
    # Boot duration (firmware start → userspace ready).
    bootDuration @7 :T.Duration;
    # Whether this was a cold boot.
    coldBoot @8 :Bool;
    # Target architecture (from the first compute node).
    architecture @9 :Text;
}

enum BootMethod {
    efi @0;
    bios @1;
    coreboot @2;
    uboot @3;
    petitboot @4;
    custom @5;
}

enum FirmwareType {
    uefi @0;
    legacy @1;
    coreboot @2;
    openFirmware @3;
    custom @4;
}

struct BootParameters {
    # Kernel command line arguments.
    kernelArgs @0 :List(Text);
    # Boot timeout (seconds; 0 = none, negative = wait forever).
    timeout @1 :Int32;
    # Default entry id.
    defaultEntry @2 :Text;
    # Whether the boot menu is shown.
    showMenu @3 :Bool;
    # Whether graphical boot is used.
    graphicalBoot @4 :Bool;
    # Whether verbose/debug boot output is enabled.
    debugMode @5 :Bool;
    # Whether quiet boot is enabled.
    quietMode @6 :Bool;
    # Custom parameters.
    custom @7 :T.StringMap;
}

struct BootEntry {
    id @0 :Text;
    title @1 :Text;
    description @2 :Text;
    # Kernel path.
    kernel @3 :Text;
    # Initrd/initramfs path.
    initrd @4 :Text;
    # Kernel command line for this entry.
    kernelArgs @5 :List(Text);
    # Architecture.
    architecture @6 :Text;
    # Whether this is the default entry.
    default @7 :Bool;
    # Whether this entry is bootable.
    bootable @8 :Bool;
    # Whether this entry is a recovery entry.
    recovery @9 :Bool;
    # Last boot time.
    lastBooted @10 :T.Timestamp;
    # Whether the last boot of this entry succeeded.
    lastBootSuccess @11 :Bool;
}

struct BootLogEntry {
    timestamp @0 :T.Timestamp;
    # Which phase the entry occurred in.
    phase @1 :BootPhase;
    # Severity (shared LogLevel from types.capnp).
    level @2 :T.LogLevel;
    subsystem @3 :Text;
    message @4 :Text;
    duration @5 :T.Duration;
}

enum BootPhase {
    firmware @0;
    bootloader @1;
    kernelInit @2;
    initrd @3;
    init @4;
    services @5;
    userspace @6;
}

struct BootLogFilter {
    phases @0 :List(BootPhase);
    levels @1 :List(T.LogLevel);
    subsystems @2 :List(Text);
    since @3 :T.Timestamp;
    pattern @4 :Text;
}

struct BootSplashConfig {
    enabled @0 :Bool;
    theme @1 :Text;
    backgroundColor @2 :Text;
    # Logo path (verbatim from manifest/assets).
    logoPath @3 :Text;
    progressBar @4 :SplashProgressBar;
    # Background image path (optional).
    backgroundImage @5 :Text;
}

enum SplashProgressBar {
    none @0;
    line @1;
    blocks @2;
    pie @3;
    custom @4;
}

# Secure boot status reported verbatim from the manifest's SecureBootState.
struct SecureBootStatus {
    enabled @0 :Bool;
    # Whether the boot chain was verified.
    verified @1 :Bool;
    # Signing key database status text.
    keyDatabaseStatus @2 :Text;
    # TPM version (local TpmVersion enum defined below).
    tpmVersion @3 :TpmVersion;
}

struct SecureBootKey {
    id @0 :Text;
    # Key type (PK, KEK, db, dbx).
    keyType @1 :Text;
    # Owner of the key.
    owner @2 :Text;
    # Valid from.
    validFrom @3 :T.Timestamp;
    # Valid to.
    validTo @4 :T.Timestamp;
}

# A/B boot attempt counters, reported verbatim from the manifest's abSlotState.
struct BootAttempts {
    # Current attempt count for the active slot.
    current @0 :UInt32;
    # Maximum attempts before fallback.
    max @1 :UInt32;
    # Whether the active slot is marked successful.
    successful @2 :Bool;
    # Last successful boot time.
    lastSuccessful @3 :T.Timestamp;
}

struct BootEvent {
    union {
        stageStarted @0 :BootManifest;
        stageFinished @1 :BootManifest;
        commFailed @2 :CommFailure;
        diagnosticsReady @3 :List(BootDiagnostic);
    }
}

struct CommFailure {
    stage @0 :BootStage;
    reason @1 :T.Error;
    retryHint @2 :T.Duration;
    recoveryAction @3 :RecoveryAction;
}

enum RecoveryAction {
    retry @0;
    skip @1;
    fallback @2;
    halt @3;
    custom @4;
}

interface BootSubscription {
    # Deprecated: use pullPaginated for bounded results.
    pull @0 () -> (events :List(BootEvent));
    cancel @1 () -> T.VoidResult;
    # Paginated pull — returns at most `limit` events starting from `offset`.
    pullPaginated @2 (pagination :T.Pagination) -> (result :BootPullResult);
}

struct BootPullResult {
    events    @0 :List(BootEvent);
    totalCount @1 :UInt32;
}

# ═══════════════════════════════════════════════════════════════════════
# Audit-7: Extended boot capabilities
#
# Boot attestation chain, boot analytics, multi-environment boot,
# failover chains, and boot policy. These extend the basic
# firmware-to-userspace model to support container, VM, embedded,
# and distributed boot scenarios.
# ═══════════════════════════════════════════════════════════════════════

# ── Boot Chain Attestation ────────────────────────────────────

struct BootChainItem {
    # Stage that produced this attestation.
    stage @0 :BootStage;
    # Cryptographic hash of the next stage's expected state.
    hash @1 :Data;
    # Algorithm used for the hash.
    algorithm @2 :TpmAlgorithm;
    # Timestamp of this attestation.
    timestamp @3 :T.Timestamp;
}

# ── Boot Stage Profile (analytics) ────────────────────────────

struct BootStageProfile {
    # Stage being profiled.
    stage @0 :BootStage;
    # Duration of this stage in the current boot.
    duration @1 :T.Duration;
    # Historical average duration (rolling window).
    averageDuration @2 :T.Duration;
    # Whether this stage exceeded its time budget.
    exceeded @3 :Bool;
    # CPU time consumed by this stage.
    cpuTime @4 :T.Duration;
    # Memory peak during this stage.
    memoryPeakBytes @5 :UInt64;
}

# ── Boot Environment ──────────────────────────────────────────

enum BootEnvironment {
    bareMetal @0;
    container @1;
    vm @2;
    wasm @3;
    embedded @4;
    hypervisor @5;
    custom @6;
}

# ── Boot Policy ───────────────────────────────────────────────

struct BootPolicy {
    # Stages that must complete for a successful boot.
    required @0 :List(BootStage);
    # Stages that are optional (failure does not block boot).
    optional @1 :List(BootStage);
    # Maximum total boot time before forced escalation.
    maxBootTime @2 :T.Duration;
}

# ── Failover Chain ────────────────────────────────────────────

struct FailoverChain {
    # Primary stage to attempt.
    primary @0 :BootStage;
    # Ordered list of fallback stages.
    fallbacks @1 :List(BootStage);
    # Maximum retries per stage before falling back.
    maxRetries @2 :UInt32;
}

# ── Boot Capability Request ───────────────────────────────────

struct BootCapabilityRequest {
    # Stage requesting the capability.
    stage @0 :BootStage;
    # Capabilities required from the previous stage.
    required @1 :List(BootCapability);
    # Capabilities that are nice-to-have.
    preferred @2 :List(BootCapability);
}

# ── A/B Partition Boot ────────────────────────────────────────

struct AbPartitionState {
    # Currently active boot slot ("a" or "b").
    activeSlot @0 :Text;
    # Boot attempt count for the active slot.
    bootAttempts @1 :UInt32;
    # Maximum boot attempts before fallback.
    maxBootAttempts @2 :UInt32;
    # Whether the slot has been marked successful.
    slotSuccessful @3 :Bool;
    # Last update timestamp.
    lastUpdate @4 :T.Timestamp;
}

# ═══════════════════════════════════════════════════════════════════════
# Audit-9: Extended boot capabilities
#
# Attestation chain verification, firmware update protocol, network boot
# orchestration, hardware enablement, and capability delegation.
# ═══════════════════════════════════════════════════════════════════════

# ── Attestation Verification ──────────────────────────────────

struct AttestationVerificationResult {
    # Whether the full chain is valid.
    valid @0 :Bool;
    # Per-item verification results.
    items @1 :List(AttestationItemResult);
    # Error if chain verification failed.
    error @2 :T.Error;
    # When verification was performed.
    verifiedAt @3 :T.Timestamp;
}

struct AttestationItemResult {
    stage @0 :BootStage;
    valid @1 :Bool;
    error @2 :T.Error;
}

# ── Firmware Update Protocol ──────────────────────────────────

struct FirmwareUpdateRequest {
    # Target firmware version.
    targetVersion @0 :Text;
    # Firmware image data or URI.
    imageUri @1 :T.Uri;
    # Expected hash of the firmware image.
    expectedHash @2 :Data;
    # Algorithm used for hash verification.
    hashAlgorithm @3 :TpmAlgorithm;
    # Whether to verify signature before applying.
    verifySignature @4 :Bool = true;
    # Maximum time to wait for the update.
    timeout @5 :T.Duration;
}

struct FirmwareUpdateResult {
    union {
        success @0 :FirmwareUpdateSuccess;
        failed @1 :T.Error;
        custom @2 :Data;
    }
}

struct FirmwareUpdateSuccess {
    # New firmware version after update.
    version @0 :Text;
    # When the update completed.
    completedAt @1 :T.Timestamp;
    # Whether a restart is required.
    requiresRestart @2 :Bool;
}

# ── Network Boot Orchestration ────────────────────────────────

struct NetworkBootConfig {
    # Ordered list of boot methods to try.
    methods @0 :List(NetworkBootMethod);
    # DHCP configuration (if applicable).
    dhcp @1 :DhcpConfig;
    # TFTP server configuration.
    tftp @2 :TftpConfig;
    # iSCSI configuration (if applicable).
    iscsi @3 :IscsiConfig;
    # Maximum retry attempts per method.
    maxRetries @4 :UInt32;
    # Timeout per boot method attempt.
    attemptTimeout @5 :T.Duration;
    # Failover policy on method failure.
    failoverPolicy @6 :NetworkBootFailoverPolicy;
}

struct DhcpConfig {
    # Interface to use for DHCP.
    interface @0 :Text;
    # Requested IP address (optional).
    requestedIp @1 :Text;
    # Vendor class identifier.
    vendorClass @2 :Text;
}

struct TftpConfig {
    # TFTP server address.
    server @0 :Text;
    # Boot file path on TFTP server.
    bootFile @1 :Text;
    # Block size for TFTP transfers.
    blockSize @2 :UInt32;
}

struct IscsiConfig {
    # iSCSI target address.
    targetAddress @0 :Text;
    # iSCSI target name.
    targetName @1 :Text;
    # iSCSI initiator name.
    initiatorName @2 :Text;
    # LUN number.
    lun @3 :UInt32;
}

enum NetworkBootFailoverPolicy {
    # Try next method in sequence.
    sequential @0;
    # Try all methods in parallel, use first success.
    parallel @1;
    # Stop on first failure.
    strict @2;
    custom @3;
}

# ── Capability Delegation Chain ───────────────────────────────

struct CapabilityDelegationRequest {
    # Source stage that holds the capability.
    sourceStage @0 :BootStage;
    # Target stage to receive the capability.
    targetStage @1 :BootStage;
    # Capabilities to delegate.
    capabilities @2 :List(BootCapability);
    # Subset of capabilities to delegate (if delegating a subset).
    subset @3 :List(BootCapability);
    # Expiry for the delegation.
    expiry @4 :T.Duration;
    # Whether the target can further delegate.
    transitive @5 :Bool;
}

# ═══════════════════════════════════════════════════════════════════════
# Boot-Agnostic Additions
#
# These additions enable:
# - Multiple bootloader support
# - Boot protocol detection (not hardcoded to one protocol)
# - Kernel selection at boot time (runtime + compile-time)
# - Binary format typing for cross-language kernel loading
# ═══════════════════════════════════════════════════════════════════════

# ── Boot Protocol Detection ───────────────────────────────────
# The kernel detects WHICH protocol delivered the boot, not which
# specific bootloader binary. This is the agnostic layer.

enum BootProtocolKind {
    limine @0;
    multibootV1 @1;
    multibootV2 @2;
    uefi @3;
    deviceTree @4;
    openBoot @5;
    custom @6;
}

struct BootProtocolInfo {
    kind @0 :BootProtocolKind;
    version @1 :Text;
    # Protocol-specific magic value (e.g., 0x2BADB002 for Multiboot1).
    magicValue @2 :UInt64;
    # Physical address of the response struct (protocol-specific).
    responseAddr @3 :UInt64;
    # Physical address of the request struct (if applicable).
    requestAddr @4 :UInt64;
}

# ── Kernel Selection (Boot-Time Polymorphism) ─────────────────
# Enables runtime kernel selection via boot menu.
# Kernels show up in boot menu, selectable at runtime.

struct KernelSelection {
    # The kernel envelope type (from kernel.capnp).
    envelope @0 :K.KernelType;
    # Unique identifier for this kernel implementation.
    implementationId @1 :Text;
    # Binary format of the kernel (ELF, PE, WASM, etc.).
    binaryFormat @2 :T.BinaryFormat;
    # Offset of the entry point from the binary base.
    entryPointOffset @3 :UInt64;
    # ABI version this kernel conforms to.
    abiVersion @4 :T.Version;
    # Human-readable name for boot menu display.
    displayName @5 :Text;
    # Architecture this kernel targets.
    architecture @6 :Text;
}

# ── Bootloader Implementation Info ────────────────────────────
# Identifies which specific bootloader produced this manifest.
# Used for debugging and bootloader-specific features.

struct BootloaderImplementation {
    # Bootloader name (e.g., "naledzi-boot", "helenos-boot").
    name @0 :Text;
    # Version string.
    version @1 :Text;
    # Source repository URL.
    sourceRepository @2 :Text;
    # Git commit hash (20 bytes).
    commitHash @3 :Data;
    # Build artifact hash (SHA-256).
    buildId @4 :Data;
    # Target triple (e.g., "x86_64-unknown-none").
    targetTriple @5 :Text;
}

# ── Boot Origin ───────────────────────────────────────────────
# How this boot stage was initiated.

enum BootOrigin {
    firmwareDirect @0;     # Firmware handed control directly to kernel
    bootloaderLoaded @1;   # Bootloader loaded kernel (current model)
    chainload @2;          # Bootloader A loaded us via bootloader B
    networkBoot @3;        # PXE/iPXE/HTTP boot
    recursiveBoot @4;      # This stage is itself in a chainload
    custom @5;
}

# ── Boot Chain (Multi-Stage Handoff) ─────────────────────────
# Supports multi-stage: firmware -> bootloader -> kernel-1 -> kernel-2

struct BootChainEntry {
    stage @0 :BootStage;
    bootloader @1 :BootloaderImplementation;
    kernel @2 :KernelSelection;
    # Pointer to this stage's manifest (physical address).
    manifestAddr @3 :UInt64;
    # Index of next entry in the chain, or 0xFFFFFFFF if last.
    nextChainEntry @4 :UInt32;
}

struct BootChain {
    entries @0 :List(BootChainEntry);
    # Index of the current entry in the chain.
    currentIndex @1 :UInt32;
}

# ── Handoff Resources (Kernel-Swap Support) ──────────────────
# When kernel-2 boots after kernel-1 was swapped out, it needs:
# - Memory map kernel-1 left behind
# - IO devices kernel-1 was using
# - Persistent state (filesystem, network)
# - Capability tokens passed through

struct BootHandoffResources {
    # Memory ranges released by previous kernel.
    memoryReleased @0 :List(MemoryRange);
    # IO devices transferred from previous kernel.
    ioTransferred @1 :List(HardwareDevice);
    # Handles to persistent state (filesystem, network).
    persistentStateHandles @2 :List(UInt64);
    # Capabilities passed through from previous kernel.
    capabilitiesPassed @3 :List(BootCapability);
}

# ── Boot Handoff ──────────────────────────────────────────────
# The schema takes ownership of every memory handoff.
# 24 bytes at a well-known address, then everything is capnp.

struct HandoffPointer {
    # 0x534D4152545F5052 = "SMART_PR" (truncated to fit UInt64).
    magic        @0 :UInt64;
    # Virtual address of the BootHandoff capnp message (kernel pre-maps it).
    handoffAddr  @1 :UInt64;
    handoffBytes @2 :UInt64;
}

struct BootHandoff {
    abiVersion       @0 :T.Version;
    producer         @1 :BootStage;
    entryContext     @2 :T.EntryContext;
    manifest         @3 :BootManifest;
    serviceEndpoints @4 :List(ServiceEndpoint);
    channels         @5 :List(ChannelInfo);
    images           @6 :List(BootImage);
    # Reserved: ordinal 7 was previously skipped. Reclaimed as
    # `reserved @7 :Void` so the union remains sequentially
    # numbered; never set or read by current code.
    reserved         @7 :Void;
    # Virtual address of the kernel's handler table. Services write their
    # dispatch fn pointer here at their channel slot index.
    handlerTableVaddr @8 :UInt64;
}

struct Module {
    name @0 :Text;
    # Virtual address where the bootloader's module bytes already live
    # (HHDM-mapped by the bootloader, address-stable for the kernel's
    # lifetime). The kernel reads the bytes in place — zero copy, no
    # stash, no embedded blob. `size` is the byte length.
    vaddr @1 :UInt64;
    size @2 :UInt64;
    hash @3 :Data;
}

struct ChannelInfo {
    requestArenaVaddr @0 :UInt64;
    requestArenaSize @1 :UInt32;
    replyArenaVaddr @2 :UInt64;
    replyArenaSize @3 :UInt32;
    # Virtual address of the request doorbell (caller bumps to signal arrival).
    requestDoorbellVaddr @4 :UInt64;
    # Virtual address of the reply doorbell (service bumps after writing reply).
    replyDoorbellVaddr @5 :UInt64;
}

struct ServiceEndpoint {
    name @0 :Text;
    serviceId @1 :T.ServiceId;
    mappedBase @2 :UInt64;
    doorbell @3 :T.CapabilityHandle;
    # Index into the channels list (0 = kernel, 1..N = services).
    channelSlot @4 :UInt32;
}

struct LoadSegment {
    offset @0 :UInt64;
    virtualAddress @1 :UInt64;
    sizeBytes @2 :UInt64;
    bssBytes @3 :UInt64;
    perms @4 :List(T.MemoryPerms);
    align @5 :UInt32;
}

struct BootImage {
    name @0 :Text;
    format @1 :T.BinaryFormat;
    entryOffset @2 :UInt64;
    linkAddress @3 :UInt64;
    stackBytes @4 :UInt64;
    segments @5 :List(LoadSegment);
    hash @6 :Data;
    signature @7 :Data;
}

struct BootstrapInfo {
    channelCount @0 :UInt32;
    channels @1 :List(ChannelInfo);
    # Optional HHDM offset for services that need physical-to-virtual
    # translation. # note recommended: leave empty; kernel pre-maps all
    # needed regions and provides vaddrs via ChannelInfo. Only populate
    # when a service has a genuine need not covered by the schema.
  #  hhdmOffset @2 :UInt64;
}
