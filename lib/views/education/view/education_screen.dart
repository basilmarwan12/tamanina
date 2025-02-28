import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/education/controller/education_controller.dart';
import 'package:tamanina/views/education/view/education_view.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});
  final EducationController _educationController =
      Get.put(EducationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Icon(Icons.arrow_back, color: Colors.white, size: 30.sp),
          ),
        ),
        centerTitle: true,
        title: Text(
          "سجل التعليمي",
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
              "assets/education.png",
              width: 30.w,
              height: 30.h,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => EducationView());
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Obx(() {
        if (_educationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_educationController.educationList.isEmpty) {
          return const Center(
            child: Text(
              "لا توجد بيانات متاحة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: _educationController.educationList.length,
          itemBuilder: (context, index) {
            final education = _educationController.educationList[index];

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
                  Row(children: [
                    IconButton(
                      onPressed: () => _showEditEducationDialog(education),
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          _showDeleteConfirmationDialog(education.id!),
                    )
                  ]),
                  _buildInfoRow("🔹 السجل رقم:", "${index + 1}"),
                  _buildInfoRow("📅 التاريخ :",
                      " ${education.date.toString().substring(0, 10)}"),
                  _buildInfoRow(
                      "📝 الملحوظات :", education.notes ?? "لا توجد ملاحظات"),
                ],
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
            fontSize: 25,
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

  void _showDeleteConfirmationDialog(String educationId) {
    Get.defaultDialog(
      title: "حذف السجل التعليمي",
      middleText: "هل أنت متأكد أنك تريد حذف هذا السجل؟",
      textConfirm: "نعم",
      textCancel: "لا",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () async {
        await _educationController.deleteEducation(educationId);
        Get.back(); // Close the dialog
      },
    );
  }

  void _showEditEducationDialog(var education) {
    TextEditingController dateController =
        TextEditingController(text: education.date.toString().substring(0, 10));
    TextEditingController notesController =
        TextEditingController(text: education.notes);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "التاريخ"),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text = pickedDate.toString().substring(0, 10);
                }
              },
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: "الملاحظات"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _educationController.editEducation(
                  education.id!,
                  dateController.text,
                  notesController.text,
                );
                Get.back();
              },
              child: const Text("حفظ"),
            ),
          ],
        ),
      ),
    );
  }
}
