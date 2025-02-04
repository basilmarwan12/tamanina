import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDataOfNawpat extends StatefulWidget {
  const AddDataOfNawpat({super.key});

  @override
  State<AddDataOfNawpat> createState() => _AddDataOfNawpatState();
}

class _AddDataOfNawpatState extends State<AddDataOfNawpat> {
  String? selectedValue; // Holds the selected value

  List<String> items = ['Apple', 'Banana', 'Orange', 'Grapes'];
  String selectedOption = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 71, 32, 201),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                alignment: Alignment.center,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
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
}
