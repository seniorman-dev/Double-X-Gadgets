import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eloka_app/Carousel/carousel.dart';
import 'package:eloka_app/CartFolder/cart.dart';
import 'package:eloka_app/CartFolder/cart_model.dart';
import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';
import 'package:eloka_app/HomeScreen/navigation_drawer.dart';
import 'package:eloka_app/Payment/paystack.dart';
import 'package:eloka_app/Product.dart';
import 'package:eloka_app/SearchBar/search_page.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:eloka_app/HomeScreen/product_gridview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';





class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key,}) : super(key: key);
  //Users users;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  
  int _currentIndex = 0;

  bool isSelected = false;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  //Firebase Auth directly
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    
    //Google SignOut Function
    //Future<void> _signOut() async {
    //final GoogleSignIn googleSignIn = GoogleSignIn();
    //await googleSignIn.signOut();
    //print("User Signed Out");
    //}

    //Google SignOut Function
    Future<void> _signOut() async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      print("User Signed Out!");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3), //newly added
          padding: EdgeInsets.all(15),  //newly added
          backgroundColor: Colors.white,
          elevation: 2, //0
          dismissDirection: DismissDirection.down,  //endToStart
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white),
          ),
          content: Text(
            "You've succesfully Signed Out with Google!",
            style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        )
      );
    }
     
    var ccart = Provider.of<CartModel>(context);  //w.r.t. provider for cart
    
    //SQL
    
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawer(), 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,  //Colors.transparent, 
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          }, 
          icon: Icon(Icons.short_text, color: Colors.black)   //defaultColor
        ),
             
        actions: [     
          //IconButton(
            //onPressed: () {
              //Navigator.push(
                //context,
               // MaterialPageRoute(builder: (context) => SearchPage()), 
              //);
            //}, 
            //icon: Icon(CupertinoIcons.search, color: Colors.black)
          //),
          Badge(
            badgeContent: Consumer<CartModel> (
              builder: (context, value, child,) {
                return Text(
                  "${ccart.japhet}",
                  style: GoogleFonts.belleza(color: Colors.white, fontWeight: FontWeight.bold)
                );
              },
            ),
            badgeColor: defaultColor,
            position: BadgePosition(start: 20, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()), 
                ).then((value) => setState(() {}));
              }, 
              icon: Icon(CupertinoIcons.cart, color: Colors.black)
            ),
          ),
        ], 
      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection:  Axis.vertical,  
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello Chief,', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height: 5),
                Text('what are you shopping today?', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),)
              ],
            ),
          ),
          SizedBox(height: 20), //25
          //for the best deals.. i'd work on this later
          Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.topLeft,  // newly added
              children: [
                ClipRRect(
                  child: Image.asset('asset/images/games 1.jpg',),
                  borderRadius: BorderRadius.circular(25)  //formerly 12
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,   //formerly start
                    children: [
                      //RichText(
                      //textAlign: TextAlign.start,
                      //text: TextSpan(
                      //text: 'Deal Of The Day!',
                      //style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: defaultColor)      //initially 28
                      //),
                      //),
                      //SizedBox(height:8),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Sweet Deal!\nDualSense 5 Controller',
                          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black,)      //fontStyle: FontStyle.italic
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: (){}, 
                        child: Text('Buy Now'.toUpperCase(), style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(defaultColor),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ]
                  ),
                ),
              ]
            ),
          ),

          const SizedBox(height: 20), 

          //create another carousel that plays videos later
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Categories', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
          ),

          //const SizedBox(height: 10),

          Carousel(),

          const SizedBox(height: 20),
               
          //GridView
          GridViewProduct(),                                        
        ],
      ),
    );
  }
}