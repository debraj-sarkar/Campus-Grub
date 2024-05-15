import 'package:campus_grub_official/provider/review_cart_provider.dart';
import 'package:campus_grub_official/provider/user_provider.dart';
import 'package:campus_grub_official/screen/canteen_menu.dart';
import 'package:campus_grub_official/screen/checkout_screen.dart';
import 'package:campus_grub_official/screen/login_screen.dart';
import 'package:campus_grub_official/utils/order_confirmation.dart';
import 'package:campus_grub_official/utils/proceed_to_checkout_btn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/auth/firebase_options.dart';
import 'package:campus_grub_official/provider/canteen.dart';
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReviewCartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
