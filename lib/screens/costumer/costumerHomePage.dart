import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/data/dummy_data.dart';
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var provider = Provider.of<OrderProvider>(context, listen: true);
    setState(() {
      totalCartItems = provider.totalOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    TextTheme textTheme = Theme.of(context).textTheme;

    var provider = Provider.of<OrderProvider>(context, listen: true);
    setState(() {
      totalCartItems = provider.totalOrders;
    });
    return Scaffold(
        key: _scaffoldKey,
        drawer: createDrawer(context),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FeatherIcons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
                            provider.totalOrders.toString(),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.todaySpecial,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 250,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dummyData.foodItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              child: GestureDetector(
                                  onTap: () => {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          dummyData.foodItems[index].imageUrl,
                                          height: 160,
                                          width: 250,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dummyData.foodItems[index].name,
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$ ${dummyData.foodItems[index].price}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
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
                                          ? Colors.blue[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                        color: index == activeIndex
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 24.0),
                                  ),
                                ),
                              );
                            }),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: activeCategoryData.length,
                        itemBuilder: (context, index) {
                          var item = activeCategoryData[index];
                          // FoodItem foodItem = FoodItem.fromJson(item);
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                            ),
                            child: ListTile(
                              trailing: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.blue,
                                      Colors.blue[700]
                                    ]),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: MaterialButton(
                                  onPressed: () async {
                                    provider.changeItem(
                                        foodId: item['id'], item: item);
                                    print(provider.orders);
                                    setState(() {
                                      totalCartItems++;
                                    });
                                  },
                                  child: Text(
                                    'Order',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.transparent,
                                    ),
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      item['name'].toString(),
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.transparent,
                                    ),
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "\$ ${item['price']}",
                                      style: TextStyle(
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
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
          ),
        ));
  }
}
