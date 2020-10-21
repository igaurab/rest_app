import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/providers/OrderProvider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OrderProvider provider;
  Map<String, dynamic> orders = Map<String, dynamic>();
  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    setState(() {
      provider = Provider.of<OrderProvider>(context, listen: true);
      orders = provider.orders;
      totalPrice = provider.totalPrice;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Orders",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.foodItems.length,
                    itemBuilder: (context, index) {
                      String item = provider.foodItems[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orders[item]['item']['name'],
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "\$ ${orders[item]['item']['price']}",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  child: Container(
                                    child: Icon(FeatherIcons.plus),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      provider.changeItem(foodId: item);
                                      totalPrice = provider.totalPrice;
                                    });
                                  }),
                              Text(
                                "x",
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                provider.orders[item]['count'].toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              MaterialButton(
                                  child: Container(
                                    child: Icon(FeatherIcons.minus),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      provider.changeItem(
                                          foodId: item, remove: true);
                                      totalPrice = provider.totalPrice;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      );
                    })),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 32.0),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "\$ ${totalPrice.toString()}",
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 32.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                height: 70,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: MaterialButton(
                    disabledColor: Colors.grey[400],
                    child: Text(
                      totalPrice == 0 ? "No items in cart" : "Order Now",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    onPressed: totalPrice == 0
                        ? (null)
                        : () async {
                            await provider.placeOrder();
                            Navigator.pop(context);
                          }))
          ],
        ),
      ),
    );
  }
}
