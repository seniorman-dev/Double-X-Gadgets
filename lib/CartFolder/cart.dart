// Courtesy of "https://github.com/edocbuhtig/flutter-ecommerce-provider/blob/master/lib/screens/cartview.dart"
// ignore_for_file: must_be_immutable
import 'package:eloka_app/Product.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eloka_app/Payment/paystack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eloka_app/CartFolder/cart_model.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:provider/provider.dart';




class Cart extends StatefulWidget {

  const Cart({Key? key,}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  //Get.find() will be here ****Get.put()
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    var ccart = Provider.of<CartModel>(context);  //w.r.t. provider for cart

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed:() {
            Navigator.pop(context);  // or similarly, "Navigator.of(context).pop()"
          },
          icon: Icon(CupertinoIcons.back, color: Colors.black,)
        ),
        centerTitle: true,
        title: Text('My Cart', style: GoogleFonts.belleza(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black))
      ),
      body: 
        ccart.cartItems.isEmpty
              ? Center(child: Text('No item(s) in your cart!', style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)))
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: ccart.cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)  
                      ),
                      child: ListTile(
                        //contentPadding: EgdeInsets.symmetric(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          //side: BorderSide(color: Colors.white),
                        ),
                        tileColor: Colors.white,
                        title: Text(ccart.cartItems[index].title, style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold)),
                        subtitle: Column( //Row
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5), //
                            Text("N${ccart.cartItems[index].amount}", style: GoogleFonts.belleza(color: Colors.black)),
                            //////
                            //////
                          ],
                        ),
                        trailing: FittedBox(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(CupertinoIcons.minus_circle_fill, color: defaultColor, size: 20),
                                onPressed: () {
                                  setState(() {
                                    if (ccart.cartItems[index].quantity <= 1) {
                                      Get.snackbar(ccart.cartItems[index].title, "removed from cart!",duration: Duration(seconds: 2), isDismissible: true, colorText: Colors.black, borderRadius: 10);
                                      ccart.remove(ccart.cartItems[index]);
                                    }
                                    else {
                                      ccart.cartItems[index].quantity--;
                                    }
                                  });
                                  //ccart.decreaseQuantity(ccart.cartItems[index]); //item
                                },
                              ),
                              Text(
                               "${ccart.cartItems[index].quantity}",
                                style: GoogleFonts.belleza(fontSize: 15, color: Colors.black), 
                              ),
                              IconButton(
                                icon: Icon(CupertinoIcons.plus_circle_fill, color: defaultColor, size: 20),
                                onPressed: () {
                                  setState(() {
                                    if (ccart.cartItems[index].quantity >= 5) {
                                      Get.snackbar("Maximum Increase", "you can't surpass this item quantity",duration: Duration(seconds: 2), isDismissible: true, colorText: Colors.black, borderRadius: 10);
                                    }
                                    else {
                                      ccart.cartItems[index].quantity++;
                                    }
                                  });
                                  //ccart.increaseQuantity(ccart.cartItems[index]);  //item                                
                                },
                              ),
                              IconButton(
                                icon: Icon(CupertinoIcons.delete_solid, color: defaultColor,),
                                onPressed: () {
                                  ccart.remove(ccart.cartItems[index]);
                                  Get.snackbar(ccart.cartItems[index].title, "removed from cart!",duration: Duration(seconds: 2), isDismissible: true, colorText: Colors.black, borderRadius: 10);
                                },
                              ),
                            ],
                          ),
                        ),                      
                        leading: Image.asset(ccart.cartItems[index].image)
                    
                    )
                  );
                }
              ),

                //bottom navigation bar
                bottomNavigationBar:
                Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: Container(
                              height: 360, //380
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, 3))]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Item(s): ',   
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        ),
                                        
                                        Text( //${ccart.cartItems.length * qty}
                                          "${ccart.japhet}",   //here, we would put the total quantity of items function in the cart
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        )                                                                     
                                      ],
                                    )
                                  ),
                                  Divider(color: defaultColor,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sub-Total:',   
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        ),
                                        Text( //N${ccart.subtotal}
                                          "N${ccart.subtotal}",
                                         // "N${ccart.cartItems.length > 0? ccart.cartItems.map<int>((e) => e.amount * e.quantity).reduce((value, element) => value + element).toStringAsFixed(2) : 0.0}",      //here, we would put the sub-total amount for items function in the cart
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        )
                                      ],
                                    )
                                  ),
                                  Divider(color: defaultColor,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Delivery fee: ',   
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        ),
                                        Text(
                                          "N"+ ccart.deliveryFeeString,
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        )
                                      ],
                                    )
                                  ),
                                  Divider(color: defaultColor,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: ',   
                                          style: GoogleFonts.belleza(fontSize: 20, color: Colors.black),
                                        ),
                                        Text(
                                          "N${ccart.totalString}",
                                          //"N${ccart.cartItems.length > 0? ccart.cartItems.map<int>((e) => e.amount * e.quantity).reduce((value, element) => value + element).toStringAsFixed(2) : 0.0}",      //here, we would put the sub-total amount for items function in the cart,     //here, we would put the total amount(sub-total + delivery fee) for items function in the cart
                                          style: GoogleFonts.belleza(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                        )
                                      ],
                                    )
                                  ),
                                  Divider(color: defaultColor,),
                                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaystackUi()), 
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 250,         //formerly 200,
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color:Colors.grey.withOpacity(0.3), blurRadius: 15, blurStyle: BlurStyle.solid)]
                        ),
                        child: Text(
                          "Pay N" + ccart.totalString,      //here, we would put the sub-total amount for items function in the cart})'),       //Icon(CupertinoIcons.rocket_fill, color: Colors.white,),
                          style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white
                        ),
                       ),
                      )
                      ),
                    )
                                ]
                              ),
                            ),
                          )
      );
  }
}