import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/HealthyEating_page.dart';
import 'package:int_to_win_it/pages/tracker_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.food_bank,
                size: 100,
              ),
              SizedBox(width: 100),
              Icon(
                Icons.emoji_food_beverage,
                size: 100,
              ),
            ],
          ),
          SizedBox(height: 40),
          Text(
            'Eat Right',
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
            ),
          ),
          SizedBox(height: 40),
          SwitchButton(
            buttonText: "Healthy Eating",
            onTap: () {
              Navigator.pushNamed(context, '/healthy_eating_page');
            },
          ),
          SizedBox(height: 50),
          SwitchButton(
            buttonText: "Tracking Journal",
            onTap: () {
              Navigator.pushNamed(context, '/tracker_home_page');
              },
          ),
          SizedBox(height: 220),
          SwitchButton(
            buttonText: "Sign Out",
            onTap:() async {
              Navigator.pushNamed(context, '/loginpage');
                await FirebaseAuth.instance.signOut();
            },
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
            style: TextStyle(
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
