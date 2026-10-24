@0xf0196cb81bb7064a;

using T = import "types.capnp";
using C = import "capability.capnp";

# ═══════════════════════════════════════════════════════════════════════
# User — stable user identity, accounts, profiles, and user lifecycle.
#
# This schema defines the user domain shared by operating-system services,
# applications, tools, and other protocol implementations. It describes
# the meaning and lifecycle of users; it does not prescribe how a provider
# stores user records, normalizes sign-in names, persists profiles, or
# implements credential verification.
#
# Domain boundaries:
#   - User identity is stable and is referenced by T.UserId. It is not a
#     session, authentication token, process identifier, or capability.
#   - A user account is an association that lets an identity use a given
#     system or authority. It has a sign-in name and an independent lifecycle.
#   - A profile is user-controlled descriptive/presentation data. A user may
#     have multiple profiles (for example, personal and professional).
#   - auth.capnp owns authenticators, credential enrollment and verification.
#   - session.capnp owns active sessions, locking, unlocking and handoff.
#   - capability.capnp owns authority, delegation, attenuation and revocation.
#   - settings.capnp owns preferences; files/filesystem and domain schemas own
#     personal content. Those domains associate content with T.UserId where
#     required. This schema does not invent a path or storage layout.
#
# Security contract:
#   - Sensitive reads and mutations take an explicit C.Capability authority.
#   - A UserId or AccountId is a reference, not proof of permission.
#   - Passwords, PINs, biometric templates, recovery secrets, and bearer tokens
#     MUST NOT be persisted in UserIdentity, UserAccount, or UserProfile.
#   - A locked session does not mean the account is disabled. Account lifecycle
#     and session lifecycle are separate state machines.
#   - Administrative power is expressed by capabilities and policy, not by a
#     boolean `isAdmin` field or a hard-coded role in the user record.
#
# Evolution:
#   - Existing T.UserId remains the cross-schema stable identity reference.
#   - IDs are opaque identifiers and MUST NOT be reused after deletion.
#   - Ordinals are permanent. Add fields/methods only at new ordinals; do not
#     reinterpret existing values. Custom variants preserve extension points.
# ═══════════════════════════════════════════════════════════════════════

# ── Opaque identifiers ─────────────────────────────────────────────────
# UserId is defined in types.capnp because other domains already use it.
# These identifiers are local to the user domain unless another schema
# imports user.capnp explicitly.

struct UserAccountId { id @0 :UInt64; }
struct UserProfileId { id @0 :UInt64; }
struct UserSetupId { id @0 :UInt64; }
struct UserErasureId { id @0 :UInt64; }

# Explicit optional wrappers avoid using an arbitrary numeric sentinel to
# represent a missing reference.
struct OptionalUserAccountId {
    union {
        none @0 :Void;
        some @1 :UserAccountId;
        custom @2 :Data;
    }
}

struct OptionalUserProfileId {
    union {
        none @0 :Void;
        some @1 :UserProfileId;
        custom @2 :Data;
    }
}

struct OptionalUserProfile {
    union {
        none @0 :Void;
        some @1 :UserProfile;
        custom @2 :Data;
    }
}

struct OptionalUserId {
    union {
        none @0 :Void;
        some @1 :T.UserId;
        custom @2 :Data;
    }
}

# ── User identity ──────────────────────────────────────────────────────
# Identity is stable independently of the accounts, profiles, sessions,
# authenticators, and capabilities currently associated with it.

struct UserIdentity {
    id @0 :T.UserId;
    kind @1 :UserIdentityKind;
    state @2 :UserIdentityState;
    createdAt @3 :T.Timestamp;
    updatedAt @4 :T.Timestamp;
    # Monotonically increasing revision for optimistic concurrency.
    revision @5 :UInt64;
    # Non-secret, namespaced extension metadata. Never use this map to bypass
    # typed fields or to store credentials, secrets, or authorization grants.
    metadata @6 :List(T.Meta);
}

enum UserIdentityKind {
    person @0;
    service @1;
    automation @2;
    system @3;
    other @4;
    custom @5;
}

enum UserIdentityState {
    active @0;
    # Retired identities remain referentially stable but are not eligible for
    # new sign-in or new user-owned work unless reactivated by policy.
    retired @1;
    erasurePending @2;
    # Terminal state. Retain only the non-reusable identifier/tombstone and
    # information required by applicable policy; erase personal attributes.
    erased @3;
    custom @4;
}

# ── User account ────────────────────────────────────────────────────────
# An account is a durable way for an identity to be represented in a user
# directory and to sign in. One identity may have multiple accounts (for
# example, separate managed and personal access contexts). Account state is
# not a substitute for checking capabilities on an operation.

struct UserAccount {
    id @0 :UserAccountId;
    userId @1 :T.UserId;
    # Human-facing sign-in identifier, not the stable identity. It may be
    # renamed under the provider's documented normalization/uniqueness rules.
    signInName @2 :Text;
    kind @3 :UserAccountKind;
    state @4 :UserAccountState;
    # Profile selected by default when this account is used. If present, the
    # profile must belong to this account's userId and must not be deleted.
    # `none` means the provider has not selected a default; callers must not
    # guess one.
    defaultProfile @5 :OptionalUserProfileId;
    createdAt @6 :T.Timestamp;
    updatedAt @7 :T.Timestamp;
    revision @8 :UInt64;
    metadata @9 :List(T.Meta);
}

enum UserAccountKind {
    personal @0;
    guest @1;
    managed @2;
    service @3;
    automation @4;
    system @5;
    other @6;
    custom @7;
}

enum UserAccountState {
    # Created but not yet ready for normal sign-in; credential enrollment and
    # any required first-run policy must finish before activation.
    setupPending @0;
    active @1;
    suspended @2;
    disabled @3;
    deletionPending @4;
    deleted @5;
    custom @6;
}

# ── User profile ────────────────────────────────────────────────────────
# Profiles hold descriptive and presentation data only. Themes, accessibility
# settings, locale preferences, per-app state, files, contacts, and secrets
# remain in their respective domains; providers may associate them with the
# stable T.UserId or an explicitly selected profile where the domain contract
# supports that scope.

struct UserProfile {
    id @0 :UserProfileId;
    userId @1 :T.UserId;
    # User-chosen profile label, e.g. "Personal" or "Work".
    name @2 :Text;
    kind @3 :UserProfileKind;
    state @4 :UserProfileState;
    content @5 :UserProfileContent;
    createdAt @6 :T.Timestamp;
    updatedAt @7 :T.Timestamp;
    revision @8 :UInt64;
    metadata @9 :List(T.Meta);
}

enum UserProfileKind {
    personal @0;
    professional @1;
    presentation @2;
    other @3;
    custom @4;
}

enum UserProfileState {
    active @0;
    archived @1;
    deleted @2;
    custom @3;
}

struct UserProfileContent {
    # Display name used by interfaces. It need not match signInName.
    displayName @0 :Text;
    givenName @1 :Text;
    familyName @2 :Text;
    preferredName @3 :Text;
    pronouns @4 :Text;
    biography @5 :Text;
    avatar @6 :ProfileAvatar;
}

struct ProfileAvatar {
    union {
        none @0 :Void;
        # Opaque protocol data handle; contents/storage are owned elsewhere.
        data @1 :T.DataHandle;
        # Backend-defined avatar representation for forward compatibility.
        custom @2 :Data;
    }
}

# ── Provisioning and first-run setup ────────────────────────────────────

struct UserDirectoryState {
    # True only while initial user provisioning has never begun.
    initialSetupRequired @0 :Bool;
    # True when the one-time bootstrap record exists but setup is not complete.
    # A reboot must resume this setup instead of creating a second first user.
    initialSetupInProgress @1 :Bool;
    initialSetupCompletedAt @2 :T.Timestamp;
    revision @3 :UInt64;
}

struct UserSetupRecord {
    id @0 :UserSetupId;
    userId @1 :T.UserId;
    accountId @2 :UserAccountId;
    initialProfileId @3 :OptionalUserProfileId;
    initialSetup @4 :Bool;
    state @5 :UserSetupState;
    createdAt @6 :T.Timestamp;
    expiresAt @7 :T.Timestamp;
    revision @8 :UInt64;
}

enum UserSetupState {
    pendingAuthentication @0;
    readyToComplete @1;
    completed @2;
    expired @3;
    cancelled @4;
    custom @5;
}

struct CreateUserRequest {
    # Empty is permitted only for account kinds that do not sign in by name.
    # Non-empty names must be unique after the directory's documented
    # normalization policy is applied.
    signInName @0 :Text;
    identityKind @1 :UserIdentityKind;
    accountKind @2 :UserAccountKind;
    # Person/personal-account policy may require an initial profile; service
    # and automation identities can be provisioned without a human profile.
    initialProfile @3 :OptionalInitialUserProfile;
    metadata @4 :List(T.Meta);
    # Optional idempotency key chosen by the caller. Reusing it for the same
    # operation must not create a second identity/account where supported.
    idempotencyKey @5 :Text;
}

struct InitialUserProfile {
    name @0 :Text;
    kind @1 :UserProfileKind;
    content @2 :UserProfileContent;
}

struct OptionalInitialUserProfile {
    union {
        none @0 :Void;
        some @1 :InitialUserProfile;
        custom @2 :Data;
    }
}

struct CreateAccountRequest {
    userId @0 :T.UserId;
    # Empty is permitted only for account kinds that do not sign in by name.
    signInName @1 :Text;
    kind @2 :UserAccountKind;
    defaultProfile @3 :OptionalUserProfileId;
    metadata @4 :List(T.Meta);
    idempotencyKey @5 :Text;
}

struct UserProvisioning {
    identity @0 :UserIdentity;
    account @1 :UserAccount;
    initialProfile @2 :OptionalUserProfile;
    # Correlation ID only; it is not a credential or authorization token.
    setupId @3 :UserSetupId;
}

struct AccountProvisioning {
    account @0 :UserAccount;
    setupId @1 :UserSetupId;
}

struct UserProvisioningResult {
    union {
        success @0 :UserProvisioning;
        nameConflict @1 :UserNameConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

struct AccountProvisioningResult {
    union {
        success @0 :AccountProvisioning;
        nameConflict @1 :UserNameConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

struct UserNameConflict {
    # True when the supplied name fails policy; false when already in use.
    invalid @0 :Bool;
    # Optional human-readable, non-sensitive explanation.
    reason @1 :Text;
    # May be empty when suggestions would disclose information.
    suggestions @2 :List(Text);
}

struct UserSetupCompletionRequest {
    setupId @0 :UserSetupId;
    expectedAccountRevision @1 :UInt64;
}

struct UserSetupCompletionResult {
    union {
        completed @0 :UserAccount;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

# ── Lookup, listing, and sign-in resolution ─────────────────────────────

struct UserListFilter {
    query @0 :Text;
    identityKinds @1 :List(UserIdentityKind);
    identityStates @2 :List(UserIdentityState);
    includeErased @3 :Bool;
}

struct UserAccountFilter {
    userId @0 :OptionalUserId;
    query @1 :Text;
    kinds @2 :List(UserAccountKind);
    states @3 :List(UserAccountState);
    includeDeleted @4 :Bool;
}

struct UserProfileFilter {
    userId @0 :T.UserId;
    states @1 :List(UserProfileState);
    kinds @2 :List(UserProfileKind);
}

struct SignInIdentifier {
    # The exact user-supplied sign-in identifier. Normalization and comparison
    # follow the user directory's published identifier policy.
    value @0 :Text;
    kind @1 :SignInIdentifierKind;
    # Optional namespace/provider name for external identifiers.
    namespace @2 :Text;
}

enum SignInIdentifierKind {
    signInName @0;
    external @1;
    custom @2;
}

struct UserAuthenticationTarget {
    userId @0 :T.UserId;
    accountId @1 :UserAccountId;
}

struct UserAuthenticationTargetResult {
    union {
        # Returned only for an account eligible for an authentication attempt.
        target @0 :UserAuthenticationTarget;
        # Unknown and ineligible accounts MUST be indistinguishable to callers
        # that do not hold dedicated authentication-resolution authority.
        unavailable @1 :Void;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

struct UserRevisionConflict {
    expectedRevision @0 :UInt64;
    actualRevision @1 :UInt64;
}

struct AccountMutationResult {
    union {
        success @0 :UserAccount;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

struct IdentityMutationResult {
    union {
        success @0 :UserIdentity;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

struct ProfileMutationResult {
    union {
        success @0 :UserProfile;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

# ── Profile updates ─────────────────────────────────────────────────────
# Patch values distinguish "leave unchanged" from "set empty" and "clear".
# This makes profile edits safe for multiple clients and forward-compatible.

struct TextChange {
    union {
        unchanged @0 :Void;
        set @1 :Text;
        clear @2 :Void;
        custom @3 :Data;
    }
}

struct AvatarChange {
    union {
        unchanged @0 :Void;
        set @1 :ProfileAvatar;
        clear @2 :Void;
        custom @3 :Data;
    }
}

struct MetadataChange {
    union {
        unchanged @0 :Void;
        replace @1 :List(T.Meta);
        clear @2 :Void;
        custom @3 :Data;
    }
}

struct UpdateUserProfileRequest {
    profileId @0 :UserProfileId;
    expectedRevision @1 :UInt64;
    name @2 :TextChange;
    displayName @3 :TextChange;
    givenName @4 :TextChange;
    familyName @5 :TextChange;
    preferredName @6 :TextChange;
    pronouns @7 :TextChange;
    biography @8 :TextChange;
    avatar @9 :AvatarChange;
    metadata @10 :MetadataChange;
}

struct CreateUserProfileRequest {
    userId @0 :T.UserId;
    name @1 :Text;
    kind @2 :UserProfileKind;
    content @3 :UserProfileContent;
    makeDefaultForAccount @4 :OptionalUserAccountId;
    idempotencyKey @5 :Text;
}

# ── Account and identity lifecycle ──────────────────────────────────────

struct RenameUserAccountRequest {
    accountId @0 :UserAccountId;
    newSignInName @1 :Text;
    expectedRevision @2 :UInt64;
}

struct SetUserAccountStateRequest {
    accountId @0 :UserAccountId;
    transition @1 :UserAccountTransition;
    expectedRevision @2 :UInt64;
}

struct UserAccountTransition {
    union {
        # Does not bypass setupPending: completeSetup is required after the
        # configured authentication/setup requirements have been satisfied.
        activate @0 :Void;
        suspend @1 :StateChangeReason;
        disable @2 :StateChangeReason;
        restore @3 :StateChangeReason;
        custom @4 :Data;
    }
}

struct StateChangeReason {
    code @0 :Text;
    explanation @1 :Text;
}

struct AccountDeletionRequest {
    accountId @0 :UserAccountId;
    expectedRevision @1 :UInt64;
    # A requested time after which finalization may occur. Zero means the
    # caller leaves timing to policy; it does not mean immediate deletion.
    notBefore @2 :T.Timestamp;
    reason @3 :Text;
}

struct AccountDeletionResult {
    union {
        pending @0 :UserAccount;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

enum UserDataDisposition {
    retain @0;
    transferToUser @1;
    eraseWherePermitted @2;
    custom @3;
}

struct FinalizeAccountDeletionRequest {
    accountId @0 :UserAccountId;
    expectedRevision @1 :UInt64;
    # Deleting an account removes this sign-in association only. It does not
    # implicitly erase the stable identity or that identity's personal data.
    reason @2 :Text;
}

struct UserIdentityErasureRequest {
    userId @0 :T.UserId;
    expectedRevision @1 :UInt64;
    dataDisposition @2 :UserDataDisposition;
    # Required when disposition is transferToUser; must not equal userId.
    transferToUserId @3 :OptionalUserId;
    reason @4 :Text;
}

struct UserIdentityErasure {
    id @0 :UserErasureId;
    userId @1 :T.UserId;
    state @2 :UserErasureState;
    requestedAt @3 :T.Timestamp;
    updatedAt @4 :T.Timestamp;
    dataDisposition @5 :UserDataDisposition;
    # Number of participating domains that have acknowledged the request.
    completedDomains @6 :UInt32;
    pendingDomains @7 :UInt32;
    revision @8 :UInt64;
}

enum UserErasureState {
    requested @0;
    inProgress @1;
    blocked @2;
    completed @3;
    cancelled @4;
    custom @5;
}

struct UserIdentityErasureResult {
    union {
        accepted @0 :UserIdentityErasure;
        conflict @1 :UserRevisionConflict;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

# Data-owning domains participate in identity erasure through an explicit
# prepare/commit contract. This prevents deleting the user record while
# silently forgetting files, settings, app data, backups, or audit obligations.

struct UserDataDispositionRequest {
    erasureId @0 :UserErasureId;
    userId @1 :T.UserId;
    disposition @2 :UserDataDisposition;
    transferToUserId @3 :OptionalUserId;
    reason @4 :Text;
}

struct UserDataErasureDomainStatus {
    erasureId @0 :UserErasureId;
    domain @1 :T.ServiceId;
    state @2 :UserDataErasureDomainState;
    updatedAt @3 :T.Timestamp;
    error @4 :T.Error;
    details @5 :Text;
}

enum UserDataErasureDomainState {
    notStarted @0;
    preparing @1;
    prepared @2;
    blocked @3;
    committing @4;
    completed @5;
    failed @6;
    skipped @7;
    custom @8;
}

struct UserDataErasurePreparationResult {
    union {
        prepared @0 :UserDataErasureDomainStatus;
        blocked @1 :UserDataErasureDomainStatus;
        error @2 :T.Error;
        custom @3 :Data;
    }
}

interface UserDataLifecycleParticipant {
    # Prepare without irreversible deletion. A participant must explain any
    # blocker and must be idempotent for the same erasureId.
    prepareUserDataDisposition @0 (request :UserDataDispositionRequest, authority :C.Capability)
        -> (result :UserDataErasurePreparationResult);
    # Commit only after the coordinator has established that all required
    # participants are prepared. Retries for the same erasureId are idempotent.
    commitUserDataDisposition @1 (erasureId :UserErasureId, authority :C.Capability)
        -> (status :UserDataErasureDomainStatus);
    getUserDataDispositionStatus @2 (erasureId :UserErasureId, authority :C.Capability)
        -> (status :UserDataErasureDomainStatus);
    # Abort is valid only before commit has begun for that participant.
    abortUserDataDisposition @3 (erasureId :UserErasureId, authority :C.Capability)
        -> (status :UserDataErasureDomainStatus);
}

# ── Events ──────────────────────────────────────────────────────────────

struct UserEvent {
    id @0 :T.EventId;
    timestamp @1 :T.Timestamp;
    actor @2 :UserEventActor;
    union {
        identityCreated @3 :UserIdentityEvent;
        identityChanged @4 :UserIdentityEvent;
        accountCreated @5 :UserAccountEvent;
        accountChanged @6 :UserAccountEvent;
        profileCreated @7 :UserProfileEvent;
        profileChanged @8 :UserProfileEvent;
        profileDeleted @9 :UserProfileEvent;
        accountDeletionRequested @10 :UserAccountEvent;
        identityErasureChanged @11 :UserErasureEvent;
        custom @12 :Data;
    }
}

struct UserEventActor {
    union {
        user @0 :T.UserId;
        service @1 :T.ServiceId;
        system @2 :Void;
        external @3 :Text;
        custom @4 :Data;
    }
}

struct UserIdentityEvent {
    userId @0 :T.UserId;
    revision @1 :UInt64;
    state @2 :UserIdentityState;
}

struct UserIdentityTransition {
    union {
        retire @0 :StateChangeReason;
        reactivate @1 :StateChangeReason;
        custom @2 :Data;
    }
}

struct UserAccountEvent {
    accountId @0 :UserAccountId;
    userId @1 :T.UserId;
    revision @2 :UInt64;
    state @3 :UserAccountState;
}

struct UserProfileEvent {
    profileId @0 :UserProfileId;
    userId @1 :T.UserId;
    revision @2 :UInt64;
    state @3 :UserProfileState;
}

struct UserErasureEvent {
    erasureId @0 :UserErasureId;
    userId @1 :T.UserId;
    state @2 :UserErasureState;
    revision @3 :UInt64;
}

interface UserEventSubscription {
    pull @0 (pagination :T.Pagination) -> (events :List(UserEvent), total :UInt32);
    cancel @1 () -> T.VoidResult;
}

# ── User service ────────────────────────────────────────────────────────

interface UserService {
    # Safe, non-secret indication of whether first-run user setup is needed.
    getDirectoryState @0 () -> (state :UserDirectoryState);

    # Bootstrap is valid exactly once, while initialSetupRequired is true.
    # The bootstrap capability is issued by the trusted boot/setup path, not
    # by a user-supplied identity, username, token, or boolean flag.
    createInitialUser @1 (request :CreateUserRequest, bootstrapAuthority :C.Capability)
        -> (result :UserProvisioningResult);

    # Create an additional identity, account, and initial profile as one
    # logical provisioning operation. The resulting account is setupPending.
    createUser @2 (request :CreateUserRequest, authority :C.Capability)
        -> (result :UserProvisioningResult);

    # Add another sign-in account for an existing stable user identity.
    createAccount @3 (request :CreateAccountRequest, authority :C.Capability)
        -> (result :AccountProvisioningResult);

    # Called by the trusted setup coordinator only after authentication has
    # confirmed that an acceptable authenticator is enrolled for this user.
    # This method does not accept or store a password or credential secret.
    completeSetup @4 (request :UserSetupCompletionRequest, authority :C.Capability)
        -> (result :UserSetupCompletionResult);

    getIdentity @5 (userId :T.UserId, authority :C.Capability)
        -> (identity :UserIdentity);
    listIdentities @6 (filter :UserListFilter, pagination :T.Pagination, authority :C.Capability)
        -> (identities :List(UserIdentity), total :UInt32);

    getAccount @7 (accountId :UserAccountId, authority :C.Capability)
        -> (account :UserAccount);
    listAccounts @8 (filter :UserAccountFilter, pagination :T.Pagination, authority :C.Capability)
        -> (accounts :List(UserAccount), total :UInt32);

    # Restricted to authentication components. Unknown and ineligible
    # accounts must not be distinguishable to an untrusted caller.
    resolveSignInTarget @9 (identifier :SignInIdentifier, authority :C.Capability)
        -> (result :UserAuthenticationTargetResult);

    renameAccount @10 (request :RenameUserAccountRequest, authority :C.Capability)
        -> (result :AccountMutationResult);
    setAccountState @11 (request :SetUserAccountStateRequest, authority :C.Capability)
        -> (result :AccountMutationResult);

    requestAccountDeletion @12 (request :AccountDeletionRequest, authority :C.Capability)
        -> (result :AccountDeletionResult);
    cancelAccountDeletion @13 (accountId :UserAccountId, expectedRevision :UInt64, authority :C.Capability)
        -> (result :AccountMutationResult);
    finalizeAccountDeletion @14 (request :FinalizeAccountDeletionRequest, authority :C.Capability)
        -> (result :AccountMutationResult);

    # Profiles belong to a stable user identity; each account may select a
    # default profile for presentation without changing the identity itself.
    createProfile @15 (request :CreateUserProfileRequest, authority :C.Capability)
        -> (result :ProfileMutationResult);
    getProfile @16 (profileId :UserProfileId, authority :C.Capability)
        -> (profile :UserProfile);
    listProfiles @17 (filter :UserProfileFilter, pagination :T.Pagination, authority :C.Capability)
        -> (profiles :List(UserProfile), total :UInt32);
    updateProfile @18 (request :UpdateUserProfileRequest, authority :C.Capability)
        -> (result :ProfileMutationResult);
    setDefaultProfile @19 (accountId :UserAccountId, profileId :OptionalUserProfileId,
                           expectedAccountRevision :UInt64, authority :C.Capability)
        -> (result :AccountMutationResult);
    archiveProfile @20 (profileId :UserProfileId, expectedRevision :UInt64, authority :C.Capability)
        -> (result :ProfileMutationResult);
    restoreProfile @21 (profileId :UserProfileId, expectedRevision :UInt64, authority :C.Capability)
        -> (result :ProfileMutationResult);
    deleteProfile @22 (profileId :UserProfileId, expectedRevision :UInt64, authority :C.Capability)
        -> (result :ProfileMutationResult);

    # Identity erasure is a coordinated domain lifecycle, not a local row
    # deletion. The identity enters erasurePending before participants prepare;
    # authentication must stop new sign-ins and session/capability owners must
    # revoke active access. Completion is reported only after obligations are
    # resolved. Retrying the same erasureId must be idempotent.
    requestIdentityErasure @23 (request :UserIdentityErasureRequest, authority :C.Capability)
        -> (result :UserIdentityErasureResult);
    getIdentityErasure @24 (erasureId :UserErasureId, authority :C.Capability)
        -> (erasure :UserIdentityErasure);
    cancelIdentityErasure @25 (erasureId :UserErasureId, authority :C.Capability)
        -> (result :UserIdentityErasureResult);

    subscribeEvents @26 (filter :UserEventFilter, authority :C.Capability)
        -> (subscription :UserEventSubscription);
    getSetup @27 (setupId :UserSetupId, authority :C.Capability)
        -> (setup :UserSetupRecord);

    # Data-owning services register a protocol-level participant so account
    # erasure can be coordinated across all domains that retain user data.
    registerDataLifecycleParticipant @28 (domain :T.ServiceId,
                                          participant :UserDataLifecycleParticipant,
                                          authority :C.Capability)
        -> (result :T.VoidResult);
    unregisterDataLifecycleParticipant @29 (domain :T.ServiceId, authority :C.Capability)
        -> (result :T.VoidResult);
    listErasureDomainStatus @30 (erasureId :UserErasureId, pagination :T.Pagination,
                                 authority :C.Capability)
        -> (domains :List(UserDataErasureDomainStatus), total :UInt32);
    setIdentityState @31 (userId :T.UserId, transition :UserIdentityTransition,
                          expectedRevision :UInt64, authority :C.Capability)
        -> (result :IdentityMutationResult);
}

struct UserEventFilter {
    userId @0 :OptionalUserId;
    accountId @1 :OptionalUserAccountId;
    profileId @2 :OptionalUserProfileId;
    includeIdentityEvents @3 :Bool;
    includeAccountEvents @4 :Bool;
    includeProfileEvents @5 :Bool;
    includeErasureEvents @6 :Bool;
}
