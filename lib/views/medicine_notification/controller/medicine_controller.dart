import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  var isLoading = false.obs;

  Future<bool> addMedicine(
      String name, String date, String notes) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection("medicine").add({
        "name": name,
        "date": date,
        "notes": notes,
        "userId": FirebaseAuth.instance.currentUser!.uid
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .update(
        {
          "medicines": FieldValue.arrayUnion([
            {"name": name, "date": date, "notes": notes}
          ])
        },
      );

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
