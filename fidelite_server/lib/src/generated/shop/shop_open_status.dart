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

/// Whether the restaurant is currently taking orders -- shown to every
/// customer the moment they open the app, toggled by staff from a
/// dedicated screen (not anywhere near the order-taking flow, on purpose).
enum ShopOpenStatus implements _i1.SerializableModel {
  open,
  closed,

  /// A short pause (e.g. staff stepping away) -- distinct from closed so
  /// customers know to check back soon rather than assume the day is over.
  onBreak;

  static ShopOpenStatus fromJson(String name) {
    switch (name) {
      case 'open':
        return ShopOpenStatus.open;
      case 'closed':
        return ShopOpenStatus.closed;
      case 'onBreak':
        return ShopOpenStatus.onBreak;
      default:
        return ShopOpenStatus.open;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
