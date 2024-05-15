import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:campus_grub_official/utils/custom_text.dart';

class AddItemButton extends StatefulWidget {
  final String? itemName;
  final int? itemPrice;
  String? canteenNo;

  AddItemButton({
    super.key,
    this.itemName,
    this.itemPrice,
    this.canteenNo,
  });

  @override
  State<AddItemButton> createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {
  int count = 0;
  bool isTrue = false;

  /* @override
  void initState() {
    super.initState();
    count = Provider.of<ReviewCartProvider>(context, listen: false)
        .getQuantityForItem(
            widget.itemName!, widget.canteenNo!);
  }
*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    count = Provider.of<ReviewCartProvider>(context, listen: false)
        .getQuantityForItem(widget.itemName!, widget.canteenNo!);
  }

  void _addItems() {
    Map<String, dynamic> orderItem = {
      'itemName': widget.itemName,
      'itemPrice': widget.itemPrice,
      'quantity': count,
      'canteenNo': widget.canteenNo,
    };

    // Add the item to the cart
    Provider.of<ReviewCartProvider>(context, listen: false)
        .addToCart(orderItem, context);

    // Update the isTrue state
    setState(() {
      isTrue = true;
    });

    print('Added to order: $orderItem');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              isTrue = true;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            minimumSize: const Size(90, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color.fromRGBO(227, 5, 72, 1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (count > 0) {
                      count--;
                      Provider.of<ReviewCartProvider>(context, listen: false)
                          .removeLastItem();
                      print('Removed from order: $count');
                    }
                    // Update isTrue when count is 1
                    if (count == 1) {
                      isTrue = false;
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IgnorePointer(
                ignoring: true,
                child: CustomText(
                  text: '$count',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  if (count < 20) {
                    print(count);
                    setState(() {
                      count++;
                      _addItems();
                      print('Added to order: $count');
                    });
                    if (count == 20) {
                      isTrue = true;
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
