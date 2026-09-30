import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fidelite/core/serverpod/serverpod_client_provider.dart';
import 'package:fidelite/features/auth/presentation/pages/auth_page.dart';

void main() {
  testWidgets('AuthPage shows a sign-in call to action', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        // AppConfig.serverpodBaseUrl is only set via --dart-define at run
        // time, so it's empty here -- Client() requires a well-formed host
        // even though this test never actually calls the network.
        overrides: [
          serverpodClientProvider.overrideWithValue(
            Client('http://localhost:8083/'),
          ),
        ],
        child: const MaterialApp(home: AuthPage()),
      ),
    );

    expect(find.text('Sign in'), findsWidgets);
    expect(find.byType(Image), findsOneWidget);
  });
}
