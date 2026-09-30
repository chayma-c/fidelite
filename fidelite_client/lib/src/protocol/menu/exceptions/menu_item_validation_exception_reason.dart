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

/// Why a menu item create/update/setActive request was rejected.
enum MenuItemValidationExceptionReason implements _i1.SerializableModel {
  /// The submitted name was empty (after trimming).
  nameRequired,

  /// The submitted category was empty (after trimming).
  categoryRequired,

  /// The submitted price was zero or negative.
  invalidPrice,

  /// Another active item in the same category already has this name.
  duplicateName,

  /// No menu item exists for the given id.
  notFound,
  unknown;

  static MenuItemValidationExceptionReason fromJson(String name) {
    switch (name) {
      case 'nameRequired':
        return MenuItemValidationExceptionReason.nameRequired;
      case 'categoryRequired':
        return MenuItemValidationExceptionReason.categoryRequired;
      case 'invalidPrice':
        return MenuItemValidationExceptionReason.invalidPrice;
      case 'duplicateName':
        return MenuItemValidationExceptionReason.duplicateName;
      case 'notFound':
        return MenuItemValidationExceptionReason.notFound;
      case 'unknown':
        return MenuItemValidationExceptionReason.unknown;
      default:
        return MenuItemValidationExceptionReason.unknown;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
