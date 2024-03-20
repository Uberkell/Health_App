import 'package:flutter/material.dart';
import '../notifications/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.title});

  final String title;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationService().showNotification(
                  title: 'Sample title',
                  body: 'It works!',
                );
              },
              child: const Text('Show Notification'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NotificationService().scheduleRecurringNotification();
              },
              child: const Text('Schedule Recurring Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
