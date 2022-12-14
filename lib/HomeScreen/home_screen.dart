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
import 'package:provider/provider.dart';
import '../defaultColor.dart';





class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  
  int _currentIndex = 0;

  bool isSelected = false;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

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
                );
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
            child: Text('Hello Chief,\nWhat Are You Shopping Today?', style: GoogleFonts.belleza(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
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
                          style: GoogleFonts.belleza(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black, fontStyle: FontStyle.italic)      //20
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: (){}, 
                        child: Text('Buy Now'.toUpperCase(), style: GoogleFonts.belleza(fontWeight: FontWeight.bold)),
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
            child: Text('Categories', style: GoogleFonts.belleza(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
          ),

          //const SizedBox(height: 10),

          Carousel(),

          const SizedBox(height: 20),
               
          //GridView
          GridViewProduct(),                                        
        ],
      ),

      //bottom navigation bar
      bottomNavigationBar: Container(      
        //height: 60,  
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeOutCirc,
          backgroundColor: Colors.white,
          onItemSelected: (index){
            setState((){
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: isSelected ? Icon(Icons.home) : Icon(Icons.home_filled),
              title: TextButton(
                child: Text('Home', style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              activeColor: defaultColor,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),              
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.search,),
              title: TextButton(
                child: Text('Search', style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),   //Cart(items: items)
                  );
                }
              ),
              activeColor: defaultColor,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),     
            BottomNavyBarItem(
              icon: isSelected ? Icon(CupertinoIcons.paperplane) : Icon(CupertinoIcons.paperplane_fill),
              title: TextButton(
                child: Text('Payment', style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaystackUi()),
                  );
                },
              ),
              activeColor: defaultColor,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}