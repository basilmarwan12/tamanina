import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 261.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0XFFC1C5D0)),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Image.asset(
                    "assets/profile.png",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "الاسم الاول",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "الاسم الثاني",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "البريد الالكتروني",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "بداية النوبات",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "عدد مرات الحدوث",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "بداية النوبات",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      fillColor: Color(0xffF3F4F6),
                      filled: true,
                      hintText: "النوع",
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 60,
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
