import 'package:flutter/material.dart';
import 'Splash_Service.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    splashService.isLogin(BuildContext, context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Image.asset("asserts/image/images/20231003_174441_0000.png"),
      ),
    );
  }
}
