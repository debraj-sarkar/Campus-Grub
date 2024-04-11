import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddItemButton extends StatefulWidget {
  const AddItemButton({super.key});

  @override
  State<AddItemButton> createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {
  int count = 1;
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          minimumSize: const Size(90, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color.fromRGBO(227, 5, 72, 1),
            ),
          ),
        ),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // - button
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isTrue = false;
                        });
                      }

                      if (count > 1) {
                        setState(() {
                          count--;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CustomText(
                      text: '$count',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (count < 20) {
                        setState(() {
                          count++;
                        });
                        if (count == 20) {
                          isTrue = true;
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(
                      () {
                        isTrue = true;
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                        text: 'ADD',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    );
  }
}
