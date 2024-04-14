import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final MyPropertyRepo _repo = MyPropertyRepo();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? imageUrl = '';
  String _firstValue = '';
  File? _image;
  final List<String> _genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    User? user = _repo.getCurrentUser();
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
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _image == null
                        ? const AssetImage('assets/images/avatar.png')
                            as ImageProvider<Object>?
                        : FileImage(_image!),
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
                          setState(() {
                            _image = File(file.path);
                          });
                          // _image = File(file.path);
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
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Username',
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
                          ? 'Username should be at least two characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          label: Text(
                            'Address',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                          prefixIcon: Icon(Icons.location_on_outlined,
                              color: Theme.of(context).colorScheme.error),
                          errorMaxLines: 2,
                          errorStyle: textStylePrata(
                              10,
                              Theme.of(context).colorScheme.error,
                              FontWeight.bold,
                              1),
                        ),
                        validator: (username) => username!.length < 2
                            ? "address should be at least two characters"
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneNumberController,
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
                    const SizedBox(height: 20),
                    FormBuilderDropdown<String>(
                      name: 'Gender',
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        hintStyle: textStyleMetalMania(
                            16,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.normal,
                            1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                      ),
                      items: _genderOptions
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _firstValue = value;
                          }
                        });
                      },
                      valueTransformer: (value) => value.toString(),
                      validator: (value) =>
                          value == null ? 'Please select your Gender' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<UserProvider>(context, listen: false)
                              .updateProfile(
                                  user!.uid,
                                  _usernameController.text,
                                  _firstValue,
                                  _addressController.text,
                                  _phoneNumberController.text,
                                  imageUrl!,
                                  context,);

                          _usernameController.clear();
                          _addressController.clear();
                          _phoneNumberController.clear();
                          _formKey.currentState!.reset();
                        } else {
                          _formKey.currentState!.reset();
                          CustomSnackBar().showSnackBar(
                              context,
                              'Wrong Credentials',
                              'Please enter valid credentials');
                        }
                      },
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Update Profile',
                            style: textStyleOrbitron(
                                14,
                                Theme.of(context).colorScheme.primary,
                                FontWeight.bold,
                                1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
