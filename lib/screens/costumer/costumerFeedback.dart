import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/screens/admin/addMenu.dart';

class CostumerFeedbackForm extends StatefulWidget {
  @override
  _CostumerFeedbackFormState createState() => _CostumerFeedbackFormState();
}

class _CostumerFeedbackFormState extends State<CostumerFeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final feedbackController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(FeatherIcons.arrowLeft),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Feedback ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: feedbackController,
                  maxLines: 15,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    hintText: "Let us know how you feel",
                  ),
                ),
                Spacer(),
                Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Map<String, dynamic> data = {
                        'feedback': feedbackController.value.text ?? ''
                      };
                      print(data);
                      FirebaseFirestore.instance
                          .collection('costumer_feedback')
                          .doc()
                          .set(data);
                      Navigator.of(context).pushNamed(
                        '/thank_you',
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
