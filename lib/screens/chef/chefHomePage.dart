import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/widgets/appBar.dart';

class ChefHomeScreen extends StatefulWidget {
  @override
  _ChefHomeScreenState createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void changeFooStatusAndUpload(
        Map<String, dynamic> data, String id, String status) {
      data['status'] = status;
      FirebaseFirestore.instance.collection('order').doc(id).update(data);
    }

    void notifyWaiter({String clientId, String foodName}) {
      var documentRef = FirebaseFirestore.instance;
      Map<String, dynamic> _data = {
        'client_id': clientId,
        'foodName': foodName,
        'delivered': 'false',
      };
      documentRef.collection('waiter').doc().set(_data);
    }

    return Scaffold(
      drawer: createDrawer(context),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder<QuerySnapshot>(
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
                        onPressed: () {
                          String id = snapshot.data.docs[index].id;
                          if (data['status'] == AppString.foodStatusInqueue) {
                            changeFooStatusAndUpload(
                                data, id, AppString.foodStatus25);
                          }
                          if (data['status'] == AppString.foodStatus25) {
                            changeFooStatusAndUpload(
                                data, id, AppString.foodStatus50);
                          }
                          if (data['status'] == AppString.foodStatus50) {
                            changeFooStatusAndUpload(
                                data, id, AppString.foodStatus75);
                          }
                          if (data['status'] == AppString.foodStatus75) {
                            changeFooStatusAndUpload(
                                data, id, AppString.foodStatusFinished);
                            notifyWaiter(
                                clientId: data['client'],
                                foodName: data['name']);
                          }
                        },
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
      ),
    );
  }
}
