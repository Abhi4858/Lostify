import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lostify/screens/Lost%20Section/lost_section.dart';
import 'package:lostify/screens/bottomNavigation.dart';
import 'package:lostify/utils/utilities.dart';

import '../auth/login_screen.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance; // can access the firebase api's
    final user = auth.currentUser;

    if(user != null){
      // print(user);
      Timer.periodic(Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LostSection()));
      });
    }
    else{
      Timer.periodic(Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
}