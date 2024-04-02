import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealPlannerPage extends StatefulWidget {
  final String username;

  const MealPlannerPage({Key? key, required this.username}) : super(key: key);

  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  DateTime? _startDate;
  List<dynamic> _mealPlan = [];
  bool _isLoading = false;

  Future<void> _fetchMealPlan(DateTime startDate) async {
    setState(() {
      _isLoading = true;
    });

    // final apiKey = '4ad5d1759baa41ddaed7c96480db484f';
    final formattedDate = '${startDate.year}-${startDate.month}-${startDate.day}';
    final endpoint = 'https://api.spoonacular.com/mealplanner/${widget.username}/week/$formattedDate';
    // ?apiKey=$apiKey

    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _mealPlan = data['items'];
        });
      } else {
        print('Failed to fetch meal plan');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _mealPlan.isNotEmpty
          ? ListView.builder(
        itemCount: _mealPlan.length,
        itemBuilder: (context, index) {
          final meal = _mealPlan[index];
          return ListTile(
            title: Text(meal['title']),
            subtitle: Text(meal['image']),
            // Add more details or actions as needed
          );
        },
      )
          : Center(child: Text('No meal plan available')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025),
          );
          if (pickedDate != null) {
            setState(() {
              _startDate = pickedDate;
            });
            _fetchMealPlan(pickedDate);
          }
        },
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
