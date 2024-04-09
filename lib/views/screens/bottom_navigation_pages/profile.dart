import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/controllers/user_provider/user_provider.dart';
import 'package:gojo_renthub/routes/routes.dart';
import 'package:gojo_renthub/services/email/signout.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: Image.network(
                      '${user?.imagePath}',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.indigo.shade300,
                            Colors.blue.shade300,
                            Colors.blue.shade100,
                          ],
                        ),
                      ),
                      child: IconButton(
                        color: Colors.black,
                        iconSize: 20,
                        onPressed: () {
                          Get.toNamed(RouteClass.updateProfilePage);
                        },
                        icon: Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${user?.username}',
                style: textStylePrata(
                    18,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
              const SizedBox(height: 5),
              Text(
                '${user?.email}',
                style: textStylePrata(
                    14,
                    Theme.of(context).colorScheme.inversePrimary,
                    FontWeight.bold,
                    1),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteClass.updateProfilePage);
                },
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        spreadRadius: 6,
                        blurRadius: 12,
                        color: Colors.indigo.withOpacity(0.1),
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.indigo.shade300,
                        Colors.blue.shade300,
                        Colors.blue.shade100,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: textStyleOrbitron(
                          14,
                          Theme.of(context).colorScheme.inversePrimary,
                          FontWeight.bold,
                          1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'Settings',
                icon: LineAwesomeIcons.cog,
                onPress: () {
                  Get.toNamed(RouteClass.settingsPage);
                },
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'Billing Detail',
                icon: LineAwesomeIcons.wallet,
                onPress: () {},
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'User Management',
                icon: LineAwesomeIcons.user_check,
                onPress: () {},
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'Terms and Conditions',
                icon: LineAwesomeIcons.info,
                onPress: () {
                  Get.toNamed(RouteClass.termsAndConditionsPage);
                },
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'Log Out',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () async => EmailPasswordSignout.signUserOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon,
    required this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool? endIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Colors.blue.withOpacity(0.1),

      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.error),
      ),
      title: Text(
        title,
        style: textStylePrata(14, textColor, FontWeight.bold, 1),
      ),
      trailing: endIcon != null && endIcon!
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18.0,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
