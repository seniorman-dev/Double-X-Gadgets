import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eloka_app/CartFolder/cart.dart';
import 'package:eloka_app/CartFolder/cart_model.dart';
import 'package:eloka_app/Product.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  
  ProductDetailScreen( this.items, {Key? key}) : super(key: key); 
  
  final Product items;
  
  var index;
  //Get.put() will be here
  
  @override
  Widget build(BuildContext context) {
    //wrt provider for cart model page just in case
    var ccart = Provider.of<CartModel>(context);

    //it provides us the total height and width for th detail screen body 
    //Size size = MediaQuery.of(context).size;

    return Scaffold( 
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed:() {
            Navigator.of(context).pop();
          },
          icon: Icon(CupertinoIcons.back, color: Colors.black,)
        ),
        title: Text(
        'Product Details',
         style: GoogleFonts.belleza(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [ 
              Container(
                //padding: EdgeInsets.symmetric(horizontal: 50),  //increase the padding //formerly 50
                height: 350, //formerly 350
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  ),
                ),
                child: Image.asset(items.image, fit: BoxFit.fitHeight,),  //go with fitHeight or contain.... i wrapped it with hero widget for nice hero animation
              ),
              const SizedBox(height: 10),
              Text(
                items.condition,
                textAlign: TextAlign.left,
                style: GoogleFonts.belleza(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                items.title,
                textAlign: TextAlign.left,
                style: GoogleFonts.belleza(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                items.capacity,
                textAlign: TextAlign.left,
                style: GoogleFonts.belleza(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Price: N${items.amount}',
                textAlign: TextAlign.left,
                style: GoogleFonts.belleza(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 100,  //91 it is!
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 15, blurStyle: BlurStyle.solid)]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),  //formerly 10
                    child: Text(
                      'Description: ${items.description}',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.belleza(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              //IconButton Wrapped with container, and padding
              const SizedBox(height: 2),
                
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    //it works courtesy of provider state management
                    ccart.add(items); 
                    //Get.snackbar('An Item Has Been Added To Your Cart', "you've added something to your cart!", duration: Duration(seconds: 2), isDismissible: true, colorText: Colors.black, borderRadius: 10);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()), 
                    );
                    //snackkbar
                    //ScaffoldMessenger.of(context).showSnackBar(
                      //SnackBar(
                        //duration: Duration(seconds: 2), //newly added
                        //padding: EdgeInsets.all(15),  //newly added
                        //content: Text("${items.title} Has Been Added To Your Cart!", style: GoogleFonts.belleza(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold),),
                        //elevation: 2, //1
                        //dismissDirection: DismissDirection.up,  //down  //endToStart  //vertical
                        //backgroundColor: Colors.white,  //grey
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(10),
                        //side: BorderSide(color: Colors.white),
                        //),
                      //)
                    //);
                  },
                  child: Container(
                    height: 40,
                    width: 250,         //formerly 200,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color:Colors.grey.withOpacity(0.3), blurRadius: 15, blurStyle: BlurStyle.solid)]
                    ),
                    child: const Icon(CupertinoIcons.cart_badge_plus, color: Colors.white,),
                  ),
                ),
              )
            ]
          ),
        ],
      )
    );
  }
}


