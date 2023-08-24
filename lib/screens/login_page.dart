import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); //pop dialog
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    if (message == 'channel-error') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid or not registered'),
        ),
      );
    } else if (message == 'wrong-password') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Password'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text('Welcome TIETians',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    )),
                const SizedBox(height: 25),
                MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 10),
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                ),
                const SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Not a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      )),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}