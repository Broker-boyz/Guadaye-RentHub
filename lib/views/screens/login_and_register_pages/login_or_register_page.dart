import 'package:flutter/material.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/loginpage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/registerpage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onPressed: togglePage,
      );
    } else {
      return SignupPage(
        onPressed: togglePage,
      );
    }
  }
}
