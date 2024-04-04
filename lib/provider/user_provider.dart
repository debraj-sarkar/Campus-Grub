import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    String? userName,
    String? userEmail,
    String? userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set({
      "userName": userName ?? "",
      "userEmail": userEmail ?? "",
      "userImage": userImage ?? "",
      "userUId": currentUser.uid,
    });
  }
}
