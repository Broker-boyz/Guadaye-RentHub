import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Myproperty/screens/bado_screen.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/homepage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/login_or_register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final MyPropertyRepo _repo = MyPropertyRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return FutureBuilder<String>(
              future: _repo.getUserRole(user: user), 
              builder: (context, accountTypeSnapshot) {
                if(accountTypeSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(accountTypeSnapshot.hasData) {
                  final _accountType = accountTypeSnapshot.data!;
                  if(_accountType == 'Tenant'){
                    return const HomePage();
                  }else {
                    print(_accountType);
                    return HomePage();
                  }
                }else {
                  return Center(
                    child: Text('Error has occured: ${accountTypeSnapshot.error}'),
                  );
                }
              },);
            // return HomePage();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
