import 'package:campus_grub_official/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_grub_official/provider/review_cart_provider.dart';

class ProceedToCheckoutBtn extends StatelessWidget {
  const ProceedToCheckoutBtn({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 4, // Adjust the elevation value as needed
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(),
              ),
            );
          },
          child: Consumer<ReviewCartProvider>(
            builder: (context, reviewCartProvider, _) {
              return Container(
                width:
                    MediaQuery.of(context).size.width - 60, // Adjust width here
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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item Total : ₹${reviewCartProvider.totalPrice}',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Checkout',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
