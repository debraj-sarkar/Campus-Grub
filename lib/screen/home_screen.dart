import 'package:campus_grub_official/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:campus_grub_official/provider/canteen.dart';
import 'package:campus_grub_official/utils/home_screen_canteens.dart';
import 'package:campus_grub_official/utils/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:campus_grub_official/screen/canteen_menu.dart'; // Import the CanteenMenu screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenProvider homeScreenProvider;

  @override
  void initState() {
    homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    homeScreenProvider.fetchHomeScreenData();
    _getUserData(); // Call _getUserData in initState
    super.initState();
  }

  // Define a method to get user data
  void _getUserData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.getUserData(); // Await for getUserData
    setState(() {}); // Trigger a rebuild after getting user data
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(
        context); // Access UserProvider using Provider.of
    var userData = userProvider.currentUserData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(227, 5, 72, 1),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
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
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                CustomText(
                    text: userData?.userName ??
                        '', // Use null-aware operator and provide default value
                    fontSize: 15,
                    color: Colors.white,
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
            Center(
              child: Container(
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/campus-grub-official.appspot.com/o/banner.png?alt=media&token=578e4358-b637-4f2c-a042-0edd594a28ed'),
                  ),
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
              child: Consumer<HomeScreenProvider>(
                builder: (context, provider, _) {
                  return GridView.builder(
                    itemCount: provider.homeScreenDataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final canteen = provider.homeScreenDataList[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the CanteenMenu screen and pass the canteen ID
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CanteenMenu(
                                  canteenId:
                                      canteen.canteenNo), // Pass canteenId
                            ),
                          );
                        },
                        child: Canteens(
                          imagePath: canteen.canteenImage ?? '',
                          canteenName: canteen.canteenName ?? '',
                          canteenDescription: canteen.canteenDescription ?? '',
                        ),
                      );
                    },
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
