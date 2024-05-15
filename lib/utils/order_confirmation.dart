import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';

class OrderConfirmation extends StatelessWidget {
  final String responseStatus;
  const OrderConfirmation({Key? key, required this.responseStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String response = responseStatus;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(237, 111, 149, 1),
              ),
              child: Center(
                child: Container(
                  height: 175,
                  width: 155,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(227, 5, 72, 1),
                  ),
                  child: response == "SUCCESS"
                      ? Icon(Icons.check, size: 100, color: Colors.white)
                      : Icon(Icons.close, size: 100, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomText(
              text: response == "SUCCESS"
                  ? 'Yay! Order Received'
                  : 'Oops! Order Failed',
              fontSize: 25,
              color: const Color.fromARGB(255, 22, 21, 21),
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
