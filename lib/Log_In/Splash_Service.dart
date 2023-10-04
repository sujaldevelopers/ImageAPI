import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_image_api/Log_In/ap_login_page.dart';
import 'package:my_image_api/my_home_page.dart';

import '../CRUD/add_firestore_post.dart';
import '../CRUD/fire_store_list_screen.dart';
import '../CRUD/image_pic.dart';

class SplashService {
  void isLogin(BuildContext, context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyImage(),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
  }
}
