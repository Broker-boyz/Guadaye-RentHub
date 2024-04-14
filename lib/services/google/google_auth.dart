import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/complete_google_sign_in_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GoogleAuth {
  Future<void> signInWithGoogle(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.dotsTriangle(
              color: Theme.of(context).colorScheme.inversePrimary, size: 50),
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
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'full-name': user.displayName,
        'email': user.email,
        'image-path': user.photoURL,
        'uid': user.uid,
        'account-type': 'Tenant',
      }, SetOptions(merge: true));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteGoogleSignInScreen(),
          ),
          (route) => false);
      // Sign in with Firebase

      // await FirebaseAuth.instance.currentUser!.updatePhotoURL(user.);
    } catch (error) {
      // Handle sign-in error
      // ignore: avoid_print
      print('Error signing in with Google: $error');
      // Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    }
  }
}
