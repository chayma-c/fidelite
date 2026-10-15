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

/// Why EmailAuthEndpoint.startRegistration refused to start a new
/// registration for the given email.
enum EmailRegistrationBlockedExceptionReason implements _i1.SerializableModel {
  /// An account with this email is already fully registered.
  alreadyRegistered,
  unknown;

  static EmailRegistrationBlockedExceptionReason fromJson(String name) {
    switch (name) {
      case 'alreadyRegistered':
        return EmailRegistrationBlockedExceptionReason.alreadyRegistered;
      case 'unknown':
        return EmailRegistrationBlockedExceptionReason.unknown;
      default:
        return EmailRegistrationBlockedExceptionReason.unknown;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
