import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/auth/authpage.dart';

class OtpScreen extends StatefulWidget {
  final String verificationID;
  const OtpScreen({super.key, required this.verificationID});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _submitOtp(BuildContext context) async {
    final String otp = _controller.text;
    try {
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationID, smsCode: otp);

        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
    } catch (e) {
      print(e.toString());
    }
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          const SizedBox(height: 100),
          const Text(
            'Verify OTP',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Enter your OTP',
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
              labelText: 'OTP',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _submitOtp(context),
            child: const Text('Verify'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          const SizedBox(height: 20),
        ],
      )),
    );
  }
}