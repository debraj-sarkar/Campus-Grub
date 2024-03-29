import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CanteenMenu extends StatelessWidget {
  const CanteenMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: CustomText(
            text: 'Menu',
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        centerTitle: true,
      ),*/
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  text: 'Welcome to',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              const CustomText(
                  text: 'Savio Canteen',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              const CustomText(
                  text: 'Burger,Wai Wai,Maggi + 7 other items',
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(227, 5, 72, 1),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/college_canteen_1.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: CustomText(
                  text: 'Menu',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Veg Items
              const Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                      text: 'Veg',
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)
                ],
              ),
              _buildMenuList(),
              const Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                      text: 'Non - Veg',
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)
                ],
              ),
              _buildMenuList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuList() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 5, // Replace with your actual number of menu items
    itemBuilder: (context, index) {
      return ListTile(
        title: CustomText(
          text: 'Menu Item ${index + 1}',
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Add functionality for the add button here
          },
          child: const CustomText(
            text: 'Add',
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 25),
            minimumSize: Size(90, 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Color.fromRGBO(227, 5, 72, 1),
              ),
            ),
          ),
        ),
      );
    },
  );
}
