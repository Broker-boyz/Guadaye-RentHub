import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gojo_renthub/services/email/signup.dart';
import 'package:gojo_renthub/services/google/google_auth.dart';
import 'package:gojo_renthub/views/shared/fonts/metalmania.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:gojo_renthub/views/shared/snackbars/snackbar.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  final void Function()? onPressed;
  const SignupPage({super.key, this.onPressed});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscuredPassword = true;
  bool _isObscuredConfirm = true;

  final List<String> _accountType = ['Tenant', 'Landlord'];
  String _firstValue = '';

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:"<>?]).{8,}$');
    final isPasswordValid = passwordRegex.hasMatch(password ?? '');
    if (!isPasswordValid) {
      return 'Password must contain at least one capital letter, one number, and one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  Text(
                    "Sign up",
                    style: textStylePrata(
                        30,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create your account",
                    style: textStylePrata(
                        17,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1.5),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          hintText: "Full Name",
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
                          prefixIcon: Icon(Icons.person,
                              color: Theme.of(context).colorScheme.error),
                          errorMaxLines: 2,
                          errorStyle: textStylePrata(
                              10,
                              Theme.of(context).colorScheme.error,
                              FontWeight.bold,
                              1)),
                      validator: (username) => username!.length < 2
                          ? 'Username should be at least two characters'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        errorStyle: textStylePrata(
                            10,
                            Theme.of(context).colorScheme.error,
                            FontWeight.bold,
                            1),
                      ),
                      validator: validateEmail,
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
                          if(value != null){
                            _firstValue = value;
                          }
                        });
                      },
                      valueTransformer: (value) => value.toString(),
                      validator: (value) => value == null
                          ? 'Please select your Account type'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
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
                        prefixIcon: Icon(Icons.password,
                            color: Theme.of(context).colorScheme.error),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscuredPassword = !_isObscuredPassword;
                            });
                          },
                          icon: _isObscuredPassword
                              ? Icon(Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.error)
                              : Icon(Icons.visibility,
                                  color: Theme.of(context).colorScheme.error),
                        ),
                        errorMaxLines: 2,
                        errorStyle: textStylePrata(
                            10,
                            Theme.of(context).colorScheme.error,
                            FontWeight.bold,
                            1),
                      ),
                      obscureText: _isObscuredPassword,
                      validator: validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                          prefixIcon: Icon(Icons.password,
                              color: Theme.of(context).colorScheme.error),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscuredConfirm = !_isObscuredConfirm;
                              });
                            },
                            icon: _isObscuredConfirm
                                ? Icon(Icons.visibility_off,
                                    color: Theme.of(context).colorScheme.error)
                                : Icon(Icons.visibility,
                                    color: Theme.of(context).colorScheme.error),
                          ),
                          errorMaxLines: 2,
                          errorStyle: textStylePrata(
                              10,
                              Theme.of(context).colorScheme.error,
                              FontWeight.bold,
                              1)),
                      obscureText: _isObscuredConfirm,
                      validator: validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await EmailPasswordSignup.signUpUser(
                        context,
                        _emailController,
                        _passwordController,
                        _confirmPasswordController,
                        _usernameController,
                        _firstValue);
                  } else {
                    // _formKey.currentState!.reset();
                    // _emailController.clear();
                    // _passwordController.clear();
                    // _confirmPasswordController.clear();
                    // _usernameController.clear();
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

                    //     // Colors.red.shade500
                    //   ],
                    // ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: textStyleOrbitron(
                          20,
                          Theme.of(context).colorScheme.secondary,
                          FontWeight.bold,
                          1),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Or",
                  style: textStylePrata(
                      15,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.normal,
                      1.2),
                ),
              ),
              GestureDetector(
                onTap: () {
                  GoogleAuth().signInWithGoogle(context);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/google.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Text(
                        "Sign Up with Google",
                        style: textStylePrata(
                            14,
                            Theme.of(context).colorScheme.inversePrimary,
                            FontWeight.bold,
                            1.4),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: textStylePrata(
                        15,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.normal,
                        1.6),
                  ),
                  TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        "Login",
                        style: textStylePrata(
                            17, Colors.blue, FontWeight.bold, 1.6),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
