import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/util/validators.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 640,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "User Email"),
                      validator: (email) {
                        return validateEmail(email);
                      },
                      onChanged: (email) {
                        setState(() {
                          this.email = email;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                      width: 640,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (password) {
                          return validatePassword(password);
                        },
                        onChanged: (password) {
                          setState(() {
                            this.password = password;
                          });
                        },
                      )),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirestorePlayerRepository.signIn(email, password)
                              .then((value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Sign in successful!"),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 2)),
                                  ))
                              .then((value) =>
                                  Navigator.of(context).pushNamed("/"))
                              .catchError((error, stackTrace) {
                            return ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(error.toString()),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ));
                          });
                        }
                      },
                      child: Text("Sign In"),
                    ),
                  ),
                ),
              ],
            )));
  }
}
