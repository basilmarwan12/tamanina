import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tamanina/some_information_screen.dart';
import 'package:tamanina/views/emergency_view.dart';
import 'package:tamanina/views/profile/view/profile_screen.dart';
import 'package:tamanina/views/education/view/education_screen.dart';
import 'package:tamanina/views/nawpat/view/nawpat_screen.dart';
import 'package:tamanina/views/medicine_notification/view/medicine_screen.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  List<String> image = [
    "assets/hosp.png",
    "assets/note.png",
    "assets/greenpill.png",
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
        leadingWidth: 200,
        leading: Row(
          children: [
            IconButton(
                onPressed: () async {
                  await homeController.logout();
                },
                icon: Icon(Icons.logout)),
            GestureDetector(
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
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: ImageIcon(
                    AssetImage("assets/person_icon.png"),
                    color: Colors.black,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none_outlined, size: 35.sp),
                    onPressed: () async {
                      await homeController.fetchNotificationCount();
                      _showNotificationPreview(context);
                    },
                  ),
                  if (homeController.notificationCount.value > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          homeController.notificationCount.value.toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ),
                ],
              )),
          InkWell(
            onTap: () {
              playSound();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/tyyt.png",
                width: 30.w,
                height: 30.h,
              ),
            ),
          ),
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
                    "أهلا ${FirebaseAuth.instance.currentUser!.displayName}",
                    style: TextStyle(color: Colors.black, fontSize: 25.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 170.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _toNavigate(index),
                    child: Container(
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
                          SizedBox(height: 10.h),
                          Image(height: 80, image: AssetImage(image[index])),
                        ],
                      ),
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
                    height: 40.h,
                  ),
                  Image(height: 200, image: AssetImage("assets/smile.png"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showNotificationPreview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(10),
        height: 300,
        child: Column(
          children: [
            Text("الإشعارات",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            Divider(),
            Expanded(
              child: Obx(() => homeController.notificationList.isEmpty
                  ? Center(child: Text("لا توجد إشعارات"))
                  : ListView.builder(
                      itemCount: homeController.notificationList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(homeController.notificationList[index]),
                          leading: Icon(Icons.notifications),
                        );
                      },
                    )),
            ),
            TextButton(
              onPressed: homeController.clearNotifications,
              child: Text("مسح الكل", style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> playSound() async {
    try {
      await AudioPlayer().play(AssetSource("audio/enzarr.mp3"));
    } catch (e) {
      print(e);
    }
  }

  void _toNavigate(int index) {
    switch (index) {
      case 1:
        Get.to(() => NawpatScreen());
        break;
      case 2:
        Get.to(() => MedicineScreen());
        break;
      case 3:
        Get.to(() => EmergencyView());
        break;
      case 4:
        Get.to(() => EducationScreen());
        break;
      case 5:
        Get.to(() => SomeInformationScreen());
        break;
    }
  }
}
