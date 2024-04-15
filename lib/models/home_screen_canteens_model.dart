import 'package:campus_grub_official/models/canteen_model.dart';

class HomeScreenModel {
  String? canteenImage;
  String? canteenName;
  String? canteenDescription;
  String? canteenNo; // Add canteenNo field
  List<CanteenMenuItem>? menuItems; // Add menuItems field

  HomeScreenModel({
    this.canteenImage,
    this.canteenName,
    this.canteenDescription,
    this.canteenNo,
    this.menuItems, // Initialize menuItems field
  });
}
