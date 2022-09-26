// Courtesy of "https://github.com/edocbuhtig/flutter-ecommerce-provider/blob/master/lib/screens/cartview.dart"
import 'package:flutter/material.dart';
import 'package:eloka_app/Product.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends ChangeNotifier {
  //empty list "_products" and it's getter
  final List<Product> _products = [];
  List<Product> get cartItems {
    return _products;
  }
  
  int get japhet => _products.fold(0, (total, current) =>total +  current.quantity); //(total == 0, i.e 0 + 1 * whatever quantity)

  //total for price and it's getter
  int _totalPrice = 0; //formerly dynamic
  int get totalPrice {
    return _totalPrice;
  }


  //getter subtotal for price
  int get subtotal => _products.fold(0, (total, current) => total + current.amount * current.quantity); //(total == 0) by default,


  //delivery fee and it's getter
  int deliveryFee(subtotal) {
    if (subtotal == 0) {
      return 0;
    } else if (subtotal >= 500000) {
      return 5000; //return 0.0;  //set this to return 0 if you wat to do discounts
    } else {
      return 5000;
    }
  }
  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);


  //total for price and it's getter
  int total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }
  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);


  //void function that adds items to the empty list "_products"
  void add(Product item) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.get(item.title);
    prefs.setString('item_title', item.title);
    print('saved SetString: ${item.title}');
    print('saved getString: ${item.title}');
    if (_products.contains(item)) {
      Get.snackbar(item.title, "is already added to your cart!");
    } else {
      _products.add(item);
      _totalPrice += item.amount;
    }
    notifyListeners();
  }


  //void function that removes items from the list "_products"
  void remove(Product item) {
    _totalPrice -= item.amount;
    _products.remove(item);
    //Get.snackbar(item.title, "removed from your cart!");
    notifyListeners();
  }


  //count getter that tells how many items we have in the list "_products".
  int get count {
    return _products.length;
  }

  
}
