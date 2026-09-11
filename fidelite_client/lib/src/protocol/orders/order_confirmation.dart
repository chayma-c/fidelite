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
import '../orders/order.dart' as _i2;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i3;

/// What OrderEndpoint.submitOrder hands back: the confirmed order plus the
/// one-time QR payload for its points claim token (the raw token itself
/// is never persisted -- this is the only time the client ever sees it).
abstract class OrderConfirmation implements _i1.SerializableModel {
  OrderConfirmation._({
    required this.order,
    required this.claimQrPayload,
  });

  factory OrderConfirmation({
    required _i2.OrderRecord order,
    required String claimQrPayload,
  }) = _OrderConfirmationImpl;

  factory OrderConfirmation.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderConfirmation(
      order: _i3.Protocol().deserialize<_i2.OrderRecord>(
        jsonSerialization['order'],
      ),
      claimQrPayload: jsonSerialization['claimQrPayload'] as String,
    );
  }

  _i2.OrderRecord order;

  String claimQrPayload;

  /// Returns a shallow copy of this [OrderConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderConfirmation copyWith({
    _i2.OrderRecord? order,
    String? claimQrPayload,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderConfirmation',
      'order': order.toJson(),
      'claimQrPayload': claimQrPayload,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OrderConfirmationImpl extends OrderConfirmation {
  _OrderConfirmationImpl({
    required _i2.OrderRecord order,
    required String claimQrPayload,
  }) : super._(
         order: order,
         claimQrPayload: claimQrPayload,
       );

  /// Returns a shallow copy of this [OrderConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderConfirmation copyWith({
    _i2.OrderRecord? order,
    String? claimQrPayload,
  }) {
    return OrderConfirmation(
      order: order ?? this.order.copyWith(),
      claimQrPayload: claimQrPayload ?? this.claimQrPayload,
    );
  }
}
