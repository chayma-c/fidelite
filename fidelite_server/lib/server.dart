import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/menu/menu_seed.dart';
import 'src/rewards/rewards_seed.dart';
import 'src/users/resend_email_sender.dart';
import 'src/users/user_seed.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

const _emailSender = ResendEmailSender();

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Self-hosted auth (no external identity provider): AuthUser/session/JWT
  // issuance and Argon2 password hashing come from serverpod_auth_core;
  // registration/login/password-reset come from serverpod_auth_idp's email
  // provider. AuthUser.scopeNames -> AuthenticationInfo.scopes is a drop-in
  // for the old Keycloak-role -> Scope('role:...') mapping, so every
  // endpoint's `requiredScopes` needed no changes.
  pod.initializeAuthServices(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        // Sent via Resend (see resend_email_sender.dart) -- mail.
        // sansalearning.com is verified (SPF + DKIM), so this delivers for
        // real to any recipient. Deliberately no try/catch here: a send
        // failure must fail the registration/reset call itself, not get
        // swallowed into a server-console log a real customer has no way
        // to see -- that would strand them believing a code was sent when
        // nothing actually reached them.
        sendRegistrationVerificationCode:
            (
              session, {
              required email,
              required accountRequestId,
              required verificationCode,
              required transaction,
            }) =>
                _emailSender.send(
                  session,
                  to: email,
                  subject: 'Your Fidélité verification code',
                  html:
                      '<p>Your verification code is: <b>$verificationCode</b></p>',
                ),
        sendPasswordResetVerificationCode:
            (
              session, {
              required email,
              required passwordResetRequestId,
              required verificationCode,
              required transaction,
            }) =>
                _emailSender.send(
                  session,
                  to: email,
                  subject: 'Your Fidélité password reset code',
                  html:
                      '<p>Your password reset code is: <b>$verificationCode</b></p>',
                ),
        // Mirrors the app-owned profile row that used to be JIT-upserted
        // from Keycloak claims on every request -- now populated once, here,
        // at registration time.
        onAfterAccountCreated:
            (
              session, {
              required email,
              required authUserId,
              required emailAccountId,
              required transaction,
            }) async {
              final now = DateTime.now().toUtc();
              await AppUserRecord.db.insertRow(
                session,
                AppUserRecord(
                  id: authUserId,
                  email: email,
                  username: email.split('@').first,
                  roles: const ['customer'],
                  createdAt: now,
                  updatedAt: now,
                ),
                transaction: transaction,
              );
            },
      ),
    ],
    authUsersConfig: AuthUsersConfig(
      // Self-registration (always called with no explicit scopes) defaults
      // to "customer" -- mirrors the old Keycloak realm's
      // default-roles-fidelite composite. Staff accounts are always created
      // explicitly with their scope already set (see user_seed.dart), so
      // this only ever fills in the empty case.
      onBeforeAuthUserCreated: (session, scopes, blocked, {required transaction}) async {
        if (scopes.isNotEmpty) return (scopes: scopes, blocked: blocked);
        return (scopes: {const Scope('role:customer')}, blocked: blocked);
      },
    ),
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Serve all files in the web/static relative directory under /.
  // These are used by the default web page.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Start the server.
  await pod.start();

  // Idempotent: only inserts if the respective table is empty. Rewards
  // mirrors the menu, so it must run after.
  final seedSession = await pod.createSession();
  try {
    await ensureMenuSeeded(seedSession);
    await ensureRewardsSeeded(seedSession);
    await ensureStaffUserSeeded(seedSession);
  } finally {
    await seedSession.close();
  }
}
