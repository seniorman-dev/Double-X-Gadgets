import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';



List<String> images = [
  "asset/images/iphone_14_pro_black.jpg",
  "asset/images/razer_blade_15_black.jpg",
  "asset/images/macbook_pro_black.jpg",
  //"asset/images/ps5_black.png",
  "asset/images/ps5_black_2.jpg",
  "asset/images/series_8_black.jpg",
  "asset/images/airpods_pro_black.jpg"
];

List<Widget> generateImages() {
  return images.map((element) => 
  ClipRRect(
    child: Image.asset(element, fit: BoxFit.cover),
    borderRadius: BorderRadius.circular(15),
  )
  ).toList();
}

// ignore: must_be_immutable
class Carousel extends StatelessWidget {

  CarouselController carouselController = CarouselController();

  Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          CarouselSlider(
            items: generateImages(), 
            options: CarouselOptions(
              height: 250, //200
              enlargeCenterPage: true,
              //autoPlay: true,
              //autoPlayCurve: Curves.fastOutSlowIn,
              //autoPlayAnimationDuration: Duration(milliseconds: 800),      
              //aspectRatio: 16/9,
              enableInfiniteScroll: true,
            ),
          )
        ],
        //add texts if you want
      )
    );
  }
}