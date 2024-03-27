import 'package:flutter/material.dart';

class TipPage extends StatelessWidget{

  TipPage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            50,
              (index) => ListTile(
                title: Text('Item ${index + 1}'),
              )
          )
        ),
      )
    );
  }
}