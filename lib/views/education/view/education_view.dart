import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tamanina/views/education/controller/education_controller.dart';
import 'package:tamanina/views/medicine_notification/controller/medicine_controller.dart';

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
                child: Text(
                  "التارىخ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SfDateRangePicker(
                  selectionColor: Colors.green,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    print(args.value);
                    timeController.text = args.value.toString();
                  },
                ),
              ),
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
              textDirection: TextDirection.rtl,
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
                      timeController.text,
                      notesController.text);
                  if (success) {
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
