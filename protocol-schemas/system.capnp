@0xa1b2c3d4e5f60002;

using T = import "types.capnp";

# NOTE: no `using B = import "boot.capnp"` here, deliberately. See the long
# note on FirmwareInfo below for why reusing boot.capnp's BootProtocolKind
# through an import is not currently possible without editing four
# uspace/*/build.rs files owned by another agent.

# ══════════════════════════════════════════════════════════════════════
# System — core system service: handshake, capabilities, extensions,
#          health, lifecycle, and hardware/system introspection.
#
# ══════════════════════════════════════════════════════════════════════
# THE HONESTY RULE, stated once and obeyed by every struct below
# ══════════════════════════════════════════════════════════════════════
# A field here is either MEASURED or it is NOT REPORTED. It is never
# DEFAULTED.
#
# Hardware lies by omission: a machine with no ACPI thermal zone does not
# report 0 °C, it reports nothing. A machine with no fan sensor does not
# report 0 RPM. So every measurement that may be absent carries an explicit
# `<field>Valid :Bool` (or `...Available`). When it is false the value fields
# are meaningless and MUST be ignored — they are not zero, they are unset.
#
# This is the schema-level expression of the rule the project already states:
# "If a field has no producer, it renders N/A with a reason. Never a default,
# never a plausible-looking literal." (progress/batch-001.md:5714). The reason
# string, where one exists, is carried alongside.
#
# Enumerations follow the same rule: `unknown` means "nobody asked the
# hardware", never "the answer is the first variant".
#
# The alternative — plain UInt32 temperature with 0 meaning "cold" — is
# exactly how this OS came to claim 270 physical pixels and four invented
# processes. Do not reintroduce it.
# ══════════════════════════════════════════════════════════════════════
#
# Origin of the numbers: the kernel enumerates CPUID, ACPI (FACP/SMBIOS/
# APIC/DMAR), the CMOS RTC, and firmware tables ONCE at boot
# (docs/NALEDZI.md; kernel/naledzi/src/arch/x86_64). Enumeration is expensive
# and the answer does not change while the machine runs, so every query below
# reads a cached struct — never re-walks the tables. That is why these calls
# are cheap enough to sit on a `sysinfo` command path.
#
# Naming: `get*` methods return cached boot-time enumeration. `sample*`
# methods return a value measured at call time and therefore cost something.
# The distinction is load-bearing; do not blur it.
#
# ── Zero-cycle notes on the whole file ──
#   * No rdtsc sampling for CPU%. `uptime @2` is the tick count the scheduler
#     already maintains; it is not a sample loop. Where a per-CPU busy
#     percentage is offered, it is derived from the scheduler's own accounting
#     (Cputime), not from a periodic rdtsc read — see plan §"Zero-cycle rules".
#   * No per-call CPUID or EDID parse. CpuInfo.topology, ArchitectureInfo and
#     GpuInfo.edid are filled once at boot and copied out thereafter.
# ══════════════════════════════════════════════════════════════════════

interface System {
    handshake @0 (applicationId :T.AppId, version :T.Version, capabilities :Capabilities) -> (sessionId :T.SessionId, serverVersion :T.Version);
    getCapabilities @1 () -> (capabilities :Capabilities);
    getInfo @2 () -> (info :SystemInfo);
    subscribeCapabilities @3 () -> (subscriptionId :UInt64);
    cancelCapabilities @4 (subscriptionId :UInt64) -> T.VoidResult;

    getExtensionCapability @5 (extensionId :T.ExtensionId) -> (capability :Bool);
    listExtensions @6 (pagination :T.Pagination) -> (extensions :List(ExtensionInfo), total :UInt64);

    ping @7 () -> ();
    shutdown @8 () -> T.VoidResult;

    # ── Processor ────────────────────────────────────────────────────────
    # Cached from CPUID at boot. Free to call.
    getCpuInfo @9 () -> (cpu :CpuInfo);
    getCpuTopology @10 () -> (topology :CpuTopology);

    # ── Memory ───────────────────────────────────────────────────────────
    # Cached from the firmware memory map at boot. Free to call.
    getMemoryInfo @11 () -> (memory :MemoryInfo);
    getSwapInfo @12 () -> (swap :SwapInfo);

    # ── Storage ──────────────────────────────────────────────────────────
    # Enumerated from the block layer. NOT free on first call — the service
    # may need to probe a bus. Cached per device thereafter.
    getDiskInfo @13 () -> (disks :List(DiskInfo));

    # ── Graphics ─────────────────────────────────────────────────────────
    # Cached from PCI/ACPI at boot. Free to call.
    getGpuInfo @14 () -> (gpus :List(GpuInfo));

    # ── Thermal and power ────────────────────────────────────────────────
    # Read from ACPI thermal zones / SMART. Costs an I/O each call — this is
    # the one place in this file that is not a struct copy. A client polling
    # temperatures should poll a sensor, not sweep every zone.
    getThermalZones @15 () -> (zones :List(ThermalZone));
    getFans @16 () -> (fans :List(FanInfo));
    getPowerSupply @17 () -> (supply :PowerSupply);

    # ── Load ─────────────────────────────────────────────────────────────
    # From the scheduler's own accounting. Free to call; costs nothing because
    # the scheduler maintains these counters already to schedule at all.
    getLoadInfo @18 () -> (load :LoadInfo);

    # ── Time ─────────────────────────────────────────────────────────────
    # uptime is the scheduler's tick count. wall is the CMOS RTC read by
    # clock-service. Both already exist as scheduler state — no sampling.
    getUptime @19 () -> (uptime :UptimeInfo);
    getSystemTime @20 () -> (time :SystemTime);

    # ── Identity and firmware ────────────────────────────────────────────
    # Read once from firmware tables (SMBIOS/FACP/DMI). Free to call.
    getFirmwareInfo @21 () -> (firmware :FirmwareInfo);
    getChassisInfo @22 () -> (chassis :ChassisInfo);
    getKernelInfo @23 () -> (kernel :KernelInfo);
    getArchitectureInfo @24 () -> (arch :ArchitectureInfo);

    # ── Capabilities ─────────────────────────────────────────────────────
    # What this machine can actually do, discovered at boot. Distinct from
    # System.getCapabilities (@1), which is what THIS CALLER may do. A
    # capability can be supported by the machine and withheld from you.
    getSystemCapabilities @25 () -> (capabilities :SystemCapability);
}

# ── Subscription interface (methods 100-101) ──

interface CapabilitiesSubscription {
    pull @0 () -> (capabilities :Capabilities, changes :List(CapabilityChange));
    cancel @1 (subscriptionId :UInt64) -> T.VoidResult;
}

# ══════════════════════════════════════════════════════════════════════
# PROCESSOR
# ══════════════════════════════════════════════════════════════════════

struct CpuInfo {
    # Vendor string exactly as CPUID reports it (e.g. "GenuineIntel").
    # Never synthesised from an architecture guess.
    vendor @0 :Text;

    # Brand string from CPUID leaf 0x80000002-4. Absent on pre-2000 parts and
    # under some hypervisors, hence the flag.
    brand @1 :Text;
    brandValid @2 :Bool;

    # Family/model/stepping from CPUID leaf 1. The canonical machine identity.
    family @3 :UInt32;
    model @4 :UInt32;
    stepping @5 :UInt32;

    # Logical processors ONLINE. Differs from CpuTopology.logicalCpuCount only
    # if the kernel has offline'd a CPU (e.g. hotplug, MP-table limit).
    logicalProcessors @6 :UInt32;

    # CPUID feature bits, already masked to the bits the kernel acts on.
    # Raw CPUID leaves are deliberately not exposed: they are 16 words of
    # mostly-unused bits and every consumer would have to know the mask.
    features @7 :List(Text);

    # Virtualisation support as CPUID reports it. Distinct from
    # SystemCapability.hypervisorPresent, which is what the machine IS.
    # A VM on a host with no VT-x reports false for both and true for
    # hypervisorPresent — conflating them produces "virtualisation: yes" on
    # a VM that cannot nest.
    hardwareVirtualization @8 :Bool;

    # Cache geometry from CPUID leaves 4 and 0x80000006. Optional on some CPUs.
    l1dCacheBytes @9 :UInt32;
    l1dCacheValid @10 :Bool;
    l2CacheBytes @11 :UInt32;
    l2CacheValid @12 :Bool;
    l3CacheBytes @13 :UInt32;
    l3CacheValid @14 :Bool;

    # TSC properties. The kernel calibrates the TSC against the RTC at boot;
    # this reports what it concluded, not what the datasheet says.
    tscFrequencyHz @15 :UInt64;
    tscFrequencyValid @16 :Bool;
    tscInvariant @17 :Bool;

    # Microcode revision from CPUID leaf 0x80000007, or 0 with valid=false.
    microcodeRevision @18 :UInt32;
    microcodeValid @19 :Bool;
}

# Describes how the CPUs are wired together, as opposed to what each one is.
# Flat SMP has no topology to report, so this is mostly absent on the
# hardware this kernel currently boots on — which is exactly why
# `smpValid` exists rather than a synthetic topology.
struct CpuTopology {
    # NUMA nodes discovered. 1 is a real answer for a real single-node machine.
    numaNodes @0 :UInt32;

    # Cores per physical package.
    coresPerPackage @1 :UInt32;

    # Threads per physical core (SMT). 1 when SMT is off or unknown.
    threadsPerCore @2 :UInt32;

    # Total logical CPUs across all online packages.
    logicalCpuCount @3 :UInt32;

    # APIC ID per logical CPU, in kernel CPU-index order. Empty means the
    # kernel has no APIC mapping to report.
    apicIds @4 :List(UInt32);

    # Package id per logical CPU, parallel to apicIds.
    packageIds @5 :List(UInt32);

    # True when the above were read from real hardware tables (ACPI MADT /
    # MP table / CPUID topology leaves). False when the kernel fell back to
    # "assume flat SMP" — which is a guess, and is labelled as one.
    smpValid @6 :Bool;

    # When smpValid is false: what the kernel fell back to and why.
    smpSource @7 :Text;
}

# ══════════════════════════════════════════════════════════════════════
# MEMORY
# ══════════════════════════════════════════════════════════════════════

struct MemoryInfo {
    # Bytes of RAM the firmware memory map reports as usable. This is the
    # number that must appear in `free`/`used`/`total` arithmetic — see the
    # allocator note in AGENTS.md §4 about not weakening an assertion because
    # the allocator has a cap.
    totalBytes @0 :UInt64;

    # Bytes currently handed out by the kernel allocator.
    usedBytes @1 :UInt64;

    # totalBytes - usedBytes. Provided so a client does not have to do the
    # subtraction and get it wrong; it is not a separate measurement.
    freeBytes @2 :UInt64;

    # Largest single contiguous free run, in bytes. Zero when the allocator
    # does not track runs — a real "unknown", not "no free memory".
    largestFreeBlockBytes @3 :UInt64;
    largestFreeBlockValid @4 :Bool;

    # Page size the kernel actually configured (4 KiB normally; 2 MiB when
    # 1 GiB pages are in use — which this kernel reports as unsupported, so
    # today it is always 4096).
    pageSizeBytes @5 :UInt32;

    # Memory regions the firmware map described, as reported. `reserved` is
    # firmware-claimed-and-unusable (ACPI tables, kernel image); it is not
    # free memory and must not be counted as such.
    regions @6 :List(MemoryRegion);
}

# A contiguous range from the firmware memory map, passed through verbatim.
# No interpretation: `kind` says what the firmware called it.
struct MemoryRegion {
    base @0 :UInt64;
    length @1 :UInt64;
    kind @2 :MemoryRegionKind;
    usable @3 :Bool;
}

enum MemoryRegionKind {
    # Firmware did not classify this range.
    unclassified @0;
    # Conventional low memory below 1 MiB.
    conventional @1;
    # Extended / high memory.
    extended @2;
    # ACPI tables, SMM, other firmware-reserved.
    acpiReclaimable @3;
    acpiNvs @4;
    reserved @5;
    # Kernel image and its modules.
    kernelImage @6;
    # Memory the kernel allocated during boot (page tables, PT pool).
    kernelAllocated @7;
    # Device MMIO. Never system RAM.
    deviceMmio @8;
    custom @9;
}

# Swap. A machine with no swap device says so — it does not report zero-sized
# swap that looks like "swap is configured and empty".
struct SwapInfo {
    totalBytes @0 :UInt64;
    usedBytes @1 :UInt64;
    freeBytes @2 :UInt64;

    # False when there is no swap configured at all, or when the kernel has no
    # swap subsystem and therefore did not look. When false, the byte counts
    # above are meaningless.
    available @3 :Bool;

    # Human-readable reason available == false. Never empty when available is
    # false — that is the whole contract.
    reason @4 :Text;

    # One entry per swap area, when there are any.
    devices @5 :List(SwapDevice);
}

struct SwapDevice {
    name @0 :Text;
    totalBytes @1 :UInt64;
    usedBytes @2 :UInt64;
    priority @3 :Int32;
}

# ══════════════════════════════════════════════════════════════════════
# STORAGE
# ══════════════════════════════════════════════════════════════════════

struct DiskInfo {
    # Stable identity from the block layer (bus:port:lun style). Real data:
    # whatever the transport reported, never a sequence number standing in
    # for one.
    deviceName @0 :Text;

    model @1 :Text;
    modelValid @2 :Bool;
    serial @3 :Text;
    serialValid @4 :Bool;
    firmwareRevision @5 :Text;
    firmwareRevisionValid @6 :Bool;

    transport @7 :DiskTransport;
    bus @8 :Text;

    # Sector size and count as reported by the device. totalBytes is derived
    # from these two, not measured separately.
    sectorSizeBytes @9 :UInt32;
    sectorCount @10 :UInt64;
    totalBytes @11 :UInt64;

    # SMART: real reads from the drive when the transport supports it.
    # Valid flags everywhere, because most emulated and USB bridges do not.
    temperatureCelsius @12 :Int32;
    temperatureValid @13 :Bool;
    powerOnHours @14 :UInt64;
    powerOnHoursValid @15 :Bool;
    wearPercent @16 :UInt32;
    wearValid @17 :Bool;

    # Whether the kernel has actually read this device's capacity, or is
    # reporting what the transport claimed without verification.
    capacityVerified @18 :Bool;
}

enum DiskTransport {
    # Not classified — the block layer does not know or has not probed.
    unknown @0;
    ide @1;
    sata @2;
    nvme @3;
    scsi @4;
    ufs @5;
    virtioBlock @6;
    virtioScsi @7;
    mmc @8;
    usbMassStorage @9;
    memory @10;
    custom @11;
}

# ══════════════════════════════════════════════════════════════════════
# GRAPHICS
# ══════════════════════════════════════════════════════════════════════

struct GpuInfo {
    deviceName @0 :Text;
    vendorId @1 :UInt16;
    deviceId @2 :UInt16;
    vendorName @3 :Text;
    vendorNameValid @4 :Bool;

    # Dedicated VRAM in bytes, when the device reports it. Integrated GPUs
    # share system memory and report this as 0 with valid=false — not as 0.
    dedicatedMemoryBytes @5 :UInt64;
    dedicatedMemoryValid @6 :Bool;

    # Text from the device's own descriptor, where one exists (EDID on
    # displays is DisplayInfo's business; this is the GPU's own identity
    # string, e.g. from a PCI VPD or ACPI _DSD).
    description @7 :Text;
    descriptionValid @8 :Bool;

    driverName @9 :Text;
    driverValid @10 :Bool;

    # Compositing capability as the driver reports it. Three-state: a driver
    # that has not reported yet says unknown.
    compositing @11 :GpuCompositing;
}

enum GpuCompositing {
    # Nobody has asked the driver.
    unknown @0;
    # The GPU cannot composite; a CPU blitter path is required.
    software @1;
    # Hardware compositing available.
    hardware @2;
    custom @3;
}

# ══════════════════════════════════════════════════════════════════════
# THERMAL AND POWER
# ══════════════════════════════════════════════════════════════════════

# One ACPI thermal zone (THERMAL/… ) or equivalent. A machine with no ACPI
# thermal tables yields an empty list — not a list of one zone reading 0 °C.
struct ThermalZone {
    # ACPI path, e.g. "TZ00". The kernel's real identifier for the zone.
    id @0 :Text;

    # Human label from _STR/_HID when the firmware supplies one. Absent on
    # most firmware, hence the flag; the kernel does not invent "CPU".
    label @1 :Text;
    labelValid @2 :Bool;

    # Current reading in millidegrees Celsius (42000 = 42.000 °C), which is
    # the unit ACPI actually reports. Divide by 1000.
    # Zero with valid=false means "no reading", which is NOT 0 °C.
    temperatureMilliCelsius @3 :Int32;
    valid @4 :Bool;

    # Trip points the firmware published for this zone.
    criticalTripMilliCelsius @5 :Int32;
    criticalTripValid @6 :Bool;
    passiveTripMilliCelsius @7 :Int32;
    passiveTripValid @8 :Bool;

    # ACPI thermal mode, when the zone publishes one.
    mode @9 :ThermalMode;
}

enum ThermalMode {
    # Not published, or the zone does not report a mode.
    unspecified @0;
    disabled @1;
    active @2;
    passive @3;
    custom @4;
}

# A fan. Fans are enumerated from ACPI _TMP or a Super-I/O chip.
struct FanInfo {
    id @0 :Text;
    label @1 :Text;
    labelValid @2 :Bool;

    # Current RPM. valid=false means the tachometer is not readable, which
    # on most hardware is the normal case: a fan tachometer needs a wired
    # pulse sensor and most VMs do not model one.
    rpm @3 :UInt32;
    valid @4 :Bool;

    # Minimum and maximum the firmware declares for this fan. Present even
    # when rpm is not — a fan with a declared range and no live reading is
    # the normal state, and the range is still true information.
    minRpm @5 :UInt32;
    minRpmValid @6 :Bool;
    maxRpm @7 :UInt32;
    maxRpmValid @8 :Bool;
}

struct PowerSupply {
    # How the machine is powered, per ACPI. Battery-backed, mains, or
    # unknown — three real answers, and `unknown` is a real answer here
    # (a desktop with no battery publishes no _BIX).
    supplyType @0 :PowerSupplyType;

    # ACPI _BIX design capacity in mWh, when the firmware publishes one.
    designCapacityMwh @1 :UInt32;
    designCapacityValid @2 :Bool;

    # Full-charge capacity as last calibrated by the firmware (BST).
    fullChargeCapacityMwh @3 :UInt32;
    fullChargeCapacityValid @4 :Bool;

    # Present charge, from the firmware's cached gauge value.
    presentCapacityMwh @5 :UInt32;
    presentCapacityValid @6 :Bool;

    # Voltage now / design / minimum, in mV, when _BIF publishes them.
    voltageMillivolts @7 :UInt32;
    voltageValid @8 :Bool;

    # Rate of charge/discharge in mW, signed (negative = discharging), when
    # _BST provides it. A laptop that is plugged in and idle reports ~0.
    # A machine whose firmware does not compute this reports valid=false.
    currentMilliwatts @9 :Int32;
    currentValid @10 :Bool;

    # Percentage remaining, derived from present/full when both are valid.
    percentRemaining @11 :UInt32;
    percentRemainingValid @12 :Bool;
}

enum PowerSupplyType {
    # No _BIX/_BIF, or the table could not be parsed.
    unknown @0;
    mains @1;
    battery @2;
    ups @3;
    fuelCell @4;
    custom @5;
}

# ══════════════════════════════════════════════════════════════════════
# LOAD
# ══════════════════════════════════════════════════════════════════════

struct LoadInfo {
    # Scheduler-averaged runnable count over 1/5/15 minutes. These are the
    # genuine loadavg(1) numbers the kernel maintains to schedule at all.
    # Not derived from rdtsc sampling.
    loadAverage1 @0 :Float32;
    loadAverage5 @1 :Float32;
    loadAverage15 @2 :Float32;

    # Tasks currently runnable (in the run queue, not running).
    runnableTasks @3 :UInt32;
    # Tasks currently executing on some CPU.
    runningTasks @4 :UInt32;
    # Total tasks the kernel knows about.
    totalTasks @5 :UInt32;

    # Cores actually online. A machine booted with -smp 4 on a 1-CPU host
    # reports 1 here, which is the truth, not the command line.
    onlineCpus @6 :UInt32;
    configurableCpus @7 :UInt32;

    # Per-CPU busy fraction in [0,1], indexed by kernel CPU id. Derived from
    # the scheduler's own tick accounting — no sampling thread.
    #
    # Empty with valid=false means the kernel does not account per-CPU time.
    # It is NOT "all zeros": a zero would claim every CPU is idle, which is
    # the specific lie this project is fixing.
    cpuBusy @8 :List(Float32);
    cpuBusyValid @9 :Bool;
}

struct UptimeInfo {
    # Time since the kernel started, from the scheduler's tick counter.
    uptime @0 :T.Duration;

    # Time since init published its first handler — i.e. how long userspace
    # has been up. Zero until then.
    userspaceUptime @1 :T.Duration;

    # Idle time across all CPUs as a fraction of total elapsed, from the same
    # counter. valid=false when the scheduler does not track it.
    idleFraction @2 :Float32;
    idleFractionValid @3 :Bool;
}

# ══════════════════════════════════════════════════════════════════════
# TIME
# ══════════════════════════════════════════════════════════════════════

struct SystemTime {
    # Wall clock, read from the CMOS RTC by clock-service.
    #
    # ZERO MEANS THE RTC IS ABSENT OR UNSET. Clients must render that as
    # unknown, never as 1970-01-01. This is stated because it is the single
    # most likely field in this file to be rendered as a plausible-looking
    # wrong value.
    wall @0 :T.Timestamp;
    wallValid @1 :Bool;

    # Monotonic time since boot, from the kernel's calibrated TSC. Never
    # affected by clock changes; safe for durations.
    monotonic @2 :T.Duration;

    # Timezone as the system is configured. Empty when unset — not "UTC"
    # standing in for "nobody set it".
    timezone @3 :Text;
    timezoneValid @4 :Bool;

    # Whether the RTC has been read successfully at least once.
    rtcAvailable @5 :Bool;

    # Whether the TSC passed the kernel's calibration against the RTC.
    # False means monotonic time is internally consistent but not yet
    # anchored to real time.
    tscCalibrated @6 :Bool;
}

# ══════════════════════════════════════════════════════════════════════
# IDENTITY AND FIRMWARE
# ══════════════════════════════════════════════════════════════════════

struct FirmwareInfo {
    # SMBIOS/DMI system manufacturer and product, as the firmware table
    # states them. Pass-through: the kernel does not clean these up, and
    # should not, because "  Dell Inc. " with stray spaces is what the
    # firmware said.
    systemManufacturer @0 :Text;
    systemProductName @1 :Text;
    systemVersion @2 :Text;

    # BIOS vendor / version / release date, from SMBIOS type 0.
    biosVendor @3 :Text;
    biosVersion @4 :Text;
    biosReleaseDate @5 :Text;

    # SMBIOS version the table declares, and the DMI spec version.
    smbiosVersion @6 :Text;
    # False on firmware that publishes no SMBIOS table at all — which is every
    # device with no BIOS (SoC bootloaders). Then all the strings above are
    # empty because there was nothing to read, not because the kernel skipped it.
    smbiosPresent @7 :Bool;

    # ACPI version the RSDP declares, when ACPI was found.
    acpiVersion @8 :Text;
    acpiPresent @9 :Bool;

    # ── Boot protocol: DELIBERATELY NOT HERE ─────────────────────────────
    # Whether this boot came in via UEFI, Limine, device tree, or legacy BIOS
    # is a real question a `sysinfo` wants to answer, and it is deliberately
    # NOT a field on this struct.
    #
    # boot.capnp:1173 `BootProtocolKind` is the single authority for it, and
    # boot.capnp:1183 `BootProtocolInfo` carries it as `kind`. Duplicating
    # the enum here would give one fact two definitions that could disagree —
    # which is precisely the failure this schema set exists to prevent.
    #
    # It is not reachable as `bootProtocol :B.BootProtocolKind` either, though
    # that would have been the reuse. Importing boot.capnp into system.capnp
    # makes capnpc emit `crate::boot_capnp::…` into every consumer's generated
    # bindings, so every crate that compiles system.capnp must ALSO compile
    # boot.capnp. Four of them (system-service, smart-shell, console-service,
    # and any future consumer) do not list it in their build.rs, and build.rs
    # files under uspace/ belong to another agent. So the import produces
    # E0433 "cannot find boot_capnp in crate" — verified, not hypothetical.
    #
    # Until those build.rs files can be updated, a client reads the boot
    # protocol from BootProtocolInfo in the boot manifest
    # (boot.capnp:32 BootManifest) or from BootService.state. Two hops, one
    # authority. That is the correct trade against a second enum that lies.
}

struct ChassisInfo {
    # SMBIOS type 3. Present only on firmware with an SMBIOS table; on
    # embedded targets without one, every field is empty and present=false.
    present @0 :Bool;

    manufacturer @1 :Text;
    version @2 :Text;
    serial @3 :Text;
    assetTag @4 :Text;
    sku @5 :Text;

    # SMBIOS chassis types, as a bitmask. 0 = no type bits set, which is a
    # real (if uninformative) firmware value.
    typeMask @6 :UInt32;

    # Boot-up state the chassis last recorded (lockout, power-supply
    # problems). Absent on most firmware.
    bootUpState @7 :UInt32;
    bootUpStateValid @8 :Bool;
}

# About the running kernel, as distinct from the machine. A `uname -a` in
# structured form: every string here comes from the kernel image itself.
struct KernelInfo {
    name @0 :Text;
    version @1 :Text;
    # Build timestamp — from the kernel's own build, not the host's clock
    # read at query time.
    buildTimestamp @2 :T.Timestamp;
    buildTimestampValid @3 :Bool;
    buildTarget @4 :Text;
    # Git commit the kernel was built from, when the build embedded one.
    commitHash @5 :Data;
    commitHashValid @6 :Bool;
    # Rust compiler version that produced it, embedded at build time.
    rustcVersion @7 :Text;
    rustcVersionValid @8 :Bool;
    # True when built with debug assertions on.
    debugBuild @9 :Bool;
}

struct ArchitectureInfo {
    # The machine architecture as the kernel was compiled for. From
    # cfg!(target_arch) in the kernel, not a string literal in the query path.
    arch @0 :Text;
    # The full target triple the kernel was built against.
    targetTriple @1 :Text;
    # 32 or 64.
    pointerBits @2 :UInt32;
    endianness @3 :Endianness;
    # Page size the kernel is running with.
    pageSizeBytes @4 :UInt32;
}

enum Endianness {
    little @0;
    big @1;
    # Mixed-endian architecture; neither applies.
    mixed @2;
}

# ══════════════════════════════════════════════════════════════════════
# SYSTEM CAPABILITIES
# ══════════════════════════════════════════════════════════════════════
# What THIS MACHINE supports, determined at boot by probing.
#
# This is deliberately not System.getCapabilities (@1). That returns what the
# calling entity is permitted to do — a policy question answered by the
# capability system. This returns what the hardware offers — a fact about the
# machine. A capability may exist and be withheld; conflating the two makes
# "the machine can't do that" indistinguishable from "you may not".
#
# Each entry is three-state in spirit: false means probed and absent, and the
# corresponding `*Detected` detail (where present) says how the answer was
# reached. Absence of detail is itself reported rather than implied.
# ══════════════════════════════════════════════════════════════════════

struct SystemCapability {
    # ── Processor ──
    smp @0 :Bool;
    # More than one physical package.
    multiprocessor @1 :Bool;
    symmetricMultiprocessing @2 :Bool;
    hyperthreading @3 :Bool;
    hardwareVirtualization @4 :Bool;
    # The machine IS a guest. Distinct from hardwareVirtualization (which is
    # whether the CPU supports running a guest).
    hypervisorPresent @5 :Bool;
    # Name the hypervisor reported via CPUID leaves 0x40000000+, when present.
    hypervisorName @6 :Text;
    hypervisorNameValid @7 :Bool;
    # Invariant TSC, so time can be trusted across CPUs.
    invariantTsc @8 :Bool;
    # CPU has a performance counter usable for profiling.
    performanceCounters @9 :Bool;
    # CPU has an architectural timer (always true on x86-64; reported because
    # other architectures exist).
    architecturalTimer @10 :Bool;

    # ── Memory ──
    # Memory above the 4 GiB boundary is addressable.
    physicalAddressExtension @11 :Bool;
    # The firmware memory map was usable and the kernel used it (as opposed to
    # falling back to assuming a flat map).
    memoryMapValid @12 :Bool;
    # 1 GiB pages available. False on current x86-64 hardware and reported
    # as such rather than as an absent field.
    hugePages1GiB @13 :Bool;
    hugePages2MiB @14 :Bool;

    # ── Devices ──
    # PCI bus present and enumerated.
    pci @15 :Bool;
    # ACPI tables found and parsed.
    acpi @16 :Bool;
    apic @17 :Bool;
    # MSI/MSI-X available.
    messageSignalledInterrupts @18 :Bool;
    # IOMMU present. This kernel logs "DMAR not found" on the machines it
    # boots on, and that is a `false` here, not an omission.
    iommu @19 :Bool;

    # ── Firmware ──
    uefi @20 :Bool;
    smbios @21 :Bool;
    acpiPowerManagement @22 :Bool;

    # ── Filesystem and storage ──
    virtioBlock @23 :Bool;
    virtioScsi @24 :Bool;
    nvme @25 :Bool;
    sata @26 :Bool;
    usb @27 :Bool;

    # ── Graphics ──
    # A framebuffer mode was set at boot from the firmware's VBE/UEFI GOP.
    # (The boot log line "vbe: Found matching mode" is the evidence.)
    firmwareFramebuffer @28 :Bool;
    # Hardware 2D/3D acceleration available. False on fb-embedded, which is a
    # CPU blitter — and it says so.
    hardwareAcceleration @29 :Bool;

    # ── Debug ──
    # The firmware published SMBIOS type 11 (OEM Strings). Used by the boot
    # diagnostics dump. Not a capability anything uses yet; reported because
    # the kernel already reads it.
    oemStrings @30 :Bool;
}

struct Capabilities {
    core @0 :Bool;
    buffer @1 :Bool;
    surface @2 :Bool;
    compositor @3 :Bool;
    windowManager @4 :Bool;
    display @5 :Bool;
    input @6 :Bool;
    textInput @7 :Bool;
    font @8 :Bool;
    theme @9 :Bool;
    accessibility @10 :Bool;
    session @11 :Bool;
    power @12 :Bool;
    network @13 :Bool;
    audio @14 :Bool;
    media @15 :Bool;
    clipboard @16 :Bool;
    notification @17 :Bool;
    capture @18 :Bool;
    auth @19 :Bool;
    location @20 :Bool;
    filesystem @21 :Bool;
    files @22 :Bool;
    process @23 :Bool;
    camera @24 :Bool;
    usb @25 :Bool;
    systemSearch @26 :Bool;
    appIndex @27 :Bool;
    app @28 :Bool;
    extension @29 :Bool;
    package @30 :Bool;
    update @31 :Bool;
    backup @32 :Bool;
    secret @33 :Bool;
    contacts @34 :Bool;
    calendar @35 :Bool;
    database @36 :Bool;
    queue @37 :Bool;
    speech @38 :Bool;
    translation @39 :Bool;
    time @40 :Bool;
    cli @41 :Bool;
    web @42 :Bool;
    service @43 :Bool;
    settings @44 :Bool;
    print @45 :Bool;
    logging @46 :Bool;
}

# The single "what is this machine" answer. Everything here is either read
# from firmware/hardware at boot or from the running kernel image — never a
# literal compiled into a query path.
#
# Aggregates the detail structs for clients that want one round trip. A client
# that needs one field should call the specific get* instead: this struct is
# the expensive one to build, and a `sysinfo` command that wants only the
# kernel name should not pay for a full firmware walk.
struct SystemInfo {


    # Redundant with ArchitectureInfo.arch (@6 below). Kept because clients
    # read this one. Both come from the same source; if they disagree, the
    # bug is in one of the two readers, not in the schema.
    arch @0 :Text;

    uptime @1 :T.Duration;

    # Wall-clock time (Unix nanoseconds) read from the CMOS RTC by
    # the system service itself — no kernel involvement. Zero when
    # the clock is absent/unset; clients must tolerate zero.
    wall @2 :T.Timestamp;

    # ── Aggregated detail. Each field is the same struct the dedicated
    #    get* method returns; present here so one call answers everything. ──
    cpu @3 :CpuInfo;
    topology @4 :CpuTopology;
    memory @5 :MemoryInfo;
    swap @6 :SwapInfo;
    # Empty when no disks were enumerated. Not a placeholder entry.
    disks @7 :List(DiskInfo);
    # Empty when no GPU was found. fb-embedded presents a framebuffer without
    # enumerating a GPU, and that is an empty list, not a fabricated Intel GPU.
    gpus @8 :List(GpuInfo);
    # Empty when the firmware published no thermal tables — the usual case
    # under QEMU, and a real answer.
    thermalZones @9 :List(ThermalZone);
    fans @10 :List(FanInfo);
    powerSupply @11 :PowerSupply;
    load @12 :LoadInfo;
    firmware @13 :FirmwareInfo;
    chassis @14 :ChassisInfo;
    kernel @15 :KernelInfo;
    architecture @16 :ArchitectureInfo;
    systemCapabilities @17 :SystemCapability;
}

struct ExtensionInfo {
    id @0 :T.ExtensionId;
    name @1 :Text;
    version @2 :T.Version;
    enabled @3 :Bool;
}

# Subscription methods are on System at methods 100-101.

struct CapabilityChange {
    name @0 :Text;
    oldValue @1 :Bool;
    newValue @2 :Bool;
}
