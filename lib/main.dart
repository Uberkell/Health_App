import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/Graph_Page.dart';
import 'package:int_to_win_it/pages/HealthyRecipies_page.dart';
import 'package:int_to_win_it/pages/MealPlanner_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notifications/notification.dart';
import 'pages/login_page.dart';
import 'pages/notification_page.dart';
import 'pages/home_page.dart';
import 'pages/camera_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/HealthyEating_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/tracker_new_entry_page.dart';
import 'pages/tracker_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eat Right',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/loginpage': (context) => LoginPage(),
        '/tippage': (context) => TipPage(),
        '/signuppage': (context) => SignUpPage(),
        '/healthy_eating_page': (context) => HealthyEatingPage(),
        '/tracker_new_entry_page': (context) => TrackerNewEntryPage(),
        '/notificationpage': (context) => NotificationPage(),
        '/tracker_home_page': (context) => TrackerHomePage(),
        '/Graph_Page': (context) => GraphTest(),
      }
    );
  }
  
  
}


