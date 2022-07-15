import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp();
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _SignUpState();
  String email = "";
  String password = "";
  String confirmPassword = "";

  final _formKey = GlobalKey<FormState>();

  void signUp() {
    if (password != confirmPassword) {
      throw Exception("Password does not match!");
    } else {
      FirestorePlayerRepository.signUp(email, password);
    }
  }

  @override
  Widget build(context) {
    return Form(
        child: Column(
      children: [
        Center(
          child: TextFormField(
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Player ID cannot be empty!";
              }
              return "";
            },
            onChanged: (email) {
              setState(() {
                this.email = email;
              });
            },
          ),
        ),
        Center(
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Password cannot be empty!";
              }
              return "";
            },
            onChanged: (password) {
              setState(() {
                this.password = password;
              });
            },
          ),
        ),
        Center(
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (confirmPassword) {
              if (confirmPassword == null || confirmPassword.isEmpty) {
                return "Please check if password is written correctly.";
              } else if (confirmPassword != password) {
                return "Your password does not match.";
              }
              return "";
            },
            onChanged: (confirmPassword) {
              setState(() {
                this.confirmPassword = confirmPassword;
              });
            },
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () =>
                  FirestorePlayerRepository.signIn(email, password),
              child: Text("Sign In"),
            ),
          ),
        ),
      ],
    ));
  }
}
