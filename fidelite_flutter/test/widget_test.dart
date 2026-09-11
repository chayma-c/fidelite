import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fidelite/features/auth/presentation/pages/login_page.dart';

void main() {
  testWidgets('LoginPage shows a sign-in call to action', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Fidélité'), findsOneWidget);
  });
}
