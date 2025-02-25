import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  var isLoading = false.obs;

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
          {"date": date,"notes": notes}
        ])
      });
      Get.snackbar("Success", "Education added successfully!");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      return false;
    } finally {
      isLoading.value = false; // Reset loading state properly
    }
  }
}
