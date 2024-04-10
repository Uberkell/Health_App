import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 2,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.red,
              iconSize: 50,
            ),
          ),
          Center( // Centering the content
            child: SingleChildScrollView( // Making content scrollable
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centering content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Centering content horizontally
                children: [
                  Container (
                    height: 100,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  ),
                  SizedBox(height: 50),
                  TextFieldSignIn(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  SizedBox(height: 20), // Reduced the height for better spacing
                  TextFieldSignIn(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 20), // Reduced the height for better spacing
                  CreateAccountButton(
                    usernameController: usernameController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldSignIn extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const TextFieldSignIn({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const CreateAccountButton({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signUp(
          usernameController.text.trim(),
          passwordController.text.trim(),
          context,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15), // Reduced padding for better appearance
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center( // Centering the text
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        await FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).set({});
        // Optionally, you can navigate to another page after successful signup
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnotherPage()));
      }
    } catch (e) {
      print(e.toString());
      // Handle error, for example, show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up failed')));
    }
  }
}