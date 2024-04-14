import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/Profile/user_model/user.dart';
import 'package:gojo_renthub/Profile/user_provider/user_provider.dart';
import 'package:gojo_renthub/routes/routes.dart';
import 'package:gojo_renthub/services/email/signout.dart';
import 'package:gojo_renthub/views/shared/fonts/orbitron.dart';
import 'package:gojo_renthub/views/shared/fonts/prata.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final MyPropertyRepo _repo = MyPropertyRepo();
  MyUser? user;

  Future _info() async {
    MyUser user = await _repo.getCurrentUserInfo();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _info();
  //   user == null ? print('-----------------sth before full name and user is null -----------'):
  //   print('-----------------sth before full name and user is not null -----------');
  //   print(user!.fullName.toString());
  // }

  @override
  Widget build(BuildContext context) {
    User? _user = _repo.getCurrentUser();
    final user = context.watch<UserProvider>().user;
    print(user);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _user!.photoURL == null ? 
                    const AssetImage('assets/images/avatar.png') 
                    :Image.network(
                      '${_user.photoURL}',
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
                        color: Colors.blueAccent,
                      ),
                      child: IconButton(
                        color: Colors.black,
                        iconSize: 20,
                        onPressed: () {
                          Get.toNamed(RouteClass.updateProfilePage);
                        },
                        icon: Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_user.displayName}',
                    style: textStylePrata(
                        18,
                        Theme.of(context).colorScheme.inversePrimary,
                        FontWeight.bold,
                        1),
                  ),
                  if(_user.emailVerified) const Icon(Icons.verified_outlined,
                  color: Colors.blue,)
                ],
              ),
              const SizedBox(height: 5),
              Text(
                _user.email.toString(),
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: textStyleOrbitron(
                          14,
                          Theme.of(context).colorScheme.primary,
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
                icon: LineAwesomeIcons.money_bill,
                onPress: () {},
                textColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: 'User Management',
                icon: LineAwesomeIcons.user,
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
                icon: LineAwesomeIcons.sign,
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
