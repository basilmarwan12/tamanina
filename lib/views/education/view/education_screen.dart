import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/models/education.dart';
import 'package:tamanina/views/education/controller/education_controller.dart';
import 'package:tamanina/views/education/view/education_details.dart';
import 'package:tamanina/views/education/view/education_view.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});
  final EducationController _controller = Get.put(EducationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل التعليم"),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.educationList.isEmpty) {
          return const Center(
            child: Text(
              "📭 لا توجد بيانات متاحة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: _controller.educationList.length,
          itemBuilder: (context, index) {
            final education = _controller.educationList[index];

            return Container(
              width: 365.w,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          _showEditEducationDialog(education);
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(education.id ?? "");
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                        () => EducationDetailScreen(education: education)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                            "📅 التاريخ", formatDateTime(education.date ?? "")),
                        _buildInfoRow(
                          "📝 الملاحظات",
                          education.notes?.isEmpty ?? true
                              ? "لا توجد ملاحظات"
                              : education.notes!,
                        ),
                      ],
                    ),
                  ),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: "$label: ",
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
      title: "حذف السجل",
      middleText: "هل أنت متأكد أنك تريد حذف هذا السجل؟",
      textConfirm: "نعم",
      textCancel: "لا",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () async {
        await _controller.deleteEducation(educationId);
        Get.back(); // Close the dialog
      },
    );
  }

  void _showEditEducationDialog(Education education) {
    TextEditingController dateController =
        TextEditingController(text: education.date);
    TextEditingController notesController =
        TextEditingController(text: education.notes);

    Get.defaultDialog(
      title: "تعديل السجل",
      content: Column(
        children: [
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: "التاريخ"),
            style: TextStyle(color: Colors.black),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                dateController.text =
                    pickedDate.toIso8601String().substring(0, 10);
              }
            },
          ),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(labelText: "الملاحظات"),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      textConfirm: "حفظ",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.blue,
      onConfirm: () async {
        await _controller.editEducation(
          education.id ?? "",
          dateController.text,
          notesController.text,
        );
        Get.back();
      },
    );
  }
}
