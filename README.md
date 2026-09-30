# A&A Fidélité

A loyalty/cashback app for **A&A**, a Tunisian fast-food restaurant. Staff take
orders on a tablet; customers scan their printed receipt to earn cashback
(8% of the order, credited in Tunisian Dinar), then later redeem that balance
against a reward.

Private project — not published, not for external use.

## How it works

1. **Staff** logs in, builds an order from the menu, confirms it. A ticket
   prints with a QR code, via [RawBT](https://www.rawbt.ru/) — see
   [SETUP.md](SETUP.md).
2. **Customer** logs in on their own phone and scans that QR code. Their
   cashback balance goes up.
3. Once they've got enough, the customer shows their own wallet QR (from
   the app) and staff scan it at the till to redeem a reward from their
   balance.

## Stack

- **App**: Flutter, one codebase for both staff and customer — the UI
  routes based on the signed-in user's role. Riverpod for state, `go_router`
  for navigation.
- **Backend**: [Serverpod](https://serverpod.dev) (Dart), Postgres.
- **Auth**: self-hosted in the Serverpod backend via Serverpod's own
  `serverpod_auth_core`/`serverpod_auth_idp` modules (email/password,
  JWT sessions, Argon2 hashing) — no external identity provider.
- **Local dev infra**: Docker Compose (Postgres).

## Project layout

```
fidelite/
├── docker-compose.yml   # Postgres, for local dev
├── fidelite_flutter/     # the app
├── fidelite_server/      # Serverpod backend
└── fidelite_client/      # generated Serverpod client (committed, don't hand-edit)
```

## Getting started

Full instructions — Docker, the backend's database, running the server,
running the app on Android/iOS/web — are in **[SETUP.md](SETUP.md)**.
Short version, once you've followed that once:

```bash
docker compose up -d
cd fidelite_server && dart bin/main.dart --apply-migrations
cd fidelite_flutter && flutter run --dart-define-from-file=env/dev.json
```

Demo staff account (local dev only, seeded automatically): `staff@fidelite.local`
/ `staff1234`. Customers self-register from the app — see SETUP.md §3 for
how the email-verification code is delivered in dev (no real email sending
yet).

## Status

- ✅ **Phase 0** — Login, role-based routing (staff vs customer).
- ✅ **Phase 1** — Menu, order-taking, pricing integrity (server always
  recomputes totals from the live menu, never trusts the client).
- ✅ **Phase 2** — Cashback: order QR → scan → earn, backed by an
  append-only ledger and an atomic single-use claim (a receipt can't be
  scanned twice, even from two phones at once).
- ✅ **Phase 3** — Rewards catalog + redemption: customer shows a
  short-lived rotating wallet QR, staff scan it and spend the balance on a
  reward. Verified: an unaffordable reward correctly fails without
  invalidating the QR, so the cashier can immediately retry a cheaper one
  on the same code.
- ✅ **Phase 4** — Branding: real gold/cream/ink colors sampled from the
  logo, distinct light and dark themes (auto-follows the system setting),
  logo on the login and splash screens.
- ✅ **Printing** — receipts print via RawBT (`core/printing/`), including
  the cashback-claim QR code on the ticket itself.
- ✅ **Self-hosted auth** — replaced Keycloak with Serverpod's own auth
  modules (email/password, no external identity provider); see SETUP.md §6.
- ⏳ Not started: menu/reward admin CRUD tooling (both are hand-edited seed
  files for now), order history/reprint UI, real email delivery for
  registration/password-reset codes (currently logged to the server console).

See [SETUP.md](SETUP.md) for the full architecture writeup, including the
security model behind both QR flows and a couple of Serverpod codegen
gotchas worth knowing before you touch the backend.
