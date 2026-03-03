import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFF527DA3),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
          title: Text('Notification title $index'),
          subtitle: Text('This is the detail of notification number $index.'),
          trailing: const Text('2m ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () {},
        );
      },
    );
  }
}
