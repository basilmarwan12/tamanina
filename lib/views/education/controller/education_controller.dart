import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tamanina/models/education.dart';

class EducationController extends GetxController {
  var isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Education> educationList = <Education>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEducations(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<bool> addEducation(String date, String notes) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection("education").add({
        "date": date,
        "notes": notes,
        "userId": FirebaseAuth.instance.currentUser!.uid
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "educations": FieldValue.arrayUnion([
          {"date": date, "notes": notes}
        ])
      });

      Get.snackbar("نجاح", "تمت إضافة التعليم بنجاح!");
      return true;
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء إضافة التعليم: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEducations(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await firestore
          .collection('education')
          .where('userId', isEqualTo: userId)
          .get();

      educationList.value = querySnapshot.docs.map((doc) {
        return Education.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل بيانات التعليم: $e");
    }
  }
}
