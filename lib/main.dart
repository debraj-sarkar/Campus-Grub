import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:campus_grub_official/provider/user_provider.dart';
import 'package:campus_grub_official/screen/login_screen.dart';
import 'package:campus_grub_official/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_grub_official/auth/firebase_options.dart';
import 'package:campus_grub_official/provider/canteen.dart';
import 'package:campus_grub_official/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(isLoading: true)); // Show splash screen initially

  // Delay for 2 seconds
  await Future.delayed(Duration(seconds: 2));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(
      isLoading: false,
      isLoggedIn: isLoggedIn)); // Show main screen based on login state
}

class MyApp extends StatelessWidget {
  final bool isLoading;
  final bool isLoggedIn;

  MyApp({required this.isLoading, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReviewCartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoading
            ? SplashScreen()
            : (isLoggedIn ? HomeScreen() : LoginScreen()),
      ),
    );
  }
}
