import 'package:flutter/material.dart';
import 'package:protoype/screens/ErrorPage.dart';
import 'package:protoype/screens/PickUserScreen.dart';
import 'package:protoype/screens/admin/MenuScreen.dart';
import 'package:protoype/screens/admin/addMenu.dart';
import 'package:protoype/screens/admin/adminHomePage.dart';
import 'package:protoype/screens/chef/chefHomePage.dart';
import 'package:protoype/screens/costumer/cartScreen.dart';
import 'package:protoype/screens/costumer/costumerData.dart';
import 'package:protoype/screens/costumer/costumerHomePage.dart';
import 'package:protoype/screens/costumer/thankyou.dart';
import 'package:protoype/screens/waiter/waiterHomePage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PickUserScreen());
      case '/admin':
        return MaterialPageRoute(builder: (_) => AdminHomeScreen());
      case '/showAdminMenu':
        return MaterialPageRoute(builder: (_) => MenuScreen());
      case '/addMenu':
        return MaterialPageRoute(builder: (_) => AddMenuScreen());
      case '/costumers':
        return MaterialPageRoute(builder: (_) => CostumerHomeScreen());
      case '/costumersData':
        return MaterialPageRoute(builder: (_) => CostumerDataForm());
      case '/thank_you':
        return MaterialPageRoute(builder: (_) => ThankYou());
      case '/chef':
        return MaterialPageRoute(builder: (_) => ChefHomeScreen());
      case '/waiter':
        return MaterialPageRoute(builder: (_) => WaiterHomeScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return ErrorPage();
    });
  }
}
