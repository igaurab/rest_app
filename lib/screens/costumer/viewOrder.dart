import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/appBar.dart';
import 'package:protoype/widgets/cardWithCenterText.dart';

class ViewOrderScreen extends StatefulWidget {
  @override
  _ViewOrderScreenState createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  CollectionReference orders;

  @override
  void initState() {
    super.initState();
    orders = FirebaseFirestore.instance.collection('orders');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: createDrawer(context),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FeatherIcons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: Text("Your Orders"),
      ),
      body: Container(
          padding: EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: orders.snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return CircularProgressIndicator();
                }
                List orders = snapshots.data.docs[0].data().keys.toList();
                List clients = snapshots.data.docs.map((e) => e.id).toList();
                List<QueryDocumentSnapshot> docs = snapshots.data.docs;

                print(clients);
                print(orders);
                return Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: clients.length,
                        itemBuilder: (context, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Table No: ${clients[i]}",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (context, j) {
                                    Map<dynamic, dynamic> data =
                                        docs[i].data()[orders[j]];
                                    print("LENGHT" + data.keys.toString());
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(color: Colors.grey),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey[200],
                                          child: Text(
                                            "\tOrder id: ${orders[j]}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Divider(color: Colors.grey),
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.keys.length,
                                            itemBuilder: (context, k) {
                                              // Map<String, dynamic> data =
                                              //     docs[i].data()[orders[j]];
                                              print("DATA");
                                              List dataKeys =
                                                  data.keys.toList();
                                              Map items =
                                                  data[dataKeys[k]]['item'];
                                              print("KEY BEING USED: " +
                                                  dataKeys[k]);
                                              print("\n");
                                              return Container(
                                                margin: EdgeInsets.all(10.0),
                                                width: 10.0,
                                                child: items['status'] !=
                                                        AppString
                                                            .foodStatusFinished
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            items['name']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 28),
                                                          ),
                                                          Text(
                                                            "${items['status']}",
                                                            style: TextStyle(
                                                                fontSize: 28),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              );
                                            }),
                                      ],
                                    );
                                  })
                            ],
                          );
                        })
                  ],
                );
              },
            ),
          )),
    );
  }
}
