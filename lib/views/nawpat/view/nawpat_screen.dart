import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/nawpat/view/add_nawpat.dart';
import 'package:tamanina/views/nawpat/view/nawpat_details.dart';
import '../controller/nawpat_controller.dart';

class NawpatScreen extends StatelessWidget {
  NawpatScreen({super.key});
  final NawpatController nawpatController = Get.put(NawpatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
        }

        return ListView.builder(
          itemCount: nawpatController.nawpatList.length,
          itemBuilder: (context, index) {
            final nawpat = nawpatController.nawpatList[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => NawpatDetailsScreen(nawpat: nawpat));
              },
              child: Container(
                width: 365.w,
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          nawpatController.deleteNawpat(nawpat.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    _buildInfoRow("👤 الاسم:", nawpat.name),
                    _buildInfoRow("⏰ الوقت:", nawpat.date.substring(11, 16)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        textDirection: TextDirection.rtl,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w900),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
