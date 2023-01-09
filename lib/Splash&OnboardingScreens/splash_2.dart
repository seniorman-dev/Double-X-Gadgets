import 'package:eloka_app/HomeScreen/bottom_nav_bar.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen
    (
      splash: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),  //40
            Image.asset('asset/images/sochi_logo.png',),
            const SizedBox(height: 20),
            //Text(
              //'Double X Gadgets',
              //style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30) //25
            //),
            //const SizedBox(height: 5),
            //Text(
              //"gadgets at it's best...", 
              //style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)
            //)
            //Image.asset('asset/images/doublex3.jpg',)
          ]
        )   //color: Colors.black,
      ), 
      nextScreen: BottomNavBar(), 
      duration: 2000, //4000
      backgroundColor: Colors.white, 
      centered: true,
      splashIconSize: 700,  //200,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: Duration(seconds: 2),  //2
    );
  }
}