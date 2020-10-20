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
    setState(() {
      provider = Provider.of<OrderProvider>(context, listen: true);
      orders = provider.orders;
      double total = 0;
      orders.forEach((key, value) {
        Map<String, dynamic> elem = orders[key]['item'];
        total += double.parse(elem['price']);
      });
      totalPrice = total;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.foodItems.length,
                    itemBuilder: (context, index) {
                      String item = provider.foodItems[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            orders[item]['item']['name'],
                            style: TextStyle(
                                fontSize: 42, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                provider.orders[item]['count'].toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              MaterialButton(
                                  child: Container(
                                    child: Icon(FeatherIcons.plus),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      provider.changeItem(foodId: item);
                                      orders = provider.orders;
                                      double total = 0;
                                      orders.forEach((key, value) {
                                        total += value['count'] *
                                            double.parse(
                                                orders[key]['item']['price']);
                                      });
                                      totalPrice = total;
                                      print(totalPrice.toString());
                                    });
                                  }),
                              MaterialButton(
                                  child: Container(
                                    child: Icon(FeatherIcons.minus),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      provider.changeItem(
                                          foodId: item, remove: true);
                                      orders = provider.orders;
                                      double total = 0;
                                      orders.forEach((key, value) {
                                        total += value['count'] *
                                            double.parse(
                                                orders[key]['item']['price']);
                                      });
                                      totalPrice = total;
                                      print(totalPrice.toString());
                                    });
                                  }),
                            ],
                          ),
                        ],
                      );
                    })),
            Text(totalPrice.toString()),
            Container(
                child: MaterialButton(
                    child: Text("Order Now"),
                    onPressed: () {
                      provider.placeOrder();
                    }))
          ],
        ),
      ),
    );
  }
}
