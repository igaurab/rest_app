import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/widgets.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: createDrawer(context),
      appBar: AppBar(
        title: Text("Admin Menu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.menu,
                    style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3),
                  ),
                  IconWithText(
                    onTap: () => Navigator.of(context).pushNamed(
                      '/addMenu',
                    ),
                    text: Text(
                      AppString.addMenuItem,
                      style: TextStyle(fontSize: 24),
                    ),
                    icon: Icon(
                      FeatherIcons.plusSquare,
                      size: 32,
                    ),
                  )
                ],
              ),
              DisplayMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
