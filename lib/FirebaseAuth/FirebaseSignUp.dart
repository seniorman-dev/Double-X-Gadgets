import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:eloka_app/HomeScreen/navigation_drawer.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eloka_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';




class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8.0), //16
        children: [
          //SizedBox(height: 20),
          Column(
            children: [
              //DXG Logo goes here
              //FlutterLogo(
                //size: 55,
              //),
            ],
          ),

          SizedBox(height: 20),  //40

          Center(
            child: Text(
              'Create Account',
              style: GoogleFonts.nunitoSans(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 100),  //50

          Padding(
            padding: const EdgeInsets.all(16.0),   //all(8.0),
            child: SignupForm(),
          ),

          SizedBox(height: 20,), //30  //new idea

          Row(
            mainAxisAlignment: MainAxisAlignment.center,  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(    //Added this here to shift row to the center
                child: Row(
                  children: [
                    Text(
                      'Have an account?', 
                      style: GoogleFonts.belleza(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Login', style: GoogleFonts.belleza(fontSize: 16, color: defaultColor)),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


//SignUp Form which entails Firebase SigIn
class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {

  final _formKey = GlobalKey<FormState>();  //very important for TextFormFields
  String? name;
  String? email;
  String? password;
  bool _obscureText = false;  //false;
  bool agree = false;  //for the T&C agreement checkbox  
  final pass = TextEditingController();  //to check for password mis-match when signing up


  final fullNameController = TextEditingController();  
  final emailController = TextEditingController();   
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();


  @override
  void dispose() {
    //to dispose controllers after usage
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    pass.dispose();
    // TODO: implement dispose
    super.dispose();
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

    //var space = SizedBox(height: 10);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // name
          TextFormField(
            controller: fullNameController,
            autocorrect: true,
            inputFormatters: [],
            enableSuggestions: true,
            enableInteractiveSelection: true,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              //labelStyle: ,
              //hintStyle: ,
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'first name',
              prefixIcon: Icon(CupertinoIcons.person, color: defaultColor),
              //focusedBorder: border,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
            ),           
            onSaved: (val) {
              fullNameController.text = val!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Empty Field!';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ),

          //space
          SizedBox(height: 20),

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
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(CupertinoIcons.mail, color: defaultColor),
              labelText: 'example@domain.com',
              //focusedBorder: border,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Invalid Email!';
              }
              return null;
            },
            //onChanged: (user_name) {
              //setState(() {});
            //},
            onSaved: (val) {
              emailController.text = val!;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          //space,
           SizedBox(height: 20,),

          // password
          TextFormField(
            //controller: passwordController,
            autocorrect: true,
            inputFormatters: [],
            enableSuggestions: true,
            enableInteractiveSelection: true,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            controller: pass,
            decoration: InputDecoration(
              //labelStyle: ,
              //hintStyle: ,
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'password',
              prefixIcon: Icon(CupertinoIcons.padlock, color: defaultColor),
              //focusedBorder: border,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,     //Icons.visibility_off : Icons.vissibility
                  color: defaultColor,
                ),
              ),
            ),
            onSaved: (val) {
              pass.text = val!;
            },
            obscureText: !_obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Empty Field!';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),

          //space,
          SizedBox(height: 20,),

          // confirm password
          TextFormField(
            autocorrect: true,
            inputFormatters: [],
            enableSuggestions: true,
            enableInteractiveSelection: true,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            controller: passwordController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              //hintStyle: ,
              labelText: 'confirm password',
              prefixIcon: Icon(CupertinoIcons.padlock, color: defaultColor),
              //focusedBorder: border,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor, width: 2.0),
                borderRadius: BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              ///
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility: Icons.visibility_off,     //Icons.visibility_off : Icons.vissibility
                  color: defaultColor,
                ),
              ),
            ),
            onSaved: (val) {
              passwordController.text = val!;
            },
            obscureText: !_obscureText,
            //obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Empty Field!';
              }
              if (value != pass.text) {
                return 'Password Mis-Match!';
              }
              //return null;
            },
            keyboardType: TextInputType.text,
          ),

          //space,
          SizedBox(height: 50),  //40

          Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                side: BorderSide(
                  color: Colors.indigo,
                  style: BorderStyle.solid
                ),
                activeColor: Colors.indigo,
                hoverColor: Colors.indigo,
                checkColor: Colors.white,
                //focusColor: Colors.white,
                //fillColor: Colors.white,
                onChanged: (_) {
                  setState(() {
                    agree = !agree;
                  });
                },
                value: agree,
              ),
              Flexible(
                child: Text(
                  'By creating account, I agree to the Terms & Conditions and Privacy Policy.',
                  style: GoogleFonts.belleza(fontSize: 15, color: Colors.black),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          //Firebase SignUp Button
          SizedBox(
            height: 50,  //50
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async{
                //Fluttertoast();
                //Response to button press
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //calls the Auth Helper if all the textforms passess it's validation
                  AuthenticationHelper()
                    .signUp(email: emailController.text.trim(), password: passwordController.text.trim())
                    .then((result) {
                      /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen())
                      );*/
                      //Get.snackbar('Your Account Has Been Created', "registration successful!", duration: Duration(seconds: 3), isDismissible: true, colorText: Colors.black, borderRadius: 10);
                      print('User Registered Successfully');
                      //cloud firestore database for creating new user
                      final user = FirebaseAuth.instance.currentUser!;
                      FirebaseFirestore.instance.collection('users').add({'name': fullNameController.text, 'email': emailController.text, 'uid': user.uid, 'password' : pass.text});                          
                      }
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  //shadowColor: Colors.white,
                  foregroundColor: Colors.black, 
                  backgroundColor: Colors.black,
                  //surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    /*side: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid
                    )*/
                  )
                ),
                child: Text(
                  'Create Account', style: GoogleFonts.nunitoSans(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
