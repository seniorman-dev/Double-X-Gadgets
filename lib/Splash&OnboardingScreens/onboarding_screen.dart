import 'package:eloka_app/FirebaseAuth/FirebaseLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';


//OnboardingModel
class OnboardingModel {
  final String imageFile;
  final String title;
  final String subtitle;
  OnboardingModel({required this.imageFile, required this.title, required this.subtitle});
}


//item tabs
List<OnboardingModel> tabs = [
  OnboardingModel(
    imageFile: 'asset/images/onboard_order.png', 
    title: 'Premium Devices', 
    subtitle: "Our Devices are of the\nmost optimum quality. \nWe'd simply give you the best."
  ),
  OnboardingModel(
    imageFile: 'asset/images/onboard_payment.png', 
    title: 'Convenient & Instant Payment', 
    subtitle: 'Secure, Fast and Reliable Payment \noptions at your finger tips.'
  ),
  OnboardingModel(
    imageFile: 'asset/images/onboard_delivery.png', 
    title: 'Swift Delivery', 
    subtitle: 'Jet-Speed Delivery to your \nlocation on the go.'
  ),
];

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: Text(
              tabs[0].title,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)  //25
            ),
            //body: tabs[0].subtitle,
            bodyWidget: Text(
              tabs[0].subtitle,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)    //15
            ),
            image: Image.asset(
              tabs[0].imageFile,
              width: 800,
              height: 800
            )
          ),
          PageViewModel(
            titleWidget: Text(
              tabs[1].title,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)  //25
            ),
            //body: tabs[1].subtitle,
            bodyWidget: Text(
              tabs[1].subtitle,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)    //15
            ),
            image: Image.asset(
              tabs[1].imageFile,
              width: 700,  //400
              height: 700   //400
            )
          ),
          PageViewModel(
            titleWidget: Text(
              tabs[2].title,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)  //25
            ),
            //body: tabs[2].subtitle,
            bodyWidget: Text(
              tabs[2].subtitle,
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)    //15
            ),
            image: Image.asset(
              tabs[2].imageFile,
              width: 700,
              height: 700
            )
          ),
        ],
        showDoneButton: true,
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()), 
          );
        },
        done: Text(
          'Done',
          style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)  //25
        ),
        //onSkip: () {
          //Navigator.push(
            //context,
           // MaterialPageRoute(builder: (context) => Login()), 
          //);
        //},
        //showSkipButton: true,
        //skip: Text(
          //'Skip',
          //style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)  //25
        //),
        next: Icon(CupertinoIcons.chevron_right, color: Colors.black),
        dotsDecorator: DotsDecorator(
          size: Size.square(10),
          activeSize: Size(20, 10),
          color: Colors.grey,
          activeColor: Colors.black,
          spacing: EdgeInsets.symmetric(horizontal: 3),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )
        ),
      ),     
    );
  }
}