import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/nawpat.dart';

class NawpatController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Nawpat> nawpatList = <Nawpat>[].obs;

  @override
  void onInit() {
    fetchNawpatData('lfE3l9xS83XH1fAUoryrZTve0qs1');
    super.onInit();
  }

  Future<void> fetchNawpatData(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await firestore
          .collection('nawpat')
          .where('userId', isEqualTo: userId)
          .get();

      nawpatList.value = querySnapshot.docs.map((doc) {
        return Nawpat.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      await Future.delayed(Duration(seconds: 4));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل البيانات: $e");
    }
  }

  Future<void> addNawpatData(String userId, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      data['userId'] = userId;

      await firestore.collection('nawpat').add(data);

      isLoading.value = false;
      Get.snackbar('نجاح', 'تمت إضافة البيانات بنجاح',
          backgroundColor: Colors.green);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'فشل في إضافة البيانات: $e');
    }
  }
}
