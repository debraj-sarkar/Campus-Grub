import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:campus_grub_official/utils/order_details.dart';
import 'package:flutter/material.dart';

class ReviewCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  int _totalPrice = 0;
  String? _currentCanteenNo;
  final OrderDetails _orderDetails = OrderDetails();

  List<Map<String, dynamic>> get cartItems => _cartItems;
  int get totalPrice => _totalPrice;

  void addToCart(Map<String, dynamic> item, BuildContext context) {
    // Check if the item already exists in the cart
    int existingItemIndex = _cartItems.indexWhere((cartItem) =>
        cartItem['itemName'] == item['itemName'] &&
        cartItem['canteenNo'] == item['canteenNo']);

    if (existingItemIndex != -1) {
      // Update the quantity of the existing item
      _cartItems[existingItemIndex]['quantity'] =
          _cartItems[existingItemIndex]['quantity'] + 1;
      // Update the total price
      _totalPrice += item['itemPrice'] as int;
      notifyListeners(); // Notify listeners about the change in cart items and total price
      return;
    }

    // Check if the cart is not empty and the item is from a different canteen
    if (_cartItems.isNotEmpty &&
        _cartItems[0]['canteenNo'] != item['canteenNo']) {
      // Show a dialog if adding item from a different canteen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const CustomText(
                text: 'Replace cart item?',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            content: const CustomText(
                text:
                    'You are trying to add items from a different canteen. Do you want to clear the cart and add items from this canteen?',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 161, 186, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        notifyListeners(); // Notify listeners about the change in cart items and total price
                      },
                      child: const CustomText(
                          text: 'No',
                          fontSize: 20,
                          color: Color.fromRGBO(227, 5, 72, 1),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(227, 5, 72, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextButton(
                      onPressed: () {
                        clearCart(); // Clear the cart
                        _cartItems.add(item); // Add the item to the cart
                        _totalPrice += item['itemPrice'] as int;
                        Navigator.of(context).pop(); // Close the dialog
                        notifyListeners(); // Notify listeners about the change in cart items and total price
                      },
                      child: const CustomText(
                          text: 'Yes',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      );
      return;
    }

    // Add the new item to the cart
    _cartItems.add(item);
    _totalPrice += item['itemPrice'] as int;
    notifyListeners(); // Notify listeners about the change in cart items and total price
  }

  int getQuantityForItem(String itemName, String canteenNo) {
    // Find the item in the cart based on its name and canteenNo
    var item = _cartItems.firstWhere(
      (cartItem) =>
          cartItem['itemName'] == itemName &&
          cartItem['canteenNo'] == canteenNo,
      orElse: () =>
          {'quantity': 0}, // Provide a default value if item is not found
    );

    // Return the quantity of the item
    return item['quantity'];
  }

  void removeLastItem() {
    if (_cartItems.isNotEmpty) {
      // Get the last item in the cart
      Map<String, dynamic> lastItem = _cartItems.last;

      // Decrement the quantity of the last item
      lastItem['quantity']--;

      // Update the total price
      _totalPrice -= lastItem['itemPrice'] as int;

      // If the quantity of the last item is now 0, remove it from the cart
      if (lastItem['quantity'] == 0) {
        _cartItems.removeLast();
      }

      notifyListeners(); // Notify listeners about the change in cart items and total price
    }
  }

  void setTotalPrice(int price) {
    _totalPrice = price;
    notifyListeners(); // Notify listeners about the change in total price
  }

  void clearCart() {
    _cartItems.clear();
    _totalPrice = 0;
    _currentCanteenNo = null;
    notifyListeners();
  }

  Future<void> uploadOrderToFirebase(
      List<Map<String, dynamic>> cartItems) async {
    await _orderDetails.uploadOrderDetails(cartItems);
  }
}
