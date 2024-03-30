import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? userId;

class EmailPasswordSignup {
  static Future<void> signUpUser(
      BuildContext context,
      TextEditingController email,
      TextEditingController password,
      TextEditingController confirmPassword,
      TextEditingController username) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      //checks if the password and confirm password fields are the same
      if (password.text.trim() == confirmPassword.text.trim()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //the logic to create account(signing up) using email and password
          email: email.text.trim(),
          password: password.text.trim(),
        );
        userId = userCredential.user!.uid;
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: avoid_print
        print('Sign-in successful for email: $email');
      } else {
        Navigator.pop(context);
        wrongCredentialMessage(context, "'Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously, avoid_print
      print('Error: ${e.message}');
      // ignore: use_build_context_synchronously
      wrongCredentialMessage(context, 'Error: ${e.message}');
    }

    addUserDetails(username.text.trim(), email.text.trim());

    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  static Future<void> wrongCredentialMessage(
      BuildContext context, String text) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
          );
        });
  }

  static Future addUserDetails(String username, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'username': username,
      'email': email,
    });
    // print(userId);
  }
}
