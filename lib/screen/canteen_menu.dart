import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/provider/canteen.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:campus_grub_official/utils/menu_item_widget.dart';
import 'package:campus_grub_official/utils/proceed_to_checkout_btn.dart';
import 'package:campus_grub_official/utils/add_item_button.dart';

class CanteenMenu extends StatelessWidget {
  final String? canteenId;
  final Map<String, dynamic>? orderItem;

  const CanteenMenu({Key? key, this.canteenId, this.orderItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    final canteen = homeScreenProvider.homeScreenDataList
        .firstWhere((element) => element.canteenNo == canteenId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 72, 1),
        title: CustomText(
          text: canteen.canteenName ?? '',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    if (canteen.menuItems != null &&
                        canteen.menuItems!.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: canteen.menuItems!.length,
                        itemBuilder: (context, index) {
                          final menuItem = canteen.menuItems![index];
                          return MenuItemWidget(
                            itemName: menuItem.itemName ?? '',
                            itemPrice: int.parse(menuItem.itemPrice ?? '0'),
                            canteenNo: menuItem.canteenNo ?? '',
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
          ),
          // Use Consumer to conditionally display ProceedToCheckoutBtn()
          Consumer<ReviewCartProvider>(
            builder: (context, cartProvider, child) {
              if (cartProvider.cartItems.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ProceedToCheckoutBtn(),
                );
              } else {
                return SizedBox
                    .shrink(); // Return empty SizedBox if cart is empty
              }
            },
          ),
        ],
      ),
    );
  }
}
