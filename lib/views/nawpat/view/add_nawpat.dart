import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tamanina/views/nawpat/controller/nawpat_controller.dart';

class AddDataOfNawpat extends StatefulWidget {
  const AddDataOfNawpat({super.key});

  @override
  State<AddDataOfNawpat> createState() => _AddDataOfNawpatState();
}

class _AddDataOfNawpatState extends State<AddDataOfNawpat> {
  final NawpatController _controller = Get.put(NawpatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "إضافة النوبات",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<NawpatController>(builder: (controller) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  size: 80.sp,
                  color: const Color.fromARGB(255, 71, 32, 201),
                ),
                SizedBox(height: 20.h),
                _buildTextField("الإسم", controller.nameController),
                _buildDatePicker(controller),
                _buildTextField("الأعراض المصاحبة", controller.digController),
                _buildDropdownField(
                  label: "النوع",
                  items: ['ذكر', 'انثي'],
                  value: controller.selectedType,
                  onChanged: (newValue) {
                    controller.selectedType = newValue;
                    controller.update();
                  },
                ),
                _buildRadioGroup(
                  label: "هل شعرت بها عند الحدوث؟",
                  options: ['نعم', 'لا'],
                  selectedValue: controller.selectedOption,
                  onChanged: (newValue) {
                    controller.selectedOption = newValue!;
                    controller.update();
                  },
                ),
                _buildTextField("المدة", controller.durationController),
                _buildTextField("أماكن الحدوث", controller.locationController),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    await _controller.addNawpatData();
                    await _controller.fetchNawpatData(
                        FirebaseAuth.instance.currentUser!.uid);
                  },
                  child: Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 71, 32, 201),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      alignment: Alignment.center,
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.blueGrey,
                                strokeWidth: 1.5,
                              ),
                            )
                          : Text(
                              "إضافة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Colors.grey.withOpacity(0.25),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildDatePicker(NawpatController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الوقت",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SfDateRangePicker(
          selectionColor: Colors.green,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            controller.timeController.text = args.value.toString();
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            fillColor: Colors.grey.withOpacity(0.25),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildRadioGroup({
    required String label,
    required List<String> options,
    required String selectedValue,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: options.map((option) {
            return Row(
              children: [
                Radio<String>(
                  value: option,
                  fillColor:
                      WidgetStatePropertyAll(Colors.grey.withOpacity(0.25)),
                  groupValue: selectedValue,
                  onChanged: onChanged,
                ),
                Text(
                  option,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
