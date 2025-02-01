import 'package:flutter/material.dart';
import 'package:tamanina/nawpat_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              ),
              Text(
                "انشاء حساب جديد",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "الاسم",
                    hintStyle: TextStyle(
                      color: Color(0xffE5E8EF),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green))),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "البريد الالكتروني",
                    hintStyle: TextStyle(
                      color: Color(0xffE5E8EF),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green))),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "كلمة المرور",
                    hintStyle: TextStyle(color: Color(0xffE5E8EF)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green))),
              ),
              const SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NawpatScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    "انشاء حساب",
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
