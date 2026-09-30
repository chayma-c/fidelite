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
import 'menu/exceptions/menu_item_validation_exception.dart' as _i2;
import 'menu/exceptions/menu_item_validation_exception_reason.dart' as _i3;
import 'menu/menu_item.dart' as _i4;
import 'orders/exceptions/invalid_order_exception.dart' as _i5;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i6;
import 'orders/order.dart' as _i7;
import 'orders/order_confirmation.dart' as _i8;
import 'orders/order_item.dart' as _i9;
import 'orders/order_item_input.dart' as _i10;
import 'orders/order_status.dart' as _i11;
import 'points/claim_result.dart' as _i12;
import 'points/claim_token_status.dart' as _i13;
import 'points/exceptions/order_claim_exception.dart' as _i14;
import 'points/exceptions/order_claim_exception_reason.dart' as _i15;
import 'points/order_claim_token.dart' as _i16;
import 'points/points_ledger_entry.dart' as _i17;
import 'points/points_ledger_reason.dart' as _i18;
import 'points/wallet_token.dart' as _i19;
import 'points/wallet_token_response.dart' as _i20;
import 'redemption/exceptions/redemption_exception.dart' as _i21;
import 'redemption/exceptions/redemption_exception_reason.dart' as _i22;
import 'redemption/redemption.dart' as _i23;
import 'redemption/redemption_result.dart' as _i24;
import 'redemption/redemption_status.dart' as _i25;
import 'rewards/reward_item.dart' as _i26;
import 'users/app_user.dart' as _i27;
import 'package:fidelite_client/src/protocol/menu/menu_item.dart' as _i28;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i29;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i30;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i31;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i32;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i33;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i34;
export 'menu/exceptions/menu_item_validation_exception.dart';
export 'menu/exceptions/menu_item_validation_exception_reason.dart';
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

    if (t == _i2.MenuItemValidationException) {
      return _i2.MenuItemValidationException.fromJson(data) as T;
    }
    if (t == _i3.MenuItemValidationExceptionReason) {
      return _i3.MenuItemValidationExceptionReason.fromJson(data) as T;
    }
    if (t == _i4.MenuItemRecord) {
      return _i4.MenuItemRecord.fromJson(data) as T;
    }
    if (t == _i5.InvalidOrderException) {
      return _i5.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i6.InvalidOrderExceptionReason) {
      return _i6.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i7.OrderRecord) {
      return _i7.OrderRecord.fromJson(data) as T;
    }
    if (t == _i8.OrderConfirmation) {
      return _i8.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i9.OrderItemRecord) {
      return _i9.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i10.OrderItemInput) {
      return _i10.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i11.OrderStatus) {
      return _i11.OrderStatus.fromJson(data) as T;
    }
    if (t == _i12.ClaimResult) {
      return _i12.ClaimResult.fromJson(data) as T;
    }
    if (t == _i13.ClaimTokenStatus) {
      return _i13.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i14.OrderClaimException) {
      return _i14.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i15.OrderClaimExceptionReason) {
      return _i15.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i16.OrderClaimTokenRecord) {
      return _i16.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i17.PointsLedgerEntryRecord) {
      return _i17.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i18.PointsLedgerReason) {
      return _i18.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i19.WalletTokenRecord) {
      return _i19.WalletTokenRecord.fromJson(data) as T;
    }
    if (t == _i20.WalletTokenResponse) {
      return _i20.WalletTokenResponse.fromJson(data) as T;
    }
    if (t == _i21.RedemptionException) {
      return _i21.RedemptionException.fromJson(data) as T;
    }
    if (t == _i22.RedemptionExceptionReason) {
      return _i22.RedemptionExceptionReason.fromJson(data) as T;
    }
    if (t == _i23.RedemptionRecord) {
      return _i23.RedemptionRecord.fromJson(data) as T;
    }
    if (t == _i24.RedemptionResult) {
      return _i24.RedemptionResult.fromJson(data) as T;
    }
    if (t == _i25.RedemptionStatus) {
      return _i25.RedemptionStatus.fromJson(data) as T;
    }
    if (t == _i26.RewardItemRecord) {
      return _i26.RewardItemRecord.fromJson(data) as T;
    }
    if (t == _i27.AppUserRecord) {
      return _i27.AppUserRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.MenuItemValidationException?>()) {
      return (data != null
              ? _i2.MenuItemValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i3.MenuItemValidationExceptionReason?>()) {
      return (data != null
              ? _i3.MenuItemValidationExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i4.MenuItemRecord?>()) {
      return (data != null ? _i4.MenuItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.InvalidOrderException?>()) {
      return (data != null ? _i5.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i6.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.OrderRecord?>()) {
      return (data != null ? _i7.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.OrderConfirmation?>()) {
      return (data != null ? _i8.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrderItemRecord?>()) {
      return (data != null ? _i9.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderItemInput?>()) {
      return (data != null ? _i10.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrderStatus?>()) {
      return (data != null ? _i11.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ClaimResult?>()) {
      return (data != null ? _i12.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ClaimTokenStatus?>()) {
      return (data != null ? _i13.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.OrderClaimException?>()) {
      return (data != null ? _i14.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i15.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.OrderClaimTokenRecord?>()) {
      return (data != null ? _i16.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i17.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.PointsLedgerReason?>()) {
      return (data != null ? _i18.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.WalletTokenRecord?>()) {
      return (data != null ? _i19.WalletTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.WalletTokenResponse?>()) {
      return (data != null ? _i20.WalletTokenResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.RedemptionException?>()) {
      return (data != null ? _i21.RedemptionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.RedemptionExceptionReason?>()) {
      return (data != null
              ? _i22.RedemptionExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.RedemptionRecord?>()) {
      return (data != null ? _i23.RedemptionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RedemptionResult?>()) {
      return (data != null ? _i24.RedemptionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.RedemptionStatus?>()) {
      return (data != null ? _i25.RedemptionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.RewardItemRecord?>()) {
      return (data != null ? _i26.RewardItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.AppUserRecord?>()) {
      return (data != null ? _i27.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i28.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i28.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i29.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i29.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i30.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i31.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.RewardItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i32.RewardItemRecord>(e))
              .toList()
          as T;
    }
    try {
      return _i33.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i34.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.MenuItemValidationException => 'MenuItemValidationException',
      _i3.MenuItemValidationExceptionReason =>
        'MenuItemValidationExceptionReason',
      _i4.MenuItemRecord => 'MenuItemRecord',
      _i5.InvalidOrderException => 'InvalidOrderException',
      _i6.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i7.OrderRecord => 'OrderRecord',
      _i8.OrderConfirmation => 'OrderConfirmation',
      _i9.OrderItemRecord => 'OrderItemRecord',
      _i10.OrderItemInput => 'OrderItemInput',
      _i11.OrderStatus => 'OrderStatus',
      _i12.ClaimResult => 'ClaimResult',
      _i13.ClaimTokenStatus => 'ClaimTokenStatus',
      _i14.OrderClaimException => 'OrderClaimException',
      _i15.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i16.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i17.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i18.PointsLedgerReason => 'PointsLedgerReason',
      _i19.WalletTokenRecord => 'WalletTokenRecord',
      _i20.WalletTokenResponse => 'WalletTokenResponse',
      _i21.RedemptionException => 'RedemptionException',
      _i22.RedemptionExceptionReason => 'RedemptionExceptionReason',
      _i23.RedemptionRecord => 'RedemptionRecord',
      _i24.RedemptionResult => 'RedemptionResult',
      _i25.RedemptionStatus => 'RedemptionStatus',
      _i26.RewardItemRecord => 'RewardItemRecord',
      _i27.AppUserRecord => 'AppUserRecord',
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
      case _i2.MenuItemValidationException():
        return 'MenuItemValidationException';
      case _i3.MenuItemValidationExceptionReason():
        return 'MenuItemValidationExceptionReason';
      case _i4.MenuItemRecord():
        return 'MenuItemRecord';
      case _i5.InvalidOrderException():
        return 'InvalidOrderException';
      case _i6.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i7.OrderRecord():
        return 'OrderRecord';
      case _i8.OrderConfirmation():
        return 'OrderConfirmation';
      case _i9.OrderItemRecord():
        return 'OrderItemRecord';
      case _i10.OrderItemInput():
        return 'OrderItemInput';
      case _i11.OrderStatus():
        return 'OrderStatus';
      case _i12.ClaimResult():
        return 'ClaimResult';
      case _i13.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i14.OrderClaimException():
        return 'OrderClaimException';
      case _i15.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i16.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i17.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i18.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i19.WalletTokenRecord():
        return 'WalletTokenRecord';
      case _i20.WalletTokenResponse():
        return 'WalletTokenResponse';
      case _i21.RedemptionException():
        return 'RedemptionException';
      case _i22.RedemptionExceptionReason():
        return 'RedemptionExceptionReason';
      case _i23.RedemptionRecord():
        return 'RedemptionRecord';
      case _i24.RedemptionResult():
        return 'RedemptionResult';
      case _i25.RedemptionStatus():
        return 'RedemptionStatus';
      case _i26.RewardItemRecord():
        return 'RewardItemRecord';
      case _i27.AppUserRecord():
        return 'AppUserRecord';
    }
    className = _i33.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i34.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'MenuItemValidationException') {
      return deserialize<_i2.MenuItemValidationException>(data['data']);
    }
    if (dataClassName == 'MenuItemValidationExceptionReason') {
      return deserialize<_i3.MenuItemValidationExceptionReason>(data['data']);
    }
    if (dataClassName == 'MenuItemRecord') {
      return deserialize<_i4.MenuItemRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i5.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i6.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i7.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i8.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i9.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i10.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i11.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i12.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i13.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i14.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i15.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i16.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i17.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i18.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'WalletTokenRecord') {
      return deserialize<_i19.WalletTokenRecord>(data['data']);
    }
    if (dataClassName == 'WalletTokenResponse') {
      return deserialize<_i20.WalletTokenResponse>(data['data']);
    }
    if (dataClassName == 'RedemptionException') {
      return deserialize<_i21.RedemptionException>(data['data']);
    }
    if (dataClassName == 'RedemptionExceptionReason') {
      return deserialize<_i22.RedemptionExceptionReason>(data['data']);
    }
    if (dataClassName == 'RedemptionRecord') {
      return deserialize<_i23.RedemptionRecord>(data['data']);
    }
    if (dataClassName == 'RedemptionResult') {
      return deserialize<_i24.RedemptionResult>(data['data']);
    }
    if (dataClassName == 'RedemptionStatus') {
      return deserialize<_i25.RedemptionStatus>(data['data']);
    }
    if (dataClassName == 'RewardItemRecord') {
      return deserialize<_i26.RewardItemRecord>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i27.AppUserRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i33.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i34.Protocol().deserializeByClassName(data);
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
    try {
      return _i33.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i34.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
