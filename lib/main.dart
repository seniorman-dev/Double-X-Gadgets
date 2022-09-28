import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'CartFolder/cart_model.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';


// My Paystack test PublicKey.... change to live key later
const String publicKey = "pk_test_72cfa9e11ca2cfcd17190fd9f38b4e8ee7ffe247";

//Google SignIn API
GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId +> eloka_app own below
  clientId: '642464167886-6qmrp7i6s1f1djdusb55g9hi3bnnvlkg.apps.googleusercontent.com',
  //scopes: <String>[
    //'email',
    //'https://www.googleapis.com/auth/contacts.readonly',
  //],
);




void main() async {  //async
  WidgetsFlutterBinding.ensureInitialized();
  //initializing firebase in my app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  //initializing the Paystack API in my app  
  await PaystackClient.initialize(publicKey);
  // initializing google admob in my app
  //await MobileAds.instance.initialize();  //admob doesn't work for web
  runApp(
    //CartModel ChangeNotifier goes here only...(exclusive)
    ChangeNotifierProvider(
      create: (_) => CartModel(), 
      child: Application()
    )
  );  
}




// app page (did this cause of Cart's provider (ChangeNotifierProvider))
class Application extends StatefulWidget {
  
  const Application({Key? key,}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //add all your providers in here.
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: GetMaterialApp(   //MaterialApp  
        debugShowCheckedModeBanner: false, 
        home: FirebaseCheck(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        // Theme mode depends on device settings at the beginning     
      ) 
    ); 
  }
}


class FirebaseCheck extends StatelessWidget {
  const FirebaseCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return HomeScreen(); 
          }
          else {
            return  Login();  //SplashScreen();          
          }
        }
      )
    );
  }
}


// function to implement the google signin (courtesy of geeks for geeks)
final FirebaseAuth auth = FirebaseAuth.instance;     // created firebase instance
  void signup(BuildContext context) async {
    //called the Google SignIn API Here
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      ); 
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      //I'd use this 'user' variable to create user Email-Picture and Email-Address in the Drawer Widget Later 
      User? user = result.user;
      
      if (result != null) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => HomeScreen()
          )
        );
      }  // if result is not null we simply call the MaterialpageRoute,
    }
  }


//Google SignOut Function
Future<void> _signOut() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
  print("User Signed Out");
}