import 'package:flutter/material.dart';
import 'package:protoype/constants/assets.dart';

class ThankYou extends StatelessWidget {
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
