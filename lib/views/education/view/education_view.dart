import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tamanina/views/education/controller/education_controller.dart';

class EducationView extends StatelessWidget {
  EducationView({super.key});
  final EducationController _controller = Get.put(EducationController());

  final timeController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        spacing: 15,
        children: [
          SizedBox(
            height: 60,
          ),
          Image.asset('assets/education.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: _buildDatePicker(_controller, context)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: TextFormField(
              minLines: 4,
              maxLines: 10,
              controller: notesController,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  fillColor: Color(0xffF3F4F6),
                  filled: true,
                  hintText: "الملحوظات",
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Obx(() => GestureDetector(
                onTap: () async {
                  bool success = await _controller.addEducation(
                      _controller.timeText.value, notesController.text);
                  if (success) {
                    timeController.clear();
                    notesController.clear();
                    _controller.timeText.value = "";
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffA8BDD2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
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
      )),
    );
  }
}

Widget _buildDatePicker(EducationController controller, BuildContext context) {
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
