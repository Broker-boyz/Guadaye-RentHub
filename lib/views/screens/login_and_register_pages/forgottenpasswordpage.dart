// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final _formKey = GlobalKey<FormState>();

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  State<ForgottenPasswordPage> createState() => _ForgottenPasswordPageState();
}

class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 50),
            );
          });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Sent to email',
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Enter your email and we will send you a password reset link',
                  style: textStylePrata(
                      14,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
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
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Theme.of(context).colorScheme.error),
                  errorMaxLines: 2,
                  errorStyle: textStylePrata(10,
                      Theme.of(context).colorScheme.error, FontWeight.bold, 1),
                ),
                validator: validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    passwordReset();
                    _emailController.clear();
                    _formKey.currentState!.reset();
                  } else {
                    _formKey.currentState!.reset();
                    _emailController.clear();
                    CustomSnackBar().showSnackBar(context, 'Wrong Credentials',
                        'Please enter valid credentials');
                  }
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
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
                      'Reset',
                      style: textStyleOrbitron(
                          20,
                          Theme.of(context).colorScheme.secondary,
                          FontWeight.bold,
                          1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
