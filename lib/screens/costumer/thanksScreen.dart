import 'package:flutter/material.dart';
import 'package:protoype/constants/assets.dart';

class ThanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              height: 300,
              width: 300,
              child: Image.asset(ImageAsset.thanks),
            ),
            Text(
              "Thank You",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "We'll notify you of our deals or coupons",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            Spacer(),
            Container(
                height: 70.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/costumers',
                      arguments: 'Hello there from the first page!',
                    );
                  },
                  child: Text(
                    "Back to Home",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
