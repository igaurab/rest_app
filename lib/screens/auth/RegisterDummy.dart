import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:protoype/widgets/appBar.dart';

class RegisterDummy extends StatefulWidget {
  @override
  _RegisterDummyState createState() => _RegisterDummyState();
}

class _RegisterDummyState extends State<RegisterDummy> {
  int _value = 1;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      drawer: createDrawer(context),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration:
                    InputDecoration(hintText: "Name", labelText: "Name"),
              ),
              TextFormField(
                controller: _email,
                validator: (email) => EmailValidator.validate(email)
                    ? null
                    : "Invalid email address",
                decoration: InputDecoration(
                    hintText: "Email Address", labelText: "Email"),
              ),
              DropdownButtonFormField(
                  value: 1,
                  items: [
                    DropdownMenuItem(
                      child: Text("Admin"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Chef"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Waiter"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Costumer"),
                      value: 4,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) return 'Empty';
                  return null;
                },
                obscureText: true,
                controller: _pass,
                decoration: InputDecoration(
                    hintText: "Enter Password", labelText: "Password"),
              ),
              TextFormField(
                controller: _confirmPass,
                validator: (val) {
                  if (val.isEmpty) return 'Empty';
                  if (val != _pass.text) return 'Passwords do not match';
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password"),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Fluttertoast.showToast(
                        msg: "User Registration Successful",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIos: 1,
                        fontSize: 16.0);
                  }
                },
                child: Text("Submit",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
