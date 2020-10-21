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

Drawer createDrawer(context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: Text(
              "Darbar House",
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            )),
        ListTile(
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/costumers',
            );
          },
        ),
        ListTile(
          title: Text('Login'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/pickuser',
            );
          },
        ),
        ListTile(
          title: Text('View Order Progress'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/view_order',
            );
          },
        ),
        ListTile(
          title: Text('Provide Feedback'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/feedback',
            );
          },
        ),
        ListTile(
          title: Text('Discounts and copouns'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/costumersData',
            );
          },
        ),
        ListTile(
          title: Text('Register'),
          onTap: () {},
        ),
        ListTile(
          title: Text('About Us'),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/about',
            );
          },
        ),
      ],
    ),
  );
}
