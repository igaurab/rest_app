import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaiterHomeScreen extends StatefulWidget {
  @override
  WaiterHomeScreenState createState() => WaiterHomeScreenState();
}

class WaiterHomeScreenState extends State<WaiterHomeScreen> {
  CollectionReference orders;
  @override
  void initState() {
    super.initState();
    orders = FirebaseFirestore.instance.collection('waiter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waiter"),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: orders.snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            print(snapshots.data.docs[0].data().toString());
            return ListView.builder(
              itemCount: snapshots.data.docs.length,
              itemBuilder: (context, index) {
                String docId = snapshots.data.docs[index].id;

                Map<String, dynamic> item = snapshots.data.docs[index].data();
                return Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['foodName'].toString(),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Table:  ${item['client_id']}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          MaterialButton(
                            color: Colors.green[600],
                            onPressed: () {
                              item['delivered'] = "true";
                              print(docId);

                              var documentRef = FirebaseFirestore.instance;
                              documentRef
                                  .collection('waiter')
                                  .doc(docId)
                                  .update(item);
                            },
                            child: Text(
                              "Delivered",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
