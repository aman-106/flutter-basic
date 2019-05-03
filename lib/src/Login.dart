import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class User {
  String email;
  String password;
  User({this.email, this.password});
}

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
  bool _validateUser = false;
  bool _invalidUser = false;
  User user = User();
  GlobalKey<FormState> _formkey = new GlobalKey();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _updateUserEmail(String email) {
    user.email = email;
  }

  void _updateUserName(String password) {
    user.password = password;
  }

  void _authorizeUser() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      _handleSignIn(user.email, user.password);
    } else {
      setState(() {
        _validateUser = true;
      });
    }
  }

  void isInvalidUser(bool invalid) {
    setState(() {
      _invalidUser = invalid;
    });
  }

  Future<void> _handleSignIn(String email, String password) async {
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user == null) {
        isInvalidUser(true);
      } else {
        isInvalidUser(false);
        print(user.uid);
        return user;
      }
    } catch (e) {
      print('expet');
      print(e);
      isInvalidUser(true);
    }
  }

  String _validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.length == 0) {
      return "please enter email";
    }
    if (!regex.hasMatch(email)) {
      return "Incorrect email format";
    }
    return null;
  }

  String _emptyPassword(String password) {
    if (password.isEmpty) {
      return "Please enter password";
    }
    return null;
  }

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

  Widget _showLoggingError(){
    print(_invalidUser.toString());
    return _invalidUser
        ? Text(
      'The user dosnt exsist or passowrd is incorrect',
      style: TextStyle(
        color: Colors.red,
      ),
    )
        : IconButton(
      icon: Icon(Icons.check_circle),
      onPressed: () {},
    );
  }

  Widget _createSignInForm() {
    return Form(
      key: _formkey,
      autovalidate: _validateUser,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.blue)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
              // errorText: invalidEmailFormat ? "Incorrect email format" : '',
            ),
            onSaved: _updateUserEmail,
            validator: _validateEmail,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              )),
              // errorText: emptyPasswordStr ? "Please enter password" : '',
            ),
            onSaved: _updateUserName,
            validator: _emptyPassword,
          ),
          Container(
              child: _showLoggingError()
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text('cancel'),
                onPressed: () => Navigator.pop(context, null),
              ),
              RaisedButton(
                child: Text('Accept'),
                onPressed: _authorizeUser,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(style: BorderStyle.solid, width: 2)),
        onPressed: () => _logInUserScreen(context),
        child: _getLogBtn(),
      ),
    );
  }
}
