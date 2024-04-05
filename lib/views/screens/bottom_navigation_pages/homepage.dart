import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/controllers/theme_provider/theme_provider.dart';
import 'package:gojo_renthub/services/email/signout.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async => EmailPasswordSignout.signUserOut(),
              icon: Icon(
                Icons.dark_mode_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(Icons.dark_mode,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ],
        ),
        body: Center(
          child: Text(
            'Signed as ${user.email}',
            style: const TextStyle(fontSize: 24),
          ),
        ));
  }
}
