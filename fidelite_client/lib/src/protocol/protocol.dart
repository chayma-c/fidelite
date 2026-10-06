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
import 'notifications/device_token.dart' as _i5;
import 'orders/exceptions/invalid_order_exception.dart' as _i6;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i7;
import 'orders/online_order_confirmation.dart' as _i8;
import 'orders/order.dart' as _i9;
import 'orders/order_confirmation.dart' as _i10;
import 'orders/order_item.dart' as _i11;
import 'orders/order_item_input.dart' as _i12;
import 'orders/order_status.dart' as _i13;
import 'points/claim_result.dart' as _i14;
import 'points/claim_token_status.dart' as _i15;
import 'points/exceptions/order_claim_exception.dart' as _i16;
import 'points/exceptions/order_claim_exception_reason.dart' as _i17;
import 'points/order_claim_token.dart' as _i18;
import 'points/points_ledger_entry.dart' as _i19;
import 'points/points_ledger_reason.dart' as _i20;
import 'points/wallet_token.dart' as _i21;
import 'points/wallet_token_response.dart' as _i22;
import 'redemption/exceptions/redemption_exception.dart' as _i23;
import 'redemption/exceptions/redemption_exception_reason.dart' as _i24;
import 'redemption/redemption.dart' as _i25;
import 'redemption/redemption_result.dart' as _i26;
import 'redemption/redemption_status.dart' as _i27;
import 'rewards/reward_item.dart' as _i28;
import 'shop/online_order_settings.dart' as _i29;
import 'shop/shop_open_status.dart' as _i30;
import 'shop/shop_status.dart' as _i31;
import 'users/app_user.dart' as _i32;
import 'package:fidelite_client/src/protocol/menu/menu_item.dart' as _i33;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i34;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i35;
import 'package:fidelite_client/src/protocol/orders/order_item.dart' as _i36;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i37;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i38;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i39;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i40;
export 'menu/exceptions/menu_item_validation_exception.dart';
export 'menu/exceptions/menu_item_validation_exception_reason.dart';
export 'menu/menu_item.dart';
export 'notifications/device_token.dart';
export 'orders/exceptions/invalid_order_exception.dart';
export 'orders/exceptions/invalid_order_exception_reason.dart';
export 'orders/online_order_confirmation.dart';
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
export 'shop/online_order_settings.dart';
export 'shop/shop_open_status.dart';
export 'shop/shop_status.dart';
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
    if (t == _i5.DeviceTokenRecord) {
      return _i5.DeviceTokenRecord.fromJson(data) as T;
    }
    if (t == _i6.InvalidOrderException) {
      return _i6.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i7.InvalidOrderExceptionReason) {
      return _i7.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i8.OnlineOrderConfirmation) {
      return _i8.OnlineOrderConfirmation.fromJson(data) as T;
    }
    if (t == _i9.OrderRecord) {
      return _i9.OrderRecord.fromJson(data) as T;
    }
    if (t == _i10.OrderConfirmation) {
      return _i10.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i11.OrderItemRecord) {
      return _i11.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i12.OrderItemInput) {
      return _i12.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i13.OrderStatus) {
      return _i13.OrderStatus.fromJson(data) as T;
    }
    if (t == _i14.ClaimResult) {
      return _i14.ClaimResult.fromJson(data) as T;
    }
    if (t == _i15.ClaimTokenStatus) {
      return _i15.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i16.OrderClaimException) {
      return _i16.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i17.OrderClaimExceptionReason) {
      return _i17.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i18.OrderClaimTokenRecord) {
      return _i18.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i19.PointsLedgerEntryRecord) {
      return _i19.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i20.PointsLedgerReason) {
      return _i20.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i21.WalletTokenRecord) {
      return _i21.WalletTokenRecord.fromJson(data) as T;
    }
    if (t == _i22.WalletTokenResponse) {
      return _i22.WalletTokenResponse.fromJson(data) as T;
    }
    if (t == _i23.RedemptionException) {
      return _i23.RedemptionException.fromJson(data) as T;
    }
    if (t == _i24.RedemptionExceptionReason) {
      return _i24.RedemptionExceptionReason.fromJson(data) as T;
    }
    if (t == _i25.RedemptionRecord) {
      return _i25.RedemptionRecord.fromJson(data) as T;
    }
    if (t == _i26.RedemptionResult) {
      return _i26.RedemptionResult.fromJson(data) as T;
    }
    if (t == _i27.RedemptionStatus) {
      return _i27.RedemptionStatus.fromJson(data) as T;
    }
    if (t == _i28.RewardItemRecord) {
      return _i28.RewardItemRecord.fromJson(data) as T;
    }
    if (t == _i29.OnlineOrderSettingsRecord) {
      return _i29.OnlineOrderSettingsRecord.fromJson(data) as T;
    }
    if (t == _i30.ShopOpenStatus) {
      return _i30.ShopOpenStatus.fromJson(data) as T;
    }
    if (t == _i31.ShopStatusRecord) {
      return _i31.ShopStatusRecord.fromJson(data) as T;
    }
    if (t == _i32.AppUserRecord) {
      return _i32.AppUserRecord.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.DeviceTokenRecord?>()) {
      return (data != null ? _i5.DeviceTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.InvalidOrderException?>()) {
      return (data != null ? _i6.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i7.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i8.OnlineOrderConfirmation?>()) {
      return (data != null ? _i8.OnlineOrderConfirmation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.OrderRecord?>()) {
      return (data != null ? _i9.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.OrderConfirmation?>()) {
      return (data != null ? _i10.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrderItemRecord?>()) {
      return (data != null ? _i11.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderItemInput?>()) {
      return (data != null ? _i12.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderStatus?>()) {
      return (data != null ? _i13.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.ClaimResult?>()) {
      return (data != null ? _i14.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ClaimTokenStatus?>()) {
      return (data != null ? _i15.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderClaimException?>()) {
      return (data != null ? _i16.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i17.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.OrderClaimTokenRecord?>()) {
      return (data != null ? _i18.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i19.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.PointsLedgerReason?>()) {
      return (data != null ? _i20.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.WalletTokenRecord?>()) {
      return (data != null ? _i21.WalletTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.WalletTokenResponse?>()) {
      return (data != null ? _i22.WalletTokenResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.RedemptionException?>()) {
      return (data != null ? _i23.RedemptionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.RedemptionExceptionReason?>()) {
      return (data != null
              ? _i24.RedemptionExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.RedemptionRecord?>()) {
      return (data != null ? _i25.RedemptionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.RedemptionResult?>()) {
      return (data != null ? _i26.RedemptionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.RedemptionStatus?>()) {
      return (data != null ? _i27.RedemptionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.RewardItemRecord?>()) {
      return (data != null ? _i28.RewardItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.OnlineOrderSettingsRecord?>()) {
      return (data != null
              ? _i29.OnlineOrderSettingsRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.ShopOpenStatus?>()) {
      return (data != null ? _i30.ShopOpenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ShopStatusRecord?>()) {
      return (data != null ? _i31.ShopStatusRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.AppUserRecord?>()) {
      return (data != null ? _i32.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i33.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i33.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i34.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i34.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i35.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.OrderItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i36.OrderItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i37.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.RewardItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i38.RewardItemRecord>(e))
              .toList()
          as T;
    }
    try {
      return _i39.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i40.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.MenuItemValidationException => 'MenuItemValidationException',
      _i3.MenuItemValidationExceptionReason =>
        'MenuItemValidationExceptionReason',
      _i4.MenuItemRecord => 'MenuItemRecord',
      _i5.DeviceTokenRecord => 'DeviceTokenRecord',
      _i6.InvalidOrderException => 'InvalidOrderException',
      _i7.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i8.OnlineOrderConfirmation => 'OnlineOrderConfirmation',
      _i9.OrderRecord => 'OrderRecord',
      _i10.OrderConfirmation => 'OrderConfirmation',
      _i11.OrderItemRecord => 'OrderItemRecord',
      _i12.OrderItemInput => 'OrderItemInput',
      _i13.OrderStatus => 'OrderStatus',
      _i14.ClaimResult => 'ClaimResult',
      _i15.ClaimTokenStatus => 'ClaimTokenStatus',
      _i16.OrderClaimException => 'OrderClaimException',
      _i17.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i18.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i19.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i20.PointsLedgerReason => 'PointsLedgerReason',
      _i21.WalletTokenRecord => 'WalletTokenRecord',
      _i22.WalletTokenResponse => 'WalletTokenResponse',
      _i23.RedemptionException => 'RedemptionException',
      _i24.RedemptionExceptionReason => 'RedemptionExceptionReason',
      _i25.RedemptionRecord => 'RedemptionRecord',
      _i26.RedemptionResult => 'RedemptionResult',
      _i27.RedemptionStatus => 'RedemptionStatus',
      _i28.RewardItemRecord => 'RewardItemRecord',
      _i29.OnlineOrderSettingsRecord => 'OnlineOrderSettingsRecord',
      _i30.ShopOpenStatus => 'ShopOpenStatus',
      _i31.ShopStatusRecord => 'ShopStatusRecord',
      _i32.AppUserRecord => 'AppUserRecord',
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
      case _i5.DeviceTokenRecord():
        return 'DeviceTokenRecord';
      case _i6.InvalidOrderException():
        return 'InvalidOrderException';
      case _i7.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i8.OnlineOrderConfirmation():
        return 'OnlineOrderConfirmation';
      case _i9.OrderRecord():
        return 'OrderRecord';
      case _i10.OrderConfirmation():
        return 'OrderConfirmation';
      case _i11.OrderItemRecord():
        return 'OrderItemRecord';
      case _i12.OrderItemInput():
        return 'OrderItemInput';
      case _i13.OrderStatus():
        return 'OrderStatus';
      case _i14.ClaimResult():
        return 'ClaimResult';
      case _i15.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i16.OrderClaimException():
        return 'OrderClaimException';
      case _i17.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i18.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i19.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i20.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i21.WalletTokenRecord():
        return 'WalletTokenRecord';
      case _i22.WalletTokenResponse():
        return 'WalletTokenResponse';
      case _i23.RedemptionException():
        return 'RedemptionException';
      case _i24.RedemptionExceptionReason():
        return 'RedemptionExceptionReason';
      case _i25.RedemptionRecord():
        return 'RedemptionRecord';
      case _i26.RedemptionResult():
        return 'RedemptionResult';
      case _i27.RedemptionStatus():
        return 'RedemptionStatus';
      case _i28.RewardItemRecord():
        return 'RewardItemRecord';
      case _i29.OnlineOrderSettingsRecord():
        return 'OnlineOrderSettingsRecord';
      case _i30.ShopOpenStatus():
        return 'ShopOpenStatus';
      case _i31.ShopStatusRecord():
        return 'ShopStatusRecord';
      case _i32.AppUserRecord():
        return 'AppUserRecord';
    }
    className = _i39.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i40.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'DeviceTokenRecord') {
      return deserialize<_i5.DeviceTokenRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i6.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i7.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OnlineOrderConfirmation') {
      return deserialize<_i8.OnlineOrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i9.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i10.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i11.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i12.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i13.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i14.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i15.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i16.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i17.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i18.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i19.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i20.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'WalletTokenRecord') {
      return deserialize<_i21.WalletTokenRecord>(data['data']);
    }
    if (dataClassName == 'WalletTokenResponse') {
      return deserialize<_i22.WalletTokenResponse>(data['data']);
    }
    if (dataClassName == 'RedemptionException') {
      return deserialize<_i23.RedemptionException>(data['data']);
    }
    if (dataClassName == 'RedemptionExceptionReason') {
      return deserialize<_i24.RedemptionExceptionReason>(data['data']);
    }
    if (dataClassName == 'RedemptionRecord') {
      return deserialize<_i25.RedemptionRecord>(data['data']);
    }
    if (dataClassName == 'RedemptionResult') {
      return deserialize<_i26.RedemptionResult>(data['data']);
    }
    if (dataClassName == 'RedemptionStatus') {
      return deserialize<_i27.RedemptionStatus>(data['data']);
    }
    if (dataClassName == 'RewardItemRecord') {
      return deserialize<_i28.RewardItemRecord>(data['data']);
    }
    if (dataClassName == 'OnlineOrderSettingsRecord') {
      return deserialize<_i29.OnlineOrderSettingsRecord>(data['data']);
    }
    if (dataClassName == 'ShopOpenStatus') {
      return deserialize<_i30.ShopOpenStatus>(data['data']);
    }
    if (dataClassName == 'ShopStatusRecord') {
      return deserialize<_i31.ShopStatusRecord>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i32.AppUserRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i39.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i40.Protocol().deserializeByClassName(data);
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
      return _i39.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i40.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
