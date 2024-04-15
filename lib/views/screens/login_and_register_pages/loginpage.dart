import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/routes/routes.dart';
import 'package:gojo_renthub/services/email/signin.dart';
import 'package:gojo_renthub/services/google/google_auth.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 50),
              _header(context),
              const SizedBox(height: 80),
              _inputField(context),
              const SizedBox(height: 70),
              _forgotPassword(context),
              const SizedBox(height: 80),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: textStylePrata(
              40,
              Theme.of(context).colorScheme.inversePrimary,
              FontWeight.bold,
              1.2),
        ),
        const SizedBox(height: 10),
        Text(
          "Enter your credentials to login",
          style: textStylePrata(
              18,
              Theme.of(context).colorScheme.inversePrimary,
              FontWeight.normal,
              1.3),
        ),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _formKey,
      child: Builder(
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
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
                // validator: validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
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
                  prefixIcon: Icon(
                    Icons.password,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: _isObscured
                        ? Icon(Icons.visibility_off,
                            color: Theme.of(context).colorScheme.error)
                        : Icon(Icons.visibility,
                            color: Theme.of(context).colorScheme.error),
                  ),
                ),
                obscureText: _isObscured,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await EmailPasswordSignin.signInUser(
                        context, _emailController, _passwordController);
                  } else {
                    _formKey.currentState!.reset();
                    _emailController.clear();
                    _passwordController.clear();
                    CustomSnackBar().showSnackBar(context, 'Wrong Credentials',
                        'Please enter valid credentials');
                  }
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
                      'Login',
                      style: textStyleOrbitron(
                          20,
                          Theme.of(context).colorScheme.secondary,
                          FontWeight.bold,
                          1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  'Or continue with',
                  style: textStylePrata(
                      12,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.normal,
                      1.1),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  GoogleAuth().signInWithGoogle(context);
                },
                child: Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 60,
                    // width: 10,
                    child: Image.asset('assets/icons/google.png'),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Get.toNamed(RouteClass.forgottenPasswordPage);
      },
      child: Text(
        "Forgot password?",
        style: textStylePrata(15, Colors.blue, FontWeight.bold, 1.4),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: textStylePrata(
              17,
              Theme.of(context).colorScheme.inversePrimary,
              FontWeight.normal,
              1.4),
        ),
        TextButton(
          onPressed: widget.onPressed,
          child: Text(
            "Sign Up",
            style: textStylePrata(17, Colors.blue, FontWeight.bold, 1.4),
          ),
        )
      ],
    );
  }
}
