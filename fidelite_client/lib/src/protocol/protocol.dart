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
import 'menu/ingredient.dart' as _i4;
import 'menu/ingredient_kind.dart' as _i5;
import 'menu/menu_item.dart' as _i6;
import 'notifications/device_token.dart' as _i7;
import 'orders/exceptions/invalid_order_exception.dart' as _i8;
import 'orders/exceptions/invalid_order_exception_reason.dart' as _i9;
import 'orders/online_order_confirmation.dart' as _i10;
import 'orders/order.dart' as _i11;
import 'orders/order_confirmation.dart' as _i12;
import 'orders/order_fulfillment_method.dart' as _i13;
import 'orders/order_item.dart' as _i14;
import 'orders/order_item_input.dart' as _i15;
import 'orders/order_payment_method.dart' as _i16;
import 'orders/order_status.dart' as _i17;
import 'points/claim_result.dart' as _i18;
import 'points/claim_token_status.dart' as _i19;
import 'points/exceptions/order_claim_exception.dart' as _i20;
import 'points/exceptions/order_claim_exception_reason.dart' as _i21;
import 'points/order_claim_token.dart' as _i22;
import 'points/points_ledger_entry.dart' as _i23;
import 'points/points_ledger_reason.dart' as _i24;
import 'points/wallet_token.dart' as _i25;
import 'points/wallet_token_response.dart' as _i26;
import 'redemption/exceptions/redemption_exception.dart' as _i27;
import 'redemption/exceptions/redemption_exception_reason.dart' as _i28;
import 'redemption/redemption.dart' as _i29;
import 'redemption/redemption_result.dart' as _i30;
import 'redemption/redemption_status.dart' as _i31;
import 'rewards/reward_item.dart' as _i32;
import 'shop/online_order_public_settings.dart' as _i33;
import 'shop/online_order_settings.dart' as _i34;
import 'shop/shop_open_status.dart' as _i35;
import 'shop/shop_status.dart' as _i36;
import 'users/app_user.dart' as _i37;
import 'users/exceptions/email_registration_blocked_exception.dart' as _i38;
import 'users/exceptions/email_registration_blocked_exception_reason.dart'
    as _i39;
import 'package:fidelite_client/src/protocol/menu/menu_item.dart' as _i40;
import 'package:fidelite_client/src/protocol/menu/ingredient.dart' as _i41;
import 'package:fidelite_client/src/protocol/orders/order_item_input.dart'
    as _i42;
import 'package:fidelite_client/src/protocol/orders/order.dart' as _i43;
import 'package:fidelite_client/src/protocol/orders/order_item.dart' as _i44;
import 'package:fidelite_client/src/protocol/points/points_ledger_entry.dart'
    as _i45;
import 'package:fidelite_client/src/protocol/rewards/reward_item.dart' as _i46;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i47;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i48;
export 'menu/exceptions/menu_item_validation_exception.dart';
export 'menu/exceptions/menu_item_validation_exception_reason.dart';
export 'menu/ingredient.dart';
export 'menu/ingredient_kind.dart';
export 'menu/menu_item.dart';
export 'notifications/device_token.dart';
export 'orders/exceptions/invalid_order_exception.dart';
export 'orders/exceptions/invalid_order_exception_reason.dart';
export 'orders/online_order_confirmation.dart';
export 'orders/order.dart';
export 'orders/order_confirmation.dart';
export 'orders/order_fulfillment_method.dart';
export 'orders/order_item.dart';
export 'orders/order_item_input.dart';
export 'orders/order_payment_method.dart';
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
export 'shop/online_order_public_settings.dart';
export 'shop/online_order_settings.dart';
export 'shop/shop_open_status.dart';
export 'shop/shop_status.dart';
export 'users/app_user.dart';
export 'users/exceptions/email_registration_blocked_exception.dart';
export 'users/exceptions/email_registration_blocked_exception_reason.dart';
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
    if (t == _i4.IngredientRecord) {
      return _i4.IngredientRecord.fromJson(data) as T;
    }
    if (t == _i5.IngredientKind) {
      return _i5.IngredientKind.fromJson(data) as T;
    }
    if (t == _i6.MenuItemRecord) {
      return _i6.MenuItemRecord.fromJson(data) as T;
    }
    if (t == _i7.DeviceTokenRecord) {
      return _i7.DeviceTokenRecord.fromJson(data) as T;
    }
    if (t == _i8.InvalidOrderException) {
      return _i8.InvalidOrderException.fromJson(data) as T;
    }
    if (t == _i9.InvalidOrderExceptionReason) {
      return _i9.InvalidOrderExceptionReason.fromJson(data) as T;
    }
    if (t == _i10.OnlineOrderConfirmation) {
      return _i10.OnlineOrderConfirmation.fromJson(data) as T;
    }
    if (t == _i11.OrderRecord) {
      return _i11.OrderRecord.fromJson(data) as T;
    }
    if (t == _i12.OrderConfirmation) {
      return _i12.OrderConfirmation.fromJson(data) as T;
    }
    if (t == _i13.OrderFulfillmentMethod) {
      return _i13.OrderFulfillmentMethod.fromJson(data) as T;
    }
    if (t == _i14.OrderItemRecord) {
      return _i14.OrderItemRecord.fromJson(data) as T;
    }
    if (t == _i15.OrderItemInput) {
      return _i15.OrderItemInput.fromJson(data) as T;
    }
    if (t == _i16.OrderPaymentMethod) {
      return _i16.OrderPaymentMethod.fromJson(data) as T;
    }
    if (t == _i17.OrderStatus) {
      return _i17.OrderStatus.fromJson(data) as T;
    }
    if (t == _i18.ClaimResult) {
      return _i18.ClaimResult.fromJson(data) as T;
    }
    if (t == _i19.ClaimTokenStatus) {
      return _i19.ClaimTokenStatus.fromJson(data) as T;
    }
    if (t == _i20.OrderClaimException) {
      return _i20.OrderClaimException.fromJson(data) as T;
    }
    if (t == _i21.OrderClaimExceptionReason) {
      return _i21.OrderClaimExceptionReason.fromJson(data) as T;
    }
    if (t == _i22.OrderClaimTokenRecord) {
      return _i22.OrderClaimTokenRecord.fromJson(data) as T;
    }
    if (t == _i23.PointsLedgerEntryRecord) {
      return _i23.PointsLedgerEntryRecord.fromJson(data) as T;
    }
    if (t == _i24.PointsLedgerReason) {
      return _i24.PointsLedgerReason.fromJson(data) as T;
    }
    if (t == _i25.WalletTokenRecord) {
      return _i25.WalletTokenRecord.fromJson(data) as T;
    }
    if (t == _i26.WalletTokenResponse) {
      return _i26.WalletTokenResponse.fromJson(data) as T;
    }
    if (t == _i27.RedemptionException) {
      return _i27.RedemptionException.fromJson(data) as T;
    }
    if (t == _i28.RedemptionExceptionReason) {
      return _i28.RedemptionExceptionReason.fromJson(data) as T;
    }
    if (t == _i29.RedemptionRecord) {
      return _i29.RedemptionRecord.fromJson(data) as T;
    }
    if (t == _i30.RedemptionResult) {
      return _i30.RedemptionResult.fromJson(data) as T;
    }
    if (t == _i31.RedemptionStatus) {
      return _i31.RedemptionStatus.fromJson(data) as T;
    }
    if (t == _i32.RewardItemRecord) {
      return _i32.RewardItemRecord.fromJson(data) as T;
    }
    if (t == _i33.OnlineOrderPublicSettings) {
      return _i33.OnlineOrderPublicSettings.fromJson(data) as T;
    }
    if (t == _i34.OnlineOrderSettingsRecord) {
      return _i34.OnlineOrderSettingsRecord.fromJson(data) as T;
    }
    if (t == _i35.ShopOpenStatus) {
      return _i35.ShopOpenStatus.fromJson(data) as T;
    }
    if (t == _i36.ShopStatusRecord) {
      return _i36.ShopStatusRecord.fromJson(data) as T;
    }
    if (t == _i37.AppUserRecord) {
      return _i37.AppUserRecord.fromJson(data) as T;
    }
    if (t == _i38.EmailRegistrationBlockedException) {
      return _i38.EmailRegistrationBlockedException.fromJson(data) as T;
    }
    if (t == _i39.EmailRegistrationBlockedExceptionReason) {
      return _i39.EmailRegistrationBlockedExceptionReason.fromJson(data) as T;
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
    if (t == _i1.getType<_i4.IngredientRecord?>()) {
      return (data != null ? _i4.IngredientRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.IngredientKind?>()) {
      return (data != null ? _i5.IngredientKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.MenuItemRecord?>()) {
      return (data != null ? _i6.MenuItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.DeviceTokenRecord?>()) {
      return (data != null ? _i7.DeviceTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.InvalidOrderException?>()) {
      return (data != null ? _i8.InvalidOrderException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.InvalidOrderExceptionReason?>()) {
      return (data != null
              ? _i9.InvalidOrderExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.OnlineOrderConfirmation?>()) {
      return (data != null ? _i10.OnlineOrderConfirmation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.OrderRecord?>()) {
      return (data != null ? _i11.OrderRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrderConfirmation?>()) {
      return (data != null ? _i12.OrderConfirmation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderFulfillmentMethod?>()) {
      return (data != null ? _i13.OrderFulfillmentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.OrderItemRecord?>()) {
      return (data != null ? _i14.OrderItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.OrderItemInput?>()) {
      return (data != null ? _i15.OrderItemInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderPaymentMethod?>()) {
      return (data != null ? _i16.OrderPaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.OrderStatus?>()) {
      return (data != null ? _i17.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ClaimResult?>()) {
      return (data != null ? _i18.ClaimResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ClaimTokenStatus?>()) {
      return (data != null ? _i19.ClaimTokenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.OrderClaimException?>()) {
      return (data != null ? _i20.OrderClaimException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.OrderClaimExceptionReason?>()) {
      return (data != null
              ? _i21.OrderClaimExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.OrderClaimTokenRecord?>()) {
      return (data != null ? _i22.OrderClaimTokenRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.PointsLedgerEntryRecord?>()) {
      return (data != null ? _i23.PointsLedgerEntryRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.PointsLedgerReason?>()) {
      return (data != null ? _i24.PointsLedgerReason.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.WalletTokenRecord?>()) {
      return (data != null ? _i25.WalletTokenRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.WalletTokenResponse?>()) {
      return (data != null ? _i26.WalletTokenResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.RedemptionException?>()) {
      return (data != null ? _i27.RedemptionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.RedemptionExceptionReason?>()) {
      return (data != null
              ? _i28.RedemptionExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.RedemptionRecord?>()) {
      return (data != null ? _i29.RedemptionRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.RedemptionResult?>()) {
      return (data != null ? _i30.RedemptionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.RedemptionStatus?>()) {
      return (data != null ? _i31.RedemptionStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.RewardItemRecord?>()) {
      return (data != null ? _i32.RewardItemRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.OnlineOrderPublicSettings?>()) {
      return (data != null
              ? _i33.OnlineOrderPublicSettings.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i34.OnlineOrderSettingsRecord?>()) {
      return (data != null
              ? _i34.OnlineOrderSettingsRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.ShopOpenStatus?>()) {
      return (data != null ? _i35.ShopOpenStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.ShopStatusRecord?>()) {
      return (data != null ? _i36.ShopStatusRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AppUserRecord?>()) {
      return (data != null ? _i37.AppUserRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.EmailRegistrationBlockedException?>()) {
      return (data != null
              ? _i38.EmailRegistrationBlockedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i39.EmailRegistrationBlockedExceptionReason?>()) {
      return (data != null
              ? _i39.EmailRegistrationBlockedExceptionReason.fromJson(data)
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i40.MenuItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i40.MenuItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.IngredientRecord>) {
      return (data as List)
              .map((e) => deserialize<_i41.IngredientRecord>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i42.OrderItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i42.OrderItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.OrderRecord>) {
      return (data as List)
              .map((e) => deserialize<_i43.OrderRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i44.OrderItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i44.OrderItemRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.PointsLedgerEntryRecord>) {
      return (data as List)
              .map((e) => deserialize<_i45.PointsLedgerEntryRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.RewardItemRecord>) {
      return (data as List)
              .map((e) => deserialize<_i46.RewardItemRecord>(e))
              .toList()
          as T;
    }
    try {
      return _i47.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i48.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.MenuItemValidationException => 'MenuItemValidationException',
      _i3.MenuItemValidationExceptionReason =>
        'MenuItemValidationExceptionReason',
      _i4.IngredientRecord => 'IngredientRecord',
      _i5.IngredientKind => 'IngredientKind',
      _i6.MenuItemRecord => 'MenuItemRecord',
      _i7.DeviceTokenRecord => 'DeviceTokenRecord',
      _i8.InvalidOrderException => 'InvalidOrderException',
      _i9.InvalidOrderExceptionReason => 'InvalidOrderExceptionReason',
      _i10.OnlineOrderConfirmation => 'OnlineOrderConfirmation',
      _i11.OrderRecord => 'OrderRecord',
      _i12.OrderConfirmation => 'OrderConfirmation',
      _i13.OrderFulfillmentMethod => 'OrderFulfillmentMethod',
      _i14.OrderItemRecord => 'OrderItemRecord',
      _i15.OrderItemInput => 'OrderItemInput',
      _i16.OrderPaymentMethod => 'OrderPaymentMethod',
      _i17.OrderStatus => 'OrderStatus',
      _i18.ClaimResult => 'ClaimResult',
      _i19.ClaimTokenStatus => 'ClaimTokenStatus',
      _i20.OrderClaimException => 'OrderClaimException',
      _i21.OrderClaimExceptionReason => 'OrderClaimExceptionReason',
      _i22.OrderClaimTokenRecord => 'OrderClaimTokenRecord',
      _i23.PointsLedgerEntryRecord => 'PointsLedgerEntryRecord',
      _i24.PointsLedgerReason => 'PointsLedgerReason',
      _i25.WalletTokenRecord => 'WalletTokenRecord',
      _i26.WalletTokenResponse => 'WalletTokenResponse',
      _i27.RedemptionException => 'RedemptionException',
      _i28.RedemptionExceptionReason => 'RedemptionExceptionReason',
      _i29.RedemptionRecord => 'RedemptionRecord',
      _i30.RedemptionResult => 'RedemptionResult',
      _i31.RedemptionStatus => 'RedemptionStatus',
      _i32.RewardItemRecord => 'RewardItemRecord',
      _i33.OnlineOrderPublicSettings => 'OnlineOrderPublicSettings',
      _i34.OnlineOrderSettingsRecord => 'OnlineOrderSettingsRecord',
      _i35.ShopOpenStatus => 'ShopOpenStatus',
      _i36.ShopStatusRecord => 'ShopStatusRecord',
      _i37.AppUserRecord => 'AppUserRecord',
      _i38.EmailRegistrationBlockedException =>
        'EmailRegistrationBlockedException',
      _i39.EmailRegistrationBlockedExceptionReason =>
        'EmailRegistrationBlockedExceptionReason',
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
      case _i4.IngredientRecord():
        return 'IngredientRecord';
      case _i5.IngredientKind():
        return 'IngredientKind';
      case _i6.MenuItemRecord():
        return 'MenuItemRecord';
      case _i7.DeviceTokenRecord():
        return 'DeviceTokenRecord';
      case _i8.InvalidOrderException():
        return 'InvalidOrderException';
      case _i9.InvalidOrderExceptionReason():
        return 'InvalidOrderExceptionReason';
      case _i10.OnlineOrderConfirmation():
        return 'OnlineOrderConfirmation';
      case _i11.OrderRecord():
        return 'OrderRecord';
      case _i12.OrderConfirmation():
        return 'OrderConfirmation';
      case _i13.OrderFulfillmentMethod():
        return 'OrderFulfillmentMethod';
      case _i14.OrderItemRecord():
        return 'OrderItemRecord';
      case _i15.OrderItemInput():
        return 'OrderItemInput';
      case _i16.OrderPaymentMethod():
        return 'OrderPaymentMethod';
      case _i17.OrderStatus():
        return 'OrderStatus';
      case _i18.ClaimResult():
        return 'ClaimResult';
      case _i19.ClaimTokenStatus():
        return 'ClaimTokenStatus';
      case _i20.OrderClaimException():
        return 'OrderClaimException';
      case _i21.OrderClaimExceptionReason():
        return 'OrderClaimExceptionReason';
      case _i22.OrderClaimTokenRecord():
        return 'OrderClaimTokenRecord';
      case _i23.PointsLedgerEntryRecord():
        return 'PointsLedgerEntryRecord';
      case _i24.PointsLedgerReason():
        return 'PointsLedgerReason';
      case _i25.WalletTokenRecord():
        return 'WalletTokenRecord';
      case _i26.WalletTokenResponse():
        return 'WalletTokenResponse';
      case _i27.RedemptionException():
        return 'RedemptionException';
      case _i28.RedemptionExceptionReason():
        return 'RedemptionExceptionReason';
      case _i29.RedemptionRecord():
        return 'RedemptionRecord';
      case _i30.RedemptionResult():
        return 'RedemptionResult';
      case _i31.RedemptionStatus():
        return 'RedemptionStatus';
      case _i32.RewardItemRecord():
        return 'RewardItemRecord';
      case _i33.OnlineOrderPublicSettings():
        return 'OnlineOrderPublicSettings';
      case _i34.OnlineOrderSettingsRecord():
        return 'OnlineOrderSettingsRecord';
      case _i35.ShopOpenStatus():
        return 'ShopOpenStatus';
      case _i36.ShopStatusRecord():
        return 'ShopStatusRecord';
      case _i37.AppUserRecord():
        return 'AppUserRecord';
      case _i38.EmailRegistrationBlockedException():
        return 'EmailRegistrationBlockedException';
      case _i39.EmailRegistrationBlockedExceptionReason():
        return 'EmailRegistrationBlockedExceptionReason';
    }
    className = _i47.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i48.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'IngredientRecord') {
      return deserialize<_i4.IngredientRecord>(data['data']);
    }
    if (dataClassName == 'IngredientKind') {
      return deserialize<_i5.IngredientKind>(data['data']);
    }
    if (dataClassName == 'MenuItemRecord') {
      return deserialize<_i6.MenuItemRecord>(data['data']);
    }
    if (dataClassName == 'DeviceTokenRecord') {
      return deserialize<_i7.DeviceTokenRecord>(data['data']);
    }
    if (dataClassName == 'InvalidOrderException') {
      return deserialize<_i8.InvalidOrderException>(data['data']);
    }
    if (dataClassName == 'InvalidOrderExceptionReason') {
      return deserialize<_i9.InvalidOrderExceptionReason>(data['data']);
    }
    if (dataClassName == 'OnlineOrderConfirmation') {
      return deserialize<_i10.OnlineOrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderRecord') {
      return deserialize<_i11.OrderRecord>(data['data']);
    }
    if (dataClassName == 'OrderConfirmation') {
      return deserialize<_i12.OrderConfirmation>(data['data']);
    }
    if (dataClassName == 'OrderFulfillmentMethod') {
      return deserialize<_i13.OrderFulfillmentMethod>(data['data']);
    }
    if (dataClassName == 'OrderItemRecord') {
      return deserialize<_i14.OrderItemRecord>(data['data']);
    }
    if (dataClassName == 'OrderItemInput') {
      return deserialize<_i15.OrderItemInput>(data['data']);
    }
    if (dataClassName == 'OrderPaymentMethod') {
      return deserialize<_i16.OrderPaymentMethod>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i17.OrderStatus>(data['data']);
    }
    if (dataClassName == 'ClaimResult') {
      return deserialize<_i18.ClaimResult>(data['data']);
    }
    if (dataClassName == 'ClaimTokenStatus') {
      return deserialize<_i19.ClaimTokenStatus>(data['data']);
    }
    if (dataClassName == 'OrderClaimException') {
      return deserialize<_i20.OrderClaimException>(data['data']);
    }
    if (dataClassName == 'OrderClaimExceptionReason') {
      return deserialize<_i21.OrderClaimExceptionReason>(data['data']);
    }
    if (dataClassName == 'OrderClaimTokenRecord') {
      return deserialize<_i22.OrderClaimTokenRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerEntryRecord') {
      return deserialize<_i23.PointsLedgerEntryRecord>(data['data']);
    }
    if (dataClassName == 'PointsLedgerReason') {
      return deserialize<_i24.PointsLedgerReason>(data['data']);
    }
    if (dataClassName == 'WalletTokenRecord') {
      return deserialize<_i25.WalletTokenRecord>(data['data']);
    }
    if (dataClassName == 'WalletTokenResponse') {
      return deserialize<_i26.WalletTokenResponse>(data['data']);
    }
    if (dataClassName == 'RedemptionException') {
      return deserialize<_i27.RedemptionException>(data['data']);
    }
    if (dataClassName == 'RedemptionExceptionReason') {
      return deserialize<_i28.RedemptionExceptionReason>(data['data']);
    }
    if (dataClassName == 'RedemptionRecord') {
      return deserialize<_i29.RedemptionRecord>(data['data']);
    }
    if (dataClassName == 'RedemptionResult') {
      return deserialize<_i30.RedemptionResult>(data['data']);
    }
    if (dataClassName == 'RedemptionStatus') {
      return deserialize<_i31.RedemptionStatus>(data['data']);
    }
    if (dataClassName == 'RewardItemRecord') {
      return deserialize<_i32.RewardItemRecord>(data['data']);
    }
    if (dataClassName == 'OnlineOrderPublicSettings') {
      return deserialize<_i33.OnlineOrderPublicSettings>(data['data']);
    }
    if (dataClassName == 'OnlineOrderSettingsRecord') {
      return deserialize<_i34.OnlineOrderSettingsRecord>(data['data']);
    }
    if (dataClassName == 'ShopOpenStatus') {
      return deserialize<_i35.ShopOpenStatus>(data['data']);
    }
    if (dataClassName == 'ShopStatusRecord') {
      return deserialize<_i36.ShopStatusRecord>(data['data']);
    }
    if (dataClassName == 'AppUserRecord') {
      return deserialize<_i37.AppUserRecord>(data['data']);
    }
    if (dataClassName == 'EmailRegistrationBlockedException') {
      return deserialize<_i38.EmailRegistrationBlockedException>(data['data']);
    }
    if (dataClassName == 'EmailRegistrationBlockedExceptionReason') {
      return deserialize<_i39.EmailRegistrationBlockedExceptionReason>(
        data['data'],
      );
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i47.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i48.Protocol().deserializeByClassName(data);
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
      return _i47.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i48.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
