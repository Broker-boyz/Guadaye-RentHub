import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(15 + kToolbarHeight),
        child: AppBar(
          elevation: 0,
          // leading: const Icon(
          //   Icons.arrow_back,
          //   size: 30,
          // ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10),
        child: ListView(
          children: [
            const Row(
              children: [
                Text(
                  "Notifications ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "*",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            Text(
              "You have 3 Notifications Today",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 15),
            NotifyCard(),
            NotifyCard(),
            NotifyCard(),
            const SizedBox(height: 15),
            const Text(
              "This Week",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            WeekNotifications(),
            WeekNotifications(),
            WeekNotifications(),
            WeekNotifications()
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget NotifyCard() {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 8), // Adjust the horizontal margin here
    child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 16), // Adjust the horizontal padding here
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('asset/images/avatar.png'),
          ),
          const SizedBox(
              width: 12), // Adjust the width between the avatar and text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Congrats',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Description goes here...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const Spacer(), // Spacer to push the icon to the end
          IconButton(
            onPressed: () {
              // Add your onPressed functionality here
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    ),
  );
}

Widget WeekNotifications() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('asset/images/avatar.png'),
        ),
        SizedBox(width: 5), // Adjust the gap between the avatar and text
        Text(
          "Marconal Miller",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          ' started following......',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
