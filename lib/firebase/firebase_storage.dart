import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FireStorage extends GetxController {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> upload(File userpic,BuildContext context) async {
    var ref = firebaseStorage
        .ref()
        .child("userprofileimage")
        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');
    await ref.putFile(userpic).whenComplete;

    var url = ref.getDownloadURL();
    return url;
  }

}
