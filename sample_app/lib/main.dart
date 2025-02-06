import 'dart:async';
import 'dart:ui';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
import 'package:master_app/guard_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    super.initState();
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
