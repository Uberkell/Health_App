import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TipPage extends StatefulWidget{
  @override
  _TipPageState createState() => _TipPageState();
}

class _TipPageState extends State<TipPage>{
  File? image;

  Future useCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      print("bello");
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


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
                SizedBox(width: 90,),
                Text(
                  'Photos',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {

                  useCamera();

                },
                iconSize: 30,
              )
            ],
        ),
        body: Column(
          children: [
            image != null ? Image.file(image!) : SizedBox(),
          ],
        )

    );
  }
}