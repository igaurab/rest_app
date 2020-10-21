import 'package:flutter/material.dart';
import 'package:protoype/widgets/appBar.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: createDrawer(context),
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Us",
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Thanks for visitng Darbar. We are happy to see you and serve you in near future.",
              style: TextStyle(fontSize: 29),
            )
          ],
        ),
      ),
    );
  }
}
