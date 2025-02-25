import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/nawpat/view/add_nawpat.dart';

class NawpatScreen extends StatelessWidget {
  const NawpatScreen({super.key});

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
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => AddDataOfNawpat());
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 365,
            // height: 240,

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
                  "التاريخ : ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                ),
                const Text(
                  "اليوم : السبت",
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
      ),
    );
  }
}
