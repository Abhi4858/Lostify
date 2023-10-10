import 'package:flutter/material.dart';
import 'Found Section/found_section.dart';
import 'Lost Section/lost_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navigationIndex = 0;

  List AppScreens = [
    LostSection(),
    FoundSection()
  ];

  @override
  Widget build(BuildContext context) {
    Widget lostIcon = Image.asset(

      'lib/assets/lostIcon.png', // Replace with your image asset path
      width: 24, // Set the width of your icon
      height: 24, // Set the height of your icon
    );

    Widget foundIcon = Image.asset(
      'lib/assets/foundIcon2.png', // Replace with your image asset path
      width: 24, // Set the width of your icon
      height: 24, // Set the height of your icon
    );

    return Scaffold(
      body: AppScreens[navigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink.shade800,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        onTap: (index){
          setState(() {
            navigationIndex = index;
          });
        },
        currentIndex: navigationIndex,
        elevation:10,
        items: [
          BottomNavigationBarItem(
            icon: lostIcon,
            label: "Lost",
          ),
          BottomNavigationBarItem(
              icon: foundIcon,
              label: "Found"
          ),
        ],
      ),
    );
  }
}
