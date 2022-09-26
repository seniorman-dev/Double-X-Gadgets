import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';
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
              Text("Let's Get You Back On Track", style: GoogleFonts.raleway(fontSize: 25, color: Colors.black)),
              SizedBox(height: 150), 
              TextFormField(
                autocorrect: true,
                inputFormatters: [],
                enableSuggestions: true,
                enableInteractiveSelection: true,
                style: TextStyle(color: Colors.black),  //black  
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  //labelStyle: ,
                  //hintStyle: ,
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: border,
                  labelText: 'example@domain.com',
                  prefixIcon: Icon(CupertinoIcons.mail, color: Colors.blue),
                ),
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Empty Field!';
                }
                //return null;
                },
                onSaved: (val) {  //onChanged
                  email = val!;
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
                    AuthenticationHelper()
                      .resetPassword(email: email!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 3), //newly added
                          padding: EdgeInsets.all(16),  //newly added
                          backgroundColor: Colors.white,
                          dismissDirection: DismissDirection.down,  //endToStart
                          elevation: 2,  //0
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          content: Text(
                            'Reset Request Approved!\nKindly Check Your Mail.',
                            style: GoogleFonts.belleza(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ));


                      //.then((result) {
                      //if (result == null) {
                        //Navigator.pushReplacement(
                          //context,
                          //MaterialPageRoute(builder: (context) => Login())
                        //);
                      //} 
                      //else {
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //duration: Duration(seconds: 3), //newly added
                          //padding: EdgeInsets.all(16),  //newly added
                          //backgroundColor: Colors.white,
                          //dismissDirection: DismissDirection.down,  //endToStart
                          //elevation: 2,  //0
                          //shape: RoundedRectangleBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(10.0))
                          //),
                          //content: Text(
                            //result,
                            //style: GoogleFonts.belleza(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          //),
                        //));
                      //}
                    //});
                  }
                  },
                  style: ElevatedButton.styleFrom(
                    //shadowColor: Colors.white,
                    //primary: Colors.white,
                    //surfaceTintColor: Colors.white,
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      side: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid
                      )
                    )
                  ),
                  child: Text('Reset Password', style: GoogleFonts.belleza(fontSize: 20, color: Colors.black))
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