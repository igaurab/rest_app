import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:protoype/constants/assets.dart';
import 'package:protoype/providers/OrderProvider.dart';
import 'package:protoype/widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutDummyForm extends StatefulWidget {
  @override
  _CheckoutDummyFormState createState() => _CheckoutDummyFormState();
}

class _CheckoutDummyFormState extends State<CheckoutDummyForm>
    with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardid = TextEditingController();
  final TextEditingController _cvc = TextEditingController();
  final TextEditingController _total = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
        drawer: createDrawer(context),
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (val) {
                    if (val.length != 16) return 'Must be 16 digits';
                    return null;
                  },
                  controller: _cardid,
                  decoration: InputDecoration(
                      hintText: "Enter 16 digit card number",
                      labelText: "Card Number"),
                ),
                TextFormField(
                  validator: (val) {
                    if (val.length != 3) return 'Must be 3 digits';
                    return null;
                  },
                  controller: _cvc,
                  decoration: InputDecoration(
                      hintText: "Enter 3 digit CVC number",
                      labelText: "CVC Number"),
                ),
                TextFormField(
                  validator: (val) {
                    if (double.parse(val) <= provider.totalPrice)
                      return 'Value less than total bill price';
                    return null;
                  },
                  controller: _total,
                  decoration: InputDecoration(
                      hintText: "Enter amount", labelText: "Amount"),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Total: \$ ${provider.totalPrice}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Container(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        provider.orders.clear();
                        provider.totalOrders = 0;
                        provider.totalPrice = 0;
                        provider.foodItems.clear();
                        provider.notifyListeners();

                        Fluttertoast.showToast(
                            msg: "Payement Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIos: 1,
                            fontSize: 16.0);
                        Navigator.of(context).pushNamed(
                          '/costumers',
                        );
                      }
                    },
                    child: Text(
                      "Pay",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Or Pay with ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://www.paypal.com/';
                        if (await canLaunch(url)) {
                          await launch(url);
                          provider.orders.clear();
                          provider.totalOrders = 0;
                          provider.totalPrice = 0;
                          provider.foodItems.clear();
                          provider.notifyListeners();
                          Navigator.of(context).pushNamed(
                            '/costumers',
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Image.asset(ImageAsset.paypal),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
