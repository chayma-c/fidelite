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
- **Auth**: [Keycloak](https://www.keycloak.org), the sole identity
  provider — the backend validates Keycloak-issued JWTs directly rather than
  running its own auth system.
- **Local dev infra**: Docker Compose (Postgres + Keycloak).

## Project layout

```
fidelite/
├── docker-compose.yml   # Postgres (shared) + Keycloak, for local dev
├── keycloak/             # realm-export.json — realm/roles/client, auto-imported
├── fidelite_flutter/     # the app
├── fidelite_server/      # Serverpod backend
└── fidelite_client/      # generated Serverpod client (committed, don't hand-edit)
```

## Getting started

Full instructions — Docker, Keycloak, the backend's database, running the
server, running the app on Android/iOS/web — are in **[SETUP.md](SETUP.md)**.
Short version, once you've followed that once:

```bash
docker compose up -d
cd fidelite_server && dart bin/main.dart --apply-migrations
cd fidelite_flutter && flutter run --dart-define-from-file=env/dev.json
```

Demo accounts (local dev realm only): `demo` / `demo1234` (customer),
`staffdemo` / `staff1234` (staff).

## Status

- ✅ **Phase 0** — Keycloak login, role-based routing (staff vs customer).
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
- ⏳ Not started: menu/reward admin CRUD tooling (both are hand-edited seed
  files for now), order history/reprint UI.

See [SETUP.md](SETUP.md) for the full architecture writeup, including the
security model behind both QR flows and a couple of Serverpod codegen
gotchas worth knowing before you touch the backend.
