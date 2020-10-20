import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayMenu extends StatefulWidget {
  @override
  _DisplayMenuState createState() => _DisplayMenuState();
}

class _DisplayMenuState extends State<DisplayMenu> {
  int activeIndex = 0;
  CollectionReference menu = FirebaseFirestore.instance.collection('menu');

  @override
  Widget build(BuildContext context) {
    return Container(
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
              children: [
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
                                    ? Colors.blueAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              category,
                              style: TextStyle(
                                  color: index == activeIndex
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 22.0),
                            ),
                          ),
                        );
                      }),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeCategoryData.length,
                  itemBuilder: (context, index) {
                    var item = activeCategoryData[index];
                    return ListTile(
                      title: Text(
                        item['name'].toString(),
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "\$ ${item['price']}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800),
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
    );
  }
}
