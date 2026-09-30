# Fidélité — setup & architecture

Monorepo layout:

```
fidelite/
├── docker-compose.yml     # Postgres
├── fidelite_flutter/        # the app
├── fidelite_server/         # Serverpod backend
└── fidelite_client/          # generated Serverpod client (committed, don't hand-edit)
```

## 1. Start Postgres

```bash
cp .env.example .env        # set your own passwords
docker compose up -d
```

The `postgres` service's DB/user/volume are still named "keycloak" —
historical, from when this container also ran Keycloak as the identity
provider (removed; auth is now self-hosted in the Serverpod backend itself,
see §6). Renaming them would mean Docker attaching a brand-new empty volume
instead of the one that actually holds the data, so they're left as-is
rather than "cleaned up".

## 2. Create the backend's database

The Serverpod backend uses a second logical database on the same Postgres
instance (not a second container). One-time step, after step 1:

```bash
docker compose exec postgres psql -U keycloak -d keycloak -c "CREATE ROLE fidelite WITH LOGIN PASSWORD 'CHOOSE_A_PASSWORD';"
docker compose exec postgres psql -U keycloak -d keycloak -c "CREATE DATABASE fidelite OWNER fidelite;"
docker compose exec postgres psql -U keycloak -d fidelite -c "GRANT ALL ON SCHEMA public TO fidelite;"
```

Put the same password in `fidelite_server/config/passwords.yaml` under
`development.database`.

## 3. Run the Serverpod backend

No external identity provider and no environment variables to set for auth
— the JWT signing key and email-verification-code hash pepper already live
in `fidelite_server/config/passwords.yaml` (`jwtHmacSha512PrivateKey`,
`emailSecretHashPepper`), following the same convention as the database
password.

```bash
cd fidelite_server
dart pub get
dart bin/main.dart --apply-migrations
```

The API server listens on **8083** (Serverpod's default 8080 was avoided to
leave it free for local tooling; see `fidelite_server/config/development.yaml`).

On first boot, a demo staff account is seeded automatically (see §6) —
**`staff@fidelite.local` / `staff1234`**. There's no seeded customer account
since customers self-register from the app; see §6 for how registration's
email-verification code is delivered in dev (there's no real email sending
yet).

After changing any model in `fidelite_server/lib/src/**/*.spy.yaml`, regenerate
and create a migration before restarting the server:

```bash
serverpod generate
serverpod create-migration
```

(`dart pub global activate serverpod_cli` once, if you don't have the
`serverpod` command yet.)

## 4. Configure and run the Flutter app

```bash
cd fidelite_flutter
cp env/env.example.json env/dev.json   # already pre-filled to match the above
flutter pub get
flutter run --dart-define-from-file=env/dev.json
```

**Android emulator only:** the emulator can't reach the host's `localhost`.
Either run on a physical device on the same network (use your machine's LAN
IP in `SERVERPOD_BASE_URL`), or use `env/dev.android.json` (already set up
with the `10.0.2.2` host alias) —
`flutter run --dart-define-from-file=env/dev.android.json`.

**Web:**

```bash
flutter run -d chrome --web-port=5173 --dart-define-from-file=env/dev.json
```

## 5. Promoting a self-registered user to staff

There's no admin console. Look up the account's id, then grant it the
`staff` scope directly:

```bash
docker compose exec postgres psql -U fidelite -d fidelite -c "SELECT id, email FROM app_user WHERE email = 'someone@example.com';"
docker compose exec postgres psql -U fidelite -d fidelite -c "UPDATE serverpod_auth_core_user SET \"scopeNames\" = \"scopeNames\" || '{role:staff}' WHERE id = 'PASTE_ID_HERE';"
```

(Also worth updating `app_user.roles` to match, for the denormalized
snapshot — it's cosmetic, not the authorization source of truth, but keeps
the two in sync.)

## 6. Architecture

```
fidelite_flutter/lib/
  core/
    config/     # AppConfig — reads --dart-define values, fails fast if missing
    money/      # millimes -> "X.XXX DT" formatting (see currency note below)
    printing/   # ReceiptPrinter interface + RawBtReceiptPrinter (see printing note below)
    router/     # go_router, redirects based on AuthState + role
    serverpod/  # Client wiring: FlutterAuthSessionManager, meProvider
    theme/      # AppColors (real brand gold/cream/ink, sampled from the logo), AppTheme (see branding note below)
  features/
    auth/
      domain/       # AppUser, AuthState
      presentation/  # AuthController (Riverpod Notifier), AuthPage (login/register/verify/reset), SplashPage, NoAccessPage
    menu/
      data/          # menuProvider (fetches MenuItemRecord list from the backend)
    orders/
      presentation/
        controllers/ # CartController (local cart state), OrderSubmissionController
        pages/       # OrderBuilderPage (staff's order-taking home), OrderConfirmationPage
        widgets/     # MenuItemCard, CartPanel
    scanner/
      presentation/  # QrScannerPage — shared camera scanner, returns a raw string
    rewards/
      data/          # rewardsCatalogProvider
      presentation/  # RewardsCatalogPage (customer browsing)
    redemption/
      presentation/
        controllers/ # RedemptionController
        pages/       # RewardPickerPage (staff, after scanning a wallet QR)
        start_redemption_flow.dart # scan -> parse -> push RewardPickerPage
    wallet/
      data/          # balanceProvider, pointsHistoryProvider
      presentation/
        controllers/ # ClaimController, WalletQrController (rotating redemption QR)
        pages/       # WalletHomePage, PointsHistoryPage, WalletQrPage

fidelite_server/lib/src/
  users/      # AppUserRecord model, UserEndpoint (getMe), EmailAuthEndpoint, user_seed.dart (staff account)
  menu/       # MenuItemRecord model, MenuEndpoint, menu_seed.dart
  orders/     # OrderRecord/OrderItemRecord models, OrderEndpoint, InvalidOrderException
  points/     # PointsLedgerEntryRecord, OrderClaimTokenRecord, WalletTokenRecord,
              # PointsClaimEndpoint, WalletEndpoint, points_balance.dart (shared balance/lock helpers)
  rewards/    # RewardItemRecord model, RewardsEndpoint, rewards_seed.dart
  redemption/ # RedemptionRecord model, RedemptionEndpoint, RedemptionException
```

- **State management**: Riverpod (`Notifier`/`NotifierProvider`, no code
  generation — keeps the project runnable with just `flutter pub get`).
- **Auth is self-hosted, not an external identity provider**: originally
  Keycloak (OIDC Authorization Code + PKCE via a browser redirect); replaced
  because testing on a physical Android device over wireless ADB kept
  breaking the reverse-tunnel the browser flow depended on. Auth now runs
  entirely inside the Serverpod backend, using Serverpod's own official
  modules — `serverpod_auth_core` (AuthUser, sessions, JWT issuance/refresh,
  Argon2 password hashing, `Scope`-based authorization) and
  `serverpod_auth_idp`'s email provider (registration with email
  verification, login, password reset) — rather than hand-rolled crypto.
  The client talks to it via plain RPC (`EmailAuthEndpoint`, exposed by
  subclassing `EmailIdpBaseEndpoint`), not a browser popup, which is also
  just a simpler flow.
- **Server-side authorization is unchanged in shape**: `AuthUser.scopeNames`
  maps straight onto Serverpod `Scope`s (`role:staff`, `role:customer`) the
  same way Keycloak realm roles used to — every endpoint's `requiredScopes`
  override needed zero changes. Self-registration defaults to
  `role:customer` (`onBeforeAuthUserCreated` in `server.dart`, mirroring
  Keycloak's old `default-roles-fidelite` composite); the seeded staff
  account is created explicitly with `role:staff` (`user_seed.dart`). A
  local `AppUserRecord` (same id as `AuthUser.id`) is populated once at
  registration time via `onAfterAccountCreated`, for other backend records
  to relate to — no more per-request JIT upsert, since there's no external
  claims payload to keep re-syncing from.
- **No real email sending yet**: `sendRegistrationVerificationCode` /
  `sendPasswordResetVerificationCode` (`server.dart`) just log the code via
  `session.log(...)` instead of emailing it — check the server console when
  testing registration. This needs real email delivery (SMTP or a
  transactional email API) wired in before customers can self-register in
  production; tracked alongside the other deferred items in §11.
- **Client → server auth**: `FlutterAuthSessionManager` (from
  `serverpod_auth_core_flutter`, wired in `core/serverpod/
  serverpod_client_provider.dart`) handles session persistence and token
  refresh natively — no more hand-rolled `TokenStorage`/`AccessTokenProvider`.
  `AuthController` just mirrors its `authInfoListenable` into Riverpod
  `AuthState`; `AuthPage` drives `EmailAuthController` (from
  `serverpod_auth_idp_flutter`) directly for the actual
  login/register/verify/reset flow, styled with the app's own theme instead
  of the package's generic widgets.
- **Routing guard**: `go_router`'s `redirect` sends authenticated users to
  `/staff` or `/wallet` based on role (from the current auth session's
  scopes), and blocks a customer from reaching `/staff/*` (or a staff member
  from reaching `/wallet/*`) even via direct URL entry on web.

## 7. Menu, orders & currency (Phase 1)

- **Currency**: Tunisian Dinar. All prices are stored as integer **millimes**
  (1 DT = 1000 millimes) — never floats — and formatted for display by
  `MillimesFormatting.asDinars` (`fidelite_flutter/lib/core/money/`). This
  matches the 3-decimal pricing on the physical menu (e.g. `3.000 DT`).
- **Menu data**: seeded automatically on first server boot from the real
  A&A menu (`fidelite_server/lib/src/menu/menu_seed.dart`) — idempotent, only
  inserts if the table is empty. Two category labels are still placeholders
  pending the owner's actual names for those menu-board columns: **"Frites"**
  and **"Chawarma & Escalope"**. Edit the `add(category, ...)` calls in that
  file and either re-seed on a fresh DB or update the rows directly.
- **Pricing integrity**: the client never sends a price — `OrderEndpoint.
  submitOrder` looks up each item's *current* price server-side and computes
  the total itself, so a compromised/buggy client can't submit a manipulated
  total.
- **Printing**: goes through [RawBT](https://www.rawbt.ru/), an Android app
  that owns the actual Bluetooth/USB connection to the printer and accepts a
  raw ESC/POS byte stream via a `rawbt:base64,<...>` URL intent. The app
  itself stays printer-model-agnostic — `RawBtReceiptPrinter`
  (`core/printing/rawbt_receipt_printer.dart`) builds the ESC/POS bytes
  (header, itemized lines, total, then a QR code via the standard Epson
  `GS ( k` 2D-symbol command set) and hands them to RawBT through
  `url_launcher`; RawBT is configured separately (on the staff tablet) with
  whichever printer is actually connected. Base64 is used rather than plain
  percent-encoded text because the QR "store data" command is
  length-prefixed binary, not text. **RawBT is Android-only** — the `<queries>`
  entry for it lives in `android/app/src/main/AndroidManifest.xml` (required
  for Android 11+ package-visibility). If the staff tablet ends up running
  the app via a mobile browser instead of the installed APK, the bare
  `rawbt:` scheme may not reliably launch the app from Chrome on Android; an
  `intent://...#Intent;scheme=rawbt;package=ru.a402d.rawbtprinter;end` link
  would be needed instead — not implemented, since the native app is the
  expected deployment target. `NoOpReceiptPrinter` remains as a no-op
  fallback (tests, non-Android platforms); swap the implementation
  registered in `core/printing/printing_providers.dart` if that's ever
  needed. The order confirmation screen still shows the full receipt
  on-screen regardless of print success.

## 8. Cashback / points ledger (Phase 2)

- **It's cashback, not abstract points**: confirmed by the owner as 8% of an
  order's total, stored and displayed in the *same* millimes/DT unit as
  order prices (a 6.000 DT order earns 0.480 DT). There is no separate
  "points currency" or conversion rate anywhere in the code — the wallet
  balance uses the exact same `MillimesFormatting.asDinars` as order totals.
- **How a customer earns it**: `OrderEndpoint.submitOrder` also issues a
  single-use claim token and returns a `FIDCLAIM1:<orderId>:<token>` QR
  payload, shown on the order confirmation screen (`qr_flutter`). The
  customer scans it (`mobile_scanner`, via the shared `QrScannerPage`) and
  `PointsClaimEndpoint.claimOrderPoints` credits their balance.
- **Why a scanned receipt can't be claimed twice**: the claim is a single
  conditional `UPDATE ... WHERE status = 'pending'` (`OrderClaimTokenRecord.
  db.updateWhere`) — Postgres serializes that at the row level, so even two
  simultaneous scans of the same receipt can only have one succeed. The
  7-day token expiry is just a cleanup horizon, not the real defense. A
  Postgres advisory lock (`lockPointsBalance`) additionally serializes all
  balance-affecting writes per customer, closing a separate race on
  computing the running balance.
- **The ledger is append-only**: `PointsLedgerEntryRecord` rows are never
  updated or deleted — the balance is always the sum of a customer's
  entries (see `currentPointsBalance` in `points_balance.dart`), which makes
  it auditable and trivially reconcilable if a bug is ever suspected.
- **Serverpod codegen gotcha, hit twice while building this**: a server
  endpoint method's Dart default parameter value (e.g. `{int limit = 50}`)
  is *not* carried into the generated client method — the client stub
  requires it explicitly. Always pass params like `limit` explicitly from
  Flutter code (see `wallet_providers.dart` for the pattern); relying on
  the server-side default will compile-error on the client, or silently
  fail with "Missing required query parameter" if called via raw HTTP.

## 9. Rewards & redemption (Phase 3)

- **A separate catalog, not points-as-discount**: `RewardItemRecord` is its
  own table, decoupled from `MenuItemRecord` — confirmed as the intended
  design up front. Currently seeded (`rewards_seed.dart`, runs after the
  menu seed) as a straight mirror of the menu at the same DT prices, since
  no distinct reward list existed yet; editing a reward afterward never
  touches menu pricing or vice versa.
- **The wallet QR is short-lived on purpose**: unlike the order-claim QR
  (Phase 2, where single-use *is* the whole defense and expiry is just a
  cleanup horizon), a customer's wallet QR encodes their own identity, so a
  screenshot of a long-lived one would be directly replayable. `WalletToken
  Record` tokens expire in ~90s, and `WalletQrController` silently re-issues
  one every 60s while the QR screen is open — comfortably inside that
  window — so the code on screen is always close to freshly issued.
- **Two different atomicity techniques, deliberately**: `PointsClaimEndpoint`
  (Phase 2) uses a conditional `UPDATE ... WHERE status = 'pending'` because
  consuming the token *is* the success signal there. `RedemptionEndpoint`
  can't use that — a valid wallet token can still fail to redeem for a
  business reason (insufficient balance), and in that case the token must
  stay usable for an immediate retry with a cheaper reward. So it instead
  takes a `SELECT ... FOR UPDATE` row lock on the token, decides success or
  failure inside the transaction, and only writes `consumedAt` on success;
  on `insufficientBalance` the exception is thrown before anything is
  written, so the transaction contributes no change and the token is
  untouched. Verified directly: an expensive reward correctly fails without
  consuming the token, and a follow-up cheap reward against the *same*
  token then succeeds.
- **Redemption is staff-scoped, claim is customer-scoped**: `Redemption
  Endpoint.redeemReward` requires `role:staff` and takes the customer's
  `walletUserId` explicitly from the scanned QR (the caller is the cashier,
  not the customer) — mirrored in the UI: `RewardPickerPage` lives under
  `redemption/`, reached from the staff order screen's app bar, not from
  the wallet.

## 10. Branding (Phase 4)

- **Colors are sampled from the real logo** (`fidelite_flutter/assets/
  branding/logo.png`, registered as a Flutter asset): a saturated gold
  (`AppColors.gold`, `#F5B800`) and a warm cream (`AppColors.cream`,
  `#F6EED9`), both designed to glow against the near-black `AppColors.ink`
  (`#16130F`) — that pairing is the logo's "native habitat", not a
  placeholder guess.
- **Light and dark mode are both real, distinct themes** (`AppTheme.light`
  / `.dark`): the page background and body text swap between a warm
  off-white/ink-text (light) and near-black/cream-text (dark) pairing. The
  app bar and brand-colored buttons deliberately *don't* swap with the
  theme — they stay gold-on-ink in both modes, since that pairing is the
  strongest, most recognizable piece of the brand and flipping it
  per-theme would dilute it.
- **The user can override the OS/browser theme setting from inside the
  app**: a theme picker (`ThemeModeMenuButton`, in the app bar of both
  home screens) lets them pick System/Light/Dark explicitly.
  `ThemeModeController` persists the choice via `shared_preferences`
  (a plain UI preference, not a secret — kept separate from
  `flutter_secure_storage`, which is reserved for tokens) so it survives
  an app restart.
- **The logo PNG has its own baked-in gray gradient backdrop** (it's not a
  transparent cutout) — `AuthPage` and `SplashPage` frame it in a rounded
  `AppColors.ink` container rather than placing it directly on the page
  background, so it reads as a deliberate badge in both themes instead of
  a mismatched rectangle. If a transparent-background version of the logo
  becomes available later, that framing can be dropped.

## 11. What's intentionally not built yet

Order history/reprint (`OrderEndpoint.getOrderHistory` exists server-side
but has no UI yet), a branded/decorative printed-receipt layout (the current
ticket is plain-text ESC/POS — see §7 for what's printed), menu/reward admin
CRUD tooling (currently both are edited by hand in their respective
`*_seed.dart` files), and real email delivery for the registration/password-
reset verification codes (see §6 — currently logged to the server console,
fine for dev/testing but not production-ready for real customer
self-registration).
