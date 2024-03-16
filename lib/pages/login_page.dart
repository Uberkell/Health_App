import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 200),
          //welcome
          Text(
            'Welcome back!',
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
          //sign in button
          SignInButton(),
        ],
      )
    );
  }
}

//textfields
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

//sign in button
class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                "Sign In",
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




