import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:tamanina/views/education/view/education_view.dart';
import '../../../models/nawpat.dart';
import '../controller/nawpat_controller.dart';

class NawpatDetailsScreen extends StatefulWidget {
  final Nawpat nawpat;

  const NawpatDetailsScreen({super.key, required this.nawpat});

  @override
  State<NawpatDetailsScreen> createState() => _NawpatDetailsScreenState();
}

class _NawpatDetailsScreenState extends State<NawpatDetailsScreen> {
  final NawpatController _controller = Get.find<NawpatController>();

  late TextEditingController nameController;
  late TextEditingController symptomsController;
  late TextEditingController typeController;
  late TextEditingController selectionController;
  late TextEditingController durationController;
  late TextEditingController locationController;
  Map<String, bool> editingFields = {
    'name': false,
    'symptoms': false,
    'type': false,
    'selection': false,
    'duration': false,
    'location': false,
  };
  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.nawpat.name);
    symptomsController = TextEditingController(text: widget.nawpat.symptoms);
    typeController = TextEditingController(text: widget.nawpat.type);
    selectionController = TextEditingController(text: widget.nawpat.selection);
    durationController = TextEditingController(text: widget.nawpat.duration);
    locationController = TextEditingController(text: widget.nawpat.location);

    _controller.timeText.value = widget.nawpat.date;
  }

  @override
  void dispose() {
    nameController.dispose();
    symptomsController.dispose();
    typeController.dispose();
    selectionController.dispose();
    durationController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void saveField(String field) {
    setState(() {});

    Map<String, dynamic> updatedData = {};

    switch (field) {
      case 'name':
        updatedData['الاسم'] = nameController.text;
        break;
      case 'symptoms':
        updatedData['الاعراض'] = symptomsController.text;
        break;
      case 'type':
        updatedData['النوع'] = typeController.text;
        break;
      case 'selection':
        updatedData['هل شعرت بها عند الحدوث؟'] = selectionController.text;
        break;
      case 'duration':
        updatedData['المدة'] = durationController.text;
        break;
      case 'location':
        updatedData['أماكن الحدوث'] = locationController.text;
        break;
      case 'date_time':
        updatedData['التاريخ'] = _controller.timeText.value;
        break;
    }

    _controller.editNawpat(widget.nawpat.id, updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "تفاصيل النوبة",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditableInfoRow("👤 الاسم:", nameController, 'name'),
                _buildDatePicker(_controller),
                _buildEditableInfoRow(
                    "🤕 الأعراض:", symptomsController, 'symptoms'),
                _buildEditableInfoRow("📌 النوع:", typeController, 'type'),
                _buildEditableInfoRow("🔍 هل شعرت بها عند الحدوث؟:",
                    selectionController, 'selection'),
                _buildEditableInfoRow(
                    "⏳ المدة:", durationController, 'duration'),
                _buildEditableInfoRow(
                    "📍 أماكن الحدوث:", locationController, 'location'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(NawpatController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "📅 الوقت",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            DateTime? dateTime = await showOmniDateTimePicker(
              context: context,
              initialDate: DateTime.tryParse(controller.timeText.value) ??
                  DateTime.now(),
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
                return dateTime != DateTime(2023, 2, 25);
              },
            );

            if (dateTime != null) {
              controller.timeText.value = dateTime.toIso8601String();
              saveField('date_time');
            }
          },
          child: Container(
            width: 300,
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

  Widget _buildEditableInfoRow(
      String label, TextEditingController controller, String fieldKey) {
    bool isEditing = editingFields[fieldKey] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          isEditing
              ? Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.black),
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                )
              : Expanded(
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
                          text: "$label ",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                        TextSpan(
                          text: controller.text,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
          isEditing
              ? IconButton(
                  icon: const Icon(Icons.save, color: Colors.green),
                  onPressed: () => saveField(fieldKey),
                )
              : IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      editingFields.forEach((key, value) {
                        editingFields[key] = false;
                      });
                      editingFields[fieldKey] = true;
                    });
                  },
                ),
        ],
      ),
    );
  }
}
