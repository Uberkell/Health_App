import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Column(
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
          TextFieldUsername(
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),
          SizedBox(height: 50),
          //password textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Toggle the value of obscureText
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            )
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
      )
    );
  }
}

//textfields
class TextFieldUsername extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;

  const TextFieldUsername({
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
          prefixIcon: Icon(Icons.email),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));

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
            color: Colors.green,
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
          color: Colors.green,
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




