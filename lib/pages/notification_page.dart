import 'package:flutter/material.dart';
import '../notifications/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isRecurringNotificationsEnabled = false; // Add this line

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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Schedule Recurring Notifications'),
                Switch(
                  value: isRecurringNotificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      isRecurringNotificationsEnabled = value;
                      if (value) {
                        NotificationService().scheduleRecurringNotification(true); // Pass true to enable recurring notifications
                      } else {
                        NotificationService().cancelRecurringNotification();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
