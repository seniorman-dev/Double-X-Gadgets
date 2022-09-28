import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloka_app/FirebaseAuth/FirebaseSignUp.dart';
import 'package:eloka_app/HomeScreen/drawer_items.dart';
import 'package:eloka_app/defaultColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:eloka_app/FirebaseAuth/AuthenticationHelper.dart';
import 'package:url_launcher/url_launcher.dart';




class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key,}) : super(key: key);


  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  
  //Firebase Auth directly
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              //headerWidget(),
              //const SizedBox(height: 40,),
              firebaseUserWidget(),
              const SizedBox(height: 15),
              //Text('email: ${user.email!}'),  //for firebase       
              Text(user.email!, style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: DrawerItems(
                  name: 'Edit Avatar',
                  icon: CupertinoIcons.camera,
                ),
              ),
              //const SizedBox(height: 20,),
              //GestureDetector(
                //onTap: () {Get.snackbar("Signed in as:", "(firebase email => #user.email!)");},
                //child: DrawerItems(
                  //name: 'Details',
                  //icon: CupertinoIcons.mail,
                //),
              //),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {notificationsBottomSheetFunction();},
                child: DrawerItems(
                  name: 'Notifications',
                  icon: CupertinoIcons.bell,
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {bottomSheetForHelpCenterFunction();},
                child: DrawerItems(
                  name: 'Help Center',
                  icon: CupertinoIcons.question_circle,
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  AuthenticationHelper().signOut(context);
                },
                child: DrawerItems(
                  name: 'Sign Out',
                  icon: Icons.logout,
                ),
              ),
              const SizedBox(height: 20,),
            ]
          ),
        ),
      )
    ); 
  }
  

  //header for drawer
  Widget headerWidget() {
    return Row(
      children: [
        SizedBox(width: 70,),     
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('asset/images/sochi_logo.png'),
        ), 
      ]
    );
  }
  
  //firebase user widget
  Widget firebaseUserWidget() {
    return FutureBuilder<Users?>(
      future: readUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}', style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,));
        }
        else if (snapshot.hasData) {
          final users = snapshot.data!;
          // ignore: unnecessary_null_comparison
          return users == null ? Text('User not found!', style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)) : buildUser(users);
        }
        else {
          return Center(
            child: CircularProgressIndicator(color: Colors.white)
          );
        }
      },
    );
  }
  Widget buildUser(Users users) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(users.user_name, style: GoogleFonts.belleza(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
    ],
  );

  
  //CRUD: Firebase createUser Method for creating user's name in Cloud Firestore
  Future createUser(Users user) async{
    ///Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    final json = user.toJson();

    ///Create documnet and write data to Firebase
    await docUser.set(json);
  }

  //CRUD: Firebase readUsers method for reading all users details as a list at once in app. *not needed atm
  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
  .collection('users')
  .snapshots()
  .map((snapshot) => 
  snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

  //CRUD: Firebase readUser method that particularly reads a sinngle user details in app
  Future<Users?> readUser() async{
    ///Reference to document (get single document ID)
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()!);
    }
  }


  //function for help center(makes the "help center gesture detector" open a bottom sheet). Thanks to resocoder on YT
  void bottomSheetForHelpCenterFunction() {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container( //to see the rounded corner
        height: 150, //120
        color: const Color(0xFF737373), //grey themed background
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
            ),
            //wrap with listview 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.question_circle_fill, color: Colors.black),
                    const SizedBox(width: 10),
                    Text(
                      "Help Center",
                      style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Got any complaint?",
                  style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)
                ),
                const SizedBox(height: 20), //10
                //wrap with elevated button with "align"
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {messageUs();}, 
                    child: Text(
                      'MAIL US',
                      style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)
                    ),
                    style: ElevatedButton.styleFrom(
                      //shadowColor: Colors.white,
                      //surfaceTintColor: Colors.white,
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  

  //function for help center bottom sheet button to link user to my email
  void messageUs() async{
    const toEmail = "doublexgadgets@gmail.com";
    const subject = "";
    const message = "";
    final url = "mailto:${Uri.encodeFull(toEmail)}?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}";

    if(await canLaunch(url)) {
      await launch(url);
    }
  }

  
  //we would use firebase push notifications
  //function for notifications(makes the "notification gesture detector" open a bottom sheet to for users to view any notification). Thanks to resocoder on YT
  void notificationsBottomSheetFunction() {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container( //to see the rounded corner
        height: 300,
        color: const Color(0xFF737373), //grey themed background
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: Radius.circular(20)
              ),
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [    
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.bell_solid, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(
                          "Notifications",
                          style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Notifications will appear here.",
                      style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}




