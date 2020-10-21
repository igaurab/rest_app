import 'package:flutter/material.dart';
import 'package:protoype/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefineRole extends StatefulWidget {
  @override
  _DefineRoleState createState() => _DefineRoleState();
}

class _DefineRoleState extends State<DefineRole> {
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Enter Password",
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    hintText: "Enter Password", labelText: "Password"),
              ),
            ),
            Spacer(),
            Container(
              height: 70,
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {
                  String pass = _password.value.text;
                  String admin = prefs.getString('admin_pass');
                  if (pass == admin) {
                    Navigator.of(context).pushNamed(
                      '/admin',
                    );
                    return;
                  }
                  String chef = prefs.getString('chef_pass');
                  if (pass == chef) {
                    Navigator.of(context).pushNamed(
                      '/chef',
                    );
                    return;
                  }
                  String waiter = prefs.getString('waiter_pass');
                  if (pass == waiter) {
                    Navigator.of(context).pushNamed(
                      '/waiter',
                    );
                    return;
                  }
                  Navigator.of(context).pushNamed('/');
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
