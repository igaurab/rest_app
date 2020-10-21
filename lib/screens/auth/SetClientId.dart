import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetClientId extends StatefulWidget {
  @override
  _SetClientIdState createState() => _SetClientIdState();
}

class _SetClientIdState extends State<SetClientId> {
  SharedPreferences preferences;
  bool setClinetId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
    setClinetId = false;
  }

  void _initialize() async {
    if (!preferences.containsKey('client_id')) {
      setClinetId = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _clinetId = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: _clinetId,
                maxLines: 1,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  hintText: 'Set Client/Table Id',
                ),
              ),
            ),
            RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  if (_clinetId.text.isNotEmpty) {
                    await preferences.setString('client_id', _clinetId.text);
                    Navigator.pushNamed(context, '/costumers');
                  }
                })
          ],
        ),
      ),
    );
  }
}
