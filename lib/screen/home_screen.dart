import 'dart:ui';
import 'package:campus_grub_official/utils/canteens.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomText(
                    text: 'Welcome',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                CustomText(
                    text: 'Debraj',
                    fontSize: 15,
                    color: Color.fromRGBO(227, 5, 72, 1),
                    fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(
                  text: 'Food Joints',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Canteens(
                    imagePath: 'assets/canteen.png', // Example image path
                    canteenName: 'Savio Canteen', // Example canteen name
                    canteenDescription:
                        'Burger,Wai Wai,Maggi + 7 other items', // Example description
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
