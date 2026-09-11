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
import 'menu/menu_item.dart' as _i2;
import 'orders/exceptions/invalid_order_exception.dart' as _i3;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i4;
import 'orders/order.dart' as _i5;
import 'orders/order_confirmation.dart' as _i6;
import 'orders/order_item.dart' as _i7;
import 'orders/order_item_input.dart' as _i8;
import 'orders/order_status.dart' as _i9;
import 'points/claim_result.dart' as _i10;
import 'points/claim_token_status.dart' as _i11;
import 'points/exceptions/order_claim_exception.dart' as _i12;
import 'points/exceptions/order_claim_exception_reason.dart' as _i13;
import 'points/order_claim_token.dart' as _i14;
import 'points/points_ledger_entry.dart' as _i15;
import 'points/points_ledger_reason.dart' as _i16;
import 'points/wallet_token.dart' as _i17;
import 'points/wallet_token_response.dart' as _i18;
import 'redemption/exceptions/redemption_exception.dart' as _i19;
import 'redemption/exceptions/redemption_exception_reason.dart' as _i20;
import 'redemption/redemption.dart' as _i21;
import 'redemption/redemption_result.dart' as _i22;
import 'redemption/redemption_status.dart' as _i23;
import 'rewards/reward_item.dart' as _i24;
import 'users/app_user.dart' as _i25;
import 'package:fidelite_client/src/protocol/menu/menu_item.dart' as _i26;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i27;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i28;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i29;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i30;
export 'menu/menu_item.dart';
export 'orders/exceptions/invalid_order_exception.dart';
export 'orders/exceptions/invalid_order_exception_reason.dart';
export 'orders/order.dart';
export 'orders/order_confirmation.dart';
export 'orders/order_item.dart';
export 'orders/order_item_input.dart';
export 'orders/order_status.dart';
export 'points/claim_result.dart';
export 'points/claim_token_status.dart';
export 'points/exceptions/order_claim_exception.dart';
export 'points/exceptions/order_claim_exception_reason.dart';
export 'points/order_claim_token.dart';
export 'points/points_ledger_entry.dart';
export 'points/points_ledger_reason.dart';
export 'points/wallet_token.dart';
export 'points/wallet_token_response.dart';
export 'redemption/exceptions/redemption_exception.dart';
export 'redemption/exceptions/redemption_exception_reason.dart';
export 'redemption/redemption.dart';
export 'redemption/redemption_result.dart';
export 'redemption/redemption_status.dart';
export 'rewards/reward_item.dart';
export 'users/app_user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.MenuItemRecord) {
      return _i2.MenuItemRecord.fromJson(data) as T;
    }
    if (t == _i3.InvalidOrderException) {
      return _i3.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i4.InvalidOrderExceptionReason) {
      return _i4.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i5.OrderRecord) {
      return _i5.OrderRecord.fromJson(data) as T;
    }
    if (t == _i6.OrderConfirmation) {
      return _i6.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i7.OrderItemRecord) {
      return _i7.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i8.OrderItemInput) {
      return _i8.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i9.OrderStatus) {
      return _i9.OrderStatus.fromJson(data) as T;
    }
    if (t == _i10.ClaimResult) {
      return _i10.ClaimResult.fromJson(data) as T;
    }
    if (t == _i11.ClaimTokenStatus) {
      return _i11.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i12.OrderClaimException) {
      return _i12.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i13.OrderClaimExceptionReason) {
      return _i13.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i14.OrderClaimTokenRecord) {
      return _i14.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i15.PointsLedgerEntryRecord) {
      return _i15.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i16.PointsLedgerReason) {
      return _i16.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i17.WalletTokenRecord) {
      return _i17.WalletTokenRecord.fromJson(data) as T;
    }
    if (t == _i18.WalletTokenResponse) {
      return _i18.WalletTokenResponse.fromJson(data) as T;
    }
    if (t == _i19.RedemptionException) {
      return _i19.RedemptionException.fromJson(data) as T;
    }
    if (t == _i20.RedemptionExceptionReason) {
      return _i20.RedemptionExceptionReason.fromJson(data) as T;
    }
    if (t == _i21.RedemptionRecord) {
      return _i21.RedemptionRecord.fromJson(data) as T;
    }
    if (t == _i22.RedemptionResult) {
      return _i22.RedemptionResult.fromJson(data) as T;
    }
    if (t == _i23.RedemptionStatus) {
      return _i23.RedemptionStatus.fromJson(data) as T;
    }
    if (t == _i24.RewardItemRecord) {
      return _i24.RewardItemRecord.fromJson(data) as T;
    }
    if (t == _i25.AppUserRecord) {
      return _i25.AppUserRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.MenuItemRecord?>()) {
      return (data != null ? _i2.MenuItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.InvalidOrderException?>()) {
      return (data != null ? _i3.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i4.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i5.OrderRecord?>()) {
      return (data != null ? _i5.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.OrderConfirmation?>()) {
      return (data != null ? _i6.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.OrderItemRecord?>()) {
      return (data != null ? _i7.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.OrderItemInput?>()) {
      return (data != null ? _i8.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderStatus?>()) {
      return (data != null ? _i9.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ClaimResult?>()) {
      return (data != null ? _i10.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ClaimTokenStatus?>()) {
      return (data != null ? _i11.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderClaimException?>()) {
      return (data != null ? _i12.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i13.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.OrderClaimTokenRecord?>()) {
      return (data != null ? _i14.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i15.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.PointsLedgerReason?>()) {
      return (data != null ? _i16.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.WalletTokenRecord?>()) {
      return (data != null ? _i17.WalletTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.WalletTokenResponse?>()) {
      return (data != null ? _i18.WalletTokenResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.RedemptionException?>()) {
      return (data != null ? _i19.RedemptionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.RedemptionExceptionReason?>()) {
      return (data != null
              ? _i20.RedemptionExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.RedemptionRecord?>()) {
      return (data != null ? _i21.RedemptionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RedemptionResult?>()) {
      return (data != null ? _i22.RedemptionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.RedemptionStatus?>()) {
      return (data != null ? _i23.RedemptionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RewardItemRecord?>()) {
      return (data != null ? _i24.RewardItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.AppUserRecord?>()) {
      return (data != null ? _i25.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i26.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i26.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i27.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i28.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i29.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.RewardItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i30.RewardItemRecord>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.MenuItemRecord => 'MenuItemRecord',
      _i3.InvalidOrderException => 'InvalidOrderException',
      _i4.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i5.OrderRecord => 'OrderRecord',
      _i6.OrderConfirmation => 'OrderConfirmation',
      _i7.OrderItemRecord => 'OrderItemRecord',
      _i8.OrderItemInput => 'OrderItemInput',
      _i9.OrderStatus => 'OrderStatus',
      _i10.ClaimResult => 'ClaimResult',
      _i11.ClaimTokenStatus => 'ClaimTokenStatus',
      _i12.OrderClaimException => 'OrderClaimException',
      _i13.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i14.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i15.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i16.PointsLedgerReason => 'PointsLedgerReason',
      _i17.WalletTokenRecord => 'WalletTokenRecord',
      _i18.WalletTokenResponse => 'WalletTokenResponse',
      _i19.RedemptionException => 'RedemptionException',
      _i20.RedemptionExceptionReason => 'RedemptionExceptionReason',
      _i21.RedemptionRecord => 'RedemptionRecord',
      _i22.RedemptionResult => 'RedemptionResult',
      _i23.RedemptionStatus => 'RedemptionStatus',
      _i24.RewardItemRecord => 'RewardItemRecord',
      _i25.AppUserRecord => 'AppUserRecord',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('fidelite.', '');
    }

    switch (data) {
      case _i2.MenuItemRecord():
        return 'MenuItemRecord';
      case _i3.InvalidOrderException():
        return 'InvalidOrderException';
      case _i4.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i5.OrderRecord():
        return 'OrderRecord';
      case _i6.OrderConfirmation():
        return 'OrderConfirmation';
      case _i7.OrderItemRecord():
        return 'OrderItemRecord';
      case _i8.OrderItemInput():
        return 'OrderItemInput';
      case _i9.OrderStatus():
        return 'OrderStatus';
      case _i10.ClaimResult():
        return 'ClaimResult';
      case _i11.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i12.OrderClaimException():
        return 'OrderClaimException';
      case _i13.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i14.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i15.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i16.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i17.WalletTokenRecord():
        return 'WalletTokenRecord';
      case _i18.WalletTokenResponse():
        return 'WalletTokenResponse';
      case _i19.RedemptionException():
        return 'RedemptionException';
      case _i20.RedemptionExceptionReason():
        return 'RedemptionExceptionReason';
      case _i21.RedemptionRecord():
        return 'RedemptionRecord';
      case _i22.RedemptionResult():
        return 'RedemptionResult';
      case _i23.RedemptionStatus():
        return 'RedemptionStatus';
      case _i24.RewardItemRecord():
        return 'RewardItemRecord';
      case _i25.AppUserRecord():
        return 'AppUserRecord';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'MenuItemRecord') {
      return deserialize<_i2.MenuItemRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i3.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i4.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i5.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i6.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i7.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i8.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i9.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i10.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i11.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i12.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i13.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i14.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i15.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i16.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'WalletTokenRecord') {
      return deserialize<_i17.WalletTokenRecord>(data['data']);
    }
    if (dataClassName == 'WalletTokenResponse') {
      return deserialize<_i18.WalletTokenResponse>(data['data']);
    }
    if (dataClassName == 'RedemptionException') {
      return deserialize<_i19.RedemptionException>(data['data']);
    }
    if (dataClassName == 'RedemptionExceptionReason') {
      return deserialize<_i20.RedemptionExceptionReason>(data['data']);
    }
    if (dataClassName == 'RedemptionRecord') {
      return deserialize<_i21.RedemptionRecord>(data['data']);
    }
    if (dataClassName == 'RedemptionResult') {
      return deserialize<_i22.RedemptionResult>(data['data']);
    }
    if (dataClassName == 'RedemptionStatus') {
      return deserialize<_i23.RedemptionStatus>(data['data']);
    }
    if (dataClassName == 'RewardItemRecord') {
      return deserialize<_i24.RewardItemRecord>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i25.AppUserRecord>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
