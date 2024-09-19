import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    "You have a new message.",
    "Your child registration is successful.",
    "Reminder: Complete the survey.",
    "System update available.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          'No notifications',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(
                Icons.notification_important,
                color: Colors.blueAccent,
              ),
              title: Text(
                notifications[index],
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
