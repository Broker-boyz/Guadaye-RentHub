import 'package:flutter/material.dart';
import 'package:gojo_renthub/controllers/theme_provider/theme_provider.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Settings',
              style: textStylePrata(
                  18,
                  Theme.of(context).colorScheme.inversePrimary,
                  FontWeight.bold,
                  1),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const SizedBox(height: 30.0),
                Text(
                  'General Settings',
                  style: textStylePrata(
                      14,
                      Theme.of(context).colorScheme.inversePrimary,
                      FontWeight.bold,
                      1),
                ),
                const SizedBox(height: 30.0),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.language,
                        color: Colors.orange, size: 30),
                  ),
                  title: Text(
                    'Language',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  subtitle: Text(
                    'English',
                    style: textStylePrata(
                        11,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.normal,
                        1),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.orange, size: 30),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.notifications,
                        color: Colors.blue, size: 30),
                  ),
                  title: Text(
                    'Notifications',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.blue, size: 30),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.privacy_tip,
                        color: Colors.red, size: 30),
                  ),
                  title: Text(
                    'Privacy',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.red, size: 30),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.help_center,
                        color: Colors.green, size: 30),
                  ),
                  title: Text(
                    'Help Center',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.green, size: 30),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.info, color: Colors.blue, size: 30),
                  ),
                  title: Text(
                    'About Us',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Colors.blue, size: 30),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Divider(height: 20.0),
                const SizedBox(height: 50.0),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(Icons.dark_mode,
                        color: Color.fromARGB(255, 18, 54, 117), size: 30),
                  ),
                  title: Text(
                    'Dark Mode',
                    style: textStylePrata(
                        14,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (bool value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: const Color.fromARGB(255, 20, 70, 111),
                    activeTrackColor: Colors.blueAccent[100],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
