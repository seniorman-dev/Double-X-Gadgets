import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




class DrawerItems extends StatelessWidget {
  const DrawerItems({Key? key, required this.name, required this.icon,}) : super(key: key);

  final String  name;
  final IconData icon;
  //final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () {onPressed;},
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 40),
            Text(name, style: GoogleFonts.belleza(fontSize: 15, color: Colors.white))
          ],
        ),
      ),
    );
  }
}