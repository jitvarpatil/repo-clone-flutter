import 'dart:io';

class DemoMetaInfoConstants {
  static String name = "master_app";
  static String type = "sample-app";
  static String version = "1.0.0";
  static String bundle = Platform.isAndroid
      ? "com.cometchat.master_app"
      : "com.cometchat.sampleApp";
  static String platform = "Flutter";
}
