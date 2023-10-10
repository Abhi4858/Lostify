import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:lostify/screens/Lost%20Section/lost_section.dart';
import 'package:lostify/screens/Lost%20Section/users_lost_request.dart';

class HiddenDrawerState extends StatefulWidget {
  const HiddenDrawerState({super.key});

  @override
  State<HiddenDrawerState> createState() => _HiddenDrawerStateState();
}

class _HiddenDrawerStateState extends State<HiddenDrawerState> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Lost Section",
          baseStyle: TextStyle(),
          selectedStyle: TextStyle(),
        ),
        LostSection()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "My Requests",
            baseStyle: TextStyle(),
            selectedStyle: TextStyle(),
          ),
          MyLostRequests()
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
        screens: _pages,
        backgroundColorMenu: Colors.pink.shade800,
        initPositionSelected: 0,
    );
  }
}
