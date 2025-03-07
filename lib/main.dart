import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tamanina/views/home/view/home_screen.dart';
import 'package:tamanina/welcome_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'cache/shared_cache.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  if (await Permission.notification.isGranted) {
    print("✅ إذن التنبيه الدقيق ممنوح بالفعل");
  }
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await StorageService.getLoginState();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tamanina',
          locale: Locale('ar', 'EG'),
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'EG'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return locale ?? supportedLocales.first;
          },
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Cairo',
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: isLoggedIn ? HomeScreen() : WelcomeScreen(),
        );
      },
    );
  }
}
