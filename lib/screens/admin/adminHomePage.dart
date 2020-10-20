import 'package:flutter/material.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/widgets.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(AppString.welcomeAdmin,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardWithCenterText(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/showAdminMenu',
                    );
                  },
                  gradient:
                      returnGradient([Colors.blueAccent, Colors.blue[300]]),
                  text: AppString.menu,
                ),
                CardWithCenterText(
                  gradient:
                      returnGradient([Colors.orangeAccent, Colors.orange[300]]),
                  text: AppString.orders,
                ),
                CardWithCenterText(
                  gradient:
                      returnGradient([Colors.greenAccent, Colors.green[300]]),
                  text: AppString.transaction,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
