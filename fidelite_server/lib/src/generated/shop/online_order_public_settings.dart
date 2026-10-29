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

/// The customer-visible subset of OnlineOrderSettingsRecord -- just
/// [deliveryEnabled], deliberately excluding staff-internal fields like
/// autoPrintEnabled. Returned by the separate public
/// OnlineOrderPublicSettingsEndpoint rather than the record itself, so a
/// future staff-internal-only field added to OnlineOrderSettingsRecord
/// never accidentally becomes customer-visible by default.
abstract class OnlineOrderPublicSettings
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OnlineOrderPublicSettings._({required this.deliveryEnabled});

  factory OnlineOrderPublicSettings({required bool deliveryEnabled}) =
      _OnlineOrderPublicSettingsImpl;

  factory OnlineOrderPublicSettings.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OnlineOrderPublicSettings(
      deliveryEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['deliveryEnabled'],
      ),
    );
  }

  bool deliveryEnabled;

  /// Returns a shallow copy of this [OnlineOrderPublicSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OnlineOrderPublicSettings copyWith({bool? deliveryEnabled});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnlineOrderPublicSettings',
      'deliveryEnabled': deliveryEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnlineOrderPublicSettings',
      'deliveryEnabled': deliveryEnabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OnlineOrderPublicSettingsImpl extends OnlineOrderPublicSettings {
  _OnlineOrderPublicSettingsImpl({required bool deliveryEnabled})
    : super._(deliveryEnabled: deliveryEnabled);

  /// Returns a shallow copy of this [OnlineOrderPublicSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OnlineOrderPublicSettings copyWith({bool? deliveryEnabled}) {
    return OnlineOrderPublicSettings(
      deliveryEnabled: deliveryEnabled ?? this.deliveryEnabled,
    );
  }
}
