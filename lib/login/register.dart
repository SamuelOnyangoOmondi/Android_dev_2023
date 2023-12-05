
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/squaretile.dart';
import 'package:flutter_app/data_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth_service.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final EmailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // try creating the user
    try {
      if (passwordController.text == confirmpasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: EmailController.text,
            password: passwordController.text,
        );
      } else {
        ShowErrorMessage("passwords do not match!");
      }
  } on FirebaseAuthException catch(e){
      ShowErrorMessage(e.code);
    }
  }
  // show error message to user
  void ShowErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
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
                    size: 50,
                  ),

                  const SizedBox(height: 25),

                  // welcome back, you've been missed!
                  Text(
                    'Lets create an account for you!',
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

                  const SizedBox(height: 10,),

                  // confirm password textfield
                  MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    text: "Sign Up",
                      onTap: signUserUp,
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
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap:widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
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
