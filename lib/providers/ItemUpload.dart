import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';

class ItemUpload with ChangeNotifier {
  File image;
  Map<String, dynamic> data;

  void addImage(File image) {
    this.image = image;
  }

  void addData(Map<String, dynamic> data) {
    this.data = data;
  }

  uploadToFirebase() {
    if (image == null) {
      _uploadForm();
    } else {
      _uploadFormWithImage();
    }
  }

  _uploadForm() async {
    var category = data['category'];
    var documentRef = FirebaseFirestore.instance;

    /*
     this.db.collection('users').doc('uid')
  .get().then(
  doc => {
    if (doc.exists) {
      this.db.collection('users').doc('uid').collection('friendsSubcollection').get().
        then(sub => {
          if (sub.docs.length > 0) {
            console.log('subcollection exists');
          }
        });
    }
  });
     */

    Map<String, dynamic> _data = {data['id']: data};
    await documentRef
        .collection('menu')
        .doc(category.toString())
        .get()
        .then((value) {
      if (value.exists) {
        documentRef.collection('menu').doc(category.toString()).update(_data);
      } else {
        documentRef.collection('menu').doc(category.toString()).set(_data);
      }
    });
    print('Written Data');
  }

  _uploadFormWithImage() async {
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
      (value) async {
        print(value.toString());
        Map<String, dynamic> foodItem = Map<String, dynamic>();
        var name = data['name'];
        var price = data['price'];
        var category = data['category'];

        foodItem['id'] = randomString(10);
        foodItem['name'] = name;
        foodItem['price'] = price;
        foodItem['category'] = category;
        foodItem['imageUrl'] = value.toString();

        var documentRef = FirebaseFirestore.instance;
        await documentRef
            .collection('menu')
            .doc(category.toString())
            .set(foodItem);
        print("Uploaded Image and Data");
      },
    );
  }
}
