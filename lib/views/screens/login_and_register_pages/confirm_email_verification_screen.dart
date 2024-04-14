import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/phone_auth_screen.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:provider/provider.dart';

class ConfirmEmailScreen extends StatelessWidget {
  final String accoutType;
  const ConfirmEmailScreen({super.key, required this.accoutType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Icon(
                Icons.mark_email_read_rounded,
                size: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Verify your email address',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'We have just send email verification link on your email. Please check email and click on that link to verify your email address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'If not auto redirected after verification, click on the Continue button.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // User? user = FirebaseAuth.instance.currentUser;
                  Provider.of<UserProvider>(context, listen: false)
                      .reloadUser(context);
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
                      'Continue',
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
              GestureDetector(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .sendVerificationEmail(context, accoutType);
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
                      'Resend Email Verification',
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
              if(accoutType == 'Tenant') GestureDetector(
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
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blueAccent,
              //   ),
              //   onPressed: () async {
              //     User? user = FirebaseAuth.instance.currentUser;
              //     if (user != null) {
              //       await user.reload();
              //       user = FirebaseAuth.instance.currentUser;
              //       if (user!.emailVerified) {
              //         Navigator.pushAndRemoveUntil(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => const PhoneAuthScreen(),
              //             ),
              //             (route) => false);
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //                 'Your Email is not verified. Please verify your email and try again!'),
              //           ),
              //         );
              //         print('Email not verified');
              //       }
              //     }
              //     print(FirebaseAuth.instance.currentUser);
              //   },
              //   child: const Text('Continue'),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blueAccent,
              //   ),
              //   onPressed: () async {
              //     await FirebaseAuth.instance.currentUser!
              //         .sendEmailVerification();
              //   },
              //   child: const Text('Resend Email Verification'),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const AuthPage(),
              //         ),
              //         (route) => false);
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.all(15),
              //     decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(15),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey,
              //         )
              //       ],
              //     ),
              //     child: Center(
              //       child: Text(
              //         'Skip for now > ',
              //         style: textStyleOrbitron(
              //             14,
              //             Theme.of(context).colorScheme.primary,
              //             FontWeight.bold,
              //             1),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
