import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
          //sign up button
          SignUpButton(),
          SizedBox(height: 30),
          //sign in button
          LogInButton(
            usernameController: usernameController,
            passwordController: passwordController,
          ),
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
class LogInButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LogInButton({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap should have an actual function call for signing into the database
        onTap: () async {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text.trim(), password: passwordController.text.trim())
                .then((userCredential) {
              if (userCredential.user != null) {
                // Authentication was successful
                User user = userCredential.user!;

                print(user.uid.toString());


                Navigator.pushNamed(context, '/homepage');
              }
              else {
                // Authentication failed, will Handle authentication failure (e.g., display error message)
              }
            })
                .catchError((error) {
              // Handle any errors that occurred during the authentication process
              print("Error: $error");
            });
          } catch (e) {
            print(e.toString());
          }
        }
        ,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
                "Log In",
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
class SignUpButton extends StatelessWidget{
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, '/signuppage')
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(8)
        ),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          ),
        )
      ),
    );
  }
}




