import 'package:flutter/material.dart';
import '../notifications/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isRecurringNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadIsRecurringNotificationsEnabled();
  }

  Future<void> _loadIsRecurringNotificationsEnabled() async {
    setState(() {
      isRecurringNotificationsEnabled = NotificationService.isRecurringNotificationsEnabled ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications,
                size: 100,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Manage Notifications',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Recurring Notifications: ${isRecurringNotificationsEnabled ? 'Enabled' : 'Disabled'}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          SwitchButton(
            buttonText: "Enable/Disable Recurring Notifications",
            onTap: () {
              setState(() {
                isRecurringNotificationsEnabled = !isRecurringNotificationsEnabled;
                if (isRecurringNotificationsEnabled) {
                  NotificationService().scheduleRecurringNotification(true);
                } else {
                  NotificationService.cancelRecurringNotification();
                }
                NotificationService.isRecurringNotificationsEnabled = isRecurringNotificationsEnabled;
              });
            },
          ),
          const SizedBox(height: 20),
          SwitchButton(
            buttonText: "Activate Water Drinking Reminder",
            onTap: () {
              NotificationService().scheduleWaterDrinkingReminder();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              NotificationService().showNotification(
                title: 'Test Notification',
                body: 'This is a one-time test notification.',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Send Test Notification',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const SwitchButton({
    required this.buttonText,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
