import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompleteGoogleSignInScreen extends StatefulWidget {
  const CompleteGoogleSignInScreen({super.key,});

  @override
  State<CompleteGoogleSignInScreen> createState() =>
      _CompleteGoogleSignInScreenState();
}

class _CompleteGoogleSignInScreenState
    extends State<CompleteGoogleSignInScreen> {
  final MyPropertyRepo _repo = MyPropertyRepo();
  final _formKey = GlobalKey<FormState>();
  final List<String> _accountType = ['Tenant', 'Landlord'];
  final List<String> _genderOptions = ['Male', 'Female'];
  String _firstValue = '';
  String _firstSecond = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = _repo.getCurrentUser();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Complete Google Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'You have successfully signed in with Google.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  label: Text(
                    'Username',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  prefixIcon: Icon(
                    LineAwesomeIcons.user,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  errorMaxLines: 2,
                  errorStyle: textStylePrata(10,
                      Theme.of(context).colorScheme.error, FontWeight.bold, 1),
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
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
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
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  prefixIcon: Icon(Icons.phone,
                      color: Theme.of(context).colorScheme.error),
                  errorMaxLines: 2,
                  errorStyle: textStylePrata(10,
                      Theme.of(context).colorScheme.error, FontWeight.bold, 1),
                ),
                validator: (phoneNumber) => phoneNumber!.length != 10
                    ? 'Please enter a valid phone number'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown<String>(
                name: 'Account Type',
                decoration: InputDecoration(
                  hintText: 'Account Type',
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
                // hint: const Text('Account Type'),
                items: _accountType
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
                    value == null ? 'Please select your Account type' : null,
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
                      _firstSecond = value;
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
                        .completeGoogleSignIn(
                            user!.uid,
                            _usernameController.text,
                            _firstValue,
                            _addressController.text,
                            _phoneNumberController.text,
                            context);

                    _usernameController.clear();
                    _addressController.clear();
                    _phoneNumberController.clear();
                    _formKey.currentState!.reset();
                    // GoogleAuth().signInFinal(widget.credential);
                  } else {
                    _formKey.currentState!.reset();
                    CustomSnackBar().showSnackBar(context, 'Wrong Credentials',
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
                      'Done',
                      style: textStyleOrbitron(
                          14,
                          Theme.of(context).colorScheme.primary,
                          FontWeight.bold,
                          1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
