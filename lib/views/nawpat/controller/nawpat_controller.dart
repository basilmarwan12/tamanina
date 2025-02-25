import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamanina/models/nawpat.dart';

class NawpatController extends GetxController {
  var isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Nawpat> nawpatList = <Nawpat>[].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController digController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedType;
  String selectedOption = 'نعم';

  @override
  void onInit() async {
    super.onInit();
    await fetchNawpatData(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> fetchNawpatData(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await firestore
          .collection('nawpat')
          .where('userId', isEqualTo: userId)
          .get();

      print(querySnapshot.docs);

      nawpatList.value = querySnapshot.docs.map((doc) {
        return Nawpat.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل بيانات النوبات: $e");
    }
  }

  Future<void> addNawpatData() async {
    try {
      isLoading.value = true;
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DateTime selectedDate =
          DateTime.tryParse(timeController.text) ?? DateTime.now();
      String arabicDay = getArabicDay(selectedDate.weekday);

      Nawpat newNawpat = Nawpat(
        id: '',
        userId: userId,
        name: nameController.text,
        date: timeController.text,
        day: arabicDay,
        symptoms: digController.text,
        type: selectedType ?? '',
        selection: selectedOption,
        duration: durationController.text,
        location: locationController.text,
      );

      await firestore.collection('nawpat').add(newNawpat.toMap());

      isLoading.value = false;
      Get.snackbar('نجاح', 'تمت إضافة البيانات بنجاح',
          backgroundColor: Colors.green);

      clearFields();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'فشل في إضافة البيانات: $e');
    }
  }

  void clearFields() {
    nameController.clear();
    timeController.clear();
    digController.clear();
    durationController.clear();
    locationController.clear();
    selectedType = null;
    selectedOption = 'نعم';
    update();
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
