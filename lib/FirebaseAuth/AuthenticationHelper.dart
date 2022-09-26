// Courtesy of "https://github.com/dipak2726/flutter_firebase_auth/blob/master/lib/authentication.dart"
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';




class AuthenticationHelper {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signIn({required String email, required String password,}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut(BuildContext context) async {  //added "context" cause of snackbar
    await _auth.signOut();
    print('User Signed Out With Firebase!');
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2), //newly added
        padding: EdgeInsets.all(16),  //newly added
        backgroundColor: Colors.white,
        dismissDirection: DismissDirection.down,  //endToStart
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white),
        ),
        elevation: 2, //0
        //duration: ,
        content: Text(
          "Signed Out!",
          style: GoogleFonts.belleza(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      )
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  //ResetPassword Method
  Future<String?> resetPassword ({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}