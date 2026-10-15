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
import '../../users/exceptions/email_registration_blocked_exception_reason.dart'
    as _i2;

/// Thrown by EmailAuthEndpoint.startRegistration instead of letting
/// serverpod_auth_idp_server's EmailIdpBaseEndpoint silently accept the
/// request and leave the customer waiting on a code that will never
/// arrive -- its default behavior deliberately hides whether an email is
/// already registered (anti-enumeration hardening), but the owner chose
/// to accept that minor trade-off here in exchange for not stranding
/// customers on a dead-end "check your email" screen. Inspect [reason]
/// to show a specific message.
abstract class EmailRegistrationBlockedException
    implements _i1.SerializableException, _i1.SerializableModel {
  EmailRegistrationBlockedException._({required this.reason});

  factory EmailRegistrationBlockedException({
    required _i2.EmailRegistrationBlockedExceptionReason reason,
  }) = _EmailRegistrationBlockedExceptionImpl;

  factory EmailRegistrationBlockedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EmailRegistrationBlockedException(
      reason: _i2.EmailRegistrationBlockedExceptionReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
    );
  }

  _i2.EmailRegistrationBlockedExceptionReason reason;

  /// Returns a shallow copy of this [EmailRegistrationBlockedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmailRegistrationBlockedException copyWith({
    _i2.EmailRegistrationBlockedExceptionReason? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailRegistrationBlockedException',
      'reason': reason.toJson(),
    };
  }

  @override
  String toString() {
    return 'EmailRegistrationBlockedException(reason: $reason)';
  }
}

class _EmailRegistrationBlockedExceptionImpl
    extends EmailRegistrationBlockedException {
  _EmailRegistrationBlockedExceptionImpl({
    required _i2.EmailRegistrationBlockedExceptionReason reason,
  }) : super._(reason: reason);

  /// Returns a shallow copy of this [EmailRegistrationBlockedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmailRegistrationBlockedException copyWith({
    _i2.EmailRegistrationBlockedExceptionReason? reason,
  }) {
    return EmailRegistrationBlockedException(reason: reason ?? this.reason);
  }
}
