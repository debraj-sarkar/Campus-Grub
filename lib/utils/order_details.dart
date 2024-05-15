import 'package:campus_grub_official/models/user_model.dart';
import 'package:campus_grub_official/provider/review_cart_provider.dart'; // Import ReviewCartProvider class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_grub_official/provider/user_provider.dart'; // Import UserProvider class

class OrderDetails {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadOrderDetails(List<Map<String, dynamic>> cartItems) async {
    try {
      // Get the current date
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);

      // Create a formatted date string (e.g., "2022-05-03")
      String formattedDate = "${date.year}-${date.month}-${date.day}";

      // Create a new document reference with the formatted date as the ID
      DocumentReference orderRef =
          _firestore.collection('orders').doc(formattedDate);

      // Get the current timestamp
      Timestamp timestamp = Timestamp.now();

      // Retrieve user data from UserProvider
      UserProvider userProvider = UserProvider();
      await userProvider.getUserData();
      UserModel? currentUser = userProvider.currentUserData;

      // Check if user data is available
      if (currentUser != null) {
        // Upload cartItems, user name, email, and timestamp to Firestore
        await orderRef.collection('orders').add({
          'cartItems': cartItems,
          'userName': currentUser.userName,
          'userEmail': currentUser.userEmail,
          'timestamp': timestamp,
        });

        print('Order details uploaded successfully!');

        // Clear the cart after successful upload
        ReviewCartProvider reviewCartProvider = ReviewCartProvider();
        reviewCartProvider.clearCart(); // Call clearCart method
      } else {
        print('User data not available.');
      }
    } catch (e) {
      print('Error uploading order details: $e');
    }
  }
}
