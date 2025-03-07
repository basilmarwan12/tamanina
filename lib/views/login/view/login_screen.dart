import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/home/view/home_screen.dart';
import 'package:tamanina/views/login/controller/login_controller.dart';
import 'package:tamanina/welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _loginController = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffECEFF5),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/main_image.png"),
                width: 500,
                height: 400,
              ),
              Text(
                "مرحباً بعودتك",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 14.h,
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
              SizedBox(
                height: 14.h,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "كلمة المرور",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.blueGrey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Color(0xff000000), width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 17.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (await _loginController.login(
                      email: _emailController.text,
                      password: _passwordController.text)) {
                    Get.offAll(() => HomeScreen());
                  } else {}
                },
                child: Container(
                  width: 180,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: Obx(
                    () => _loginController.isLoading()
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              strokeWidth: 1.5,
                            ),
                          )
                        : Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
