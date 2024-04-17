import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Eating Habits',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GoodEatingHabitsPage(),
    );
  }
}

class GoodEatingHabitsPage extends StatelessWidget {
  // List of YouTube video IDs and titles about healthy eating habits
  final List<Map<String, String>> videoList = [
    {
      'title': 'Clean Eating For Beginners',
      'videoId': '9h9S9kD67-Q',
    },
    {
      'title': 'What Happens When You Start Eating Healthy?',
      'videoId': '3DM3_ocFy0U',
    },
    {
      'title': '5 ways to start eating healthy',
      'videoId': 'fuPJxOyGdWo',
    },
    {
      'title': 'How to start eating healthier',
      'videoId': 'xPo0HJ9B_ho',
    },
    {
      'title': 'How to make healthy eating unbelievably easy',
      'videoId': '9Q4yUlJV31Rk',
    },
    {
      'title': 'Healthy eating for beginners: how to eat healthy in 2024! Best tips from a nutritionist',
      'videoId': 'yTNN_0j5S2Q',
    },
    {
      'title': 'HOW I HEALED MY GUT | bloating, IBS, digestion issues & how healing your gut will *GLOW* you up',
      'videoId': 'KX_SXMkUIkM',
    },
    {
      'title': 'Cheap And Healthy Meals For The Week, Done In 1 Hour',
      'videoId': 'AYXfaVD5o40',
    },
    // Add more videos as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos: Healthy Eating Habits', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/youtube_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Card List
          ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _playYoutubeVideo(context, videoList[index]['videoId']!);
                },
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      videoList[index]['title']!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    leading: Icon(Icons.play_circle_outline),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to play YouTube video
  void _playYoutubeVideo(BuildContext context, String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('YouTube Video'),
          ),
          body: Center(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  mute: false,
                  autoPlay: true,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: true,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
