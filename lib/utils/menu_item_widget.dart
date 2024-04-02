import 'package:campus_grub_official/utils/add_item_button.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final VoidCallback onPressed;

  const MenuItemWidget({
    required this.itemName,
    required this.itemPrice,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Item Name
                CustomText(
                  text: itemName,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                //Item Price
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.currency_rupee_sharp,
                        size: 18, color: Colors.black),
                    CustomText(
                      text: '${itemPrice.toStringAsFixed(0)}',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Add space after the price
              ],
            ),
          ),
          //Add Button
          AddItemButton()
        ],
      ),
    );
  }
}
