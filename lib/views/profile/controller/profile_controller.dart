import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamanina/services/user_services.dart';

class ProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController seizureStartController = TextEditingController();
  final TextEditingController occurrencesController = TextEditingController();
  final TextEditingController seizureTypeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserService _userService = Get.put(UserService());

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    seizureStartController.dispose();
    occurrencesController.dispose();
    seizureTypeController.dispose();
    genderController.dispose();
    super.onClose();
  }

  void loadUserData() async {
    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        emailController.text = currentUser.email ?? '';

        if (currentUser.displayName != null) {
          final nameParts = currentUser.displayName!.split(' ');
          if (nameParts.length > 1) {
            firstNameController.text = nameParts[0];
            lastNameController.text = nameParts.sublist(1).join(' ');
          } else {
            firstNameController.text = currentUser.displayName!;
          }
        }

        try {
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(currentUser.uid).get();

          if (userDoc.exists) {
            Map<String, dynamic> userData =
                userDoc.data() as Map<String, dynamic>;

            seizureStartController.text = userData['seizureStart'] ?? '';
            occurrencesController.text =
                userData['occurrences']?.toString() ?? '';
            seizureTypeController.text = userData['seizureType'] ?? '';
            genderController.text = userData['gender'] ?? '';
          }
        } catch (firestoreError) {
          print('Error fetching Firestore data: $firestoreError');
        }
      } else {
        Get.snackbar(
          'خطأ',
          'لم يتم العثور على بيانات المستخدم. يرجى تسجيل الدخول مرة أخرى.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تحميل بيانات المستخدم: ${e.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<bool> updateUserProfile() async {
    isLoading.value = true;

    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        final String fullName =
            '${firstNameController.text} ${lastNameController.text}'.trim();
        await currentUser.updateDisplayName(fullName);

        if (currentUser.email != emailController.text &&
            emailController.text.isNotEmpty) {
          await currentUser.verifyBeforeUpdateEmail(emailController.text);
        }

        await _firestore.collection('users').doc(currentUser.uid).update({
          'name': fullName,
          'email': emailController.text,
          'seizureStart': seizureStartController.text,
          'occurrences': occurrencesController.text,
          'seizureType': seizureTypeController.text,
          'gender': genderController.text,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        _userService.login(currentUser);

        Get.snackbar(
          'نجاح',
          'تم تحديث بيانات المستخدم بنجاح',
          backgroundColor: Colors.green,
        );

        return true;
      } else {
        Get.snackbar(
          'خطأ',
          'لم يتم العثور على بيانات المستخدم. يرجى تسجيل الدخول مرة أخرى.',
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (e) {
      String errorMessage = 'حدث خطأ أثناء تحديث بيانات المستخدم';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'requires-recent-login':
            errorMessage = 'تحتاج إلى إعادة تسجيل الدخول لتحديث بياناتك';
            break;
          case 'email-already-in-use':
            errorMessage = 'البريد الإلكتروني مستخدم بالفعل';
            break;
          case 'invalid-email':
            errorMessage = 'البريد الإلكتروني غير صالح';
            break;
          default:
            errorMessage = 'حدث خطأ: ${e.code}';
        }
      }

      Get.snackbar(
        'خطأ',
        errorMessage,
        backgroundColor: Colors.red,
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
