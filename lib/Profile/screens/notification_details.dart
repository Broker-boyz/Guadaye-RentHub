import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/notification_model.dart';

class NotificationDetailsPage extends StatelessWidget {
  final MyNotification notification;
  const NotificationDetailsPage({
    super.key, required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Name', notification.fullName),
            _buildDetailItem('Phone Number', notification.phoneNumber),
            _buildDetailItem('Address', notification.address),
            _buildDetailItem('Email', notification.email),
            // Add more details here bro forgotten the other details
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const Divider(
          color: Colors.indigo,
          thickness: 1.5,
          height: 30,
        ),
      ],
    );
  }
}
