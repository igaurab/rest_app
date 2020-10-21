import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:protoype/screens/admin/addMenu.dart';

class CostumerDataForm extends StatefulWidget {
  @override
  _CostumerDataFormState createState() => _CostumerDataFormState();
}

class _CostumerDataFormState extends State<CostumerDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = GlobalKey<FormFieldState<String>>();
  final _number = GlobalKey<FormFieldState<String>>();
  final _email = GlobalKey<FormFieldState<String>>();
  final _address = GlobalKey<FormFieldState<String>>();

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
                  "Costumer Details ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                customTextFormField(hintText: "Name", key: _name),
                customTextFormField(hintText: "Mobile Number", key: _number),
                customTextFormField(hintText: "Email Address ", key: _email),
                customTextFormField(hintText: "Location ", key: _address),
                SizedBox(
                  height: 20.0,
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
                      String name = _name.currentState.value;
                      String email = _email.currentState.value;
                      String mobile = _number.currentState.value;
                      String address = _address.currentState.value;

                      Map<String, dynamic> data = {
                        'name': name,
                        'email': email,
                        'mobile': mobile,
                        'address': address
                      };

                      FirebaseFirestore.instance
                          .collection('costumer_data')
                          .doc()
                          .set(data);
                      Navigator.of(context).pushNamed(
                        '/thank_you_screen',
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
