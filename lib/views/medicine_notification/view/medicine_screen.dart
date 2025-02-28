import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/models/medicine.dart';
import 'package:tamanina/views/medicine_notification/controller/medicine_controller.dart';
import 'package:tamanina/views/medicine_notification/view/medicine_notification.dart';

class MedicineScreen extends StatelessWidget {
  MedicineScreen({super.key});
  final MedicineController _medicineController = Get.put(MedicineController());

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
          "سجل الأدوية",
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
              "assets/greenpill.png",
              width: 30.w,
              height: 30.h,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => MedicineNotifcationView());
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Obx(() {
        if (_medicineController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_medicineController.medicineList.isEmpty) {
          return const Center(
            child: Text(
              "📭 لا توجد بيانات متاحة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: _medicineController.medicineList.length,
          itemBuilder: (context, index) {
            final medicines = _medicineController.medicineList[index];

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
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        _showEditMedicineDialog(medicines);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(medicines.id);
                      },icon: const Icon(Icons.delete),
                    )
                  ]),
                  _buildInfoRow("💊 العلاج رقم", "${index + 1}"),
                  _buildInfoRow("📌 الاسم", medicines.name),
                  _buildInfoRow("📅 التاريخ",
                      medicines.dateTime.toString().substring(0, 10)),
                  _buildInfoRow(
                      "📝 الملاحظات",
                      medicines.notes.isEmpty
                          ? "لا توجد ملاحظات"
                          : medicines.notes),
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
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.black,
    buttonColor: Colors.red,
    onConfirm: () async {
      await _medicineController.deleteMedicine(medicineId);
      Get.back(); // Close the dialog
    },
  );
}
void _showEditMedicineDialog(Medicine medicine) {
  TextEditingController nameController =
      TextEditingController(text: medicine.name);
  TextEditingController dateController =
      TextEditingController(text: medicine.dateTime.toString().substring(0, 10));
  TextEditingController notesController =
      TextEditingController(text: medicine.notes);

  Get.defaultDialog(
    title: "تعديل الدواء",
    content: Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "اسم الدواء"),
        ),
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
      ],
    ),
    textConfirm: "حفظ",
    textCancel: "إلغاء",
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.black,
    buttonColor: Colors.blue,
    onConfirm: () async {
      await _medicineController.editMedicine(
        medicine.id,
        nameController.text,
        dateController.text,
        notesController.text,
      );
      Get.back();
    },
  );
}


}
