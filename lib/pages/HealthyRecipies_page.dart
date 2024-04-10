import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void initState() {
    super.initState();
    // Check if the user is logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _loadSavedRecipes(user.uid);
      }
    });
  }

  // Function to fetch data from Firestore for the current user
  Future<void> _loadSavedRecipes(String userId) async {
    List<Map<String, dynamic>> savedRecipes =
    await _getRecipesFromFirestore(userId);
    setState(() {
      _savedRecipes = savedRecipes;
    });
  }

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
    final endpoint2 =
        'https://api.spoonacular.com/recipes/$foodID/information?apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(endpoint2));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await _addRecipeToFirestore(user.uid, data['title'], data['sourceUrl']);
        }
        setState(() {
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

  // Function to remove recipe from the saved list
  void _removeSavedRecipe(int index, String id) {
    setState(() {
      _savedRecipes.removeAt(index);
    });
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _deleteRecipeFromFirestore(user.uid, id);
    }
  }

  // Add recipe to Firestore for the current user
  Future<void> _addRecipeToFirestore(String userId, String title, String url) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('recipes')
          .add({
        'title': title,
        'url': url,
      });
    } catch (e) {
      print('Error adding recipe to Firestore: $e');
    }
  }

  // Fetch recipes from Firestore for the current user
  Future<List<Map<String, dynamic>>> _getRecipesFromFirestore(String userId) async {
    List<Map<String, dynamic>> recipes = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('recipes')
          .get();
      snapshot.docs.forEach((doc) {
        recipes.add({
          'id': doc.id,
          'title': doc['title'],
          'url': doc['url'],
        });
      });
    } catch (e) {
      print('Error getting recipes from Firestore: $e');
    }
    return recipes;
  }

  // Delete recipe from Firestore for the current user
  Future<void> _deleteRecipeFromFirestore(String userId, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('recipes')
          .doc(id)
          .delete();
    } catch (e) {
      print('Error deleting recipe from Firestore: $e');
    }
  }

  // Function to launch URL in browser
  Future<void> _launchURLBrowser(foodURL) async {
    var url = Uri.parse(foodURL);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Search',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
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
                        _launchURLBrowser(savedRecipe['url']);
                      },
                      title: Text(savedRecipe['title']),
                      subtitle: Text(savedRecipe['url']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeSavedRecipe(index, savedRecipe['id']);
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
