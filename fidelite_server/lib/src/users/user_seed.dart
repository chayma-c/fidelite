import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// Local dev/demo credentials -- there is no registration UI for staff
/// accounts (self-registration always yields "customer", see server.dart),
/// so a trusted staff account has to come from somewhere. Mirrors the old
/// Keycloak realm's seeded `staffdemo` user. Change/remove before a real
/// deployment.
const _staffEmail = 'staff@fidelite.local';
const _staffPassword = 'staff1234';

/// Creates one staff-scoped account if none exists yet. Safe to call on
/// every server startup -- a no-op once the account exists.
Future<void> ensureStaffUserSeeded(Session session) async {
  final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
  final existing = await emailIdp.admin.findAccount(
    session,
    email: _staffEmail,
  );
  if (existing != null) return;

  final authUser = await AuthServices.instance.authUsers.create(
    session,
    scopes: {const Scope('role:staff')},
  );

  await emailIdp.admin.createEmailAuthentication(
    session,
    authUserId: authUser.id,
    email: _staffEmail,
    password: _staffPassword,
  );

  final now = DateTime.now().toUtc();
  await AppUserRecord.db.insertRow(
    session,
    AppUserRecord(
      id: authUser.id,
      email: _staffEmail,
      username: 'staffdemo',
      roles: const ['staff'],
      createdAt: now,
      updatedAt: now,
    ),
  );

  session.log('Seeded staff account: $_staffEmail / $_staffPassword');
}
