import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SomeInformationScreen extends StatelessWidget {
  const SomeInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.transparent,
        /* toolbarHeight: 70,
        leadingWidth: 80, */
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 50.w,
            height: 50.h,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "معلومات تثقيفية",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.sp,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/tyyt.png",
              width: 30.w,
              height: 30.h,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 33.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25), // 25% opacity
                offset: const Offset(2, 4), // (x=2, y=4)
                blurRadius: 4, // Blur=4
                spreadRadius: 2, // Spread=2
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            '''
لمعلومات التي نجمعها
المعلومات الشخصية: مثل الاسم، البريد الإلكتروني، رقم الهاتف، والمعلومات الأخرى التي تقدمها عند التسجيل أو استخدام خدماتنا.

معلومات الاستخدام: بيانات عن كيفية استخدامك لخدماتنا، مثل نوع الجهاز، عنوان IP، والصفحات التي تزورها.

الملفات المؤقتة (Cookies): نستخدم ملفات تعريف الارتباط لتحسين تجربتك وتخصيص المحتوى.''',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
