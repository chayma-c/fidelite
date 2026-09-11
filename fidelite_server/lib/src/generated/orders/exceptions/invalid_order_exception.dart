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
import '../../orders/exceptions/invalid_order_exception_reason.dart' as _i2;

/// Thrown by OrderEndpoint.submitOrder when the requested items can't form
/// a valid order. Inspect [reason] to show a specific message instead of a
/// generic failure.
abstract class InvalidOrderException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  InvalidOrderException._({
    required this.reason,
    this.menuItemId,
  });

  factory InvalidOrderException({
    required _i2.InvalidOrderExceptionReason reason,
    int? menuItemId,
  }) = _InvalidOrderExceptionImpl;

  factory InvalidOrderException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InvalidOrderException(
      reason: _i2.InvalidOrderExceptionReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      menuItemId: jsonSerialization['menuItemId'] as int?,
    );
  }

  _i2.InvalidOrderExceptionReason reason;

  /// Set when [reason] is `menuItemUnavailable`: the offending menu item id.
  int? menuItemId;

  /// Returns a shallow copy of this [InvalidOrderException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InvalidOrderException copyWith({
    _i2.InvalidOrderExceptionReason? reason,
    int? menuItemId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvalidOrderException',
      'reason': reason.toJson(),
      if (menuItemId != null) 'menuItemId': menuItemId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvalidOrderException',
      'reason': reason.toJson(),
      if (menuItemId != null) 'menuItemId': menuItemId,
    };
  }

  @override
  String toString() {
    return 'InvalidOrderException(reason: $reason, menuItemId: $menuItemId)';
  }
}

class _Undefined {}

class _InvalidOrderExceptionImpl extends InvalidOrderException {
  _InvalidOrderExceptionImpl({
    required _i2.InvalidOrderExceptionReason reason,
    int? menuItemId,
  }) : super._(
         reason: reason,
         menuItemId: menuItemId,
       );

  /// Returns a shallow copy of this [InvalidOrderException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InvalidOrderException copyWith({
    _i2.InvalidOrderExceptionReason? reason,
    Object? menuItemId = _Undefined,
  }) {
    return InvalidOrderException(
      reason: reason ?? this.reason,
      menuItemId: menuItemId is int? ? menuItemId : this.menuItemId,
    );
  }
}
