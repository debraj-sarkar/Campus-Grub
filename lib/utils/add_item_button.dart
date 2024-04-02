import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:flutter/material.dart';

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
          minimumSize: const Size(80, 35),
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
                    child: Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                      text: '$count',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                  SizedBox(
                    width: 10,
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
                    child: Icon(Icons.add),
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
                  child: CustomText(
                      text: 'ADD',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
