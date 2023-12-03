import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/squaretile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/login/login.dart';

void main() {
  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(
        onTap: () {}, // Provide a mock onTap function
      ),
    ));

    // Verify that the logo is displayed
    expect(find.byIcon(Icons.lock), findsOneWidget);

    // Verify that the welcome text is displayed
    expect(find.text('Welcome back you\'ve been missed!'), findsOneWidget);

    // Verify that the email and password text fields are displayed
    expect(find.byType(MyTextField), findsNWidgets(2));

    // Verify that the "Forgot Password?" text is displayed
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Verify that the sign-in button is displayed
    expect(find.byType(MyButton), findsOneWidget);

    // Verify that the "Or continue with" text is displayed
    expect(find.text('Or continue with'), findsOneWidget);

    // Verify that the Google and Apple sign-in buttons are displayed
    expect(find.byType(SquareTile), findsNWidgets(2));

    // Verify that the "Not a member?" text is displayed
    expect(find.text('Not a member?'), findsOneWidget);

    // Verify that the "Register now" text is displayed and tap triggers onTap
    expect(find.text('Register now'), findsOneWidget);
    await tester.tap(find.text('Register now'));
    await tester.pump();

    // Add more tests as needed
  });
}
