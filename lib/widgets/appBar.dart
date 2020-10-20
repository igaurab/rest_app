import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/constants/strtings.dart';

AppBar buildAppBar({BuildContext context}) {
  return AppBar(
    leading: IconButton(
      icon: Icon(FeatherIcons.menu),
      onPressed: () => {},
    ),
    title: Text(AppString.resturantName),
    elevation: 0,
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CartScreen(),
          //   ),
          // );
        },
        icon: Icon(FeatherIcons.shoppingCart),
      ),
      IconButton(
        onPressed: () => {},
        icon: Icon(FeatherIcons.search),
      )
    ],
  );
}
