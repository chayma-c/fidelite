import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// Exposes serverpod_auth_idp's email/password login, registration, and
/// password-reset flow to the client. All business logic lives in the
/// module (`EmailIdpBaseEndpoint`) -- this class only needs to exist so the
/// endpoint is registered and reachable, per the module's own
/// "subclass this in your own application" contract.
class EmailAuthEndpoint extends EmailIdpBaseEndpoint {
  /// Overridden to surface an already-registered email to the client
  /// instead of the module's default anti-enumeration behavior (silently
  /// returning a request id that will never receive a code -- see
  /// EmailIdp.startRegistration's own comment on this). The owner
  /// explicitly chose to accept the minor account-enumeration trade-off
  /// here in exchange for not stranding customers on a dead-end "check
  /// your email" screen.
  ///
  /// A *pending, unverified* request for the same email (someone retrying
  /// after not receiving a code) is deliberately left alone -- the module
  /// already handles that transparently by replacing the stale request
  /// with a fresh one (see EmailIdpAccountCreationUtil.startRegistration),
  /// which is the correct behavior and shouldn't be turned into an error.
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final alreadyRegistered = await EmailAccount.db.count(
      session,
      where: (t) => t.email.equals(normalizedEmail),
    );
    if (alreadyRegistered > 0) {
      throw EmailRegistrationBlockedException(
        reason: EmailRegistrationBlockedExceptionReason.alreadyRegistered,
      );
    }

    return super.startRegistration(session, email: email);
  }
}
