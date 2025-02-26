import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

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

  Future<void> fetchNotificationCount() async {
    final List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    print(activeNotifications);
    notificationCount.value = activeNotifications.length;
    notificationList.value = activeNotifications
        .map((n) => "${n.title ?? 'إشعار'}: ${n.body ?? 'تفاصيل غير متاحة'}")
        .toList();
  }

  void clearNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
    notificationCount.value = 0;
    notificationList.clear();
  }
}
