/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:fidelite_client/src/protocol/menu/menu_item.dart' as _i3;
import 'package:fidelite_client/src/protocol/menu/ingredient.dart' as _i4;
import 'package:fidelite_client/src/protocol/orders/online_order_confirmation.dart'
    as _i5;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i6;
import 'package:fidelite_client/src/protocol/orders/order_fulfillment_method.dart'
    as _i7;
import 'package:fidelite_client/src/protocol/orders/order_payment_method.dart'
    as _i8;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i9;
import 'package:fidelite_client/src/protocol/orders/order_item.dart' as _i10;
import 'package:fidelite_client/src/protocol/orders/order_confirmation.dart'
    as _i11;
import 'package:fidelite_client/src/protocol/points/claim_result.dart' as _i12;
import 'package:fidelite_client/src/protocol/points/wallet_token_response.dart'
    as _i13;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i14;
import 'package:fidelite_client/src/protocol/redemption/redemption_result.dart'
    as _i15;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i16;
import 'package:fidelite_client/src/protocol/shop/online_order_public_settings.dart'
    as _i17;
import 'package:fidelite_client/src/protocol/shop/online_order_settings.dart'
    as _i18;
import 'package:fidelite_client/src/protocol/shop/shop_status.dart' as _i19;
import 'package:fidelite_client/src/protocol/shop/shop_open_status.dart'
    as _i20;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i21;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i22;
import 'package:fidelite_client/src/protocol/users/app_user.dart' as _i23;
import 'protocol.dart' as _i24;

/// {@category Endpoint}
class EndpointMenu extends _i1.EndpointRef {
  EndpointMenu(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menu';

  /// Active menu items, grouped for display by ordering on category then
  /// [MenuItemRecord.sortOrder].
  _i2.Future<List<_i3.MenuItemRecord>> getMenu() =>
      caller.callServerEndpoint<List<_i3.MenuItemRecord>>(
        'menu',
        'getMenu',
        {},
      );

  /// The customization catalog shown when ordering a customizable item
  /// (see [MenuItemRecord.isCustomizable]) -- both kinds (base/sauce)
  /// together, ordered for display by kind then
  /// [IngredientRecord.sortOrder].
  _i2.Future<List<_i4.IngredientRecord>> getIngredients() =>
      caller.callServerEndpoint<List<_i4.IngredientRecord>>(
        'menu',
        'getIngredients',
        {},
      );
}

/// Staff-only menu administration: create/edit items and toggle their
/// availability. `MenuEndpoint.getMenu` stays the "what can currently be
/// ordered" view shared by both roles; this is the separate management
/// surface behind it.
/// {@category Endpoint}
class EndpointMenuManagement extends _i1.EndpointRef {
  EndpointMenuManagement(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'menuManagement';

  /// Every item, active or not, for the management list.
  _i2.Future<List<_i3.MenuItemRecord>> listAllMenuItems() =>
      caller.callServerEndpoint<List<_i3.MenuItemRecord>>(
        'menuManagement',
        'listAllMenuItems',
        {},
      );

  /// Distinct categories currently in use, for the add/edit form's picker --
  /// steers staff toward reusing an existing category instead of typo'ing a
  /// near-duplicate, without needing a separate category table.
  _i2.Future<List<String>> getCategories() =>
      caller.callServerEndpoint<List<String>>(
        'menuManagement',
        'getCategories',
        {},
      );

  _i2.Future<_i3.MenuItemRecord> createMenuItem({
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
    required bool isCustomizable,
  }) => caller.callServerEndpoint<_i3.MenuItemRecord>(
    'menuManagement',
    'createMenuItem',
    {
      'name': name,
      'description': description,
      'category': category,
      'priceMillimes': priceMillimes,
      'isCustomizable': isCustomizable,
    },
  );

  _i2.Future<_i3.MenuItemRecord> updateMenuItem({
    required int id,
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
    required bool isCustomizable,
  }) => caller.callServerEndpoint<_i3.MenuItemRecord>(
    'menuManagement',
    'updateMenuItem',
    {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'priceMillimes': priceMillimes,
      'isCustomizable': isCustomizable,
    },
  );

  /// "Delete"/restore, in effect: see [MenuItemRecord.isActive]'s doc
  /// comment for why this is a soft toggle rather than a real row delete
  /// (order history depends on the row still existing).
  _i2.Future<_i3.MenuItemRecord> setMenuItemActive({
    required int id,
    required bool isActive,
  }) => caller.callServerEndpoint<_i3.MenuItemRecord>(
    'menuManagement',
    'setMenuItemActive',
    {
      'id': id,
      'isActive': isActive,
    },
  );
}

/// {@category Endpoint}
class EndpointDeviceToken extends _i1.EndpointRef {
  EndpointDeviceToken(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'deviceToken';

  /// Upserts this user's push token -- see DeviceTokenRecord for why
  /// "one row per user, last write wins" is the right model here.
  _i2.Future<void> registerToken(String fcmToken) =>
      caller.callServerEndpoint<void>(
        'deviceToken',
        'registerToken',
        {'fcmToken': fcmToken},
      );
}

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
/// {@category Endpoint}
class EndpointOnlineOrder extends _i1.EndpointRef {
  EndpointOnlineOrder(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'onlineOrder';

  _i2.Future<_i5.OnlineOrderConfirmation> placeOrder(
    List<_i6.OrderItemInput> items,
    _i7.OrderFulfillmentMethod fulfillmentMethod,
    _i8.OrderPaymentMethod paymentMethod, {
    String? deliveryAddress,
    String? deliveryPhone,
  }) => caller.callServerEndpoint<_i5.OnlineOrderConfirmation>(
    'onlineOrder',
    'placeOrder',
    {
      'items': items,
      'fulfillmentMethod': fulfillmentMethod,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'deliveryPhone': deliveryPhone,
    },
  );
}

/// Staff-only view of online orders that still need attention -- what
/// backs both the Online Orders queue and the staff notification badge
/// count (its length).
/// {@category Endpoint}
class EndpointOnlineOrderManagement extends _i1.EndpointRef {
  EndpointOnlineOrderManagement(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'onlineOrderManagement';

  /// Oldest first -- staff should work through them in the order
  /// customers actually placed them. `handledAt` alone is enough to scope
  /// this to online orders: a counter order is marked handled the instant
  /// it's created (see OrderEndpoint.submitOrder) since staff creating it
  /// in person *is* handling it, so it never shows up here.
  _i2.Future<List<_i9.OrderRecord>> listUnhandled() =>
      caller.callServerEndpoint<List<_i9.OrderRecord>>(
        'onlineOrderManagement',
        'listUnhandled',
        {},
      );

  /// Also returns the order's line items, since the Online Orders screen
  /// needs them to build a printable ticket.
  _i2.Future<List<_i10.OrderItemRecord>> getItemsForOrder(int orderId) =>
      caller.callServerEndpoint<List<_i10.OrderItemRecord>>(
        'onlineOrderManagement',
        'getItemsForOrder',
        {'orderId': orderId},
      );

  _i2.Future<_i9.OrderRecord> markHandled(int orderId) =>
      caller.callServerEndpoint<_i9.OrderRecord>(
        'onlineOrderManagement',
        'markHandled',
        {'orderId': orderId},
      );

  /// Mints the claim QR for an online order's printed ticket -- called
  /// right before printing (see the client's
  /// OnlineOrderPrintingController), not at order-placement time: printing
  /// is asynchronous, so there's no raw token to hand back yet when
  /// OnlineOrderEndpoint.placeOrder returns (see its own doc comment).
  ///
  /// Refuses an order paid with points -- no cashback is ever earned on
  /// one (see OrderPaymentMethod.points), so there's nothing to claim.
  /// This is the actual enforcement of that rule for online orders:
  /// PointsClaimEndpoint.claimOrderPoints computes its payout from the
  /// order total alone, with no awareness of how the order was paid for,
  /// so the only thing standing between a points-paid order and a
  /// double-dip is simply never minting it a valid token in the first
  /// place.
  ///
  /// If a still-valid token already exists for this order (e.g. this is a
  /// reprint), it's expired before minting a fresh one -- otherwise two
  /// live tickets for the same order could each be scanned and double
  /// -credit cashback. The old row is kept (not deleted) for audit/
  /// history; only [ClaimTokenStatus.pending] ones are touched, so an
  /// already-claimed token's record is untouched either way.
  _i2.Future<String> issueClaimToken(int orderId) =>
      caller.callServerEndpoint<String>(
        'onlineOrderManagement',
        'issueClaimToken',
        {'orderId': orderId},
      );
}

/// {@category Endpoint}
class EndpointOrder extends _i1.EndpointRef {
  EndpointOrder(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'order';

  /// Creates a confirmed order in one atomic call: validates the requested
  /// items, prices them from the *current* menu (never trusting a
  /// client-supplied price), inserts the order + its line items, and
  /// issues a single-use points-claim token whose QR goes on the printed
  /// receipt. The cart itself is client-local state up to this point --
  /// there is no separate "pending order" concept in the schema.
  ///
  /// [requestedTicketNumber] is set when this order was placed offline and
  /// the client already showed staff a locally-reserved ticket number --
  /// see [reserveTicketNumber] for how that's honored (or safely not, on a
  /// collision).
  ///
  /// [placedAt] is the moment staff actually took the order, for the same
  /// offline case -- distinct from whenever this call happens to reach the
  /// server, which could be much later if the order sat queued. Without
  /// this, a synced order would be recorded (and ticket-numbered, and
  /// bucketed into sales history) as if it happened at sync time instead
  /// of order time, which is wrong every time there's any gap between the
  /// two, and actively misleading for an order placed right before
  /// midnight that doesn't sync until after. Ignored if it's somehow in
  /// the future (clock skew, or a bug) -- falls back to now instead.
  _i2.Future<_i11.OrderConfirmation> submitOrder(
    List<_i6.OrderItemInput> items, {
    int? requestedTicketNumber,
    DateTime? placedAt,
  }) => caller.callServerEndpoint<_i11.OrderConfirmation>(
    'order',
    'submitOrder',
    {
      'items': items,
      'requestedTicketNumber': requestedTicketNumber,
      'placedAt': placedAt,
    },
  );

  /// Most recent orders first, for a staff reprint/lookup screen.
  _i2.Future<List<_i9.OrderRecord>> getOrderHistory({required int limit}) =>
      caller.callServerEndpoint<List<_i9.OrderRecord>>(
        'order',
        'getOrderHistory',
        {'limit': limit},
      );

  /// Orders created within `[start, end)`, most recent first -- backs the
  /// staff sales-history screen's day view. The boundaries are passed in
  /// explicitly rather than a single "day" the server would have to
  /// interpret, so it's always the *caller's* local calendar day being
  /// queried regardless of what timezone this server happens to run in.
  _i2.Future<List<_i9.OrderRecord>> getOrdersInRange({
    required DateTime start,
    required DateTime end,
  }) => caller.callServerEndpoint<List<_i9.OrderRecord>>(
    'order',
    'getOrdersInRange',
    {
      'start': start,
      'end': end,
    },
  );
}

/// {@category Endpoint}
class EndpointPointsClaim extends _i1.EndpointRef {
  EndpointPointsClaim(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pointsClaim';

  /// Redeems a scanned order-ticket QR for cashback. Single-use is
  /// enforced by the conditional [OrderClaimTokenRecord.db.updateWhere]
  /// below succeeding atomically for exactly one caller -- see
  /// order_claim_token.spy.yaml for why this is safe under concurrent
  /// scans of the same receipt.
  _i2.Future<_i12.ClaimResult> claimOrderPoints(
    int orderId,
    String token,
  ) => caller.callServerEndpoint<_i12.ClaimResult>(
    'pointsClaim',
    'claimOrderPoints',
    {
      'orderId': orderId,
      'token': token,
    },
  );
}

/// {@category Endpoint}
class EndpointWallet extends _i1.EndpointRef {
  EndpointWallet(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'wallet';

  _i2.Future<int> getBalance() => caller.callServerEndpoint<int>(
    'wallet',
    'getBalance',
    {},
  );

  /// Issues a fresh single-use wallet QR token for staff to scan during a
  /// redemption. Bundles the current balance so the wallet QR screen
  /// doesn't need a second call on every refresh.
  _i2.Future<_i13.WalletTokenResponse> getWalletToken() =>
      caller.callServerEndpoint<_i13.WalletTokenResponse>(
        'wallet',
        'getWalletToken',
        {},
      );

  /// Most recent entries first, bank-statement style.
  _i2.Future<List<_i14.PointsLedgerEntryRecord>> getPointsHistory({
    required int limit,
  }) => caller.callServerEndpoint<List<_i14.PointsLedgerEntryRecord>>(
    'wallet',
    'getPointsHistory',
    {'limit': limit},
  );
}

/// {@category Endpoint}
class EndpointRedemption extends _i1.EndpointRef {
  EndpointRedemption(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'redemption';

  /// Redeems a reward against a customer's wallet QR. Unlike an order
  /// claim, "is this token valid" and "does the redemption succeed" are
  /// separate questions here -- a valid token can still fail on
  /// insufficient balance, and in that case the token must stay usable for
  /// a retry. That's why this locks the token row with `FOR UPDATE`
  /// (read-then-decide) instead of the conditional-UPDATE pattern
  /// PointsClaimEndpoint uses (where consumption itself *is* the success
  /// signal).
  _i2.Future<_i15.RedemptionResult> redeemReward(
    _i1.UuidValue walletUserId,
    String walletToken,
    int rewardItemId,
  ) => caller.callServerEndpoint<_i15.RedemptionResult>(
    'redemption',
    'redeemReward',
    {
      'walletUserId': walletUserId,
      'walletToken': walletToken,
      'rewardItemId': rewardItemId,
    },
  );
}

/// {@category Endpoint}
class EndpointRewards extends _i1.EndpointRef {
  EndpointRewards(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rewards';

  /// Any authenticated user: customers browse what they could redeem,
  /// staff need the same list mid-redemption.
  _i2.Future<List<_i16.RewardItemRecord>> getCatalog() =>
      caller.callServerEndpoint<List<_i16.RewardItemRecord>>(
        'rewards',
        'getCatalog',
        {},
      );
}

/// Read-only and deliberately public -- same reasoning as ShopStatusEndpoint:
/// a customer deciding how to receive their order needs to see this before
/// (and while) building their cart. Projects just [deliveryEnabled] off the
/// staff-internal OnlineOrderSettingsRecord (see
/// OnlineOrderSettingsEndpoint for the staff-only read/write of the full
/// record) rather than exposing it directly.
/// {@category Endpoint}
class EndpointOnlineOrderPublicSettings extends _i1.EndpointRef {
  EndpointOnlineOrderPublicSettings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'onlineOrderPublicSettings';

  _i2.Future<_i17.OnlineOrderPublicSettings> getSettings() =>
      caller.callServerEndpoint<_i17.OnlineOrderPublicSettings>(
        'onlineOrderPublicSettings',
        'getSettings',
        {},
      );
}

/// Staff-internal only -- unlike ShopStatusEndpoint, nothing here is ever
/// customer-visible.
/// {@category Endpoint}
class EndpointOnlineOrderSettings extends _i1.EndpointRef {
  EndpointOnlineOrderSettings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'onlineOrderSettings';

  _i2.Future<_i18.OnlineOrderSettingsRecord> getSettings() =>
      caller.callServerEndpoint<_i18.OnlineOrderSettingsRecord>(
        'onlineOrderSettings',
        'getSettings',
        {},
      );

  _i2.Future<_i18.OnlineOrderSettingsRecord> setAutoPrint(bool enabled) =>
      caller.callServerEndpoint<_i18.OnlineOrderSettingsRecord>(
        'onlineOrderSettings',
        'setAutoPrint',
        {'enabled': enabled},
      );

  _i2.Future<_i18.OnlineOrderSettingsRecord> setDeliveryEnabled(bool enabled) =>
      caller.callServerEndpoint<_i18.OnlineOrderSettingsRecord>(
        'onlineOrderSettings',
        'setDeliveryEnabled',
        {'enabled': enabled},
      );
}

/// Read-only and deliberately public -- a customer deciding whether to
/// walk over needs to see this the moment they open the app, logged in or
/// not. Writing the status is a separate, staff-only endpoint (see
/// ShopStatusManagementEndpoint), the same public-read/staff-write split
/// already used for the menu (MenuEndpoint vs MenuManagementEndpoint).
/// {@category Endpoint}
class EndpointShopStatus extends _i1.EndpointRef {
  EndpointShopStatus(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shopStatus';

  _i2.Future<_i19.ShopStatusRecord> getStatus() =>
      caller.callServerEndpoint<_i19.ShopStatusRecord>(
        'shopStatus',
        'getStatus',
        {},
      );
}

/// Staff-only. No locking needed for a single-row toggle like this --
/// two staff changing it at the same moment is harmless, whichever write
/// lands last is simply what the sign shows, which is the correct
/// behavior here (unlike e.g. a balance, there's no invariant to protect).
/// {@category Endpoint}
class EndpointShopStatusManagement extends _i1.EndpointRef {
  EndpointShopStatusManagement(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shopStatusManagement';

  _i2.Future<_i19.ShopStatusRecord> setStatus(_i20.ShopOpenStatus status) =>
      caller.callServerEndpoint<_i19.ShopStatusRecord>(
        'shopStatusManagement',
        'setStatus',
        {'status': status},
      );
}

/// Exposes serverpod_auth_idp's email/password login, registration, and
/// password-reset flow to the client. All business logic lives in the
/// module (`EmailIdpBaseEndpoint`) -- this class only needs to exist so the
/// endpoint is registered and reachable, per the module's own
/// "subclass this in your own application" contract.
/// {@category Endpoint}
class EndpointEmailAuth extends _i21.EndpointEmailIdpBase {
  EndpointEmailAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailAuth';

  /// Overridden to surface an already-registered email to the client
  /// instead of the module's default anti-enumeration behavior (silently
  /// returning a request id that will never receive a code -- see
  /// EmailIdp.startRegistration's own comment on this). The owner
  /// explicitly chose to accept the minor account-enumeration trade-off
  /// here in exchange for not stranding customers on a dead-end "check
  /// your email" screen.
  ///
  /// A *pending, unverified* request for the same email (someone retrying
  /// after not receiving a code) is deliberately left alone -- the module
  /// already handles that transparently by replacing the stale request
  /// with a fresh one (see EmailIdpAccountCreationUtil.startRegistration),
  /// which is the correct behavior and shouldn't be turned into an error.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailAuth',
        'startRegistration',
        {'email': email},
      );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i22.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i22.AuthSuccess>(
    'emailAuth',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailAuth',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i22.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i22.AuthSuccess>(
    'emailAuth',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailAuth',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailAuth',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailAuth',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailAuth',
    'hasAccount',
    {},
  );
}

/// Exposes serverpod_auth_core's JWT refresh flow to the client. The
/// business logic lives entirely in the module (`RefreshJwtTokensEndpoint`)
/// -- this class only needs to exist so the endpoint is registered and
/// reachable, per the module's own "subclass this" contract. Required for
/// `FlutterAuthSessionManager`'s JWT auth key provider to find a refresh
/// endpoint at all (`client.getEndpointOfType<EndpointRefreshJwtTokens>()`).
/// {@category Endpoint}
class EndpointJwtTokens extends _i22.EndpointRefreshJwtTokens {
  EndpointJwtTokens(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtTokens';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i22.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i22.AuthSuccess>(
    'jwtTokens',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Returns the caller's own app-owned profile row. Not load-bearing for
/// routing/authorization -- the client already has its own id/roles from
/// the auth session -- this is only for screens that want to display
/// account details (see meProvider on the Flutter side).
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i23.AppUserRecord> getMe() =>
      caller.callServerEndpoint<_i23.AppUserRecord>(
        'user',
        'getMe',
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_core = _i22.Caller(client);
    serverpod_auth_idp = _i21.Caller(client);
  }

  late final _i22.Caller serverpod_auth_core;

  late final _i21.Caller serverpod_auth_idp;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i24.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    menu = EndpointMenu(this);
    menuManagement = EndpointMenuManagement(this);
    deviceToken = EndpointDeviceToken(this);
    onlineOrder = EndpointOnlineOrder(this);
    onlineOrderManagement = EndpointOnlineOrderManagement(this);
    order = EndpointOrder(this);
    pointsClaim = EndpointPointsClaim(this);
    wallet = EndpointWallet(this);
    redemption = EndpointRedemption(this);
    rewards = EndpointRewards(this);
    onlineOrderPublicSettings = EndpointOnlineOrderPublicSettings(this);
    onlineOrderSettings = EndpointOnlineOrderSettings(this);
    shopStatus = EndpointShopStatus(this);
    shopStatusManagement = EndpointShopStatusManagement(this);
    emailAuth = EndpointEmailAuth(this);
    jwtTokens = EndpointJwtTokens(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointMenu menu;

  late final EndpointMenuManagement menuManagement;

  late final EndpointDeviceToken deviceToken;

  late final EndpointOnlineOrder onlineOrder;

  late final EndpointOnlineOrderManagement onlineOrderManagement;

  late final EndpointOrder order;

  late final EndpointPointsClaim pointsClaim;

  late final EndpointWallet wallet;

  late final EndpointRedemption redemption;

  late final EndpointRewards rewards;

  late final EndpointOnlineOrderPublicSettings onlineOrderPublicSettings;

  late final EndpointOnlineOrderSettings onlineOrderSettings;

  late final EndpointShopStatus shopStatus;

  late final EndpointShopStatusManagement shopStatusManagement;

  late final EndpointEmailAuth emailAuth;

  late final EndpointJwtTokens jwtTokens;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'menu': menu,
    'menuManagement': menuManagement,
    'deviceToken': deviceToken,
    'onlineOrder': onlineOrder,
    'onlineOrderManagement': onlineOrderManagement,
    'order': order,
    'pointsClaim': pointsClaim,
    'wallet': wallet,
    'redemption': redemption,
    'rewards': rewards,
    'onlineOrderPublicSettings': onlineOrderPublicSettings,
    'onlineOrderSettings': onlineOrderSettings,
    'shopStatus': shopStatus,
    'shopStatusManagement': shopStatusManagement,
    'emailAuth': emailAuth,
    'jwtTokens': jwtTokens,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_core': modules.serverpod_auth_core,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
  };
}
