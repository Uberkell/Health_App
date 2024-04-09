import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DietOption {
  final String name;
  final String description;

  DietOption({required this.name, required this.description});
}

class MealPlannerPage extends StatefulWidget {
  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  TextEditingController _caloriesController = TextEditingController();
  List<DietOption> _dietOptions = [
    DietOption(
        name: 'No Specific Diet',
        description:
        'For individuals who do not want to have any specific dietary restrictions or guidelines'),
    DietOption(
        name: 'Gluten Free',
        description:
        'Eliminating gluten means avoiding wheat, barley, rye, and other gluten-containing grains and foods made from them (or that may have been cross contaminated).'),
    DietOption(
        name: 'Ketogenic',
        description:
        'The keto diet is based more on the ratio of fat, protein, and carbs in the diet rather than specific ingredients. Generally speaking, high fat, protein-rich foods are acceptable and high carbohydrate foods are not. The formula we use is 55-80% fat content, 15-35% protein content, and under 10% of carbohydrates.'),
    DietOption(
        name: 'Vegetarian',
        description:
        'No ingredients may contain meat or meat by-products, such as bones or gelatin.'),
    DietOption(
        name: 'Lacto-Vegetarian',
        description:
        'All ingredients must be vegetarian and none of the ingredients can be or contain egg.'),
    DietOption(
        name: 'Ovo-Vegetarian',
        description:
        'All ingredients must be vegetarian and none of the ingredients can be or contain dairy.'),
    DietOption(
        name: 'Vegan',
        description:
        'No ingredients may contain meat or meat by-products, such as bones or gelatin, nor may they contain eggs, dairy, or honey.'),
    DietOption(
        name: 'Pescetarian',
        description:
        'Everything is allowed except meat and meat by-products - some pescetarians eat eggs and dairy, some do not.'),
    DietOption(
        name: 'Paleo',
        description:
        'Allowed ingredients include meat (especially grass fed), fish, eggs, vegetables, some oils (e.g. coconut and olive oil), and in smaller quantities, fruit, nuts, and sweet potatoes. We also allow honey and maple syrup (popular in Paleo desserts, but strict Paleo followers may disagree). Ingredients not allowed include legumes (e.g. beans and lentils), grains, dairy, refined sugar, and processed foods.'),
    DietOption(
        name: 'Primal',
        description:
        'Very similar to Paleo, except dairy is allowed - think raw and full fat milk, butter, ghee, etc.'),
    DietOption(
        name: 'Low FODMAP',
        description:
        'FODMAP stands for "fermentable oligo-, di-, mono-saccharides and polyols". Our ontology knows which foods are considered high in these types of carbohydrates (e.g. legumes, wheat, and dairy products)'),
    DietOption(
        name: 'Whole30',
        description:
        'Allowed ingredients include meat, fish/seafood, eggs, vegetables, fresh fruit, coconut oil, olive oil, small amounts of dried fruit and nuts/seeds. Ingredients not allowed include added sweeteners (natural and artificial, except small amounts of fruit juice), dairy (except clarified butter or ghee), alcohol, grains, legumes (except green beans, sugar snap peas, and snow peas), and food additives, such as carrageenan, MSG, and sulfites.'),
  ];
  String _selectedDietOption = '';
  Map<String, dynamic> _mealPlan = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter target calories per day',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Select diet option:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Column(
              children: _dietOptions.map((option) {
                return CheckboxListTile(
                  title: Text(option.name),
                  subtitle: Text(option.description),
                  value: _selectedDietOption == option.name,
                  onChanged: (value) {
                    setState(() {
                      _selectedDietOption = value! ? option.name : '';
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_caloriesController.text.isNotEmpty &&
                    _selectedDietOption.isNotEmpty) {
                  int targetCalories =
                  int.parse(_caloriesController.text);
                  _generateMealPlan(targetCalories, _selectedDietOption);
                }
              },
              child: Text('Generate Meal Plan'),
            ),
            SizedBox(height: 20.0),
            if (_mealPlan.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _mealPlan.keys.map((day) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${day.toUpperCase()}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children: _mealPlan[day]['meals'].map<Widget>((meal) {
                          Color? backgroundColor;
                          if (meal.containsKey('type')) {
                            if (meal['type'] == 'breakfast') {
                              backgroundColor = Colors.green.shade100;
                            } else if (meal['type'] == 'lunch') {
                              backgroundColor = Colors.blue.shade100;
                            } else if (meal['type'] == 'dinner') {
                              backgroundColor = Colors.orange.shade100;
                            }
                          }

                          return Card(
                            color: backgroundColor,
                            child: ListTile(
                              title: Text(meal['title']),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.grey.shade200,
                        child: Text(
                          'Calories: ${_mealPlan[day]['nutrients']['calories']}, Protein: ${_mealPlan[day]['nutrients']['protein']}, Fat: ${_mealPlan[day]['nutrients']['fat']}, Carbohydrates: ${_mealPlan[day]['nutrients']['carbohydrates']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10.0,)
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void _generateMealPlan(int targetCalories, String dietOption) async {
    final apiKey = '4ad5d1759baa41ddaed7c96480db484f';
    final url =
        'https://api.spoonacular.com/mealplanner/generate?apiKey=$apiKey&timeFrame=week&targetCalories=$targetCalories&diet=$dietOption';
    final url_no_option =
        'https://api.spoonacular.com/mealplanner/generate?apiKey=$apiKey&timeFrame=week&targetCalories=$targetCalories';
    var final_url;

    if (dietOption == 'No Specific Diet') {
      final_url = url_no_option;
    } else {
      final_url = url;
    }

    try {
      final response = await http.get(Uri.parse(final_url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _mealPlan = Map<String, dynamic>.from(data['week']);
        });
      } else {
        print('Failed to fetch meal plan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
