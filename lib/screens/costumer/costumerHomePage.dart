import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/models/food_item.dart';
import 'package:protoype/providers/OrderProvider.dart';
import 'package:protoype/widgets/addFoodItemsToCart.dart';
import 'package:protoype/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CostumerHomeScreen extends StatefulWidget {
  @override
  _CostumerHomeScreenState createState() => _CostumerHomeScreenState();
}

class _CostumerHomeScreenState extends State<CostumerHomeScreen> {
  int activeIndex = 0;
  CollectionReference menu = FirebaseFirestore.instance.collection('menu');
  SharedPreferences prefs;
  int totalCartItems = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FeatherIcons.menu),
            onPressed: () => {},
          ),
          title: Text(AppString.resturantName),
          elevation: 0,
          centerTitle: true,
          actions: [
            Row(
              children: [
                totalCartItems != 0
                    ? Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            totalCartItems.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ))
                    : Container(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/cart');
                  },
                  icon: Icon(FeatherIcons.shoppingCart),
                ),
              ],
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(FeatherIcons.search),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: menu.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('got data');

                var data = snapshot.data;
                // print(data.docs[0].data().values.toList()[0]['category']);
                var activeCategoryData =
                    data.docs[activeIndex].data().values.toList();
                return Column(
                  children: [
                    Container(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            var category = data.docs[index]
                                .data()
                                .values
                                .toList()[0]['category'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: index == activeIndex
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                      color: index == activeIndex
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 22.0),
                                ),
                              ),
                            );
                          }),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: activeCategoryData.length,
                      itemBuilder: (context, index) {
                        var item = activeCategoryData[index];
                        // FoodItem foodItem = FoodItem.fromJson(item);
                        return ListTile(
                          trailing: MaterialButton(
                            onPressed: () async {
                              provider.changeItem(
                                  foodId: item['id'], item: item);
                              print(provider.orders);
                              setState(() {
                                totalCartItems++;
                              });
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Text(
                            item['name'].toString(),
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "\$ ${item['price']}",
                              style: TextStyle(
                                  fontSize: 26.0, fontWeight: FontWeight.w800),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Container();
            },
          ),
        ));
  }
}
