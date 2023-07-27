
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    print('\n %^&*( maryam!!!!!!!!!______');
     final GoogleSignInAccount? gUser = await GoogleSignIn(
    // scopes: [
    //   'email',
    //   'https://www.googleapis.com/auth/userinfo.profile',
    // ]
     ).signIn();


    print('\n 3333333333333333%^&*( maryam!!!!!!!!!______ can you show me error again please?; yeah');
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print('\n 444444444444444444444%^&*( maryam!!!!!!!!!______');
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);


    try {
      var result = await FirebaseAuth.instance.signInWithCredential(credential);
      print("]#%^^&& $result");
      return true;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to the Home Screen"),
      ),
      body: Center(
        child: Text("You have successfully logged in!"),
      ),
    );
  }
}