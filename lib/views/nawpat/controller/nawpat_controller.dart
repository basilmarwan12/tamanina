import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamanina/main.dart';
import 'package:tamanina/models/nawpat.dart';
import 'package:timezone/timezone.dart' as tz;

class NawpatController extends GetxController {
  var isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Nawpat> nawpatList = <Nawpat>[].obs;
  RxInt ringCount = 0.obs;

  final TextEditingController nameController = TextEditingController();
  var timeText = "".obs;
  final TextEditingController digController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedType;
  String selectedOption = 'نعم';

  @override
  void onInit() async {
    super.onInit();
    await fetchNawpatData(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> fetchNawpatData(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await firestore
          .collection('nawpat')
          .where('userId', isEqualTo: userId)
          .get();

      print(querySnapshot.docs);

      nawpatList.value = querySnapshot.docs.map((doc) {
        return Nawpat.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "فشل تحميل بيانات النوبات: $e");
    }
  }

  Future<void> addNawpatData() async {
    try {
      isLoading.value = true;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DateTime selectedDate =
          DateTime.tryParse(timeText.value) ?? DateTime.now();
      String arabicDay = getArabicDay(selectedDate.weekday);

      Nawpat newNawpat = Nawpat(
        id: '',
        userId: userId,
        name: nameController.text,
        date: timeText.value,
        day: arabicDay,
        symptoms: digController.text,
        type: selectedType ?? '',
        selection: selectedOption,
        duration: durationController.text,
        location: locationController.text,
      );

      DocumentReference docRef =
          await firestore.collection('nawpat').add(newNawpat.toMap());

      await docRef.update({'id': docRef.id});

      await scheduleNotification(newNawpat);

      isLoading.value = false;
      Get.snackbar('نجاح', 'تمت إضافة البيانات بنجاح',
          backgroundColor: Colors.green);

      clearFields();
    } catch (e) {
      isLoading.value = false;
      print(e);
      Get.snackbar('خطأ', 'فشل في إضافة البيانات: $e');
    }
  }

  Future<void> scheduleNotification(Nawpat nawpat) async {
    try {
      DateTime scheduledTime = DateTime.parse(nawpat.date);
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime tzScheduledTime =
          tz.TZDateTime.from(scheduledTime, tz.local);

      print("📅 Scheduled Time (UTC): $scheduledTime");
      print("⏳ Converted to Local Time: $tzScheduledTime");

      if (tzScheduledTime.isBefore(now)) {
        print(
            "🛑 Cannot schedule a past notification. Adjusting to 10 seconds from now.");

        tzScheduledTime = now.add(Duration(seconds: 10));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        nawpat.id.hashCode,
        "🔔 تذكير بالنوبة!",
        "📅 ${nawpat.name} - لديك نوبة مجدولة في ${tzScheduledTime.toLocal()}",
        tzScheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'nawpat_channel',
            'Nawpat Reminders',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );

      print("✅ Notification will trigger at (Local Time): $tzScheduledTime");
    } catch (e) {
      print("❌ Error scheduling notification: $e");
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

  void clearFields() {
    nameController.clear();
    timeText.value = "";
    digController.clear();
    durationController.clear();
    locationController.clear();
    selectedType = null;
    selectedOption = 'نعم';
    update();
  }

  String getArabicDay(int weekday) {
    Map<int, String> daysInArabic = {
      1: "الإثنين",
      2: "الثلاثاء",
      3: "الأربعاء",
      4: "الخميس",
      5: "الجمعة",
      6: "السبت",
      7: "الأحد"
    };
    return daysInArabic[weekday] ?? "غير معروف";
  }
}
