import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>(); //very important for TextFormFields
  final emailController = TextEditingController();
  String? email;

  @override
  Widget build(BuildContext context) {
    
    //for TextForm Border Outline
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        //title: Text("Let's Get You Back On Track!", style: GoogleFonts.belleza(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
        //centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed:() {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => Login())
            );
          },
          icon: Icon(CupertinoIcons.back, color: Colors.black)    //Colors.indigoAccent  //Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 8,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),  //40
              Text("Let's Get You Back On Track", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black)),
              SizedBox(height: 150), 
              TextFormField(
                controller: emailController,
                autocorrect: true,
                inputFormatters: [],
                enableSuggestions: true,
                enableInteractiveSelection: true,
                style: TextStyle(color: Colors.black),  //black  
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  //labelStyle: ,
                  //hintStyle: ,
                  labelStyle: TextStyle(color: Colors.grey),
                  //focusedBorder: border,
                  labelText: 'example@domain.com',
                  prefixIcon: Icon(CupertinoIcons.mail, color: defaultColor),
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
                  )
                ),
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Empty Field!';
                }
                //return null;
                },
                onSaved: (val) {  //onChanged
                  emailController.text = val!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 40,),

              //wrap with a Container or SizedBox to give it better feels later
              SizedBox(
                height: 50,  //50
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //calls the Auth Helper if textform passess it's validation
                    AuthenticationHelper().resetPassword(email: emailController.text.trim());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    //shadowColor: Colors.white,
                    //primary: Colors.white,
                    //surfaceTintColor: Colors.white,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      /*side: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid
                      )*/
                    )
                  ),
                  child: Text('Reset Password', style: GoogleFonts.nunitoSans(fontSize: 20, color: Colors.white))
                ),
              ),

              const SizedBox(height: 30),  //20
            ]
          )
        )
      )
    );
  }
}