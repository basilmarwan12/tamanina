import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tamanina/cache/shared_cache.dart';
import 'package:tamanina/welcome_screen.dart';

class HomeController extends GetxController {
  RxInt notificationCount = 0.obs;
  RxList<String> notificationList = <String>[].obs;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    fetchNotificationCount();
  }

  RxInt moodStatus = 5.obs;

  void setMood(int value) {
    moodStatus.value = value;
  }

  Future<void> fetchNotificationCount() async {
    final List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    print(activeNotifications);
    notificationCount.value = activeNotifications.length;
    notificationList.value = activeNotifications
        .map((n) => "${n.title ?? 'إشعار'}: ${n.body ?? 'تفاصيل غير متاحة'}")
        .toList();
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      await StorageService.clearLoginState();

      Get.offAll(() => WelcomeScreen());

      Get.snackbar("تم تسجيل الخروج", "تم تسجيل خروجك بنجاح!",
          backgroundColor: Colors.green);

      print("✅ User has been logged out successfully!");
    } catch (e) {
      Get.snackbar("خطأ", "فشل تسجيل الخروج. حاول مرة أخرى.",
          backgroundColor: Colors.red);
      print("❌ Error during logout: $e");
    }
  }

  void clearNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
    notificationCount.value = 0;
    notificationList.clear();
  }
}
