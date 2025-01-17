import 'package:get/get.dart';

// Singleton Controller Class
class CallStateController extends GetxController {
  // Private constructor for singleton
  CallStateController._();

  // Singleton instance
  static final CallStateController instance = CallStateController._();

  // Observable variable
  var isActiveCall = false.obs;

  // Method to toggle the value
  void toggleValue() {
    isActiveCall.value = !isActiveCall.value;
  }

  // Method to set a specific value
  void setValue(bool value) {
    isActiveCall.value = value;
  }
}
