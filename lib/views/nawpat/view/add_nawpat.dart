import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';
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
                SizedBox(
                  height: 50.h,
                )
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
        InkWell(
          onTap: () async {
            DateTime? dateTime = await showOmniDateTimePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
              lastDate: DateTime.now().add(const Duration(days: 3652)),
              is24HourMode: false,
              isShowSeconds: false,
              minutesInterval: 1,
              secondsInterval: 1,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 650,
              ),
              transitionBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1.drive(
                    Tween(begin: 0, end: 1),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
              selectableDayPredicate: (dateTime) {
                if (dateTime == DateTime(2023, 2, 25)) {
                  return false;
                } else {
                  return true;
                }
              },
            );

            if (dateTime != null) {
              controller.timeText.value = dateTime.toIso8601String();
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(
              () => Text(
                controller.timeText.value.isEmpty
                    ? "اختر التاريخ والوقت"
                    : formatDateTime(controller.timeText.value),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  String formatDateTime(String dateTimeStr) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeStr);

      Map<int, String> arabicMonths = {
        1: "يناير",
        2: "فبراير",
        3: "مارس",
        4: "أبريل",
        5: "مايو",
        6: "يونيو",
        7: "يوليو",
        8: "أغسطس",
        9: "سبتمبر",
        10: "أكتوبر",
        11: "نوفمبر",
        12: "ديسمبر"
      };

      String period = dateTime.hour >= 12 ? "مساءً" : "صباحًا";

      int hour = dateTime.hour % 12;
      hour = hour == 0 ? 12 : hour;

      return "${dateTime.day} ${arabicMonths[dateTime.month]} ${dateTime.year} - $hour:${DateFormat('mm').format(dateTime)} $period";
    } catch (e) {
      return "تاريخ غير صالح";
    }
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
