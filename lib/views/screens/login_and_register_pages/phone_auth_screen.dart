import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/otp_screen.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/verify_email_screen.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _submit(BuildContext context) async {
    String phoneNumber = _controller.text.trim();
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Navigator.pop(context);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationID, int? resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationID: verificationID,
              ),
            ));
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 100),
          const Text(
            'Phone Authentication',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Enter your phone number',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () => _submit(context),
            child: const Text('Submit'),
          ),
          const SizedBox(height: 20),
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
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Skip for now > ',
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
      )),
    );
  }
}
