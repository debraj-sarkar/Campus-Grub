import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/provider/home_screen_provider.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:campus_grub_official/utils/menu_item_widget.dart';

class CanteenMenu extends StatelessWidget {
  final String? canteenId;

  const CanteenMenu({Key? key, this.canteenId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    final canteen = homeScreenProvider.homeScreenDataList
        .firstWhere((element) => element.canteenNo == canteenId);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Welcome to',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: canteen.canteenName ?? '',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: canteen.canteenDescription ?? '',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(227, 5, 72, 1),
                  image: DecorationImage(
                    image: NetworkImage(canteen.canteenImage ?? ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: CustomText(
                  text: 'Menu',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Display menu items
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: canteen.menuItems?.length ?? 0,
                itemBuilder: (context, index) {
                  final menuItem = canteen.menuItems![index];
                  return MenuItemWidget(
                    itemName: menuItem.itemName ?? '',
                    itemPrice: double.parse(menuItem.itemPrice ?? '0'),
                    onPressed: () {
                      // Add functionality for the add button here
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
