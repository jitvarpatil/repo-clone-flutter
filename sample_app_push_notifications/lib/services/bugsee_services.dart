import 'dart:async';
import 'dart:io';
import 'package:bugsee_flutter/bugsee.dart';
import 'package:flutter/foundation.dart';

class BugseeServices {
  static String getApplicationToken() {
    return Platform.isAndroid
        ? '4ba69025-5c82-4e40-8b40-42e33ae1940e'
        : (Platform.isIOS ? 'f54bb048-eeb6-4b9d-9ce7-f39de9360369' : '');
  }

  static Future<void> launchBugsee(
      Future<void> Function(bool isBugseeLaunched) appRunner) async {
    // Allow Bugsee to intercept network requests
    HttpOverrides.global = Bugsee.defaultHttpOverrides;

    final BugseeLaunchOptions launchOptions =
        Platform.isAndroid ? AndroidLaunchOptions() : IOSLaunchOptions();
    launchOptions.captureDeviceAndNetworkNames = false;
    launchOptions.captureLogs = false;
    launchOptions.crashReport = false;
    await Bugsee.launch(
      // launchOptions: (kDebugMode) ? launchOptions : null,
      getApplicationToken(),
      appRunCallback: (bool isBugseeLaunched) {
        // Re-run in the main zone to avoid zone mismatch
        Zone.root.run(() {
          appRunner(isBugseeLaunched);
        });
      },
    );
  }
}
