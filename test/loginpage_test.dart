import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/squaretile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/login/login.dart';

void main() {
  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(
        onTap: () {},
      ),
    ));
    // lock display test
    expect(find.byIcon(Icons.lock), findsOneWidget);

    // welcome text test
    expect(find.text('Welcome back you\'ve been missed!'), findsOneWidget);

    // test for the email and password widgets
    expect(find.byType(MyTextField), findsNWidgets(2));

    // test for the forgot password text
    expect(find.text('Forgot Password?'), findsOneWidget);

    // test sign-in button display
    expect(find.byType(MyButton), findsOneWidget);

    // continue with text test
    expect(find.text('Or continue with'), findsOneWidget);

    // test google and apple widgets
    expect(find.byType(SquareTile), findsNWidgets(2));

    // test new members
    expect(find.text('Not a member?'), findsOneWidget);

    // new registration nav/widget
    expect(find.text('Register now'), findsOneWidget);
    await tester.tap(find.text('Register now'));
    await tester.pump();
  });
}
