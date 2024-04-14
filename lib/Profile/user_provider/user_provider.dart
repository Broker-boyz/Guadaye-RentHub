// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Profile/user_model/user.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

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

        _user = User.fromMap(userData);

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
}
