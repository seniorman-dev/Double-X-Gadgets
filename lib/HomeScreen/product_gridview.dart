import 'package:flutter/material.dart';
import 'package:eloka_app/Product.dart';
import 'package:eloka_app/DetailScreen.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:google_fonts/google_fonts.dart';

class GridViewProduct extends StatelessWidget{
  const GridViewProduct({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(5),
      children:  Product.items.map((items) => Container(  //the error is coming from here
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(20),   
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
            )
          ]
        ),
        width: 200,
        height: 100,
        child: GestureDetector(   //formerly inkwell
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetailScreen(items)),
            );
          },  
          child: Container(
          alignment: Alignment.topLeft, //newly added
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),   //newly added
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5,),     //top formerly 5
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(items.image, height: 120, width: double.infinity),                      //e.image, height: 120, width: double.infinity,), //height property formerly 90
              const SizedBox(height: 3),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: items.condition,
                  style: GoogleFonts.belleza(
                  color: Colors.black,  //defaultColor
                  fontSize: 11, 
                  )
                )
              ),
              const SizedBox(height: 3),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: items.title,
                    style: GoogleFonts.belleza(
                      color: Colors.black,
                      fontSize: 13,  
                    )
                )
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "N${items.amount.toString()}",
                      style: GoogleFonts.belleza(
                        color: Colors.black,  //defaultColor
                        fontSize: 13,         
                        fontWeight: FontWeight.bold   
                      )
                    )
                  ),                      
                ],
              ),

              // description, color and capacity class property yet to be used but will be used in the description page later
              //const SizedBox(height: 3),
              //RichText(
                //textAlign: TextAlign.start,
                //text: TextSpan(
                  //text: items.color,
                    //style: GoogleFonts.belleza(
                      //color: Colors.black,
                      //fontSize: 13,  
                    //)
                //)
              //),
              //const SizedBox(height: 3),
            ] 
          ),
        ),
      ),
    )
  ).toList(),
);
}
}
