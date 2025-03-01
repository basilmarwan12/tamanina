import 'package:flutter/material.dart';
import 'package:tamanina/views/login/view/login_screen.dart';
import 'package:tamanina/views/signup/view/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECEFF5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/main_image.png"),
                width: 352,
                height: 600,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    "انشاء حساب ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
