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

import 'package:serverpod/serverpod.dart' as _i1;
import '../orders/order.dart' as _i2;
import 'package:fidelite_server/src/generated/protocol.dart' as _i3;

/// What OnlineOrderEndpoint.placeOrder hands back. No claim QR -- unlike a
/// counter order, cashback here is credited directly in the same call
/// (see OnlineOrderEndpoint), since the orderer is already a known,
/// authenticated account; there's nothing to scan or claim.
abstract class OnlineOrderConfirmation
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OnlineOrderConfirmation._({
    required this.order,
    required this.pointsEarnedMillimes,
    required this.newBalanceMillimes,
  });

  factory OnlineOrderConfirmation({
    required _i2.OrderRecord order,
    required int pointsEarnedMillimes,
    required int newBalanceMillimes,
  }) = _OnlineOrderConfirmationImpl;

  factory OnlineOrderConfirmation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OnlineOrderConfirmation(
      order: _i3.Protocol().deserialize<_i2.OrderRecord>(
        jsonSerialization['order'],
      ),
      pointsEarnedMillimes: jsonSerialization['pointsEarnedMillimes'] as int,
      newBalanceMillimes: jsonSerialization['newBalanceMillimes'] as int,
    );
  }

  _i2.OrderRecord order;

  int pointsEarnedMillimes;

  int newBalanceMillimes;

  /// Returns a shallow copy of this [OnlineOrderConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OnlineOrderConfirmation copyWith({
    _i2.OrderRecord? order,
    int? pointsEarnedMillimes,
    int? newBalanceMillimes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnlineOrderConfirmation',
      'order': order.toJson(),
      'pointsEarnedMillimes': pointsEarnedMillimes,
      'newBalanceMillimes': newBalanceMillimes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnlineOrderConfirmation',
      'order': order.toJsonForProtocol(),
      'pointsEarnedMillimes': pointsEarnedMillimes,
      'newBalanceMillimes': newBalanceMillimes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OnlineOrderConfirmationImpl extends OnlineOrderConfirmation {
  _OnlineOrderConfirmationImpl({
    required _i2.OrderRecord order,
    required int pointsEarnedMillimes,
    required int newBalanceMillimes,
  }) : super._(
         order: order,
         pointsEarnedMillimes: pointsEarnedMillimes,
         newBalanceMillimes: newBalanceMillimes,
       );

  /// Returns a shallow copy of this [OnlineOrderConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OnlineOrderConfirmation copyWith({
    _i2.OrderRecord? order,
    int? pointsEarnedMillimes,
    int? newBalanceMillimes,
  }) {
    return OnlineOrderConfirmation(
      order: order ?? this.order.copyWith(),
      pointsEarnedMillimes: pointsEarnedMillimes ?? this.pointsEarnedMillimes,
      newBalanceMillimes: newBalanceMillimes ?? this.newBalanceMillimes,
    );
  }
}
