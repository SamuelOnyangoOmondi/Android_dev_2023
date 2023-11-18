import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/squaretile.dart';
import 'package:flutter_app/data_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth_service.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final EmailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {

    // show loading circle
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // try signin
      //   Wrong email popup
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: EmailController.text,
            password: passwordController.text
        );
        //   pop the loading circle
        // Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Navigator.pop(context);
        // Wrong email error
        if (e.code == 'INVALID_LOGIN_CREDENTIALS'){
          // show error to user
          wrongEmailMessage();
        }

      //   wrong password error
        if (e.code == 'wrong-password') {
          // show error to user

          wrongPasswordMessage();
        }
      }
    // pop the circle

    // Navigator.pop(context);

    //Add authentication logic here

    //Navigate to the DataEntry Page

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => DataEntryPage(collectionName: 'details'
    //       ),
    //   ),
    // );
  }
  void wrongEmailMessage() {
    showDialog(context: context,
        builder: (context) {
          return const AlertDialog (
            title: Text('Incorrect email'),
            content: Text('The provided email is not associated with an account.'),
          );
        },
    );
  }
  void wrongPasswordMessage() {
    showDialog(context: context,
        builder: (context) {
          return const AlertDialog (
            title: Text('Incorrect password'),
            content: Text('The provided password is not associated with an account.'),
          );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(  // Wrap the Column with SingleChildScrollView
            child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: EmailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: (){
                  signUserIn();
                },
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                      onTap: () => AuthService().signinWithGoogle(),
                      imagePath: 'lib/images/google.png'
                  ),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
