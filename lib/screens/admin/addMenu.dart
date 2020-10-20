import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:protoype/constants/strtings.dart';
import 'package:protoype/providers/ItemUpload.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class AddMenuScreen extends StatefulWidget {
  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  File _image;
  final picker = ImagePicker();

  _imgFromCamera(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var itemUpload = Provider.of<ItemUpload>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FeatherIcons.camera),
        onPressed: () {
          _showPicker(context);
          itemUpload.image = _image;
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: MyCustomForm(image: _image),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final File image;
  MyCustomForm({this.image});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(image: this.image);
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final File image;
  MyCustomFormState({this.image});

  final _formKey = GlobalKey<FormState>();
  final _name = GlobalKey<FormFieldState<String>>();
  final _price = GlobalKey<FormFieldState<String>>();
  final _category = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    var itemUpload = Provider.of<ItemUpload>(context, listen: true);
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            customTextFormField(key: _name, hintText: AppString.itemName),
            customTextFormField(key: _price, hintText: AppString.price),
            customTextFormField(key: _category, hintText: AppString.category),
            SizedBox(
              height: 15.0,
            ),
            MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Map<String, dynamic> data = Map<String, dynamic>();
                data['id'] = randomNumeric(10).toString();
                data['name'] = _name.currentState.value;
                data['price'] = _price.currentState.value;
                data['category'] = _category.currentState.value;

                itemUpload.addData(data);
                itemUpload.uploadToFirebase();
              },
              child: Text('Upload Form'),
            )
          ]),
    );
  }
}

TextFormField customTextFormField({Key key, String hintText}) {
  return TextFormField(
    key: key,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      hintText: hintText,
    ),
    maxLines: 1,
    validator: (value) {},
  );
}
