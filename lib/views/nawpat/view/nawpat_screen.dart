import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/nawpat/view/add_nawpat.dart';

import '../controller/nawpat_controller.dart'; // Import the controller

class NawpatScreen extends StatelessWidget {
  NawpatScreen({super.key});
  final NawpatController nawpatController = Get.put(NawpatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () async {
            Get.back();
          },
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
          "سجل النوبات",
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => const AddDataOfNawpat());
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Obx(() {
        if (nawpatController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (nawpatController.nawpatList.isEmpty) {
          return const Center(
            child: Text(
              "لا توجد بيانات متاحة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: nawpatController.nawpatList.length,
          itemBuilder: (context, index) {
            final nawpat = nawpatController.nawpatList[index];

            return Container(
              width: 365.w,
              padding: const EdgeInsets.only(right: 20, top: 10),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "النوبة رقم  ${index + 1}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "الاسم : ${nawpat.name}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "التاريخ : ${nawpat.date.substring(0, 10)}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "اليوم : ${nawpat.day}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "الأعراض : ${nawpat.symptoms}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
