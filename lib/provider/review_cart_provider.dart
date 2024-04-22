import 'package:flutter/material.dart';

class ReviewCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  int _totalPrice = 0;

  List<Map<String, dynamic>> get cartItems => _cartItems;
  int get totalPrice => _totalPrice;

  void addToCart(Map<String, dynamic> item) {
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
    } else {
      // Add the new item to the cart
      _cartItems.add(item);
      _totalPrice += item['itemPrice'] as int;
    }
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
}
