import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tamanina/main.dart';
import 'package:tamanina/models/education.dart';
import 'package:timezone/timezone.dart' as tz;

class EducationController extends GetxController {
  var isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Education> educationList = <Education>[].obs;
  RxString timeText = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchEducations(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> deleteEducation(String educationId) async {
    isLoading.value = true;
    try {
      await firestore.collection('education').doc(educationId).delete();

      educationList.removeWhere((education) => education.id == educationId);

      Get.snackbar("نجاح", "تم حذف الدواء بنجاح!");
      await fetchEducations(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      Get.snackbar("خطأ", "فشل حذف الدواء: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addEducation(String date, String notes) async {
    isLoading.value = true;
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("education")
          .add({
        "date": date,
        "notes": notes,
        "userId": FirebaseAuth.instance.currentUser!.uid
      });

      await scheduleEducationNotification(docRef.id, notes, date);

      Get.snackbar("نجاح", "تمت إضافة التذكير الدراسي بنجاح!");
      return true;
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء إضافة التذكير الدراسي: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editEducation(String id, String date, String notes) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('education').doc(id).update({
        "date": date,
        "notes": notes,
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .update({
        "education": FieldValue.arrayRemove([
          {"date": date, "notes": notes}
        ]),
        "education": FieldValue.arrayUnion([
          {"date": date, "notes": notes}
        ])
      });

      // // cancel previous notification
      // await flutterLocalNotificationsPlugin.cancel(id.hashCode);

      // // schedule new notification
      // await scheduleEducationNotification(id, notes, date);

      Get.snackbar("Success", "Education updated successfully!");
      await fetchEducations(FirebaseAuth.instance.currentUser!.uid);
      return true;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
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
      print(querySnapshot.docs);
      educationList.value = querySnapshot.docs.map((doc) {
        return Education.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل بيانات التذكيرات الدراسية: $e");
    }
  }

  Future<bool> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      try {
        if (await Permission.scheduleExactAlarm.isGranted) {
          print("✅ إذن التنبيه الدقيق ممنوح بالفعل");
          return true;
        }

        PermissionStatus status = await Permission.scheduleExactAlarm.request();

        if (status.isGranted) {
          print("✅ تم منح إذن التنبيه الدقيق بنجاح");
          return true;
        } else if (status.isDenied) {
          print("⚠️ رفض المستخدم إذن التنبيه الدقيق");
          Get.snackbar(
              "تنبيه", "يجب منح إذن التنبيه الدقيق لجدولة التذكيرات الدراسية",
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

  Future<void> scheduleEducationNotification(
      String id, String title, String date) async {
    try {
      print("📅 تاريخ التذكير الدراسي: $date");

      bool granted = await requestExactAlarmPermission();
      if (!granted) {
        print("❌ لا يمكن جدولة التذكير بدون إذن التنبيه الدقيق!");
        Get.snackbar(
            "خطأ", "يجب منح إذن التنبيه الدقيق لجدولة التذكيرات الدراسية",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      DateTime scheduledTime = DateTime.parse(date);
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime tzScheduledTime =
          tz.TZDateTime.from(scheduledTime, tz.local);

      print("⏳ تم تحويل التوقيت إلى المحلي: $tzScheduledTime");

      if (tzScheduledTime.isBefore(now)) {
        print(
            "🛑 لا يمكن جدولة إشعار في وقت ماضٍ. سيتم ضبطه بعد 10 ثوانٍ من الآن.");
        tzScheduledTime = now.add(Duration(seconds: 10));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id.hashCode,
        "📚 تذكير دراسي",
        "🕒 لديك تذكير دراسي: $title",
        tzScheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'education_channel',
            'تذكيرات الدراسة',
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

      print("✅ تم ضبط التذكير الدراسي في (التوقيت المحلي): $tzScheduledTime");

      Get.snackbar("نجاح", "تم جدولة التذكير الدراسي بنجاح!",
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      print("❌ خطأ في جدولة التذكير الدراسي: $e");

      Get.snackbar("خطأ", "حدثت مشكلة أثناء جدولة التذكير الدراسي: $e",
          snackPosition: SnackPosition.BOTTOM);
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
