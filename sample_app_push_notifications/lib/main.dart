import 'dart:async';
import 'dart:ui';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:master_app/guard_screen.dart';
import 'notifications/services/firebase_services.dart';
import 'notifications/services/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(
      ));

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: handleNotificationTap,
  );
  try {
    print('Firebase initialized. BEFORE TRY');
    await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully.');
  } catch (e) {
    print('Firebase initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initServices();
    super.initState();
  }

  initServices() async {
    SharedPreferencesClass.init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CometChat Flutter Sample App',
      home: GuardScreen(
        key: CallNavigationContext.navigatorKey,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
