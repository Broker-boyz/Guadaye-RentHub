import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/services/email/otp_screen.dart';
import 'package:gojo_renthub/services/email/verify_email_screen.dart';

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
              builder: (context) =>  OtpScreen(verificationID: verificationID,),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            onPressed: () {
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyEmailScreen(),
                              ),
                            );
            },
            child: Text('Cancel'),
          ),
          const SizedBox(height: 20),
        ],
      )),
    );
  }
}
