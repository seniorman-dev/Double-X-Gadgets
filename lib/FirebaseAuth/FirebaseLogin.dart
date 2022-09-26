import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseSignUp.dart';
import 'package:eloka_app/FirebaseAuth/ResetPassword.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:eloka_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



//Google SignIn Courtesy of "https://www.geeksforgeeks.org/flutter-google-sign-in-ui-and-authentication/#:~:text=Step%201%3A%20First%20create%20the,with%20the%20name%20'GoogleSignIn'."

//Google SignIn API
GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  //clientId: '642464167886-6qmrp7i6s1f1djdusb55g9hi3bnnvlkg.apps.googleusercontent.com',
  //scopes: <String>[
    //'email',
    //'https://www.googleapis.com/auth/contacts.readonly',
  //],
);


// function to implement the google signin courtesy of geeks for geeks
final FirebaseAuth auth = FirebaseAuth.instance;   // creating firebase instance
  // Calling The Google SignIn API Here
  // ignore: non_constant_identifier_names
  //void 
  void _googleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);  
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential); 
      User? user = result.user;
      
      if (result != null) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => HomeScreen()
          )
        );
      }  // if result is not null, we simply call the MaterialpageRoute.
    }
  }



//Google SignOut Function
Future<void> _signOut() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
  print("User Signed Out With Google!");
}



class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8.0),
        children: [
          //SizedBox(height: 20),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //DXG Logo goes here
              //FlutterLogo(
                //size: 55,
              //),
              SizedBox(height: 40),  //40
              Text(
                "Buy Peace Of Mind",
                style: GoogleFonts.raleway(fontSize: 35, color: Colors.black),  //24 //
              ),
            ],
          ),

          SizedBox(height: 130,),  //110

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),

          SizedBox(height: 10), //20

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),  //20  //new idea           
              Text(
                "Don't have an account?",
                style: GoogleFonts.belleza(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)
              ),
                
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup())
                  );
                },
                child: Text('Sign Up',
                  style: GoogleFonts.belleza(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


//Login Form which contains both Google and Firebase SigIn Properties
class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>(); //very important for TextFormFields
  String? email;
  String? password;
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //for TextForm Border Outline
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    return 
      Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // email
            TextFormField(
              controller: emailController,
              autocorrect: true,
              inputFormatters: [],
              enableSuggestions: true,
              enableInteractiveSelection: true,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                //labelStyle: ,
                //hintStyle: ,
                labelStyle: TextStyle(color: Colors.blue),
                prefixIcon: Icon(CupertinoIcons.mail, color: Colors.blue),
                labelText: 'example@domain.com',
                focusedBorder: border,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Invalid Email!';
                }
                return null;
              },
              onSaved: (val) {
                email = val;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 30,
            ),
    
            // user's legit/verified password
            TextFormField(
              controller: passwordController,
              autocorrect: true,
              inputFormatters: [],
              enableSuggestions: true,
              enableInteractiveSelection: true,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                //labelStyle: ,
                //hintStyle: ,
                labelStyle: TextStyle(color: Colors.blue),
                labelText: 'password',
                prefixIcon: Icon(CupertinoIcons.padlock, color: Colors.blue),
                focusedBorder: border,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: _obscureText,
              onSaved: (val) {
                password = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Invalid Password!';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
    
            SizedBox(height: 60),  //40
            
            //Firebase Login or Sign In Button
            SizedBox(
              height: 50, //50
              width: double.infinity,     //180
              child: ElevatedButton(
                onPressed: () {
                 // _signIn;
                  //String useremail = emailController.text;
                  // Respond to button press wrt firebase
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //calls the Auth Helper if textform passess it's validation
                    AuthenticationHelper()
                    .signIn(email: email!, password: password!)
                    .then((result) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen())
                      );             
                    }
                  );
                }
                },
                style: ElevatedButton.styleFrom(
                  //shadowColor: Colors.white,
                  primary: Colors.white,
                  onPrimary: Colors.white,
                  //surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  side: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid
                  )
                  )
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Text('OR', style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
            //Divider(
              //thickness: 0.5,
              //color: Colors.black
            //),
            //SizedBox(height: 10),
            //forgot password button here
            TextButton(
              onPressed: () {
                //REST PASSWORD PAGE
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPassword())
                ); 
              },
              child: Text('Forgot Password?', style: GoogleFonts.belleza(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),            
            ),
            SizedBox(height: 20),
            //Google SignIn Button
            GestureDetector(
              onTap: () {
                _googleSignIn(context);
              },
              //Wrap it with padding if it's too big
              child: Container(
                height: 40,  //40
                width: 150,  //250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), //15
                  boxShadow: [BoxShadow(color:Colors.grey, blurRadius: 2, blurStyle: BlurStyle.solid)]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('asset/images/google_black.png'),
                    //SizedBox(width: 5), //10                  
                    Text('SignIn', style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),                                     
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  //Firebase SignIn With Controller
  //Future _signIn() async{
    //try {
      //await FirebaseAuth.instance.signInWithEmailAndPassword(
       // email: emailController.text.trim(),
       // password: passwordController.text.trim(),
     // );
      //return null;
   // } on FirebaseAuthException catch (e) {
      //return e.message;
    //}
  //}
}
