import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tamanina/models/nawpat.dart';
import 'package:tamanina/views/nawpat/controller/nawpat_controller.dart';

class AddDataOfNawpat extends StatefulWidget {
  const AddDataOfNawpat({super.key});

  @override
  State<AddDataOfNawpat> createState() => _AddDataOfNawpatState();
}

class _AddDataOfNawpatState extends State<AddDataOfNawpat> {
  String? selectedValue;
  final NawpatController _controller = Get.put(NawpatController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _digController = TextEditingController();

  List<String> items = ['Apple', 'Banana', 'Orange', 'Grapes'];
  String selectedOption = 'Male';
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
      body: Container(
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
              SizedBox(
                height: 20.h,
              ),
              Text(
                "نوبة",
                style: TextStyle(
                  color: const Color.fromARGB(255, 71, 32, 201),
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "نوبة",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الإسم",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.25),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
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
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      print(args.value);
                      _timeController.text = args.value.toString();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "النوع",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedValue,
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
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "هل شعرت بها عند الحدوث؟",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'نعم',
                              fillColor: WidgetStatePropertyAll(
                                Colors.grey.withOpacity(0.25),
                              ),
                              groupValue: selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              "نعم",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'لا',
                              fillColor: WidgetStatePropertyAll(
                                Colors.grey.withOpacity(0.25),
                              ),
                              groupValue: selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              "لا",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "هل شعرت بها أثناء النوم؟",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'نعم',
                              fillColor: WidgetStatePropertyAll(
                                Colors.grey.withOpacity(0.25),
                              ),
                              groupValue: selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              "نعم",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'لا',
                              fillColor: WidgetStatePropertyAll(
                                Colors.grey.withOpacity(0.25),
                              ),
                              groupValue: selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              "لا",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المدة",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.25),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "الأعراض المصاحبة",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _digController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.25),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "أماكن الحدوث",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.25),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () async {
                  await _controller
                      .addNawpatData("lfE3l9xS83XH1fAUoryrZTve0qs1", {
                    "الاسم": _nameController.text,
                    "التاريخ": _timeController.text,
                    "اليوم": getArabicDay(
                        DateTime.parse(_timeController.text).weekday),
                    "الاعراض": _digController.text
                  });
                  await _controller
                      .fetchNawpatData("lfE3l9xS83XH1fAUoryrZTve0qs1");
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
                    child: _controller.isLoading()
                        ? SizedBox(
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
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getArabicDay(int weekday) {
    Map<int, String> daysInArabic = {
      1: "الإثنين",
      2: "الثلاثاء",
      3: "الأربعاء",
      4: "الخميس",
      5: "الجمعة",
      6: "السبت",
      7: "الأحد"
    };
    return daysInArabic[weekday] ?? "غير معروف";
  }
}
