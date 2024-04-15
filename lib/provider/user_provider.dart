import 'package:campus_grub_official/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentData;

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
      "userUid": currentUser.uid,
    });
  }

  Future<void> getUserData() async {
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      currentData = UserModel(
        userEmail: value.get('userEmail'),
        userImage: value.get('userImage'),
        userName: value.get('userName'),
        userUid: value.get('userUid'),
      );
      notifyListeners(); // Notify listeners after updating data
    }
  }

  UserModel? get currentUserData {
    return currentData;
  }
}
