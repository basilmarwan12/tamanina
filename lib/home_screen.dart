import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> image = [
    "assets/hospital.png",
    "assets/note.png",
    "assets/caps.png",
    "assets/emarg.png",
    "assets/education.png",
    "assets/inform.png",
  ];

  List<String> text = [
    "مستشفي",
    "سجل النوبات",
    "تنبيهات الادوية",
    "الاسعافات الاولية",
    "تنبيهات دراسية",
    "معلومات تثقيفية"
  ];
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
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.w,
                )),
            child: ImageIcon(
              AssetImage(
                "assets/persom_icon.png",
              ),
              color: Colors.black,
              size: 20.sp,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/tyyt.png",
              width: 30.w,
              height: 30.h,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            15.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "أهلا يارا علي",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black,
                    size: 35.sp,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 170.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.center,
                    width: 140.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.w),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Image(
                          image: AssetImage(
                            image[index],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  width: 2.w,
                  color: Color(
                    0xffFCC56B,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "كيف حالك الان",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  SvgPicture.asset("assets/emo.svg")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
