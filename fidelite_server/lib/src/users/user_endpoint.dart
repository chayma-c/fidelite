import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Proves the Keycloak auth chain end-to-end during Phase 0 integration
/// testing (JWT validation -> JIT user provisioning -> role scopes). Not
/// load-bearing for the app itself, since the client already knows its own
/// roles from the decoded ID token.
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AppUserRecord> getMe(Session session) async {
    final userId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    final user = await AppUserRecord.db.findById(session, userId);
    if (user == null) {
      throw StateError('Authenticated user has no AppUserRecord.');
    }
    return user;
  }
}
