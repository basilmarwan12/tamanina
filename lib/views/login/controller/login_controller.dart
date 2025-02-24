import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamanina/services/user_services.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final UserService _service = Get.put(UserService());

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login({required String email, required String password}) async {
    if (!_validateInput(email, password)) return false;

    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        _service.login(user);
        Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح!",
            backgroundColor: Colors.green);
        print("User UID: ${user.uid}");
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
          backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInput(String email, String password) {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("بريد إلكتروني غير صالح", "يرجى إدخال بريد إلكتروني صحيح.",
          backgroundColor: Colors.red);
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      Get.snackbar(
          "كلمة مرور ضعيفة", "يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل.",
          backgroundColor: Colors.red);
      return false;
    }
    return true;
  }

  void _handleAuthError(FirebaseAuthException e) {
    String errorMessage = "حدث خطأ.";

    switch (e.code) {
      case 'user-not-found':
        errorMessage = "لم يتم العثور على مستخدم لهذا البريد الإلكتروني.";
        break;
      case 'wrong-password':
        errorMessage = "كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.";
        break;
      case 'too-many-requests':
        errorMessage =
            "تم تجاوز الحد المسموح لمحاولات تسجيل الدخول. حاول لاحقًا.";
        break;
      case 'invalid-email':
        errorMessage = "تنسيق البريد الإلكتروني غير صالح.";
        break;
      default:
        errorMessage =
            "فشل تسجيل الدخول. يرجى التحقق من البيانات والمحاولة مرة أخرى.";
    }

    Get.snackbar("فشل تسجيل الدخول", errorMessage, backgroundColor: Colors.red);
  }
}
