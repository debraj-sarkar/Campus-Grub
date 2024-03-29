import 'package:campus_grub_official/screen/canteen_menu.dart';
import 'package:campus_grub_official/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/auth/firebase_options.dart';
import 'package:campus_grub_official/provider/home_screen_provider.dart';
import 'package:campus_grub_official/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        // Add more providers if needed
      ],
      child: MaterialApp(
        title: 'Your App Title',
        home: LoginScreen(),
        // Define your routes here if needed
        // routes: {
        //   '/home': (context) => HomeScreen(),
        //   '/login': (context) => LoginScreen(),
        //   '/canteen_menu': (context) => CanteenMenuScreen(),
        // },
      ),
    );
  }
}
