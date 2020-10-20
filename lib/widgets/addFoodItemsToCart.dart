import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/providers/OrderProvider.dart';
import 'package:protoype/models/food_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFoodItemToCart extends StatefulWidget {
  final FoodItem foodItem;
  const AddFoodItemToCart({
    this.foodItem,
    Key key,
  }) : super(key: key);

  @override
  _AddFoodItemToCartState createState() => _AddFoodItemToCartState();
}

class _AddFoodItemToCartState extends State<AddFoodItemToCart> {
  int itemChanged;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    prefs = await SharedPreferences.getInstance();
    itemChanged = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.foodItem.name,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$ ${widget.foodItem.price.toString()}",
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "x ${itemChanged.toString()}",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 25.0,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(5.0)),
                  child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        FeatherIcons.plus,
                        size: 18,
                      ),
                      onPressed: () {
                       
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(5.0)),
                  child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        FeatherIcons.minus,
                        size: 18,
                      ),
                      onPressed: () {
                        
                      }),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
