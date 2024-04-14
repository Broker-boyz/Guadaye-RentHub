import 'package:flutter/material.dart';
import 'package:gojo_renthub/otp/otp.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/homepage.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';

final _formKeyOtp = GlobalKey<FormState>();
final _formKey1 = GlobalKey<FormState>();

class OtpRegistrationPage extends StatefulWidget {
  const OtpRegistrationPage({super.key});

  @override
  State<OtpRegistrationPage> createState() => _OtpRegistrationPageState();
}

class _OtpRegistrationPageState extends State<OtpRegistrationPage> {
  final _phoneController = TextEditingController();

  final _otpController = TextEditingController();

  @override
  void dispose() {
    _formKeyOtp.currentState?.dispose();
    _formKey1.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone,
            size: 60,),
            const SizedBox(height: 20,),
            Text(
              'Verify your phone number',
              style: textStylePrata(
                  15,
                  Theme.of(context).colorScheme.inversePrimary,
                  FontWeight.bold,
                  1),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKeyOtp,
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: '+251 ',
                  hintText: 'Enter your phone number',
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
                  prefixIcon: Icon(Icons.phone,
                      color: Theme.of(context).colorScheme.error),
                  errorMaxLines: 2,
                  errorStyle: textStylePrata(10,
                      Theme.of(context).colorScheme.error, FontWeight.bold, 1),
                ),
                validator: (value) {
                  if (value!.length != 9) {
                    return 'Enter a valid phone number';
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                if (_formKeyOtp.currentState!.validate()) {
                  OtpAuth.sendOtp(
                      phone: _phoneController.text,
                      errorStep: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Error in sending OTP',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          ),
                      nextStep: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Enter 6 digit OTP'),
                                  const SizedBox(height: 12),
                                  Form(
                                    key: _formKey1,
                                    child: TextFormField(
                                      controller: _otpController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your OTP code',
                                        hintStyle: textStyleMetalMania(
                                            16,
                                            Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            FontWeight.normal,
                                            1),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            borderSide: BorderSide.none),
                                        fillColor: Colors.blue.withOpacity(0.1),
                                        filled: true,
                                        prefixIcon: Icon(Icons.phone,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                        errorMaxLines: 2,
                                        errorStyle: textStylePrata(
                                            10,
                                            Theme.of(context).colorScheme.error,
                                            FontWeight.bold,
                                            1),
                                      ),
                                      validator: (value) {
                                        if (value!.length != 6) {
                                          return 'Enter a valid OTP';
                                        } else {
                                          return null;
                                        }
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (_formKey1.currentState!.validate()) {
                                      OtpAuth.loginWithOtp(
                                              otp: _otpController.text)
                                          .then((value) {
                                        if (value == "Success") {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const AuthPage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  },
                                  child: const Text('Submit'),
                                )
                              ],
                            );
                          },
                        );
                      });
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
                    'Verify',
                    style: textStyleOrbitron(
                        20,
                        Theme.of(context).colorScheme.primary,
                        FontWeight.bold,
                        1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                    (route) => false);
              },
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Skip for now > ',
                    style: textStyleOrbitron(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
