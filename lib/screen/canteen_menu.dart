import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/provider/canteen_menu_provider.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:campus_grub_official/utils/menu_item_widget.dart';

class CanteenMenu extends StatefulWidget {
  const CanteenMenu({Key? key}) : super(key: key);

  @override
  _CanteenMenuState createState() => _CanteenMenuState();
}

class _CanteenMenuState extends State<CanteenMenu> {
  late CanteenMenuProvider canteenMenuProvider;

  @override
  void initState() {
    canteenMenuProvider =
        Provider.of<CanteenMenuProvider>(context, listen: false);
    canteenMenuProvider.fetchCanteenMenuData('001'); // Corrected method name
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Welcome to',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              const CustomText(
                text: 'Savio Canteen',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              const CustomText(
                text: 'Burger,Wai Wai,Maggi + 7 other items',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(227, 5, 72, 1),
                  image: const DecorationImage(
                    image: AssetImage('assets/college_canteen_1.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: CustomText(
                  text: 'Menu',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Display menu items
              Consumer<CanteenMenuProvider>(
                builder: (context, canteenMenuProvider, _) {
                  final menuItems = canteenMenuProvider.canteenMenuItems;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final menuItem = menuItems[index];
                      return MenuItemWidget(
                        itemName: menuItem.itemName ?? '',
                        itemPrice: double.parse(menuItem.itemPrice ?? '0'),
                        onPressed: () {
                          // Add functionality for the add button here
                        },
                      );
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
