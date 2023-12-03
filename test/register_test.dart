import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/squaretile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/login/register.dart';

void main() {
  testWidgets('Register page widgets test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: RegisterPage(
        onTap: () {}, // Provide a mock onTap function
      ),
    ));

    // Verify that the logo is displayed
    expect(find.byIcon(Icons.lock), findsOneWidget);

    // Verify that the welcome text is displayed
    expect(find.text('Welcome to our super app!'), findsOneWidget);

    // Verify that the email, password, and confirm password text fields are displayed
    expect(find.byType(MyTextField), findsNWidgets(3));

    // Verify that the "Forgot Password?" text is displayed
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Verify that the sign-up button is displayed
    expect(find.byType(MyButton), findsOneWidget);

    // Verify that the "Or continue with" text is displayed
    expect(find.text('Or continue with'), findsOneWidget);

    // Verify that the Google and Apple sign-in buttons are displayed
    expect(find.byType(SquareTile), findsNWidgets(2));

    // Verify that the "Already have an account?" text is displayed
    expect(find.text('Already have an account?'), findsOneWidget);

    // Verify that the "Login now" text is displayed
    expect(find.text('Login now'), findsOneWidget);
  });

  // Add more tests as needed
}
