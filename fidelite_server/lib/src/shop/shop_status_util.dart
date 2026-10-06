import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// The one-and-only [ShopStatusRecord] row, creating it (defaulting to
/// [ShopOpenStatus.open]) if this is genuinely the first time anything has
/// read or written it -- a fresh deploy shouldn't error just because
/// nobody has toggled the sign yet.
Future<ShopStatusRecord> currentShopStatusOrDefault(
  Session session, {
  Transaction? transaction,
}) async {
  final existing = await ShopStatusRecord.db.findFirstRow(
    session,
    transaction: transaction,
  );
  if (existing != null) return existing;
  return ShopStatusRecord.db.insertRow(
    session,
    ShopStatusRecord(
      status: ShopOpenStatus.open,
      updatedAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );
}
