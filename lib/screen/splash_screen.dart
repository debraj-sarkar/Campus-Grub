import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 5, 72, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.fill,
            alignment: Alignment.topLeft,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/app_logo.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Text(
                'Campus',
                style: GoogleFonts.carterOne(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 4,
                  ),
                ),
              ),
              Text(
                'Grub',
                style: GoogleFonts.carterOne(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
