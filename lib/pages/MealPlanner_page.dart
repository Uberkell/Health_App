import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MealPlannerApp());
}

class MealPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Planner',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MealPlannerPage(),
    );
  }
}

class MealPlannerPage extends StatefulWidget {
  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  TextEditingController calorieController = TextEditingController();
  String errorMessage = '';
  List<Map<String, dynamic>> mealPlan = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: calorieController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter daily calorie intake',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int calorieIntake = int.tryParse(calorieController.text) ?? 0;
                if (calorieIntake > 0) {
                  _generateMealPlan(calorieIntake);
                } else {
                  setState(() {
                    errorMessage = 'Please enter a valid calorie intake.';
                    mealPlan = [];
                  });
                }
              },
              child: Text('Generate Meal Plan'),
            ),
            SizedBox(height: 20),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mealPlan.length,
                itemBuilder: (context, index) {
                  String day = mealPlan[index]['day'];
                  List<String> meals = mealPlan[index]['meals'].cast<String>();
                  String mealList = meals.join(', ');
                  return ListTile(
                    title: Text(day),
                    subtitle: Text(mealList),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateMealPlan(int calorieIntake) async {
    final String appId = 'e1f4dc2c';
    final String appKey = '2e67e3037f2c7fe4ec69564c7cf3ee2c';
    final String apiUrl = 'https://api.edamam.com/api/mealplanner/v1/';

    final Uri uri = Uri.parse('$apiUrl?timeFrame=week&targetCalories=$calorieIntake&appId=$appId&appKey=$appKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        errorMessage = '';
        mealPlan = _parseMealPlan(responseData['items']);
      });
    } else {
      setState(() {
        errorMessage = 'Failed to generate meal plan. Please try again later.';
        mealPlan = [];
      });
    }
  }

  List<Map<String, dynamic>> _parseMealPlan(List<dynamic> items) {
    List<Map<String, dynamic>> parsedMealPlan = [];
    items.forEach((item) {
      String day = item['day'];
      List<String> meals = [];
      item['meals'].forEach((meal) {
        meals.add(meal['title']);
      });
      parsedMealPlan.add({
        'day': day,
        'meals': meals,
      });
    });
    return parsedMealPlan;
  }
}
