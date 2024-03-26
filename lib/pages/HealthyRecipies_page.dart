// import 'package:flutter/material.dart';
// import "package:url_launcher/url_launcher.dart"; // Import url_launcher package
//
// // void main() {
// //   runApp(HealthyRecipesApp());
// // }
//
// final List<Map<String, dynamic>> healthyInfo = [
//   {
//     'title': 'Grilled Salmon Salad',
//     'photo': 'assets/images/salad.jpg',
//     'description': 'This grilled salmon salad is packed with healthy fats and nutrients. It\'s perfect for a light and refreshing meal.',
//     'source': 'https://www.example.com/recipes/grilled-salmon-salad',
//     'isFavorite': false,
//   },
//   {
//     'title': 'Quinoa Stuffed Bell Peppers',
//     'photo': 'assets/images/stuffed_peppers.jpg',
//     'description': 'These quinoa stuffed bell peppers are not only delicious but also rich in protein and fiber. A perfect healthy meal!',
//     'source': 'https://www.example.com/recipes/quinoa-stuffed-bell-peppers',
//     'isFavorite': false,
//   },
//   // Add more example recipes as needed
// ];
//
// class HealthyRecipesPage extends StatefulWidget {
//   @override
//   _HealthyRecipesPageState createState() => _HealthyRecipesPageState();
// }
//
// class _HealthyRecipesPageState extends State<HealthyRecipesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Healthy Recipes'),
//       ),
//       body: ListView.builder(
//         itemCount: healthyInfo.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               elevation: 2,
//               child: ListTile(
//                 title: Text(
//                   healthyInfo[index]['title'] ?? '',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2.0),
//                 ),
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage(healthyInfo[index]['photo']),
//                 ),
//                 subtitle: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       healthyInfo[index]['description'] ?? '',
//                       style: TextStyle(fontSize: 20, letterSpacing: 1.0),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _launchURL(healthyInfo[index]['source']);
//                       },
//                       child: Text(
//                         'Source',
//                         style: TextStyle(
//                           fontSize: 15,
//                           letterSpacing: 1.0,
//                           color: Colors.blue, // Add blue color to indicate it's clickable
//                           decoration: TextDecoration.underline, // Add underline to indicate it's clickable
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.favorite_border),
//                       onPressed: () {
//                         setState(() {
//                           healthyInfo[index]['isFavorite'] = !healthyInfo[index]['isFavorite'];
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Function to launch URL
//   void _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
//
//
// // class HealthyRecipesApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Healthy Recipes',
// //       theme: ThemeData(
// //         primarySwatch: Colors.green,
// //       ),
// //       home: HealthyRecipesPage(),
// //     );
// //   }
// // }
// //
//
//
// // class HealthyRecipesPage extends StatelessWidget {
// //   // List of healthy eating habits and benefits
// //   final List<Map<String, dynamic>> healthyInfo = [
// //     {
// //       'title': 'Caprese Chicken Stuffed Peppers',
// //       'photo': 'assets/images/Recipe1.jpg',
// //       'description':
// //       'Looking to spice up taco night? Call in the roasted cauliflower. Loaded with crisp cabbage slaw and drizzled with a tangy lime crema, these richly spiced meatless tacos promise to shake up your weeknight dinner routine for good this year.',
// //       'source': 'https://www.delish.com/cooking/recipe-ideas/g3733/healthy-dinner-recipes/',
// //       'link': 'https://www.delish.com/cooking/a45715713/roasted-cauliflower-tacos-recipe/',
// //     },
// //     {
// //       'title': 'Stay Hydrated',
// //       'photo': 'assets/images/Recipe2.jpg',
// //       'description':
// //       'Drinking an adequate amount of water is essential for maintaining hydration, aiding digestion, and supporting overall bodily functions.',
// //       'source': 'Source: Mayo Clinic',
// //       'link': 'https://www.mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/basics/nutrition-basics/hlv-20049477',
// //     },
// //     {
// //       'title': 'Stay Hydrated',
// //       'photo': 'assets/images/Recipe3.jpg',
// //       'description':
// //       'Drinking an adequate amount of water is essential for maintaining hydration, aiding digestion, and supporting overall bodily functions.',
// //       'source': 'Source: Mayo Clinic',
// //       'link': 'https://www.mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/basics/nutrition-basics/hlv-20049477',
// //     },
// //     {
// //       'title': 'Stay Hydrated',
// //       'photo': 'assets/images/Recipe4.jpg',
// //       'description':
// //       'Drinking an adequate amount of water is essential for maintaining hydration, aiding digestion, and supporting overall bodily functions.',
// //       'source': 'Source: Mayo Clinic',
// //       'link': 'https://www.mayoclinic.org/healthy-lifestyle/nutrition-and-healthy-eating/basics/nutrition-basics/hlv-20049477',
// //     },
// //     // Add more example recipes as needed
// //   ];
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Healthy Recipes'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: healthyInfo.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Card(
// //               elevation: 2,
// //               child: ListTile(
// //                 title: Text(
// //                   healthyInfo[index]['title'] ?? '',
// //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2.0),
// //                 ),
// //                 leading: CircleAvatar(
// //                   backgroundImage: AssetImage(healthyInfo[index]['photo']),
// //                 ),
// //                 subtitle: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       healthyInfo[index]['description'] ?? '',
// //                       style: TextStyle(fontSize: 20, letterSpacing: 1.0),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         _launchURL(healthyInfo[index]['link']);
// //                       },
// //                       child: Text(
// //                         healthyInfo[index]['source'] ?? '',
// //                         style: TextStyle(
// //                           fontSize: 15,
// //                           letterSpacing: 1.0,
// //                           color: Colors.blue, // Add blue color to indicate it's clickable
// //                           decoration: TextDecoration.underline, // Add underline to indicate it's clickable
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   // Function to launch URL
// //   void _launchURL(String url) async {
// //     if (await canLaunch(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }
// // }

import 'package:flutter/material.dart';

void main() {
  runApp(HealthyRecipesApp());
}

class HealthyRecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Recipes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HealthyRecipesPage(),
    );
  }
}

class HealthyRecipesPage extends StatefulWidget {
  @override
  _HealthyRecipesPageState createState() => _HealthyRecipesPageState();
}

class _HealthyRecipesPageState extends State<HealthyRecipesPage> {
  List<Map<String, String>> savedRecipes = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Healthy Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Recipe Title',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: 'Website Link',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveRecipe();
              },
              child: Text('Save Recipe'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(savedRecipes[index]['title']!),
                      subtitle: Text(savedRecipes[index]['description']!),
                      onTap: () {
                        // You can navigate to a detailed view of the recipe here
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveRecipe() {
    String title = titleController.text;
    String description = descriptionController.text;
    String link = linkController.text;

    if (title.isNotEmpty && description.isNotEmpty && link.isNotEmpty) {
      setState(() {
        savedRecipes.add({
          'title': title,
          'description': description,
          'link': link,
        });
        titleController.clear();
        descriptionController.clear();
        linkController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incomplete Information'),
          content: Text('Please fill in all fields to save the recipe.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
