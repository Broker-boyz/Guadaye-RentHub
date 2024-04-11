import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _userName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage(
                      'assets/icons/user.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent,
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [
                        //     Colors.indigo.shade300,
                        //     Colors.blue.shade300,
                        //     Colors.blue.shade100,
                        //   ],
                        // ),
                      ),
                      child: IconButton(
                        color: Colors.black,
                        iconSize: 20,
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          print(file?.path);
                          if (file == null) return;
                          String uniqueFileName =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');
                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            SettableMetadata metadata =
                                SettableMetadata(contentType: 'image/jpeg');
                            await referenceImageToUpload.putFile(
                                File(file.path), metadata);
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            print('imageUrl: $imageUrl');
                          } catch (error) {}
                        },
                        icon: Icon(
                          LineAwesomeIcons.camera,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstName,
                      decoration: InputDecoration(
                        label: Text(
                          'First Name',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        prefixIcon: Icon(
                          LineAwesomeIcons.user,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        errorMaxLines: 2,
                        errorStyle: textStylePrata(
                            10,
                            Theme.of(context).colorScheme.error,
                            FontWeight.bold,
                            1),
                      ),
                      validator: (firstName) => firstName!.length < 2
                          ? 'First name should be at least two characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _lastName,
                      decoration: InputDecoration(
                        label: Text(
                          'Last Name',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        prefixIcon: Icon(LineAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.error),
                        errorMaxLines: 2,
                        errorStyle: textStylePrata(
                            10,
                            Theme.of(context).colorScheme.error,
                            FontWeight.bold,
                            1),
                      ),
                      validator: (lastName) => lastName!.length < 2
                          ? 'Last name should be at least two characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                        controller: _userName,
                        decoration: InputDecoration(
                          label: Text(
                            'Username',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.user_1,
                              color: Theme.of(context).colorScheme.error),
                          errorMaxLines: 2,
                          errorStyle: textStylePrata(
                              10,
                              Theme.of(context).colorScheme.error,
                              FontWeight.bold,
                              1),
                        ),
                        validator: (username) => username!.length < 2
                            ? "Username should be at least two characters"
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _phoneNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text(
                          'Phone Number',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        prefixIcon: Icon(Icons.phone,
                            color: Theme.of(context).colorScheme.error),
                        errorMaxLines: 2,
                        errorStyle: textStylePrata(
                            10,
                            Theme.of(context).colorScheme.error,
                            FontWeight.bold,
                            1),
                      ),
                      validator: (phoneNumber) => phoneNumber!.length != 10
                          ? 'Please enter a valid phone number'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 80),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<UserProvider>(context, listen: false)
                              .updateUserInfo(
                                  userId,
                                  _userName.text,
                                  _firstName.text,
                                  _lastName.text,
                                  _phoneNumber.text,
                                  imageUrl!,
                                  context);

                          _userName.clear();
                          _firstName.clear();
                          _lastName.clear();
                          _phoneNumber.clear();
                          _userName.clear();
                          _formKey.currentState!.reset();
                        } else {
                          _formKey.currentState!.reset();
                          _userName.clear();
                          _firstName.clear();
                          _lastName.clear();
                          _phoneNumber.clear();
                          _userName.clear();
                          CustomSnackBar().showSnackBar(
                              context,
                              'Wrong Credentials',
                              'Please enter valid credentials');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              // offset: const Offset(0, 5),
                              // spreadRadius: 6,
                              // blurRadius: 12,
                              color: Colors.blueAccent,
                            )
                          ],
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Colors.indigo.shade300,
                          //     Colors.blue.shade300,
                          //     Colors.blue.shade100,
                          //   ],
                          // ),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: textStyleOrbitron(
                                14,
                                Theme.of(context).colorScheme.primary,
                                FontWeight.bold,
                                1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
