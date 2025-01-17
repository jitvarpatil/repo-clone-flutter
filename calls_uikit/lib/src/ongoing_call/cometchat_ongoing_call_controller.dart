import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///[CometChatOngoingCallController] is a view model class which manages the state of [CometChatOngoingCall] widget.
class CometChatOngoingCallController extends GetxController
    with CometChatCallsEventsListener {
  /// [callingWidget] is used to store the calling widget received from cometchat calls sdk.
  Widget? callingWidget;
  late BuildContext context;

  /// [callSettingsBuilder] is used to build the call settings.
  CallSettingsBuilder callSettingsBuilder;

  /// [sessionId] is used to store the session id of the call.
  final String sessionId;

  /// [errorHandler] is used to handle the error.
  final OnError? errorHandler;
  bool isCallEndedByMe = false;

  /// [callWorkFlow] is used to determine the type of call workflow which is used to end the call.
  final CallWorkFlow? callWorkFlow;

  /// [CometChatOngoingCallController] is a constructor which requires [callSettingsBuilder], [sessionId], [errorHandler] and [callWorkFlow] as a parameter.
  CometChatOngoingCallController(
      {required this.callSettingsBuilder,
      required this.sessionId,
      this.errorHandler,
      this.callWorkFlow});

  @override
  void onInit() {
    super.onInit();
    loadCallingScreen();
  }

  /// [loadCallingScreen] is used to load the calling screen.
  void loadCallingScreen() async {
    String? userAuthToken = await CometChatUIKitCalls.getUserAuthToken();
    //check if user auth token is null then exit
    if (userAuthToken == null) {
      return;
    }
    //we need to generate token for the start session
    CometChatUIKitCalls.generateToken(sessionId, userAuthToken,
        onSuccess: (generatedToken) {
      String? callToken = generatedToken.token;
      if (callToken == null) {
        return;
      }
      CallSettings callSettings =
          (callSettingsBuilder..listener = this).build();
      //start session
      CometChatUIKitCalls.startSession(
        callToken,
        callSettings,
        onSuccess: (screen) {
          callingWidget = screen;
          update();
        },
        onError: (error) {
          if (kDebugMode) {
            debugPrint(
                'caught in startSession call could not be ended: ${error.message}');
          }
          if (errorHandler != null) {
            try {
              errorHandler!(error);
            } catch (e) {
              if (kDebugMode) {
                debugPrint(
                    'call session could not be started and something went wrong while handling error: $e');
              }
            }
          }
        },
      );
    });
  }

  @override
  void onAudioModeChanged(List<AudioMode> devices) {}

  @override
  void onCallEndButtonPressed() {
    if (callWorkFlow == CallWorkFlow.directCalling) {
      _endSession();
    } else {
      isCallEndedByMe = true;
      update();
    }
  }

  @override
  void onCallEnded() {
    if (callWorkFlow == CallWorkFlow.defaultCalling) {
      if (isCallEndedByMe) {
        _endCall();
      } else {
        _endSession();
      }
    }
  }

  _endCall() {
    CometChat.endCall(
      sessionId,
      onSuccess: (call) {
        _handleCallEnd(call);
      },
      onError: (error) {
        if (kDebugMode) {
          debugPrint(
              'caught in onCallEnded call could not be ended: ${error.message}');
          debugPrint(
              'caught in onCallEnded call could not be ended: ${error.code}');
          debugPrint(
              'caught in onCallEnded call could not be ended: ${error.details}');
        }
        if (errorHandler != null) {
          try {
            errorHandler!(error);
          } catch (e) {
            if (kDebugMode) {
              debugPrint(
                  'call could not be ended and something went wrong while handling error: $e');
            }
          }
        }
        _handleCallEnd(null);
      },
    );
  }

  void _handleCallEnd(Call? call) {
    if (call != null) {
      call.category = MessageCategoryConstants.call;
      CometChatCallEvents.ccCallEnded(call);
    }
    Navigator.pop(context);
  }

  _endSession() {
    CometChatUIKitCalls.endSession(
      onSuccess: (message) {
        CometChat.clearActiveCall();
        Navigator.pop(context);
      },
      onError: (error) {
        if (kDebugMode) {
          debugPrint(
              'caught in endSession call could not be ended: ${error.message}');
        }
        if (errorHandler != null) {
          try {
            errorHandler!(error);
          } catch (e) {
            if (kDebugMode) {
              debugPrint(
                  'call session could not be ended and something went wrong while handling error: $e');
            }
          }
        }
      },
    );
  }

  @override
  void onCallSwitchedToVideo(CallSwitchRequestInfo info) {}

  @override
  void onError(CometChatCallsException ce) {}

  @override
  void onRecordingToggled(RTCRecordingInfo info) {}

  @override
  void onUserJoined(RTCUser user) {}

  @override
  void onUserLeft(RTCUser user) {}

  @override
  void onUserListChanged(List<RTCUser> users) {}

  @override
  void onUserMuted(RTCMutedUser muteObj) {}
}
