import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn();
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  _SignInState();
  String email = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

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
