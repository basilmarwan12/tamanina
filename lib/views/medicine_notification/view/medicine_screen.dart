import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/models/medicine.dart';
import 'package:tamanina/views/medicine_notification/controller/medicine_controller.dart';
import 'package:tamanina/views/medicine_notification/view/medicine_notification.dart';
import 'medicine_details.dart';

class MedicineScreen extends StatelessWidget {
  MedicineScreen({super.key});
  final MedicineController _medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => MedicineNotifcationView());
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
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
          "سجل الأدوية",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.sp,
          ),
        ),
      ),
      body: Obx(() {
        if (_medicineController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_medicineController.medicineList.isEmpty) {
          return const Center(
            child: Text(
              "📭 لا توجد بيانات متاحة",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: _medicineController.medicineList.length,
          itemBuilder: (context, index) {
            final medicine = _medicineController.medicineList[index];

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
                          _showEditMedicineDialog(medicine);
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(medicine.id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(() => MedicineDetailScreen(medicine: medicine)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow("📌 الاسم", medicine.name),
                        _buildInfoRow(
                          "📅 التاريخ",
                          medicine.dateTime.length < 5
                              ? "غير محدد"
                              : medicine.dateTime.toString().substring(0, 10),
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

  void _showDeleteConfirmationDialog(String medicineId) {
    Get.defaultDialog(
      title: "حذف الدواء",
      middleText: "هل أنت متأكد أنك تريد حذف هذا الدواء؟",
      textConfirm: "نعم",
      textCancel: "لا",
      titleStyle: TextStyle(color: Colors.black, fontSize: 25.sp),
      middleTextStyle: TextStyle(color: Colors.black, fontSize: 20.sp),
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () async {
        await _medicineController.deleteMedicine(medicineId);
        Get.back(canPop: true);
      },
    );
  }

  void _showEditMedicineDialog(Medicine medicine) {
    TextEditingController nameController =
        TextEditingController(text: medicine.name);
    TextEditingController dateController = TextEditingController(
      text: medicine.dateTime.toString().substring(0, 10),
    );
    TextEditingController notesController =
        TextEditingController(text: medicine.notes);

    Get.defaultDialog(
      title: "تعديل الدواء",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "اسم الدواء"),
            style: TextStyle(color: Colors.black),
          ),
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
                dateController.text = pickedDate.toString().substring(0, 10);
              }
            },
          ),
          TextField(
            controller: notesController,
            style: TextStyle(color: Colors.black),
            decoration: const InputDecoration(labelText: "الملاحظات"),
          ),
        ],
      ),
      textConfirm: "حفظ",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.blue,
      onConfirm: () async {
        await _medicineController.editMedicine(
          medicine.id ?? "",
          nameController.text,
          dateController.text,
          notesController.text,
        );
        Get.back();
      },
    );
  }
}
