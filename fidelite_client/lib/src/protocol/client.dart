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
import 'package:fidelite_client/src/protocol/orders/order_confirmation.dart'
    as _i4;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i5;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i6;
import 'package:fidelite_client/src/protocol/points/claim_result.dart' as _i7;
import 'package:fidelite_client/src/protocol/points/wallet_token_response.dart'
    as _i8;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i9;
import 'package:fidelite_client/src/protocol/redemption/redemption_result.dart'
    as _i10;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i11;
import 'package:fidelite_client/src/protocol/users/app_user.dart' as _i12;
import 'protocol.dart' as _i13;

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
  _i2.Future<_i4.OrderConfirmation> submitOrder(
    List<_i5.OrderItemInput> items,
  ) => caller.callServerEndpoint<_i4.OrderConfirmation>(
    'order',
    'submitOrder',
    {'items': items},
  );

  /// Most recent orders first, for a staff reprint/lookup screen.
  _i2.Future<List<_i6.OrderRecord>> getOrderHistory({required int limit}) =>
      caller.callServerEndpoint<List<_i6.OrderRecord>>(
        'order',
        'getOrderHistory',
        {'limit': limit},
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
  _i2.Future<_i7.ClaimResult> claimOrderPoints(
    int orderId,
    String token,
  ) => caller.callServerEndpoint<_i7.ClaimResult>(
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
  _i2.Future<_i8.WalletTokenResponse> getWalletToken() =>
      caller.callServerEndpoint<_i8.WalletTokenResponse>(
        'wallet',
        'getWalletToken',
        {},
      );

  /// Most recent entries first, bank-statement style.
  _i2.Future<List<_i9.PointsLedgerEntryRecord>> getPointsHistory({
    required int limit,
  }) => caller.callServerEndpoint<List<_i9.PointsLedgerEntryRecord>>(
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
  _i2.Future<_i10.RedemptionResult> redeemReward(
    _i1.UuidValue walletUserId,
    String walletToken,
    int rewardItemId,
  ) => caller.callServerEndpoint<_i10.RedemptionResult>(
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
  _i2.Future<List<_i11.RewardItemRecord>> getCatalog() =>
      caller.callServerEndpoint<List<_i11.RewardItemRecord>>(
        'rewards',
        'getCatalog',
        {},
      );
}

/// Proves the Keycloak auth chain end-to-end during Phase 0 integration
/// testing (JWT validation -> JIT user provisioning -> role scopes). Not
/// load-bearing for the app itself, since the client already knows its own
/// roles from the decoded ID token.
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i12.AppUserRecord> getMe() =>
      caller.callServerEndpoint<_i12.AppUserRecord>(
        'user',
        'getMe',
        {},
      );
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
         _i13.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    menu = EndpointMenu(this);
    order = EndpointOrder(this);
    pointsClaim = EndpointPointsClaim(this);
    wallet = EndpointWallet(this);
    redemption = EndpointRedemption(this);
    rewards = EndpointRewards(this);
    user = EndpointUser(this);
  }

  late final EndpointMenu menu;

  late final EndpointOrder order;

  late final EndpointPointsClaim pointsClaim;

  late final EndpointWallet wallet;

  late final EndpointRedemption redemption;

  late final EndpointRewards rewards;

  late final EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'menu': menu,
    'order': order,
    'pointsClaim': pointsClaim,
    'wallet': wallet,
    'redemption': redemption,
    'rewards': rewards,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
