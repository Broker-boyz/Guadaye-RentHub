import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/confirm_email_verification_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/phone_auth_screen.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String accountType;
  const VerifyEmailScreen({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mail,
              size: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Verify your email',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'We would like to send email verification link on your email to verify your email address. Would you like to receive verification link on your email ?',
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
                Provider.of<UserProvider>(context, listen: false)
                    .sendVerificationEmail(context, accountType);
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
                    'Send Verification link',
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
            if(accountType == 'Tenant') GestureDetector(
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
