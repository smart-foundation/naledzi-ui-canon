@0xa1b2c3d4e5f60099;

# ═══════════════════════════════════════════════════════════════════════
# GPU — vendor-agnostic graphics acceleration contract.
#
# Naledzi does not embed vendor APIs (Vulkan, Metal, OpenGL, D3D12,
# CUDA). The protocol defines the contract; backends implement it.
# A userspace GPU driver (gpu-intel, gpu-amd, gpu-nvidia) speaks this
# interface and the OS hosts it via HalService + DriverRegistry.
#
# This is the durable artifact. Vendors change, hardware changes, but
# the contract is timeless — applications targeting this interface
# remain binary-compatible across all GPU implementations.
#
# Design rules:
#   - Zero-copy: all buffer payloads are DMA-BUF file descriptors
#     (T.DataHandle) or shm region references (T.MappedRegionId).
#   - Capability is type in wire: enum variants are exhaustive at
#     compile time, no runtime dispatch on the consumer side.
#   - Forward compatibility: every enum has `other` / `custom` and
#     every union has `custom`.
#   - No vendor-specific fields leak through the API. Vendor-private
#     data goes through `vendorPrivate :Data` (e.g. a blob of
#     register values the driver understands).
# ═══════════════════════════════════════════════════════════════════════

using T = import "types.capnp";

# ── Vendor ────────────────────────────────────────────────────────
enum GpuVendor {
    unknown @0;
    intel @1;
    amd @2;
    nvidia @3;
    arm @4;
    imgTec @5;
    virtio @6;
    apple @7;
    qualcomm @8;
    broadcom @9;
    other @10;
    # Backend-specific vendor.
    custom @11;
}

# ── Buffer usage flags (bit-style list, not a bitfield so consumers
#    can pattern-match on individual usage in a zero-cost way).       ──
enum BufferUsage {
    scanout @0;          # Surface presented to a display
    shaderRead @1;       # Sampled / read in a shader
    shaderWrite @2;      # Written from a shader
    transferSrc @3;      # Source of a copy
    transferDst @4;      # Destination of a copy
    hostVisible @5;      # CPU can map the memory
    hostCoherent @6;      # No explicit sync needed from host
    renderTarget @7;     # Color attachment
    depthStencil @8;     # Depth/stencil attachment
    linear @9;           # Linear (untiled) layout
    tiled @10;           # Tiled (compressed) layout
    protected @11;       # Hardware-encrypted buffer
    other @12;
    custom @13;
}

# ── Pixel format ────────────────────────────────────────────────
# Re-uses T.PixelFormat from types.capnp where applicable; this
# block adds GPU-only formats. The contract forbids baking a
# specific format's byte layout — drivers decide.

# ── Buffer descriptor (client → driver) ───────────────────────
struct BufferDesc {
    sizeBytes @0 :UInt64;
    usage @1 :List(BufferUsage);
    # T.PixelFormat when used as a color/depth attachment; zero when
    # used only for storage or transfer.
    format @2 :T.PixelFormat;
    # Width/height in pixels for 2D surfaces; both zero for 1D buffers.
    width @3 :UInt32;
    height @4 :UInt32;
    # Tiling modifier (Linux DRM_FORMAT_MOD_* equivalent). 0 = linear.
    modifier @5 :UInt64;
    label @6 :Text;
}

# ── Opaque handles (capability is type in wire) ─────────────
struct GpuBufferId { id @0 :UInt64; }
struct GpuTextureId { id @0 :UInt64; }
struct GpuCommandPoolId { id @0 :UInt64; }
struct GpuSurfaceId { id @0 :UInt64; }
struct GpuFenceId { id @0 :UInt64; }
struct GpuShaderId { id @0 :UInt64; }

# ── Returned buffer info ───────────────────────────────────
struct GpuBuffer {
    id @0 :GpuBufferId;
    sizeBytes @1 :UInt64;
    # Optional DMA-BUF fd exposed to other services; 0 = not shareable.
    dmaBufFd @2 :UInt32;
    # Optional mapped region id if hostVisible was requested.
    mappedRegion @3 :T.MappedRegionId;
    # Actual size the driver allocated (may be larger due to alignment).
    allocatedBytes @4 :UInt64;
}

# ── Shader module ───────────────────────────────────────
# Compiled binary. The format is vendor-specific (Intel Gen binary,
# AMD GCN RDNA, NVIDIA SASS, SPIR-V via translation). Drivers
# receive opaque blobs; consumers compile their own source.
struct ShaderModule {
    id @0 :GpuShaderId;
    entryPoint @1 :Text;
    vendorBinary @2 :Data;
    vendor @3 :GpuVendor;
}

# ── Command buffer (vendor-specific opcode stream) ───────
# The driver is the only thing that interprets this. Length is
# bounded by capabilities.maxCommandBytes.
struct CommandBuffer {
    opcodes @0 :Data;
    # Submission fence: caller-allocated GpuFence that gets signaled
    # when the GPU completes this batch. Zero id = no fence.
    signalFence @1 :GpuFenceId;
    # List of buffers referenced (for lifetime tracking).
    referencedBuffers @2 :List(GpuBufferId);
}

# ── Surface present (frame submission to a display) ─────
struct SurfacePresent {
    surface @0 :GpuSurfaceId;
    image @1 :GpuBufferId;
    # Vertical-sync wait (0 = no vsync, 1 = next vsync, 2 = ...).
    vsyncCount @2 :UInt32;
    # Damage rectangle (0,0,0,0 = full surface).
    damage @3 :T.Rect;
}

# ── Capabilities (reported by the driver) ─────────────
struct GpuCapabilities {
    vendor @0 :GpuVendor;
    deviceName @1 :Text;
    apiVersion @2 :UInt32;            # BCD: 0x010200 = 1.2
    maxBufferBytes @3 :UInt64;
    maxTextureBytes @4 :UInt64;
    maxCommandBytes @5 :UInt32;
    maxPushConstants @6 :UInt32;
    maxSamplers @7 :UInt32;
    maxBoundTextures @8 :UInt32;
    maxColorAttachments @9 :UInt32;
    supportsCompute @10 :Bool;
    supportsGraphics @11 :Bool;
    supportsTiling @12 :Bool;
    supportsTimestampQueries @13 :Bool;
    supportsAsyncSubmit @14 :Bool;
    # Subset of formats the driver can sample / render to.
    supportedFormats @15 :List(T.PixelFormat);
    # Memory heap sizes in bytes.
    heapLocalBytes @16 :UInt64;
    heapSharedBytes @17 :UInt64;
}

# ── Vendor private blob (driver-interpreted) ──────────
# Use this for IOCTL-equivalents that the contract does not yet
# model. The vendor is identified by `vendor`; the data is opaque
# to other vendors and to non-driver code.
struct VendorCommand {
    vendor @0 :GpuVendor;
    op @1 :UInt32;
    payload @2 :Data;
}

# ── Result types ──────────────────────────────────────
struct SubmitResult {
    success @0 :Bool;
    error @1 :T.Error;
    # When success=true, GPU-side command submission fence id.
    submittedFence @2 :GpuFenceId;
}

struct PresentResult {
    success @0 :Bool;
    error @1 :T.Error;
    # Presentation timestamp (driver-set, in nanoseconds).
    presentedAt @2 :UInt64;
    # Actual vsync count waited on.
    vsyncsWaited @3 :UInt32;
}

# ── The driver interface ─────────────────────────────
# A userspace GPU driver publishes a GpuProvider cap. The
# compositor / display service binds to it; applications
# bind through the compositor.
interface GpuProvider {
    # ── Static info ──
    getCapabilities @0 () -> (caps :GpuCapabilities);
    getVendorInfo @1 () -> (vendor :GpuVendor, deviceName :Text, vendorId :UInt16, deviceId :UInt16);
    ping @2 () -> T.VoidResult;

    # ── Buffer management ──
    allocateBuffer @3 (desc :BufferDesc) -> (buffer :GpuBuffer, error :T.Error);
    freeBuffer @4 (id :GpuBufferId) -> T.VoidResult;
    # Map a hostVisible buffer; returns a mapped region id usable
    # for CPU read/write. Unmap via HalService.unmap.
    mapHost @5 (id :GpuBufferId) -> (region :T.MappedRegionId, error :T.Error);
    unmapHost @6 (id :GpuBufferId, region :T.MappedRegionId) -> T.VoidResult;

    # ── Texture / sampler management ──
    createTexture @7 (desc :BufferDesc) -> (tex :GpuTextureId, error :T.Error);
    destroyTexture @8 (id :GpuTextureId) -> T.VoidResult;

    # ── Shaders ──
    createShader @9 (module :ShaderModule) -> (id :GpuShaderId, error :T.Error);
    destroyShader @10 (id :GpuShaderId) -> T.VoidResult;

    # ── Command submission ──
    createCommandPool @11 () -> (pool :GpuCommandPoolId, error :T.Error);
    destroyCommandPool @12 (pool :GpuCommandPoolId) -> T.VoidResult;
    submitCommandBuffer @13 (pool :GpuCommandPoolId, cmd :CommandBuffer) -> (result :SubmitResult);

    # ── Synchronization ──
    createFence @14 (signaled :Bool) -> (id :GpuFenceId, error :T.Error);
    destroyFence @15 (id :GpuFenceId) -> T.VoidResult;
    waitFence @16 (id :GpuFenceId, timeoutNs :UInt64) -> (signaled :Bool, error :T.Error);

    # ── Surfaces (display presentation) ──
    createSurface @17 (outputId :T.OutputId, width :UInt32, height :UInt32) -> (surface :GpuSurfaceId, error :T.Error);
    destroySurface @18 (surface :GpuSurfaceId) -> T.VoidResult;
    presentToSurface @19 (present :SurfacePresent) -> (result :PresentResult);

    # ── Vendor escape hatch (for features the contract doesn't model) ──
    vendorCommand @20 (cmd :VendorCommand) -> (response :Data, error :T.Error);
}

# ── Driver registry events (emitted by DriverService) ──────
struct GpuDeviceEvent {
    at @0 :UInt64;
    union {
        gpuAttached @1 :GpuDevice;
        gpuDetached @2 :GpuVendor;
        driverLoaded @3 :GpuVendor;
        driverUnloaded @4 :GpuVendor;
        custom @5 :Data;
    }
}

struct GpuDevice {
    vendor @0 :GpuVendor;
    deviceName @1 :Text;
    vendorId @2 :UInt16;
    deviceId @3 :UInt16;
    # PCI BDF for hardware addressing.
    pciBus @4 :UInt8;
    pciDevice @5 :UInt8;
    pciFunction @6 :UInt8;
    # BAR0 size in bytes.
    bar0Size @7 :UInt64;
}

# ═══════════════════════════════════════════════════════════════════════
# 3D command stream
#
# A 3D command stream is a sequence of vendor-encoded opcodes
# (MI_, 3DSTATE_, 3DPRIMITIVE_, etc.) that the GPU's command
# streamer executes in order. The driver knows how to interpret
# the opcodes; consumers compile their pipeline state into
# opcodes and submit.
#
# Encoding convention (little-endian):
#   dword 0: opcode (low 16 bits = command class, high 16 = sub-op)
#   dwords 1..N: command-specific dwords
#
# This is a real, executable command stream. The GL frontend
# (gl-intel) compiles shader source and pipeline state into
# this format and submits via the `submitRenderCommandBuffer`
# method.
# ═══════════════════════════════════════════════════════════════════════

# Shader stage. The numeric index is what the GPU uses; the
# semantic names are an aid for humans and tools. A frontend
# (GL, Vulkan, Metal, D3D12, ...) decides what each stage
# means in its own language. The contract is intentionally
# agnostic about which stages a given API exposes.
enum ShaderStage {
    stage0 @0;   # by convention: vertex input
    stage1 @1;   # by convention: tessellation control
    stage2 @2;   # by convention: tessellation evaluation
    stage3 @3;   # by convention: geometry
    stage4 @4;   # by convention: fragment
    stage5 @5;   # by convention: compute
    other @6;
    custom @7;
}

# Compiled shader binary. The vendor binary is the GPU-specific
# instruction stream — a sequence of EU instructions for the
# GPU's execution units. The shader binary is opaque to the
# consumer; only the GPU driver for the matching vendor can
# interpret it. Vulkan SPIR-V, GL GLSL→GEN, Metal MSL→AIR, and
# D3D12 DXIL are all `vendorBinary` blobs from this contract's
# perspective.
struct CompiledShader {
    stage @0 :ShaderStage;
    vendor @1 :GpuVendor;
    binary @2 :Data;
    # Number of constant buffer entries (push constants / uniforms).
    constantCount @3 :UInt32;
    # Number of input varyings.
    inputCount @4 :UInt32;
    # Number of output varyings.
    outputCount @5 :UInt32;
    entryPoint @6 :Text;
}

# 3D pipeline state. The consumer fills this in to describe
# what they want the GPU to do; the driver compiles it into
# 3DSTATE_* commands.
struct PipelineState {
    # Whether the GPU writes to the framebuffer.
    enableColorWrite @0 :Bool;
    # Whether the GPU does depth testing.
    enableDepthTest @1 :Bool;
    # Whether the GPU does stencil testing.
    enableStencil @2 :Bool;
    # Cull mode: 0 = none, 1 = front, 2 = back.
    cullMode @3 :UInt8;
    # Front face: 0 = CCW, 1 = CW.
    frontFace @4 :UInt8;
    # Topology: 0 = triangles, 1 = triangle strip, 2 = triangle fan,
    # 3 = lines, 4 = line strip, 5 = points.
    topology @5 :UInt8;
    # Pixel format of the framebuffer attachment.
    colorFormat @6 :T.PixelFormat;
    # Viewport width / height in pixels.
    viewportWidth @7 :UInt32;
    viewportHeight @8 :UInt32;
    # Vertex shader handle (id from createShader).
    vertexShader @9 :GpuShaderId;
    # Fragment shader handle.
    fragmentShader @10 :GpuShaderId;
}

# One draw call. The driver compiles this into a 3DPRIMITIVE
# command on the render ring.
struct DrawCall {
    # Index of the first vertex.
    firstVertex @0 :UInt32;
    # Number of vertices to draw.
    vertexCount @1 :UInt32;
    # First instance (for instanced draws).
    firstInstance @2 :UInt32;
    # Number of instances.
    instanceCount @3 :UInt32;
}

# A vertex attribute. The driver composes 3DSTATE_VERTEX_BUFFERS
# and 3DSTATE_VERTEX_ELEMENTS commands from these.
struct VertexAttribute {
    buffer @0 :UInt32;        # Which vertex buffer this attribute reads from
    offset @1 :UInt32;        # Byte offset within the buffer
    format @2 :UInt32;        # 0=Float, 1=Float2, 2=Float3, 3=Float4, 4=Byte, ...
    components @3 :UInt8;      # 1, 2, 3, or 4
    divisor @4 :UInt8;        # 0 = per-vertex, 1 = per-instance
}

struct VertexBuffer {
    address @0 :UInt64;
    stride @1 :UInt32;
    size @2 :UInt64;
}

# Extended interface for 3D command stream submission.
# Methods are paradigm-agnostic: a GL frontend, a Vulkan
# frontend, a Metal frontend, or a D3D12 frontend can all
# drive this interface. Each frontend translates its own
# language into the underlying GpuProvider methods.
interface Gpu3DProvider extends(GpuProvider) {
    submitRenderCommandBuffer @0 (pipeline :PipelineState, attributes :List(VertexAttribute), buffers :List(VertexBuffer), draw :DrawCall) -> SubmitResult;
    # Upload a shader in the frontend's chosen source language.
    # The contract is: a (stage, source bytes) pair. The
    # frontend decides what language; the GPU backend compiles.
    uploadShader @1 (stage :ShaderStage, source :Data) -> (shader :CompiledShader, error :T.Error);
}
