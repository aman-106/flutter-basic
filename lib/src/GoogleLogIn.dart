import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class GoogleLogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleLogInState();
  }
}

class GoogleLogInState extends State<StatefulWidget> {
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: _handleSignIn,
      icon: Image.asset('assets/images/btn_google_dark_normal_mdpi.9.png'),
      label: Text('Sign In'),
      color: Colors.white,
    );
  }
}
