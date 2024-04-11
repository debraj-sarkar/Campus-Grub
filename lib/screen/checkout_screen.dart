import 'package:flutter/material.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 240, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 48, 1),
        title: CustomText(
            text: 'Checkout Screen',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 260,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('data'),
                ),

                SizedBox(
                  height: 20,
                ),
                // Payment
                CustomText(
                    text: 'Online Payment Options',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            // Google Pay Image
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
                            SizedBox(
                              width: 20,
                            ),
                            CustomText(
                                text: 'Google Pay',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            Spacer(),
                            Radio<String>(
                              value: 'Google Pay',
                              groupValue: _selectedPaymentOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentOption = value;
                                });
                              },
                              activeColor:
                                  Colors.green, // Set active color to green
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
                            SizedBox(
                              width: 20,
                            ),
                            CustomText(
                                text: 'Paytm',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(width: 110),
                            Spacer(),
                            Radio<String>(
                              value: 'Paytm',
                              groupValue: _selectedPaymentOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentOption = value;
                                });
                              },
                              activeColor: Colors.green,
                              visualDensity: VisualDensity
                                  .standard, // Set active color to green
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

          // Place Order button
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Material(
              elevation: 4, // Adjust the elevation value as needed
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
                        color: Colors.black
                            .withOpacity(0.2), // Adjust opacity as needed
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
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
