import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/login/login.dart';
import 'package:flutter_app/Homepage.dart';
import 'package:flutter_app/login/loginorRegister.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        //   user logged in
          if (snapshot.hasData) {
            return HomePage();
          }
        //   user not logged in
          else {
            return LoginOrRegisterPage();
          }
        }
      )
    );
  }
}