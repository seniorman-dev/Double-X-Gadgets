import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:eloka_app/HomeScreen/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eloka_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




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
              style: GoogleFonts.belleza(fontSize: 35, color: Colors.black),
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
                      child: Text('Login', style: GoogleFonts.belleza(fontSize: 16, color: Colors.blue)),
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


  final fullNameController = TextEditingController();  //for shared preference
  final emailController = TextEditingController();   //for shared preference
  //final passwordController = TextEditingController();



  //SharedPereferences for persisting this data
  
  


  @override
  void dispose() {
    //to dispose controllers after usage
    emailController.dispose();
    fullNameController.dispose();
    //passwordController.dispose();
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
            //`1initialValue: user_name,
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
              labelStyle: TextStyle(color: Colors.blue),
              labelText: 'full name',
              prefixIcon: Icon(CupertinoIcons.person, color: Colors.blue),
              focusedBorder: border,
            ),
            onChanged: (user_name) {
              setState(() {
                user_name = user_name;
              });
            },
            onSaved: (val) {
              name = val;
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
            //initialValue: user_email,
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
            onChanged: (user_name) {
              setState(() {
                
              });
            },
            onSaved: (val) {
              email = val;
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
                  _obscureText ? Icons.visibility : Icons.visibility_off,     //Icons.visibility_off : Icons.vissibility
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
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
            controller: pass,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.blue),
              //hintStyle: ,
              labelText: 'confirm password',
              prefixIcon: Icon(CupertinoIcons.padlock, color: Colors.blue),
              focusedBorder: border,
              ///
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility: Icons.visibility_off,     //Icons.visibility_off : Icons.vissibility
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
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
                //final user_email = emailController.text;
                //add more controllers if needed
                final user = Users(
                  user_name: fullNameController.text,
                );
                createUser(user);

                //Fluttertoast();
                print('Successful');
                  //Response to button press
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //calls the Auth Helper if all the textforms passess it's validation
                    AuthenticationHelper()
                    .signUp(email: email!, password: password!)
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
                foregroundColor: Colors.white, 
                backgroundColor: Colors.white,
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
                'Create Account', style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  
  //CRUD: Firebase createUser Method for creating user's name in Cloud Firestore
  Future createUser(Users users) async {
    ///Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    users.id = docUser.id;
    final json = users.toJson();

    ///Create documnet and write data to Firebase
    await docUser.set(json);
  }


  //CRUD: Firebase readUsers method for reading all users details as a list at once in app. *not needed atm
  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
  .collection('users')
  .snapshots()
  .map((snapshot) => 
  snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

  //CRUD: Firebase readUser method that particularly reads a sinngle user details in app
  Future<Users?> readUser() async{
    ///Reference to document (get single document ID)
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()!);
    }
  }


  //CRUD: Firebase "Update and Delete" calls are only exclusive to me

}



//Firebase User model
class Users {  //if you add
  String id;
  final String user_name;
  Users({this.id = '', required this.user_name});

  //toJson method for 'Users' model
  Map<String, dynamic> toJson() => {  //then add
    'id': id,
    'name': user_name
  };

  //fromJson method for 'Users' model
 static Users fromJson(Map<String, dynamic> json) =>  //then add again!
 Users(
  id: json['id'],
  user_name: json['name']
 );

}

