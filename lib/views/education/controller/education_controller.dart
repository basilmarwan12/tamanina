import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EducationController extends GetxController{
  var isLoading = false.obs;

  Future<bool> addEducation(
     String date, String time, String notes) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("medicine")
          .add({"date": date, "time": time, "notes": notes});
      Get.snackbar("Success", "Medicine added successfully!");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      return false;
    } finally {
      isLoading.value = false; // Reset loading state properly
    }
  }
  
}