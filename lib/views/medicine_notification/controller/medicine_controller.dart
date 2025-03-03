import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tamanina/main.dart';
import 'package:tamanina/models/medicine.dart';
import 'package:timezone/timezone.dart' as tz;

class MedicineController extends GetxController {
  var isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Medicine> medicineList = <Medicine>[].obs;
  RxString timeText = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchMedicines(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<bool> addMedicine(String name, String date, String notes) async {
    isLoading.value = true;
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("medicine").add({
        "name": name,
        "date": date,
        "notes": notes,
        "userId": FirebaseAuth.instance.currentUser!.uid
      });

      await scheduleMedicineNotification(docRef.id, name, date);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMedicine(String medicineId) async {
    isLoading.value = true;
    try {
      await firestore.collection('medicine').doc(medicineId).delete();

      medicineList.removeWhere((medicine) => medicine.id == medicineId);

      Get.snackbar("نجاح", "تم حذف الدواء بنجاح!");
      await fetchMedicines(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      Get.snackbar("خطأ", "فشل حذف الدواء: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editMedicine(
      String id, String name, String date, String notes) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('medicine').doc(id).update({
        "name": name,
        "date": date,
        "notes": notes,
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .update({
        "medicines": FieldValue.arrayRemove([
          {"name": name, "date": date, "notes": notes}
        ]),
        "medicines": FieldValue.arrayUnion([
          {"name": name, "date": date, "notes": notes}
        ])
      });

      await flutterLocalNotificationsPlugin.cancel(id.hashCode);

      await scheduleMedicineNotification(id, name, date);

      Get.snackbar("Success", "Medicine updated successfully!");
      await fetchMedicines(FirebaseAuth.instance.currentUser!.uid);
      return true;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMedicines(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await firestore
          .collection('medicine')
          .where('userId', isEqualTo: userId)
          .get();

      medicineList.value = querySnapshot.docs.map((doc) {
        return Medicine.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل بيانات الأدوية: $e");
    }
  }

  Future<bool> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      try {
        if (await Permission.scheduleExactAlarm.isGranted) {
          print("✅ إذن التنبيه الدقيق ممنوح بالفعل");
          return true;
        }
        if (await Permission.notification.isGranted) {
          print("✅ إذن التنبيه الدقيق ممنوح بالفعل");
          return true;
        }

        PermissionStatus status = await Permission.scheduleExactAlarm.request();

        if (status.isGranted) {
          print("✅ تم منح إذن التنبيه الدقيق بنجاح");
          return true;
        } else if (status.isDenied) {
          print("⚠️ رفض المستخدم إذن التنبيه الدقيق");
          Get.snackbar("تنبيه", "يجب منح إذن التنبيه الدقيق لجدولة الإشعارات",
              snackPosition: SnackPosition.BOTTOM);
          return false;
        } else if (status.isPermanentlyDenied) {
          print("❌ تم رفض إذن التنبيه الدقيق بشكل دائم! يفتح الإعدادات...");
          await openAppSettings();
          return false;
        }
      } catch (e) {
        print("❌ خطأ أثناء طلب إذن التنبيه الدقيق: $e");
        return false;
      }
    }
    return false;
  }

  Future<void> scheduleMedicineNotification(
      String id, String name, String date) async {
    try {
      print(date);
      bool granted = await requestExactAlarmPermission();
      if (!granted) {
        print("❌ لا يمكن جدولة التنبيه بدون إذن التنبيه الدقيق!");
        Get.snackbar("خطأ", "يجب منح إذن التنبيه الدقيق لجدولة الإشعارات",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      DateTime scheduledTime = DateTime.parse(date);
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime tzScheduledTime =
          tz.TZDateTime.from(scheduledTime, tz.local);

      print("📅 تم جدولة تذكير الدواء (UTC): $scheduledTime");
      print("⏳ تم تحويله إلى التوقيت المحلي: $tzScheduledTime");

      if (tzScheduledTime.isBefore(now)) {
        print(
            "🛑 لا يمكن جدولة إشعار في وقت ماضٍ. سيتم ضبطه بعد 10 ثوانٍ من الآن.");
        tzScheduledTime = now.add(Duration(seconds: 10));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id.hashCode,
        "💊 تذكير بالدواء",
        "🕒 حان وقت تناول الدواء: $name",
        tzScheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'medicine_channel',
            'تذكيرات الدواء',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            channelShowBadge: true,
            visibility: NotificationVisibility.public,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );

      print("✅ تم ضبط الإشعار للدواء في (التوقيت المحلي): $tzScheduledTime");

      Get.snackbar("نجاح", "تم جدولة تذكير الدواء بنجاح!",
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      print("❌ خطأ في جدولة الإشعار: $e");

      // Get.snackbar("خطأ", "حدثت مشكلة أثناء جدولة التذكير: $e",
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> isAndroid12OrAbove() async {
    if (Platform.isAndroid) {
      return (await Process.run('getprop', ['ro.build.version.sdk']))
              .stdout
              .trim()
              .compareTo('31') >=
          0;
    }
    return false;
  }
}
