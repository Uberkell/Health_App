import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //back to prev page button
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 0,400, 0),
              icon: const Icon(Icons.arrow_back),
              iconSize: 50,
              onPressed: () => {Navigator.pop(context)},
              color: Colors.grey,
            ),
            SizedBox(height: 100),
            //welcome
            Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
              ),
            ),
            SizedBox(height: 50),
            //username textfield
            TextFieldSignIn(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            SizedBox(height: 50),
            //password textfield
            TextFieldSignIn(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 50),
            CreateAccountButton(
              usernameController: usernameController,
              passwordController: passwordController,
            ),
          ],
        )
    );
  }
}

class TextFieldSignIn extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;

  const TextFieldSignIn({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });




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
        )
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
          );
        },
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
            ),
          ),
        )
    );
  }
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        FirebaseFirestore.instance.collection('Users').doc((userCredential.user?.uid).toString()).set({});
      }
      // Optionally, you can navigate to another page after successful signup
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnotherPage()));
    } catch (e) {
      print(e.toString());
      // Handle error, for example, show error message
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up failed')));
    }
  }
}