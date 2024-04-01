import 'package:flutter/material.dart';

class TipPage extends StatelessWidget{

  TipPage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 40,
            ),
            title: Row(
              children: [
                SizedBox(width: 108,),
                Text(
                  'Tips',
                  style: TextStyle(fontSize: 30),
                )
              ],
            )
        ),
        body: Column(
          children: [

          ],
        )

    );
  }
}