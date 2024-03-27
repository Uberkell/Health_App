import 'package:flutter/material.dart';
import '../notifications/notification.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required String title}) : super(key: key);

  @override
  AdminPageState createState() => AdminPageState();
} 

class AdminPageState extends State<AdminPage> {
  final TextEditingController _tipController = TextEditingController();
  final NotificationService _notificationService = NotificationService();

  final List<String> _tips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Healthy Eating Tips:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _tipController,
              decoration: const InputDecoration(
                hintText: 'Enter a healthy eating tip',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addTip();
              },
              child: const Text('Add Tip'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tips List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tips.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tips[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendMassNotification();
              },
              child: const Text('Send Mass Notification'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTip() {
    if (_tipController.text.isNotEmpty) {
      setState(() {
        _tips.add(_tipController.text);
        _tipController.clear();
      });
    }
  }

  void _sendMassNotification() {
    if (_tips.isNotEmpty) {
      _notificationService.sendMassNotificationWithTips(_tips);
      _showSnackBar('Mass notification sent successfully!');
    } else {
      _showSnackBar('Please add at least one tip before sending notifications.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
