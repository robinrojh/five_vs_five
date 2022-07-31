import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/util/validators.dart';
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

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
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
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (email) {
                      return validateEmail(email);
                    },
                    onChanged: (email) {
                      setState(() {
                        this.email = email;
                      });
                    },
                  ),
                )),
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
                  child: SizedBox(
                      width: 640,
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Confirm Password"),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (confirmPassword) {
                          return validateConfirmPassword(
                              confirmPassword, password);
                        },
                        onChanged: (confirmPassword) {
                          setState(() {
                            this.confirmPassword = confirmPassword;
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
                          FirestorePlayerRepository.signUp(email, password)
                              .then((value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Sign up successful!"),
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
                Center(
                  child: InkWell(
                    child: Text(
                      "Sign In Here!",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, "/signin"),
                  ),
                ),
              ],
            )));
  }
}
