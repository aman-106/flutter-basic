import 'package:flutter/material.dart';
import 'dart:async';
import './SignInForm.dart';

// import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  final bool loggedIn;
  Login({this.loggedIn}) : assert(loggedIn != null);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}
// bool invalidEmailFormat = false;
// bool emptyPasswordStr = false;

class LoginState extends State<StatefulWidget> {
  bool loggedIn = false;

  Future<void> _logInUserScreen(context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Login'),
            children: <Widget>[
              SimpleDialogOption(
                child: _createSignInForm(),
              ),
            ],
          );
        });
    // hasUserLoogedIn();
  }

  void hasUserLoogedIn() {
    setState(() {
      loggedIn = !loggedIn;
    });
  }

  Widget _getLogBtn() {
    return loggedIn ? Text('Log Out') : Text('Log In');
  }

  Widget _createSignInForm() {
    return SignInForm();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(style: BorderStyle.solid, width: 2)),
            onPressed: () => _logInUserScreen(context),
            child: _getLogBtn(),
          ),
        ],
      ),
    );
  }
}
