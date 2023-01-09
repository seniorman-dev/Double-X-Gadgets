import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:eloka_app/Payment/paystack.dart';
import 'package:eloka_app/SearchBar/search_page.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>{
  

  //pages list
  List pages = [
    HomeScreen(),
    SearchPage(),
    PaystackUi(),
  ];

  //current index for bottom navigation bar
  int currentIndex = 0;

  bool selectedIndex = false;

  //'onTap' function for bottom navigation bar
  void onTap(int index) {
    setState(() {
      currentIndex = index;
      //selectedIndex = !selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        //fixedColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedFontSize: 9, ///
        selectedFontSize: 9,  ///
        elevation: 0,      
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.comfortaa(color: Colors.grey, fontWeight: FontWeight.bold),
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill,),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.paperplane_fill),
            label: 'Payment',
          ),
        ],
      ),
    );
  }
}