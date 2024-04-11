import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/homepage.dart';
import 'package:gojo_renthub/views/screens/login_and_register_pages/login_or_register_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return FutureBuilder<String>(
              future: _repo.getUserRole(user: user), 
              builder: (context, accountTypeSnapshot) {
                if(accountTypeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        size: 50),
                  );
                }else if(accountTypeSnapshot.hasData) {
                  final _accountType = accountTypeSnapshot.data!;
                  if(_accountType == 'Tenant'){
                    return const HomePage(accountType: 'Tenant',);
                  }else {
                    print(_accountType);
                    return const HomePage(accountType: 'Landlord',);
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
