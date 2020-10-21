import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/cardWithCenterText.dart';

class ChefHomeScreen extends StatefulWidget {
  @override
  _ChefHomeScreenState createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  CollectionReference orders;
  @override
  void initState() {
    super.initState();
    orders = FirebaseFirestore.instance.collection('orders');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Container(
          padding: EdgeInsets.all(25.0),
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
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
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey[200],
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            "\tOrder id: ${orders[j]}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      items['name'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        switch (
                                                            items['status']) {
                                                          case AppString
                                                              .foodStatusInqueue:
                                                            {
                                                              items['status'] =
                                                                  AppString
                                                                      .foodStatusStarted;
                                                            }
                                                            break;
                                                          case AppString
                                                              .foodStatusStarted:
                                                            {
                                                              items['status'] =
                                                                  AppString
                                                                      .foodStatus25;
                                                            }
                                                            break;
                                                          case AppString
                                                              .foodStatus25:
                                                            {
                                                              items['status'] =
                                                                  AppString
                                                                      .foodStatus50;
                                                            }
                                                            break;
                                                          case AppString
                                                              .foodStatus50:
                                                            {
                                                              items['status'] =
                                                                  AppString
                                                                      .foodStatus75;
                                                            }
                                                            break;
                                                          case AppString
                                                              .foodStatus75:
                                                            {
                                                              items['status'] =
                                                                  AppString
                                                                      .foodStatusFinished;

                                                              var documentRef =
                                                                  FirebaseFirestore
                                                                      .instance;
                                                              Map<String,
                                                                      dynamic>
                                                                  _data = {
                                                                'client_id':
                                                                    clients[i]
                                                                        .toString(),
                                                                'foodName':
                                                                    items[
                                                                        'name'],
                                                                'delivered':
                                                                    'false',
                                                              };
                                                              documentRef
                                                                  .collection(
                                                                      'waiter')
                                                                  .doc(data[
                                                                      'client_id'])
                                                                  .set(_data);
                                                            }
                                                            break;
                                                          case AppString
                                                              .foodStatusFinished:
                                                            {
                                                              print(
                                                                  "Finisehd Food Item Notify to waiter");
                                                            }
                                                            break;
                                                          default:
                                                            {
                                                              print(
                                                                  "No default cases");
                                                            }
                                                            break;
                                                        }

                                                        Map<String, dynamic>
                                                            _temp = {};

                                                        data.forEach(
                                                            (key, value) {
                                                          print(key);
                                                          _temp[key] =
                                                              data[key];
                                                        });
                                                        Map<String, dynamic>
                                                            _data = {
                                                          orders[i].toString():
                                                              _temp
                                                        };
                                                        // print("TEMP");
                                                        // print(_data);
                                                        // print('Order id: ' +
                                                        //     orders[i]
                                                        //         .toString());
                                                        // print('Food id: ' +
                                                        //     items['id']
                                                        //         .toString());
                                                        // print('Item: ' +
                                                        //     data[dataKeys[k]]
                                                        //         .toString());

                                                        var doc =
                                                            FirebaseFirestore
                                                                .instance;
                                                        doc
                                                            .collection(
                                                                'orders')
                                                            .doc(clients[i])
                                                            .update(_data);
                                                      },
                                                      child: Text(
                                                        items['status'],
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    );
                                  })
                            ],
                          );
                        })
                  ],
                ),
              );
            },
          )),
    );
  }
}
