import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:random_string/random_string.dart';

class OrderProvider with ChangeNotifier {
  Map<String, dynamic> orders = Map<String, dynamic>();
  int totalOrders = 0;
  double totalPrice = 0;
  List<String> foodItems = [];

  double getTotalPrice() {
    double total = 0;
    orders.forEach((key, value) {
      Map<String, dynamic> elem = orders[key]['item'];
      print(elem);
      total = total + (double.parse(elem['price']) * orders[key]['count']);
    });
    print(orders);
    print("Total: " + total.toString());
    return total;
  }

  void changeItem({String foodId, Map item, remove = false}) {
    bool isPresent = orders.containsKey(foodId);
    if (isPresent) {
      int count = orders[foodId]['count'];
      if (remove && count == 1) {
        orders.remove(foodId);
        foodItems.remove(foodId);
        totalOrders -= 1;
        totalPrice = getTotalPrice();
        notifyListeners();
        return;
      }
      if (remove && count > 1) {
        orders[foodId]['count'] -= 1;
        totalOrders -= 1;
        totalPrice = getTotalPrice();

        notifyListeners();

        return;
      }
      orders[foodId]['count'] += 1;
      totalOrders += 1;
      totalPrice = getTotalPrice();

      notifyListeners();
    } else {
      item['status'] = AppString.foodStatusInqueue;
      Map<String, dynamic> value = {'item': item, 'count': 1};
      orders[foodId] = value;
      foodItems.add(foodId);
      totalOrders += 1;
      totalPrice = getTotalPrice();

      notifyListeners();
    }
    notifyListeners();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  placeOrder() async {
    //TODO: Add Seperate client id's

    String clientId = "1";
    var documentRef = FirebaseFirestore.instance;
    String orderId = randomNumeric(10).toString();
    Map<String, dynamic> _data = {orderId: orders};
    print(_data);

    

    await documentRef.collection('orders').doc(clientId).get().then((value) {
      if (value.exists) {
        documentRef.collection('orders').doc(clientId).update(_data);
      } else {
        documentRef.collection('orders').doc(clientId).set(_data);
      }
    });
    print('Placed Order');
    orders.clear();
    totalOrders = 0;
    totalPrice = 0;
    foodItems.clear();
    notifyListeners();
  }
}
