import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

class IncomingCallOverlay {
  static OverlayEntry? _overlayEntry;

  // Show incoming call overlay
  static void show({
    required BuildContext context,
    required Call call,
    User? user,
    OnError? onError,
    Widget? subtitle,
    Function(BuildContext, Call)? onDecline,
    Function(BuildContext, Call)? onAccept,
    bool? disableSoundForCalls,
    String? customSoundForCalls,
    String? customSoundForCallsPackage,
    CometChatIncomingCallStyle? style,
    CallSettingsBuilder? callSettingsBuilder,
    double? height,
    double? width,
    String? declineButtonText,
    String? acceptButtonText,
  }) {

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40.0,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: CometChatIncomingCall(
            call: call,
            user: user,
            onError: onError,
            subtitle: subtitle,
            onDecline: onDecline,
            onAccept: onAccept,
            disableSoundForCalls: disableSoundForCalls,
            customSoundForCalls: customSoundForCalls,
            customSoundForCallsPackage: customSoundForCallsPackage,
            style: style,
            callSettingsBuilder: callSettingsBuilder,
            height: height,
            width: width,
            declineButtonText: declineButtonText,
            acceptButtonText: acceptButtonText,
          ),
        ),
      ),
    );


    if (CallNavigationContext.navigatorKey.currentState?.overlay != null && _overlayEntry != null) {
      CallNavigationContext.navigatorKey.currentState!.overlay!.insert(_overlayEntry!);
    } else {
      debugPrint("Overlay is null, cannot insert entry.");
    }
  }

  // Dismiss incoming call overlay
  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
