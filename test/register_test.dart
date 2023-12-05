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
        onTap: () {},
      ),
    ));

    expect(find.byIcon(Icons.lock), findsOneWidget);

    expect(find.text('Welcome to our super app!'), findsOneWidget);

    expect(find.byType(MyTextField), findsNWidgets(3));

    expect(find.text('Forgot Password?'), findsOneWidget);

    expect(find.byType(MyButton), findsOneWidget);

    expect(find.text('Or continue with'), findsOneWidget);

    expect(find.byType(SquareTile), findsNWidgets(2));

    expect(find.text('Already have an account?'), findsOneWidget);

    expect(find.text('Login now'), findsOneWidget);
  });
}
