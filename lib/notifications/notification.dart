import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static bool? _isRecurringNotificationsEnabled;
  static bool? _isWaterReminderEnabled; // Added

  // Getter
  static bool? get isRecurringNotificationsEnabled =>
      _isRecurringNotificationsEnabled;

  static bool? get isWaterReminderEnabled => _isWaterReminderEnabled;


  // Setter
  static set isRecurringNotificationsEnabled(bool? value) {
    _isRecurringNotificationsEnabled = value;
    _saveIsRecurringNotificationsEnabled(value);
  }

  static set isWaterReminderEnabled(bool? value) {
    _isWaterReminderEnabled = value;
    _saveIsWaterReminderEnabled(value);
  }

  static Future<void> _saveIsRecurringNotificationsEnabled(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRecurringNotificationsEnabled', value ?? false);
  }

  static Future<void> _saveIsWaterReminderEnabled(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isWaterReminderEnabled', value ?? false);
  }

  static Future<void> _loadIsRecurringNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRecurringNotificationsEnabled =
        prefs.getBool('isRecurringNotificationsEnabled');
  }

  static Future<void> _loadIsWaterReminderEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isWaterReminderEnabled = prefs.getBool('isWaterReminderEnabled');
  }

  Future<void> initNotification() async {
    await _loadIsRecurringNotificationsEnabled();
    await _loadIsWaterReminderEnabled();

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

  static List<String> healthyEatingTips = [
    "Remember to include a variety of colorful fruits and vegetables in your meals.",
    "Opt for whole grains like brown rice, quinoa, and oats instead of refined grains.",
    "Limit processed foods and choose fresh, whole foods whenever possible.",
    "Incorporate lean proteins such as fish, chicken, beans, and tofu into your diet.",
    "Practice mindful eating by paying attention to your hunger and fullness cues.",
    "Read food labels and ingredients lists to make informed choices about what you eat.",
    "Cook meals at home using healthy cooking methods like baking, grilling, and steaming.",
    "Plan your meals and snacks ahead of time to avoid impulsive eating.",
    "Listen to your body and eat when you're hungry, stop when you're full."
  ];

  static String _getRandomTip() {
    final Random random = Random();
    return healthyEatingTips[random.nextInt(healthyEatingTips.length)];
  }

  Future<void> scheduleRecurringNotification(bool isEnabled) async {
    if (isEnabled) {
      const int recurringNotificationId = 1;
      const String recurringNotificationTitle = 'Healthy Eating Tip';
      final String tip = _getRandomTip();
      final String recurringNotificationBody = 'Today\'s tip: $tip';

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'Recurring Notification',
        'Delivers daily healthy eating tips',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await notificationsPlugin.periodicallyShow(
        recurringNotificationId,
        recurringNotificationTitle,
        recurringNotificationBody,
        RepeatInterval.everyMinute, // Show every minute
        platformChannelSpecifics,
      );

      // Set the recurring notification as enabled after it's successfully scheduled
      isRecurringNotificationsEnabled = true;
    } else {
      await cancelRecurringNotification();
    }

    // Save the state of the recurring notification in shared preferences
    _saveIsRecurringNotificationsEnabled(isRecurringNotificationsEnabled);
  }


  static Future<void> cancelRecurringNotification() async {
    await notificationsPlugin.cancel(1);
  }

  Future<void> scheduleWaterDrinkingReminder(bool isEnabled) async {
    if (isEnabled) {
      const int waterReminderId = 2;
      const String waterReminderTitle = 'Drink Water';
      const String waterReminderBody = 'It\'s time to drink water! Stay hydrated.';

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'Water Reminder',
        'Reminds users to drink water regularly',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await notificationsPlugin.periodicallyShow(
        waterReminderId,
        waterReminderTitle,
        waterReminderBody,
        RepeatInterval.everyMinute, // Adjust interval as needed
        platformChannelSpecifics,
      );

      // Set the water reminder as enabled after it's successfully scheduled
      isWaterReminderEnabled = true;
    } else {
      await cancelWaterDrinkingReminder();
    }

    // Save the state of the water reminder in shared preferences
    _saveIsWaterReminderEnabled(isWaterReminderEnabled);
  }

  Future<void> cancelWaterDrinkingReminder() async {
    await notificationsPlugin.cancel(2); // Cancel the water drinking reminder
  }
}