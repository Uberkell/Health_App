import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthyRecipePage extends StatefulWidget {
  const HealthyRecipePage({Key? key}) : super(key: key);

  @override
  _HealthyRecipePageState createState() => _HealthyRecipePageState();
}

class _HealthyRecipePageState extends State<HealthyRecipePage> {
  final TextEditingController _ingredientController = TextEditingController();
  List<dynamic> _recipes = [];
  bool _isLoading = false;

  Future<void> _searchRecipes(String ingredient) async {
    setState(() {
      _isLoading = true;
    });

    const apiKey = '4ad5d1759baa41ddaed7c96480db484f';
    final endpoint =
        'https://api.spoonacular.com/recipes/complexSearch?query=$ingredient&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _recipes = data['results'];
        });
      } else {
        print('Failed to fetch recipes');
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
        title: Text('Recipe Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Enter your ingredient',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchRecipes(_ingredientController.text);
                  },
                ),
              ),
            ),
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else if (_recipes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return ListTile(
                    title: Text(recipe['title']),
                    leading: Image.network(recipe['image']),
                    onTap: () {
                      // Do something when tapped
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
