import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class HealthyRecipePage extends StatefulWidget {
  const HealthyRecipePage({Key? key}) : super(key: key);

  @override
  _HealthyRecipePageState createState() => _HealthyRecipePageState();
}

class _HealthyRecipePageState extends State<HealthyRecipePage> {
  final TextEditingController _ingredientController = TextEditingController();
  List<Map<String, dynamic>> _savedRecipes = []; //saved recipe list
  List<Map<String, dynamic>> _recipes = [];
  bool _isLoading = false;

  // Function to handle recipe search
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
          _recipes = List<Map<String, dynamic>>.from(data['results']);
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

  // Function to fetch recipe URL and name
  Future<void> _fetchRecipeDetails(int foodID) async {
    setState(() {
      _isLoading = true;
    });

    const apiKey = '4ad5d1759baa41ddaed7c96480db484f';
    final endpoint2 = 'https://api.spoonacular.com/recipes/$foodID/information?apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(endpoint2));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // Add the selected recipe to the saved recipes list
          _savedRecipes.add({
            'title': data['title'],
            'url': data['sourceUrl'],
          });
        });
      } else {
        print('Failed to fetch recipe details');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURLBrowser(foodURL) async {
    var url = Uri.parse(foodURL);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to remove recipe from the saved list
  void _removeSavedRecipe(int index) {
    setState(() {
      _savedRecipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _savedRecipes.clear();
              });
            },
          ),
        ],
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
                  return Card(
                    child: ListTile(
                      title: Text(recipe['title']),
                      leading: Image.network(recipe['image']),
                      onTap: () {
                        _fetchRecipeDetails(recipe['id']);
                      },
                    ),
                  );
                },
              ),
            ),
          if (_savedRecipes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _savedRecipes.length,
                itemBuilder: (context, index) {
                  final savedRecipe = _savedRecipes[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        _launchURLBrowser(savedRecipe['url']); // Replace with your desired URL
                      },
                      title: Text(savedRecipe['title']),
                      subtitle: Text(savedRecipe['url']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeSavedRecipe(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

