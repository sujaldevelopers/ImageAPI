import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatelessWidget {
  const LoginPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Mobile"),
      ),
      body: Center(
        child: Text("Enter Your Phone"),
      ),
    );
  }
}

