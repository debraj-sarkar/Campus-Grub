import 'package:flutter/material.dart';
import 'package:campus_grub_official/provider/home_screen_provider.dart';
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
    homeScreenProvider.fetchHomeScreenData(); // Corrected method name
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red,
                  width: 2.0,
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
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                CustomText(
                    text: 'Debraj',
                    fontSize: 15,
                    color: Color.fromRGBO(227, 5, 72, 1),
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
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/campus-grub-official.appspot.com/o/banner.png?alt=media&token=578e4358-b637-4f2c-a042-0edd594a28ed'),
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
                    itemCount: provider.getHomeScreenDataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final canteen = provider.getHomeScreenDataList[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the CanteenMenu screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CanteenMenu(), // Pass CanteenMenu screen
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
