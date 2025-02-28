import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  
  // Text editing controllers for each field
  late TextEditingController nameController;
  late TextEditingController symptomsController;
  late TextEditingController typeController;
  late TextEditingController selectionController;
  late TextEditingController durationController;
  late TextEditingController locationController;
  
  // Map to track which fields are being edited
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
    // Initialize controllers with current values
    nameController = TextEditingController(text: widget.nawpat.name);
    symptomsController = TextEditingController(text: widget.nawpat.symptoms);
    typeController = TextEditingController(text: widget.nawpat.type);
    selectionController = TextEditingController(text: widget.nawpat.selection);
    durationController = TextEditingController(text: widget.nawpat.duration);
    locationController = TextEditingController(text: widget.nawpat.location);
  }
  
  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    symptomsController.dispose();
    typeController.dispose();
    selectionController.dispose();
    durationController.dispose();
    locationController.dispose();
    super.dispose();
  }
  
  // Save changes for a specific field
  void saveField(String field) {
    setState(() {
      editingFields[field] = false;
    });
    
    // Create a map with only the field being updated
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
    }
    
    // Call controller to update the field in Firebase
    _controller.editNawpat(widget.nawpat.id, updatedData);
  }

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
      body: Center(
        child: Container(
          width: double.infinity,
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
              _buildInfoRow("📅 التاريخ:", widget.nawpat.date.substring(0, 10), false),
              _buildInfoRow("⏰ الوقت:", widget.nawpat.date.substring(11, 16), false),
              _buildInfoRow("🗓️ اليوم:", widget.nawpat.day, false),
              _buildEditableInfoRow("🤕 الأعراض:", symptomsController, 'symptoms'),
              _buildEditableInfoRow("📌 النوع:", typeController, 'type'),
              _buildEditableInfoRow("🔍 هل شعرت بها عند الحدوث؟:", selectionController, 'selection'),
              _buildEditableInfoRow("⏳ المدة:", durationController, 'duration'),
              _buildEditableInfoRow("📍 أماكن الحدوث:", locationController, 'location'),
            ],
          ),
        ),
      ),
    );
  }

  // Non-editable info row
  Widget _buildInfoRow(String label, String value, bool editable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
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
                    text: value,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          if (editable)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Toggle edit mode for this field
                setState(() {
                  // Reset all editing fields first
                  editingFields.forEach((key, value) {
                    editingFields[key] = false;
                  });
                });
              },
            ),
        ],
      ),
    );
  }
  
  // Editable info row with edit icon
  Widget _buildEditableInfoRow(String label, TextEditingController controller, String fieldKey) {
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
