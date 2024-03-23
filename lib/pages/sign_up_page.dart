import 'package:flutter/material.dart';

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
            CreateAccountButton(),
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
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap should have an actual function call for signing into the database
        onTap: () => {},
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
}