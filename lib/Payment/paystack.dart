//Courtesy of "flutter_paystack_client" API from pub.dev
import 'package:eloka_app/CartFolder/cart_model.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class PaystackUi extends StatefulWidget {
  @override
  _PaystackUiState createState() => _PaystackUiState();
}

class _PaystackUiState extends State<PaystackUi> {
  final _formKey = GlobalKey<FormState>(); //very important for TextFormFields
  String _email = '';
  int _amount = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {

    //for TextForm Border Outline
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    //for CartModel  //w.r.t. provider for cart
    var ccart = Provider.of<CartModel>(context);  
    
    //for Cart Amount to be passed and verified in the "TextFormField"
    final pass = ccart.totalString;

    //ccart.cartItems
    final items = (ccart.cartItems).toString(); //or as String
    
    //
    //final _key = GlobalKey<FormState>(); //very important for TextFormFields
  
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        //title: Text('Order', style: GoogleFonts.belleza(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
        //centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed:() {
            Navigator.of(context).pop();
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white)    //Colors.indigoAccent  //Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 8,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autocorrect: true,
                inputFormatters: const [],
                enableSuggestions: true,
                enableInteractiveSelection: true,
                style: TextStyle(color: Colors.white),  //black  //formerly
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  focusedBorder: border,
                  labelStyle: TextStyle(color: Colors.indigo),
                  labelText: 'verified email',
                  prefixIcon: Icon(CupertinoIcons.mail, color: Colors.indigo),
                ),
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Empty Field!';
                }
                return null;
                },
                onSaved: (val) {  //onChanged
                  _email = val!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 30,),

              TextFormField(
                autocorrect: true,
                inputFormatters: const [],
                enableSuggestions: true,
                enableInteractiveSelection: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  focusedBorder: border,
                  labelText: 'enter the amount below...',
                  labelStyle: TextStyle(color: Colors.indigo),
                  prefixIcon: Icon(CupertinoIcons.checkmark_seal, color: Colors.indigo),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Field!';
                  }
                  // ignore: unrelated_type_equality_checks
                  if (value != pass) {   //or pass.length
                    return 'Invalid Amount!';
                  }
                  //return null;
                },
                onChanged: (val) {
                  try {
                    _amount = (double.parse(val) * 100).toInt();
                  } 
                  catch (e) {
                    print(e);   //you could replace with a snackbar
                  }
                },
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 40), //30

              //Text("Pay N${ccart.totalString}", textAlign: TextAlign.start, textDirection: TextDirection.ltr, style: GoogleFonts.belleza(color: Colors.white, fontSize: 15)),

              //const SizedBox(height: 10),

              Text("please note: we will send you an e-mail \nfor more information pertaining your order.", textAlign: TextAlign.start, textDirection: TextDirection.ltr, style: GoogleFonts.belleza(color: Colors.white, fontSize: 14)),

              const SizedBox(height: 60),  //30

              //wrap with a Container or SizedBox to give it better feels later
              SizedBox(
                height: 50,  //50
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    //Response to button press
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {_message = '';});
                      //Charge Call
                      final charge = Charge()
                        //..toString()
                        ..putCustomField(_email,  items)  //added this feature
                        ..email = _email
                        ..amount = _amount
                        ..reference = 'Ref_${DateTime.now().millisecondsSinceEpoch}'; 
                      //CheckOut Response
                      final res =
                      await PaystackClient.checkout(context, charge: charge);
                      if (res.status) {
                        _message = 'Transaction Successful!\nRef: ${res.reference}'; 
                      } else {
                        _message = 'Failed: ${res.message}';
                      }
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    //shadowColor: Colors.white,
                    //surfaceTintColor: Colors.white,
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    side: BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid
                    )
                  ),
                  child: Text('Pay N${ccart.totalString}', style: GoogleFonts.belleza(fontSize: 20, color: Colors.white))
                ),
              ),

              const SizedBox(height: 30),  //20

              Text(
                _message,
                style: GoogleFonts.belleza(
                  fontWeight: FontWeight.bold,
                  //fontSize: ,
                  color: Colors.white,  //change 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}