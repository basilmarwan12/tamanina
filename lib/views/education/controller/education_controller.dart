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
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addEducation(String date, String notes) async {
    try {
      isLoading(true);
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("education")
          .add({
        "date": date,
        "notes": notes,
        "userId": FirebaseAuth.instance.currentUser!.uid
      });

      await scheduleEducationNotification(docRef.id, notes, date);

      Get.snackbar("نجاح", "تمت إضافة التذكير الدراسي بنجاح!");
      await fetchEducations(FirebaseAuth.instance.currentUser!.uid);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading(false);
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

  Future<bool> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isGranted) {
        print("🔔 إذن الإشعارات مفعّل بالفعل.");
        return true;
      }

      final PermissionStatus status = await Permission.notification.request();

      if (status.isGranted) {
        print("✅ تم منح إذن الإشعارات.");
        return true;
      } else {
        print("❌ إذن الإشعارات مرفوض.");
        Get.snackbar(
          "خطأ",
          "يرجى منح إذن الإشعارات لضمان تلقي التذكيرات",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }
    return true;
  }

  Future<void> scheduleEducationNotification(
      String id, String title, String date) async {
    try {
      print("📅 تاريخ التذكير الدراسي: $date");

      bool notificationsGranted = await requestNotificationPermission();
      bool exactAlarmGranted = await requestExactAlarmPermission();

      if (!notificationsGranted || !exactAlarmGranted) {
        print("❌ لا يمكن جدولة التذكير بدون الأذونات المطلوبة!");
        Get.snackbar("خطأ",
            "يجب منح إذن التنبيه الدقيق وإشعارات النظام لجدولة التذكيرات الدراسية",
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

      int notificationId =
          DateTime.now().millisecondsSinceEpoch.remainder(100000);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
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
      // Get.snackbar("خطأ", "حدثت مشكلة أثناء جدولة التذكير الدراسي: $e",
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
