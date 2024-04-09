import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmailPasswordSignin {
  static Future<void> signInUser(
    BuildContext context,
    TextEditingController email,
    TextEditingController password,
  ) async {
    // shows a loading screen until logging in successfully
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.dotsTriangle(
              color: Theme.of(context).colorScheme.inversePrimary, size: 50),
        );
      },
    );
    // the logic to sign in with email and password
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // removes the loading screen if logging in is successful
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      print('Sign-in successful for email: $email');
    } on FirebaseAuthException catch (e) {
      // removes the loading screen to show the alert
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      print('Error signing in: ${e.message}');
      // ignore: use_build_context_synchronously
      wrongCredentialMessage(context);
    }
    // empties the textfields
    email.clear();
    password.clear();
  }

  static Future<void> wrongCredentialMessage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect email or password'),
          );
        });
  }
}
