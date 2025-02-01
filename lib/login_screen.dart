import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECEFF5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/main_image.png"),
                width: 352.w,
                height: 550.h,
              ),
              Text(
                "اهلا بالعودة",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 14.h,
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
              SizedBox(
                height: 14.h,
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
              SizedBox(
                height: 17.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 200.w,
                  height: 60.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
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
