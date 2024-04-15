import 'package:flutter/material.dart';

class ReviewCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  int _totalPrice = 0;

  List<Map<String, dynamic>> get cartItems => _cartItems;
  int get totalPrice => _totalPrice;

  void addToCart(Map<String, dynamic> item) {
    // Check if the item already exists in the cart
    int existingItemIndex = _cartItems
        .indexWhere((cartItem) => cartItem['itemName'] == item['itemName']);
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

  void removeLastItem() {
    if (_cartItems.isNotEmpty) {
      // Get the price and quantity of the last item
      int lastItemPrice = _cartItems.last['itemPrice'] as int;
      int lastItemQuantity = _cartItems.last['quantity'] as int;

      // Subtract the total price of the last item from the total price
      _totalPrice -= (lastItemPrice * lastItemQuantity);

      // Remove the last item from the cart
      _cartItems.removeLast();

      notifyListeners(); // Notify listeners about the change in cart items and total price
    }
  }

  void setTotalPrice(int price) {
    _totalPrice = price;
    notifyListeners(); // Notify listeners about the change in total price
  }
}
