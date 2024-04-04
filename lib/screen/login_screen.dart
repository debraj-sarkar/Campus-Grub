import 'package:campus_grub_official/auth/fire_functions.dart';
import 'package:campus_grub_official/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 5, 72, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Campus Grub',
              style: GoogleFonts.carterOne(
                textStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset('assets/burger_croped.png'),
            Text(
              'Waiting In Queues\nNo More',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SignInButton(
              Buttons.google,
              onPressed: () {
                FirebaseService.signInWithGoogle(context);
              },
            ),
            SignInButton(
              Buttons.apple,
              text: "Sign up with Google",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
