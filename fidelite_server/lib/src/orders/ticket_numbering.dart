import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Africa/Tunis has run a fixed UTC+1 offset with no daylight-saving
/// transitions since 2009 -- a plain constant offset gives the exact local
/// calendar day for this restaurant without pulling in a full timezone
/// database.
const _restaurantUtcOffset = Duration(hours: 1);

/// Reserves the customer-facing ticket number for an order: a short,
/// printable sequence that resets to 1 every restaurant-local day and also
/// wraps back to 1 after 100, unlike [OrderRecord.id] (the database primary
/// key), which just keeps growing and is meant for internal/staff
/// reference, not what gets called out to a customer.
///
/// If [requested] is given (an order that was placed offline, where the
/// client already assigned itself a number locally so staff had something
/// to print immediately -- see LocalTicketNumberTracker on the Flutter
/// side), it's honored as-is as long as nothing today already has it. That
/// keeps the number on the paper ticket matching what the server records
/// in the normal case of one order-taking device. On the rare collision
/// (e.g. two devices happened to go offline at the same time and both
/// locally reserved the same number), this falls back to a fresh atomic
/// allocation instead -- two orders can never end up sharing a number, it
/// just means that one ticket's printed number and its recorded number
/// could end up different.
///
/// Must be called inside the same transaction as the [OrderRecord] insert
/// it's assigned to. The advisory lock serializes concurrent submitOrder
/// calls so two simultaneous orders can't both count the same existing
/// rows and land on the same next number; it's released automatically when
/// [transaction] commits.
Future<int> reserveTicketNumber(
  Session session,
  DateTime nowUtc,
  Transaction transaction, {
  int? requested,
}) async {
  await session.db.unsafeQuery(
    "SELECT pg_advisory_xact_lock(hashtext('fidelite_daily_ticket_number')::bigint)",
    transaction: transaction,
  );

  final localNow = nowUtc.add(_restaurantUtcOffset);
  final localDayStartUtc = DateTime.utc(
    localNow.year,
    localNow.month,
    localNow.day,
  ).subtract(_restaurantUtcOffset);

  if (requested != null) {
    final alreadyTaken = await OrderRecord.db.count(
      session,
      where: (t) =>
          (t.createdAt >= localDayStartUtc) & (t.ticketNumber.equals(requested)),
      transaction: transaction,
    );
    if (alreadyTaken == 0) return requested;
  }

  final todaysOrderCount = await OrderRecord.db.count(
    session,
    where: (t) => t.createdAt >= localDayStartUtc,
    transaction: transaction,
  );

  return (todaysOrderCount % 100) + 1;
}
