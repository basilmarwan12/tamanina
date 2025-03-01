import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/login/view/login_screen.dart';
import 'package:tamanina/views/signup/controller/register_controller.dart';

import '../../../welcome_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegisterController _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffECEFF5),
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Get.to(() => WelcomeScreen());
            },
          ),
        ],
      ),
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
                controller: _nameController,
                keyboardType: TextInputType.name,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "الاسم",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "البريد الالكتروني",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
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
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "كلمة المرور",
                    hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 12),
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
                onTap: () async {
                  await _controller.signUp(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text);
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  width: 160,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: Obx(
                    () => _controller.isLoading()
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              strokeWidth: 1.5,
                            ),
                          )
                        : const Text(
                            "انشاء حساب",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
