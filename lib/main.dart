import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:protoype/providers/ItemUpload.dart';
import 'package:protoype/providers/OrderProvider.dart';
import 'package:protoype/routes/routeGenerator.dart';
import 'package:protoype/screens/ErrorPage.dart';
import 'package:protoype/screens/PickUserScreen.dart';
import 'package:protoype/screens/admin/MenuScreen.dart';
import 'package:protoype/screens/admin/addMenu.dart';
import 'package:protoype/screens/auth/firebaseAuthDemo.dart';
import 'package:protoype/screens/chef/chefHomePage.dart';
import 'package:protoype/screens/costumer/costumerHomePage.dart';
import 'package:protoype/screens/waiter/waiterHomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ItemUpload()),
        ChangeNotifierProvider.value(value: OrderProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return ErrorPage();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return PickUserScreen();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
