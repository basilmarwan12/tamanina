import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tamanina/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffECEFF5),
        body: Container(
          width: double.infinity,
          child: const Center(
              child: Image(
            image: AssetImage("assets/main_image.png"),
            width: double.infinity,
          )),
        ));
  }
}
