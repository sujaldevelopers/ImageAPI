import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  final ref = FirebaseDatabase.instance.ref().child("users").once().then((value){DataSnapshot snapshot;});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
