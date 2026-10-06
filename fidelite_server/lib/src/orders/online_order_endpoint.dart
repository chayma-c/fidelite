import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../notifications/fcm_notification_sender.dart';
import '../points/points_balance.dart';
import '../shop/shop_status_util.dart';
import 'order_pricing_util.dart';
import 'ticket_numbering.dart';

const _notificationSender = FcmNotificationSender();

/// Lets a customer place and pay for their own order instead of waiting at
/// the counter -- the whole point of this endpoint. Cashback is credited
/// directly in the same call (see OnlineOrderConfirmation for why there's
/// no claim QR), and staff are pushed a notification so an order placed
/// while nobody's looking at the app still gets noticed.
class OnlineOrderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:customer')};

  Future<OnlineOrderConfirmation> placeOrder(
    Session session,
    List<OrderItemInput> items,
  ) async {
    final shopStatus = await currentShopStatusOrDefault(session);
    if (shopStatus.status != ShopOpenStatus.open) {
      throw InvalidOrderException(
        reason: InvalidOrderExceptionReason.shopNotOpen,
      );
    }

    final priced = await validateAndPriceOrder(session, items);
    final customerUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );

    final result = await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final now = DateTime.now().toUtc();
        final ticketNumber = await reserveTicketNumber(
          session,
          now,
          transaction,
        );

        final order = await OrderRecord.db.insertRow(
          session,
          OrderRecord(
            customerUserId: customerUserId,
            subtotalMillimes: priced.totalMillimes,
            totalMillimes: priced.totalMillimes,
            ticketNumber: ticketNumber,
            createdAt: now,
            // Awaiting staff attention -- see OrderRecord.handledAt.
            handledAt: null,
          ),
          transaction: transaction,
        );

        await OrderItemRecord.db.insert(
          session,
          buildOrderItemRecords(order.id!, priced),
          transaction: transaction,
        );

        final pointsEarned = (priced.totalMillimes * cashbackRate).round();

        await lockPointsBalance(session, customerUserId, transaction);
        final currentBalance = await currentPointsBalance(
          session,
          customerUserId,
          transaction,
        );
        final newBalance = currentBalance + pointsEarned;

        await PointsLedgerEntryRecord.db.insertRow(
          session,
          PointsLedgerEntryRecord(
            userId: customerUserId,
            deltaMillimes: pointsEarned,
            reason: PointsLedgerReason.onlineOrder,
            relatedOrderId: order.id,
            balanceAfterMillimes: newBalance,
            createdByUserId: customerUserId,
            createdAt: now,
          ),
          transaction: transaction,
        );

        return OnlineOrderConfirmation(
          order: order,
          pointsEarnedMillimes: pointsEarned,
          newBalanceMillimes: newBalance,
        );
      },
    );

    // Best-effort, after the order is safely committed -- a push failure
    // (missing FCM credentials, a network blip, every token stale) must
    // never undo or fail an order that's already been placed and paid.
    try {
      await _notificationSender.sendToAllStaffDevices(
        session,
        title: 'New online order',
        body: 'Ticket #${result.order.ticketNumber} -- '
            '${result.order.totalMillimes / 1000} DT',
        data: {'orderId': result.order.id.toString()},
      );
    } catch (e) {
      session.log(
        'Failed to push online-order notification: $e',
        level: LogLevel.warning,
      );
    }

    return result;
  }
}
