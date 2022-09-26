//Courtesy of 'Coding with Hadi' on YT
import 'package:eloka_app/CartFolder/cart.dart';
import 'package:eloka_app/CartFolder/cart_model.dart';
import 'package:eloka_app/HomeScreen/home_screen.dart';
import 'package:eloka_app/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:eloka_app/defaultColor.dart';



class SearchPage extends StatefulWidget {


  const SearchPage({Key? key,}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController? textController = TextEditingController();
  
  //this empty list was created to store items on search in record/memory. it's very essential
  //use this in the 'setState' query of the TextField
  //List<Product> get cartItems => List<Product>items;
  List<Product> suggestionsOnSearch = [];

  //update this if you're doing a general list update
  List <Product> suggestions = [    
    Product( ////
      quantity: 1,
      id: 1,  
      amount: 55000,
      image: 'asset/images/games 1.jpg',
      title:'DualSense 5 Controller',
      condition:'Brand New',
      capacity: '',
      color: 'Color: Mixed(White & Black)',
      description: 'Year: 2022 \nHaptic feedBack, Adaptive triggers, Built-in microphone and headset jack \nCreate button, Signature comfort, Family features \nBuilt-in-battery, Integrated speaker, Motion sensor'
    ),
    Product(
      quantity: 1,
      id: 2,
      amount: 55000,
      image: 'asset/images/games 2.jpg',
      title:'DualSense 5 Controller',
      condition: 'Brand New',
      capacity: '',
      color: 'Color: Black',
      description: 'Year: 2022 \nHaptic feedBack, Adaptive triggers, Built-in microphone and headset jack \nCreate button, Signature comfort, Family features \nBuilt-in-battery, Integrated speaker, Motion sensor'
    ),
    Product(
      quantity: 1,
      id: 3,
      amount: 290000,
      image: 'asset/images/series7.jpeg',
      title: 'iWatch Series 7',
      condition: 'Brand New',
      capacity: 'Capacity: 1GB RAM',
      color: 'White',
      description: 'Year: 2022, Model A2478, Bluetooth: 5.0 A2DP LE, RAM: 1GB, ROM: 32GB eMMc 5.1, Battery: Li-Ion 309 mAh(wireless charging), Loudspeaker: Yes(without 3.5mm jack) WLAN: WiFi 802.11(dual band), GPS: Yes \nOS: watch 8.7(upgradable to 9.0), Size: 45mm, Weight: 38.8g, Technology: GPS + Cellular(GSM/HSPA/LTE) \nSensor: Accelerometer, gyro, heart rate, barometer, always-on, altimeter, compass, SpO2, VO2max, talking mode, UWB support \n SIM: eSIM, IP6X certified, Resolution: 484 x 396 pixels, Protection: Ion-X strengthened glass, Chipset: Apple S7, CPU: Dual Core, GPU: PowerVR, Others: 50m water resistant, ECG certified,'
    ),
    Product(
      quantity: 1,
      id: 4,
      amount: 1500000,
      image: 'asset/images/dell_alienware_m15_r7.jpg',
      title: 'Alienware M15 R7',
      condition: 'Brand New',
      capacity: 'Capacity: 1TB SSD',
      color: 'Color: Black',
      description: 'Year: 2022, Brand: Dell, Processor: AMD Ryzen 9, RAM: 16GB, ROM: 1TB SSD, Graphics: NVIDIA GeForce Rtx 3070-4GB GDDR6 VRAM, OS: Windows 11 \nDisplay:15.6''(non-touch) FHD Advanced Optimus, Battery: 6 Cell 86Wh integrated'
    ),
    Product(
      quantity: 1,
      id: 5,
      amount: 2700000,
      image: 'asset/images/laptop.jpg',
      title: 'Razer Blade 17',
      condition: 'Brand New',
      capacity: 'Capacity: 1TB SSD',
      color: 'Color: Matte Black',
      description: 'Year: 2022, Model: Razer Blade 17, Processor: Intel Core i7-12800H - QHD 240Hz - GeForce Rtx 3080 Ti-16GB GDDR6 VRAM, RAM: 32GB, ROM: 1TB SSD, OS: Windows Hello \nDisplay:17.3''(non-touch) - IPS-QHD - G-Sync - 240Hz - 1440p, Battery: 82Wh battery'
    ),
    Product( ///
      quantity: 1,
      id: 6,
      amount: 700000,
      image: 'asset/images/phones.jpg',
      title: 'iPhone 13 Pro ',
      condition: 'Brand New',
      capacity: '128GB',
      color: 'Color: Silver',
      description: 'Year: 2021,  Display: 6.1'', 2532 x 1170 pixels, 19.5:9 ratio, 457 PPI, 120Hz, \nRAM: 6GB, ROM: 128GB, Battery: Li-Ion 3095mAh, FaceID: Yes, '
    ),
    Product(  ////change image
      quantity: 1,
      id: 7,
      amount: 820000,
      image: 'asset/images/hp_x360.jpg',
      title: "Hp Envy x360 Convertible",
      condition: 'Brand New',
      capacity: '512GB SSD',
      color: 'Color: Natural Silver',
      description: 'Year: 2021 \nModel: HP ENVY x360 2-in-1 \nScreen size: 15.6 inches touch screen \nRAM: 16GB, Processor: Intel Core i7, OS: Windows 11'
    ),
    Product(
      quantity: 1,
      id: 8,
      amount: 175000,
      image: 'asset/images/hp_folio_9470m.jpg',
      title: "Hp Folio 9470m",
      condition: 'Brand New',
      capacity: '500GB SSD',
      color: 'Color: Silver',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(  ////
      quantity: 1,
      id: 9,
      amount: 650000,
      image: 'asset/images/hp_pavilion_15.jpg',
      title: "Hp Pavilion 15",
      condition: 'Brand New',
      capacity: '512GB  SSD',
      color: 'Color: Silver',
      description: 'RAM: 16GB \nDespite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ), 
    Product(
      quantity: 1,
      id: 10,
      amount: 890000,
      image: 'asset/images/samsung_s22_ultra.jpg',
      title: "Samsung S22 Ultra",
      condition: 'Brand New',
      capacity: '256GB',
      color: 'Color: White',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 11,
      amount: 800000,
      image: 'asset/images/samsung_s22.jpg',
      title: "Samsung S22",
      condition: 'Brand New',
      capacity: '256GB',
      color: 'Color: Baby Pink',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 12,
      amount: 720000,
      image: 'asset/images/pixel_6_pro.jpg',
      title: "Google Pixel 6 Pro",
      condition: 'Brand New',
      capacity: '256GB',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 13,
      amount: 500000,
      image: 'asset/images/pixel_6.jpg',
      title: "Google Pixel 6 ",
      condition: 'Brand New',
      capacity: '256GB',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 14,
      amount: 1200000,
      image: 'asset/images/lenovo_legion_5pro.jpg',
      title: "Lenovo Legion 5 Pro",
      condition: 'Brand New',
      capacity: 'Capacity: 1TB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 15,
      amount: 1000000,
      image: 'asset/images/lenovo_legion_5.jpg',
      title: "Lenovo Legion 5",
      condition: 'Brand New',
      capacity: 'Capacity: 512GB SSD',
      color: 'Color: Black',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    Product(
      quantity: 1,
      id: 16,
      amount: 810000,
      image: 'asset/images/hp_envy_x360_15.jpg',
      title: "Hp Envy x360 15",
      condition: 'Brand New',
      capacity: 'Capacity: 512GB SSD',
      color: 'Color: Silver',
      description: 'Despite the storms, beauty arrives like it was always going to regardless of the darkness.'
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    var ccart = Provider.of<CartModel>(context);  //w.r.t. provider for cart
    return Scaffold(
      backgroundColor: Colors.white,   //Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,  //Colors.white, 
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), 
            );
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              suggestionsOnSearch.clear();
              textController!.clear();
              setState(() {
                textController!.text = '';
              });
            }, 
            icon: const Icon(CupertinoIcons.clear_circled, color: Colors.black),
          )
        ],
        title: Container(
          decoration: BoxDecoration(
            //color: Colors.transparent,
            border: Border.all(
              color: Colors.black,
              //style: BorderStyle.solid //optional
            ),
            borderRadius: BorderRadius.circular(15),         
          ),
          
          child: TextField(
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              // Applied 'setState' to invoke changes  //error coming from here
              setState(() {
                //suggestionsOnSearch //certified
                suggestionsOnSearch = suggestions.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
              });
            },
            enableSuggestions: true,
            autocorrect: true,
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15), //10
              hintStyle: GoogleFonts.belleza(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
              hintText: 'Search Products...',
              prefixIcon: Icon(CupertinoIcons.search, color: defaultColor),
              //labelStyle: ,
              //hintStyle: ,
              //labelStyle: TextStyle(color: Colors.blue),
              //labelText: 'example@domain.com',
            ),
          ),
        ), 
      ),

      //something is wrong here
      //suggestions  &&
      body: textController!.text.isNotEmpty && suggestionsOnSearch.isEmpty? Center(  //certified
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, color: Colors.black, size: 70,),
            Text(
              'No results found!', 
              style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)
            )  
          ],
        ),
      ) :ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: textController!.text.isNotEmpty? suggestionsOnSearch.length :suggestionsOnSearch.length, //certified  //suggestions.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)  
            ),
            child: ListTile(
              onTap: () {},
              //contentPadding: EgdeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white),
              ),
              tileColor: Colors.white,
              //all below formerly suggestions     //certified
              title: Text(suggestionsOnSearch[index].title, style: GoogleFonts.belleza(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text("N${suggestionsOnSearch[index].amount.toString()}", style: GoogleFonts.belleza(color: Colors.black,)),
              leading: Image.asset(suggestionsOnSearch[index].image),
              trailing: IconButton(
                icon: Icon(CupertinoIcons.cart_fill, color: defaultColor),
                onPressed: () {
                  ccart.add(suggestionsOnSearch[index]); //suggestions  //certified
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()), 
                  );
                  //snackkbar
                  //ScaffoldMessenger.of(context).showSnackBar(
                    //SnackBar(
                      //duration: Duration(seconds: 2), //newly added
                      //padding: EdgeInsets.all(16),  //newly added
                      //content: Text("${suggestionsOnSearch[index].title} Has Been Added To Your Cart!", style: GoogleFonts.belleza(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold),),
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
              ),                         
            )
          );
        }
      ),
    );
  }
}