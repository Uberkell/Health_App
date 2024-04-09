import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TipPage extends StatefulWidget{
  @override
  _TipPageState createState() => _TipPageState();
}

class _TipPageState extends State<TipPage>{
  File? image;

  @override
  void initState() {
    super.initState();
    retrievePhotos();
  }

  void setStateWrapper(){
    setState(() {

    });
  }

  Future<List<Widget>> retrievePhotos() async {
    final userid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('photos')
        .get();
    List<Widget> photoWidgets = [];

    // Use Future.forEach to ensure proper async iteration
    await Future.forEach(querySnapshot.docs, (doc) async {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      String? url = data?['url'];

      if (url != null) {
        Reference fileRef = FirebaseStorage.instance.ref().child(url);

        String downloadURL = await fileRef.getDownloadURL();
        // Add the photo widget to the list
        photoWidgets.add(CircularImageWithBorder(
          imageUrl: downloadURL,
          storageUrl: url,
          DocId: doc.id,
          retrieve: retrievePhotos,
          setStateWrapper: setStateWrapper,
        ));
      }
    });
    print("h");


    // Return the list of photo widgets once all URLs are fetched and widgets are added
    return photoWidgets;
  }

  Future uploadImage() async{
    try {
      final storageRef = FirebaseStorage.instance;

      final filePath = 'uploads/${DateTime
          .now()
          .millisecondsSinceEpoch}';

      Reference ref = storageRef.ref(filePath);
      UploadTask uploadTask = ref.putFile(image!);
      await uploadTask;

      final userid = FirebaseAuth.instance.currentUser?.uid;

      FirebaseFirestore.instance.collection('Users').doc(userid).collection('photos').add({
        'url' : filePath,
      });
      retrievePhotos();
      setState(() {

      });
    } catch (e) {
      print('error: $e');
    }
  }

  Future useCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      uploadImage();
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
        body: FutureBuilder<List<Widget>>(
          future: retrievePhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is being fetched, show a loading indicator
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurs during data fetching, display an error message
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Once data is available, display the list of widgets
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!,
                ),
              );
            }
          },
        ),

    );
  }
}

class CircularImageWithBorder extends StatelessWidget {
  final String imageUrl;
  final String storageUrl;
  final String DocId;
  final Future<List<Widget>> Function() retrieve;
  final void Function() setStateWrapper;

  CircularImageWithBorder({
    required this.imageUrl,
    required this.storageUrl,
    required this.DocId,
    required this.retrieve,
    required this.setStateWrapper,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          top: BorderSide(width: 1, color: Colors.grey),
          bottom: BorderSide(width: 8, color: Colors.grey),
          left: BorderSide(width: 8, color: Colors.grey),
          right: BorderSide(width: 8, color: Colors.grey),
        ),
        color: Colors.grey,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: ()  {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Are you sure you want to delete this image?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                // Create a reference to the file in Firebase Storage
                                Reference storageReference = FirebaseStorage.instance.ref().child(storageUrl);

                                // Delete the file
                                await storageReference.delete();

                                print('File deleted successfully');
                              } catch (e) {
                                print('Error deleting file: $e');
                              }

                              try {
                                final userid = FirebaseAuth.instance.currentUser?.uid;
                                // Get reference to the document
                                DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(userid).collection('photos').doc(DocId);

                                // Delete the document
                                await documentReference.delete();

                                print('Document deleted successfully');
                              } catch (e) {
                                print('Error deleting document: $e');
                              }

                              await retrieve();
                              setStateWrapper();
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.close),
                color: Colors.white,
              ),
            ],
          ),
          ClipRRect(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}