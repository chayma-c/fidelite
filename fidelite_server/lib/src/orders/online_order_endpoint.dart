import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../notifications/fcm_notification_sender.dart';
import '../points/points_balance.dart';
import '../shop/online_order_settings_util.dart';
import '../shop/shop_status_util.dart';
import 'order_pricing_util.dart';
import 'ticket_numbering.dart';

const _notificationSender = FcmNotificationSender();

/// Lets a customer place and pay for their own order instead of waiting at
/// the counter -- the whole point of this endpoint. Paying with points
/// settles immediately, right here (it's a real-time payment, not a
/// bonus) -- but cash orders no longer earn cashback in this same call.
/// Earning is deliberately a separate, later step: scanning the order's
/// receipt QR (see PointsClaimEndpoint.claimOrderPoints), same as a
/// counter order. The token for that QR is minted when staff print the
/// ticket (see OnlineOrderManagementEndpoint.issueClaimToken), not here --
/// an online order's printing is asynchronous (staff might not print for
/// minutes or longer), so there's no raw token to hand back yet at
/// placement time. Staff are pushed a notification so an order placed
/// while nobody's looking at the app still gets noticed.
class OnlineOrderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:customer')};

  Future<OnlineOrderConfirmation> placeOrder(
    Session session,
    List<OrderItemInput> items,
    OrderFulfillmentMethod fulfillmentMethod,
    OrderPaymentMethod paymentMethod, {
    String? deliveryAddress,
    String? deliveryPhone,
  }) async {
    final shopStatus = await currentShopStatusOrDefault(session);
    if (shopStatus.status != ShopOpenStatus.open) {
      throw InvalidOrderException(
        reason: InvalidOrderExceptionReason.shopNotOpen,
      );
    }

    final isDelivery = fulfillmentMethod == OrderFulfillmentMethod.delivery;
    if (isDelivery) {
      final settings = await currentOnlineOrderSettingsOrDefault(session);
      if (!settings.deliveryEnabled) {
        throw InvalidOrderException(
          reason: InvalidOrderExceptionReason.deliveryNotAvailable,
        );
      }
    }
    if (isDelivery &&
        ((deliveryAddress?.trim().isEmpty ?? true) ||
            (deliveryPhone?.trim().isEmpty ?? true))) {
      throw InvalidOrderException(
        reason: InvalidOrderExceptionReason.missingDeliveryDetails,
      );
    }
    // A pickup order never carries delivery details, even if the client
    // sent some (e.g. left over from switching the fulfillment method back
    // and forth in the UI).
    final resolvedAddress = isDelivery ? deliveryAddress!.trim() : null;
    final resolvedPhone = isDelivery ? deliveryPhone!.trim() : null;
    final deliveryFee = isDelivery ? flatDeliveryFeeMillimes : 0;

    final priced = await validateAndPriceOrder(session, items);
    final grandTotal = priced.totalMillimes + deliveryFee;
    final customerUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    final payWithPoints = paymentMethod == OrderPaymentMethod.points;

    final result = await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final now = DateTime.now().toUtc();

        // Checked before reserving a ticket number or creating the order
        // row, so a payment that can't go through doesn't consume either.
        await lockPointsBalance(session, customerUserId, transaction);
        final currentBalance = await currentPointsBalance(
          session,
          customerUserId,
          transaction,
        );
        if (payWithPoints && currentBalance < grandTotal) {
          throw InvalidOrderException(
            reason: InvalidOrderExceptionReason.insufficientPointsBalance,
          );
        }

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
            totalMillimes: grandTotal,
            fulfillmentMethod: fulfillmentMethod,
            paymentMethod: paymentMethod,
            deliveryFeeMillimes: deliveryFee,
            deliveryAddress: resolvedAddress,
            deliveryPhone: resolvedPhone,
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

        // Paying with points settles the order immediately, in full
        // (including the delivery fee) -- a real-time payment action, so
        // it's recorded right here same as before. It still never earns
        // cashback on top, which would otherwise read as generating points
        // from spending points.
        //
        // Paying cash doesn't credit anything here anymore -- [pointsEarned]
        // below is purely a *preview* of what scanning the receipt will be
        // worth (shown on the confirmation screen), not an amount actually
        // added to the balance. [newBalance] is therefore just
        // [currentBalance] unchanged in that case.
        final int pointsEarned;
        final int newBalance;
        if (payWithPoints) {
          pointsEarned = 0;
          newBalance = currentBalance - grandTotal;
          await PointsLedgerEntryRecord.db.insertRow(
            session,
            PointsLedgerEntryRecord(
              userId: customerUserId,
              deltaMillimes: -grandTotal,
              reason: PointsLedgerReason.onlineOrderPayment,
              relatedOrderId: order.id,
              balanceAfterMillimes: newBalance,
              createdByUserId: customerUserId,
              createdAt: now,
            ),
            transaction: transaction,
          );
        } else {
          pointsEarned = (priced.totalMillimes * cashbackRate).round();
          newBalance = currentBalance;
        }

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
      final fulfillmentLabel = isDelivery ? 'Delivery' : 'Pickup';
      final paymentLabel = payWithPoints ? 'paid online' : 'cash due';
      await _notificationSender.sendToAllStaffDevices(
        session,
        title: 'New online order',
        body: 'Ticket #${result.order.ticketNumber} -- '
            '${result.order.totalMillimes / 1000} DT '
            '($fulfillmentLabel, $paymentLabel)',
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
