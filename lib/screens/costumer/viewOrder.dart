import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/appBar.dart';

class ViewOrderScreen extends StatefulWidget {
  @override
  _ViewOrderScreenState createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: createDrawer(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('order').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Orders",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      (snapshot.data.docs[index].data());
                  return ListTile(
                    leading: Text(
                      data['name'],
                      style: TextStyle(fontSize: 28.0),
                    ),
                    trailing: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        data['status'],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
