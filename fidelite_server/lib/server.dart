import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'src/auth/keycloak_authentication_handler.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/menu/menu_seed.dart';
import 'src/rewards/rewards_seed.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Keycloak is the sole identity provider: every request's bearer token is
  // a Keycloak-issued JWT, validated against Keycloak's JWKS here rather
  // than through Serverpod's own auth module (which assumes Serverpod
  // issues its own tokens).
  pod.authenticationHandler = keycloakAuthenticationHandler;

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
  } finally {
    await seedSession.close();
  }
}
