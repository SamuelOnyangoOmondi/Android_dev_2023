import 'package:flutter/material.dart';
import 'package:flutter_app/login/login.dart';
import 'package:flutter_app/login/register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/login/loginorRegister.dart';

void main() {
  testWidgets('LoginOrRegisterPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginOrRegisterPage(),
    ));

    // Verify that the initial page is the LoginPage
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(RegisterPage), findsNothing);

    // Tap to toggle pages
    await tester.tap(find.byKey(Key('toggleButton')));
    await tester.pump();

    // Verify that the page has switched to the RegisterPage
    expect(find.byType(LoginPage), findsNothing);
    expect(find.byType(RegisterPage), findsOneWidget);

    // Tap to toggle pages back to LoginPage
    await tester.tap(find.byKey(Key('toggleButton')));
    await tester.pump();

    // Verify that the page has switched back to the LoginPage
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(RegisterPage), findsNothing);
  });

  // Add more tests as needed
}
