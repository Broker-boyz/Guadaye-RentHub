import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<void> signInWithGoogle(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // User cancelled sign-in
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      // Handle sign-in error
      // ignore: avoid_print
      print('Error signing in with Google: $error');
    } finally {
      // Dismiss the dialog after sign-in attempt
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
