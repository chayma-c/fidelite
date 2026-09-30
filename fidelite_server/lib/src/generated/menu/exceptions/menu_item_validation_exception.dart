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
import '../../menu/exceptions/menu_item_validation_exception_reason.dart'
    as _i2;

/// Thrown by MenuManagementEndpoint when a create/update/setActive request
/// can't be applied. Inspect [reason] to show a specific message instead of
/// a generic failure.
abstract class MenuItemValidationException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  MenuItemValidationException._({required this.reason});

  factory MenuItemValidationException({
    required _i2.MenuItemValidationExceptionReason reason,
  }) = _MenuItemValidationExceptionImpl;

  factory MenuItemValidationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MenuItemValidationException(
      reason: _i2.MenuItemValidationExceptionReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
    );
  }

  _i2.MenuItemValidationExceptionReason reason;

  /// Returns a shallow copy of this [MenuItemValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItemValidationException copyWith({
    _i2.MenuItemValidationExceptionReason? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItemValidationException',
      'reason': reason.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuItemValidationException',
      'reason': reason.toJson(),
    };
  }

  @override
  String toString() {
    return 'MenuItemValidationException(reason: $reason)';
  }
}

class _MenuItemValidationExceptionImpl extends MenuItemValidationException {
  _MenuItemValidationExceptionImpl({
    required _i2.MenuItemValidationExceptionReason reason,
  }) : super._(reason: reason);

  /// Returns a shallow copy of this [MenuItemValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItemValidationException copyWith({
    _i2.MenuItemValidationExceptionReason? reason,
  }) {
    return MenuItemValidationException(reason: reason ?? this.reason);
  }
}
