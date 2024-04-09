import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static bool? _isRecurringNotificationsEnabled;

  // Getter for isRecurringNotificationsEnabled
  static bool? get isRecurringNotificationsEnabled => _isRecurringNotificationsEnabled;

  // Setter for isRecurringNotificationsEnabled
  static set isRecurringNotificationsEnabled(bool? value) {
    _isRecurringNotificationsEnabled = value;
    _saveIsRecurringNotificationsEnabled(value);
  }

  static Future<void> _saveIsRecurringNotificationsEnabled(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRecurringNotificationsEnabled', value ?? false);
  }

  static Future<void> _loadIsRecurringNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRecurringNotificationsEnabled = prefs.getBool('isRecurringNotificationsEnabled');
  }


  Future<void> initNotification() async {
    await _loadIsRecurringNotificationsEnabled();

    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('banana');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, notificationDetails());
  }

  Future<void> scheduleRecurringNotification(bool isEnabled) async {
    if (isEnabled) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('repeating_channel_id',
          'Repeating channel name');

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await notificationsPlugin.periodicallyShow(
          1,
          'Recurring Title',
          'This is a recurring notification',
          RepeatInterval.everyMinute,
          platformChannelSpecifics);
    } else {
      await cancelRecurringNotification();
    }
  }

  Future<void> cancelRecurringNotification() async {
    await notificationsPlugin.cancel(1); // Change the ID if needed
  }

  Future<void> sendMassNotificationWithTips(List<String> tips) async {
    for (int i = 0; i < tips.length; i++) {
      await showNotification(
        title: 'Healthy Eating Tip',
        body: tips[i],
      );
    }
  }

  Future<void> scheduleWaterDrinkingReminder() async {
    const int waterReminderId = 0;
    const String waterReminderTitle = 'Drink Water';
    const String waterReminderBody = 'It\'s time to drink water! Stay hydrated.';

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'Water Reminder',
      'Reminds users to drink water regularly',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('reminder_sound'),
      enableLights: true,
      color: Color.fromARGB(255, 0, 153, 204),
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule a notification to remind users to drink water every hour
    await notificationsPlugin.periodicallyShow(
      waterReminderId,
      waterReminderTitle,
      waterReminderBody,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
    );
  }
}
