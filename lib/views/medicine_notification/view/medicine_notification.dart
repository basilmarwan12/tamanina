import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamanina/views/medicine_notification/controller/medicine_controller.dart';

class MedicineNotifcationView extends StatelessWidget {
  MedicineNotifcationView({super.key});
  
  final MedicineController _controller = Get.put(MedicineController());

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final nameController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(spacing: 15,
          children: [
            SizedBox(height: 80),
            Image.asset('assets/greenpill.png'),
            
            _buildTextField("الاسم", nameController),
            _buildTextField("التاريخ", dateController),
            _buildTextField("الوقت", timeController),
            _buildTextField("الملحوظات", notesController, isMultiline: true),

            SizedBox(height: 50),

            Obx(() => GestureDetector(
              onTap: () async {
                bool success = await _controller.addMedicine(
                  nameController.text, 
                  dateController.text,
                  timeController.text,
                  notesController.text
                );

                if (success) {
                  nameController.clear();
                  dateController.clear();
                  timeController.clear();
                  notesController.clear();
                }
              },
              child: Container(
                width: 200,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffA8BDD2),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: _controller.isLoading.value
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.blueGrey,
                      strokeWidth: 1.5,
                    )
                  : Text(
                      "حفظ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool isMultiline = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.right,
        minLines: isMultiline ? 4 : 1,
        maxLines: isMultiline ? 10 : 1,
        decoration: InputDecoration(
          fillColor: Color(0xffF3F4F6),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
