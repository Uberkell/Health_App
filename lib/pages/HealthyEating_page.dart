import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/GoodEatingHabits_page.dart';
import 'package:int_to_win_it/pages/HealthyRecipies_page.dart';
import 'package:int_to_win_it/pages/MealPlanner_page.dart';

class HealthyEatingPage extends StatelessWidget {
  HealthyEatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/foodPhoto1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                "    Healthy Eating",
                style: TextStyle(
                  fontSize: 45,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: SwitchButton(
                  buttonText: "Food Pictures/Camera",
                  onPressed: () {
                    Navigator.pushNamed(context, '/tippage');
                  },
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SwitchButton(
                  buttonText: "Meal Planner",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MealPlannerPage(username: 'intowinit')),
                    );
                    // Navigate to the next page
                  },
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SwitchButton(
                  buttonText: "Healthy Recipes",
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HealthyRecipePage()),
                    );
                    // Navigate to the next page
                  },
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: SwitchButton(
                  buttonText: "Good Eating habits/ benefits",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoodEatingHabitsPage()),
                    );// Navigate to the next page
                  },
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
          Positioned(
            top: 50,
            left: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const SwitchButton({
    required this.buttonText,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey : Colors.white, //when you click a button, it shows that it's clicked by changing its color
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
