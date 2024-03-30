/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:campus_grub_official/models/canteen_menu_model.dart';

class CanteenMenuProvider with ChangeNotifier {
  List<CanteenMenuItem> _canteenMenuItems = [];

  List<CanteenMenuItem> get canteenMenuItems => _canteenMenuItems;

  Future<void> fetchCanteenMenuData(String canteenId) async {
    List<CanteenMenuItem> menuItems = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('canteens')
              .doc(canteenId)
              .get();

      Map<String, dynamic> data = documentSnapshot.data() ?? {};

      Map<String, dynamic> canteenMenuData = data['canteenMenu'] ?? {};

      canteenMenuData.forEach((key, value) {
        Map<String, dynamic> itemData = value as Map<String, dynamic>;
        String itemName = itemData['itemName'];
        String itemPrice = itemData['itemPrice'];
        String itemType = itemData['itemType'];
        menuItems.add(CanteenMenuItem(
          itemName: itemName,
          itemPrice: itemPrice,
          itemType: itemType,
        ));
      });

      _canteenMenuItems = menuItems;
      notifyListeners();
    } catch (error) {
      print("Error fetching canteen menu data: $error");
    }
  }
}
*/