import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as kit;

/// [CometChatOutgoingCallController] is the view model class for [CometChatOutgoingCall]
class CometChatOutgoingCallController extends GetxController
    with CometChatCallEventListener, CallListener {
  ///[onError] is called when some error occurs
  final OnError? onError;

  late String _listenerId;
  final Call activeCall;
  late BuildContext context;

  ///[onDeclineCallTap] is used to define the callback for the widget when decline call button is tapped.
  final Function(BuildContext, Call)? onDeclineCallTap;

  ///[disableSoundForCalls] is used to define whether to disable sound for call or not.
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to define the custom sound for calls.
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[callSettingsBuilder] is used to set the call settings
  final CallSettingsBuilder? callSettingsBuilder;


  CometChatOutgoingCallController({
    this.onError,
    required this.activeCall,
    this.onDeclineCallTap,
    CometChatTheme? theme,
    this.disableSoundForCalls,
    this.customSoundForCalls,
    this.customSoundForCallsPackage,
    this.callSettingsBuilder,
  });

  CallStateController? _callStateController;

  @override
  void onInit() {
    _callStateController = CallStateController.instance;
    _callStateController?.setActiveOutgoingValue(true);
    _listenerId =
        "outgoingCall${DateTime.now().microsecondsSinceEpoch.toString()}";
    addListeners();

    if (disableSoundForCalls != true) {
      playOutgoingSound();
    }

    super.onInit();
  }

  playOutgoingSound() {
    try {
      CometChatUIKit.soundManager.play(
          sound: Sound.outgoingCall,
          packageName: customSoundForCallsPackage ?? UIConstants.packageName,
          customSound: customSoundForCalls);
      developer.log('sound playing');
    } catch (_) {
      developer.log("Sound not played");
    }
  }

  stopSound() {
    try {
      CometChatUIKit.soundManager.stop();
    } catch (_) {
      developer.log('failed to stop sound player');
    }
  }

  @override
  void onClose() {
    _callStateController?.setActiveOutgoingValue(false);
    removeListeners();
    if (disableSoundForCalls != true) {
      stopSound();
    }
    super.onClose();
    developer.log('executed on close in CometChatOutgoingCallController');
  }

  void rejectCall(BuildContext context, CometChatColorPalette colorPalette,
      CometChatTypography typography) {
    if (onDeclineCallTap != null) {
      onDeclineCallTap!(context, activeCall);
    } else {
      if (activeCall.sessionId != null) {
        CometChatUIKitCalls.rejectCall(
            activeCall.sessionId!, CallStatusConstants.cancelled,
            onSuccess: (Call call) {
          call.category = MessageCategoryConstants.call;
          CometChatCallEvents.ccCallRejected(call);

          developer.log('call was cancelled');
          Navigator.pop(context);
        }, onError: (e) {
          try {
            if (onError != null) {
              onError!(e);
            } else {
              _showError(context, e, colorPalette, typography);
            }

            Navigator.pop(context);
          } catch (err) {
            if (kDebugMode) {
              debugPrint('Error in rejecting call: ${e.message}');
            }
          }
        });
      }
    }
  }

  void addListeners() {
    CometChat.addCallListener(_listenerId, this);
    CometChatCallEvents.addCallEventsListener(_listenerId, this);
  }

  void removeListeners() {
    CometChat.removeCallListener(_listenerId);
    CometChatCallEvents.removeCallEventsListener(_listenerId);
  }

  @override
  void onOutgoingCallAccepted(Call call) {
    bool? isAudioOnly;

    if (call.type == CallTypeConstants.audioCall) {
      isAudioOnly = true;
    }

    CallSettingsBuilder defaultCallSettingsBuilder = (CallSettingsBuilder()
      ..enableDefaultLayout = true
      ..setAudioOnlyCall = isAudioOnly);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatOngoingCall(
            callSettingsBuilder:
                callSettingsBuilder ?? defaultCallSettingsBuilder,
            sessionId: call.sessionId!,
            callWorkFlow: CallWorkFlow.defaultCalling,
          ),
        ));

    developer.log('outgoing call was accepted');
  }

  @override
  void onOutgoingCallRejected(Call call) {
    Navigator.pop(context);
    developer.log('outgoing call was rejected');
  }

  void _showError(BuildContext context, CometChatException e,
      CometChatColorPalette colorPalette, CometChatTypography typography) {
    try {
      var snackBar = SnackBar(
        backgroundColor: colorPalette.error,
        content: Text(
          kit.Translations.of(context).somethingWentWrongError,
          style: TextStyle(
            color: colorPalette.white,
            fontSize: typography.button?.medium?.fontSize,
            fontWeight: typography.button?.medium?.fontWeight,
            fontFamily: typography.button?.medium?.fontFamily,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error while displaying snackBar: $e");
      }
    }
  }
}
