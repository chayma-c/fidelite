# Fidélité — setup & architecture

Monorepo layout:

```
fidelite/
├── docker-compose.yml     # Postgres (shared) + Keycloak
├── keycloak/               # realm-export.json
├── fidelite_flutter/        # the app
├── fidelite_server/         # Serverpod backend
└── fidelite_client/          # generated Serverpod client (committed, don't hand-edit)
```

## 1. Start Postgres + Keycloak

```bash
cp .env.example .env        # set your own passwords
docker compose up -d
```

This starts Postgres + Keycloak and auto-imports `keycloak/realm-export.json`:
realm **fidelite**, public client **fidelite-app** (Authorization Code + PKCE,
no client secret), a `customer` / `staff` role pair, and two demo users
(`demo` / `demo1234`, role `customer`; `staffdemo` / `staff1234`, role
`staff`). Admin console: http://localhost:8080 (`admin` / the password you
set in `.env`).

**Gotcha:** `--import-realm` only imports on the *first* boot of a fresh
Postgres volume — Keycloak logs `Realm 'fidelite' already exists. Import
skipped` on every later restart. If you edit `keycloak/realm-export.json`
after your first `docker compose up`, either apply the same change by hand
via the admin console/API, or wipe the volume (`docker compose down -v`,
which also deletes the `fidelite` Postgres database below) to re-import from
scratch.

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

Nothing Keycloak-specific is hard-coded in the server either — it reads two
required environment variables:

```bash
cd fidelite_server
dart pub get
KEYCLOAK_ISSUER="http://localhost:8080/realms/fidelite" KEYCLOAK_CLIENT_ID="fidelite-app" dart bin/main.dart --apply-migrations
```

(On Windows PowerShell: `$env:KEYCLOAK_ISSUER = "..."; $env:KEYCLOAK_CLIENT_ID = "..."; dart bin/main.dart --apply-migrations`.)

The API server listens on **8083** (not Serverpod's default 8080 — that
port's already taken by Keycloak; see `fidelite_server/config/development.yaml`).

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
IP in `KEYCLOAK_BASE_URL` and `SERVERPOD_BASE_URL`), or use
`env/dev.android.json` (already set up with the `10.0.2.2` host alias) —
`flutter run --dart-define-from-file=env/dev.android.json`.

**Web:** run on a fixed port so it matches the registered redirect URI:

```bash
flutter run -d chrome --web-port=5173 --dart-define-from-file=env/dev.json
```

## 5. Platform-specific redirect wiring (already done, for reference)

- **Android**: `fidelite_flutter/android/app/build.gradle.kts` sets
  `manifestPlaceholders["appAuthRedirectScheme"]`, which `flutter_web_auth_2`
  uses to register the callback activity.
- **iOS**: `fidelite_flutter/ios/Runner/Info.plist` declares the same custom
  URL scheme under `CFBundleURLTypes`.
- **Web**: `fidelite_flutter/web/auth.html` is the static page Keycloak
  redirects back to; it posts the result back to the app via `postMessage`
  (when opened with `window.opener`) or `localStorage` (the actual path
  used here, since `url_launcher_web` opens the popup with `noopener`). If
  you bump `flutter_web_auth_2` to a much newer major version, diff this
  file against that version's own `example/web/auth.html` — the exact
  fallback logic is that package's contract, not ours.

If you ever change the app's bundle ID / applicationId away from
`com.example.fidelite`, update `OAUTH_REDIRECT_SCHEME_MOBILE` in your env
file, the Android/iOS files above, and the client's redirect URIs in
`keycloak/realm-export.json` (or the Keycloak admin console) to match.

## 6. Architecture

```
fidelite_flutter/lib/
  core/
    config/     # AppConfig — reads --dart-define values, fails fast if missing
    money/      # millimes -> "X.XXX DT" formatting (see currency note below)
    printing/   # ReceiptPrinter interface + NoOpReceiptPrinter (see printing note below)
    router/     # go_router, redirects based on AuthState + role
    serverpod/  # Client wiring: KeycloakAuthKeyProvider, meProvider
    theme/      # AppColors (brand mustard/charcoal), AppTheme
  features/
    auth/
      domain/       # AppUser, AuthTokens, AuthState, AuthRepository (interface)
      data/          # TokenStorage, OidcDataSource, AccessTokenProvider
      presentation/  # AuthController (Riverpod Notifier), LoginPage, SplashPage, NoAccessPage
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
  auth/       # KeycloakJwtValidator, keycloakAuthenticationHandler
  config/     # AppConfig — reads env vars, fails fast if missing
  users/      # AppUserRecord model + UserEndpoint (getMe)
  menu/       # MenuItemRecord model, MenuEndpoint, menu_seed.dart
  orders/     # OrderRecord/OrderItemRecord models, OrderEndpoint, InvalidOrderException
  points/     # PointsLedgerEntryRecord, OrderClaimTokenRecord, WalletTokenRecord,
              # PointsClaimEndpoint, WalletEndpoint, points_balance.dart (shared balance/lock helpers)
  rewards/    # RewardItemRecord model, RewardsEndpoint, rewards_seed.dart
  redemption/ # RedemptionRecord model, RedemptionEndpoint, RedemptionException
```

- **State management**: Riverpod (`Notifier`/`NotifierProvider`, no code
  generation — keeps the project runnable with just `flutter pub get`).
- **Auth flow**: OIDC Authorization Code + PKCE against Keycloak (see prior
  section of this doc for the client-side flow — unchanged).
- **Backend auth**: Keycloak remains the *only* identity provider — the
  Serverpod backend never issues its own tokens. Every request's bearer
  token is validated as a Keycloak-issued JWT against the realm's JWKS
  (`KeycloakJwtValidator`, using the `jose` package), and on success the
  realm roles are mapped 1:1 to Serverpod `Scope`s (`role:staff`,
  `role:customer`) that endpoints declare via `requiredScopes`. A local
  `AppUserRecord` is upserted (keyed by the Keycloak `sub`, a UUID) on every
  request so other backend records have something to relate to.
- **Client → server auth**: `KeycloakAuthKeyProvider` (in
  `core/serverpod/`) attaches the current access token to every Serverpod
  call, refreshing it first via the *same* `AccessTokenProvider` the
  `AuthController` uses to restore a session on app start — one refresh
  implementation, two consumers.
- **Routing guard**: `go_router`'s `redirect` sends authenticated users to
  `/staff` or `/wallet` based on their Keycloak role (decoded client-side
  from the ID token), and blocks a customer from reaching `/staff/*` (or a
  staff member from reaching `/wallet/*`) even via direct URL entry on web.

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
- **Printing**: deliberately abstract (`core/printing/ReceiptPrinter`) since
  the printer hardware isn't chosen yet. `NoOpReceiptPrinter` is the only
  implementation for now — the order confirmation screen shows the full
  receipt on-screen regardless, so nothing is lost by not printing yet. Once
  hardware is picked, swap the implementation registered in
  `core/printing/printing_providers.dart`; nothing else in the order flow
  needs to change.

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

## 10. What's intentionally not built yet

Order history/reprint (`OrderEndpoint.getOrderHistory` exists server-side
but has no UI yet), real printer integration, and menu/reward admin CRUD
tooling (currently both are edited by hand in their respective `*_seed.dart`
files).
