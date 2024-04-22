import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    final reviewcartProvider = Provider.of<ReviewCartProvider>(context);
    final cartItems = reviewcartProvider.cartItems;
    print(cartItems);

    double totalAmount = 0;
    cartItems.forEach((item) {
      totalAmount += (item['itemPrice'] * item['quantity']);
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 240, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 48, 1),
        title: const CustomText(
          text: 'Checkout Screen',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // menu items and total
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartItems.map((item) {
                      return MenuItem(
                        name: item['itemName'],
                        price: '\₹ ${item['itemPrice']}',
                        quantity: item['quantity'],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: 'Total to Amount Pay:',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: '\₹$totalAmount',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Payment
                const CustomText(
                  text: 'Online Payment Options',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey[350]!,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/campus-grub-official.appspot.com/o/google_pay_icon.png?alt=media&token=f07c7323-cd56-45d1-8d80-8813272e73cf',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const CustomText(
                              text: 'Google Pay',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            Radio<String>(
                              value: 'Google Pay',
                              groupValue: _selectedPaymentOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentOption = value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey[350]!,
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/campus-grub-official.appspot.com/o/paytm_icon.png?alt=media&token=6f7ffaad-3973-4998-8546-4a262711edf4',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const CustomText(
                              text: 'Paytm',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 110),
                            const Spacer(),
                            Radio<String>(
                              value: 'Paytm',
                              groupValue: _selectedPaymentOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentOption = value;
                                });
                              },
                              activeColor: Colors.green,
                              visualDensity: VisualDensity.standard,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  print('Hello');
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 5, 7, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;

  const MenuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.transparent,
              width: 1,
            )),
            child: CustomText(
              text: name,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          CustomText(
            text: price,
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          const CustomText(
              text: 'X',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal),
          CustomText(
              text: quantity.toString(),
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
