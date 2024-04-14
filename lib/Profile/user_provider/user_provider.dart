// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_model/user.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/complete_registration_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/confirm_email_verification_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/verify_email_screen.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';

class UserProvider extends ChangeNotifier {
  MyUser? _user;

  MyUser? get user => _user;

  Future<void> loadUserInfo(String userId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
            child: Container(
              width: double.infinity,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ]);
      },
    );
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userSnapshot = await userCollection.doc(userId).get();

      if (userSnapshot.exists) {
        // Document exists, retrieve the data
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        // Now you can access the data using userData['field_name']

        _user = MyUser.fromMap(userData);
        // user
        notifyListeners();
        Navigator.pop(context);
      } else {
        print('failed');
      }
    } catch (e) {
      print('failed to load user info');
    }
  }

  Future<void> updateUserInfo(
      String userId,
      String newName,
      String firstName,
      String lastName,
      String phoneNumber,
      String imagePath,
      BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userReference = userCollection.doc(userId);

    DocumentSnapshot userSnapshot = await userReference.get();

    String updatedName = userSnapshot.get('username');

    updatedName = newName;
    await userReference.update({
      'username': updatedName,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
    });
    await loadUserInfo(userId, context);
    Navigator.pop(context);
    CustomSnackBar()
        .showSnackBar(context, 'Success!', 'Profile updated successfully!');
  }

  Future<void> completeRegistration(
      String userId,
      String username,
      String gender,
      String address,
      String phoneNumber,
      String imagePath,
      BuildContext context,
      String accountType) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userReference = userCollection.doc(userId);

    DocumentSnapshot userSnapshot = await userReference.get();

    // String updatedName = userSnapshot.get('username');

    // updatedName = username;
    await userReference.update({
      'username': username,
      'gender': gender,
      'address': address,
      'phone-number': phoneNumber,
      'image-path': imagePath,
    });
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);

    await loadUserInfo(userId, context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyEmailScreen(
                  accountType: accountType,
                )),
        (route) => false);
    CustomSnackBar()
        .showSnackBar(context, 'Success!', 'Profile updated successfully!');
  }

  Future<void> completeGoogleSignIn(
    String userId,
    String username,
    String gender,
    String address,
    String phoneNumber,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userReference = userCollection.doc(userId);

    DocumentSnapshot userSnapshot = await userReference.get();

    // String updatedName = userSnapshot.get('username');

    // updatedName = username;
    await userReference.update({
      'username': username,
      'gender': gender,
      'address': address,
      'phone-number': phoneNumber,
    });
    // await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);

    await loadUserInfo(userId, context);
    await reloadUser(context);
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const AuthPage()),
    //     (route) => false);
    // Navigator.pop(context);
    CustomSnackBar()
        .showSnackBar(context, 'Success!', 'Profile updated successfully!');
  }

  Future<void> updateProfile(
    String userId,
    String username,
    String gender,
    String address,
    String phoneNumber,
    String imagePath,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userReference = userCollection.doc(userId);

    DocumentSnapshot userSnapshot = await userReference.get();

    // String updatedName = userSnapshot.get('username');

    // updatedName = username;
    await userReference.update({
      'username': username,
      'gender': gender,
      'address': address,
      'phone-number': phoneNumber,
      'image-path': imagePath,
    });
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);

    await loadUserInfo(userId, context);
    Navigator.pop(context);
    CustomSnackBar()
        .showSnackBar(context, 'Success!', 'Profile updated successfully!');
  }

  Future<void> sendVerificationEmail(
      BuildContext context, String accountType) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmEmailScreen(
                  accoutType: accountType,
                )),
        (route) => false);
    CustomSnackBar().showSnackBar(
        context, 'Success!', 'verification email sent successfully!');
  }

  Future<void> reloadUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
            ),
          ),
        ]);
      },
    );
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      await _user.reload();
      _user = FirebaseAuth.instance.currentUser;
      if (_user!.emailVerified) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
            (route) => false);
        CustomSnackBar()
            .showSnackBar(context, 'Success!', 'Your Email is verified!');
      } else {
        CustomSnackBar().showSnackBar(context, 'Failed!',
            'Your Email is not verified. Please verify your email and try again!');
        print(_user);
      }
    }
  }

  Future<void> isEmailVerified(BuildContext context, String hostId) async {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                width: double.infinity,
              ),
            ),
          ],
        );
      },
    );
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user!.emailVerified) {
      await MyPropertyRepo().sendNotification(_user.uid, hostId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 20),
          content: Row(
            children: [
              const Expanded(
                child: Text(
                    'We\'ve just sent you contact info. Check your notification'),
              ),
              SnackBarAction(
                textColor: Colors.white,
                label: 'DISMISS',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      );
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Your account is not verified!'),
            content: const Text('Do you want to verify your account?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompleteRegistrationScreen(
                          accoutType: 'Tenant',
                        ),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ],
          );
        },
      );
      // Navigator.pop(context);
    }
  }
}
