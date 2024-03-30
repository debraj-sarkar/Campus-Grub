import 'package:campus_grub_official/models/home_screen_canteens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  List<HomeScreenModel> HomeScreenDataList = [];
  late HomeScreenModel homeScreenModel;

  fetchHomeScreenData() async {
    List<HomeScreenModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection('canteens').get();

    value.docs.forEach(
      (element) {
        homeScreenModel = HomeScreenModel(
          canteenImage: element.get('canteenImage'),
          canteenName: element.get('canteenName'),
          canteenDescription: element.get('canteenDescription'),
        );
        newList.add(homeScreenModel);
      },
    );
    HomeScreenDataList = newList;
    notifyListeners();
  }

  List<HomeScreenModel> get getHomeScreenDataList {
    return HomeScreenDataList;
  }
}
