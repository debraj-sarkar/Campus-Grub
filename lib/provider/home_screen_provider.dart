import 'package:campus_grub_official/models/canteen_menu_model.dart';
import 'package:campus_grub_official/models/home_screen_canteens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  List<HomeScreenModel> _homeScreenDataList = [];

  List<HomeScreenModel> get homeScreenDataList => _homeScreenDataList;

  Future<void> fetchHomeScreenData() async {
    try {
      QuerySnapshot homeScreenDataSnapshot =
          await FirebaseFirestore.instance.collection('canteens').get();

      List<HomeScreenModel> newList = [];
      for (QueryDocumentSnapshot document in homeScreenDataSnapshot.docs) {
        HomeScreenModel homeScreenModel = HomeScreenModel(
          canteenImage: document.get('canteenImage'),
          canteenName: document.get('canteenName'),
          canteenDescription: document.get('canteenDescription'),
          canteenNo: document.get('canteenNo'),
        );

        // Fetch menu items for this canteen
        List<CanteenMenuItem> menuItems =
            await _fetchCanteenMenuData(document.id);

        homeScreenModel.menuItems = menuItems;
        // Print menu items for debugging
        print('Menu items for canteen ${homeScreenModel.canteenName}:');
        for (var menuItem in menuItems) {
          print('Item Name: ${menuItem.itemName}, '
              'Price: ${menuItem.itemPrice}, '
              'Type: ${menuItem.itemType}');
        }

        newList.add(homeScreenModel);
      }

      _homeScreenDataList = newList; // Assigning newList to _homeScreenDataList
      notifyListeners();
    } catch (error) {
      print("Error fetching home screen data: $error");
    }
  }

  Future<List<CanteenMenuItem>> _fetchCanteenMenuData(String canteenId) async {
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

      return menuItems;
    } catch (error) {
      print("Error fetching canteen menu data: $error");
      return [];
    }
  }
}
