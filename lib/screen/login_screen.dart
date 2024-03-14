import 'package:campus_grub_official/auth/fire_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                FirebaseService.signInwithGoogle(context);
              },
              child: Text('sign in with google '))
        ],
      ),
    );
  }
}
