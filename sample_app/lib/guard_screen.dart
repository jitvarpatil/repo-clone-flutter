import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:sample_app/app_credentials.dart';
import 'package:sample_app/auth/login_app_credential.dart';
import 'package:sample_app/auth/login_sample_users.dart';
import 'package:sample_app/dashboard.dart';
import 'package:sample_app/demo_meta_info_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({Key? key}) : super(key: key);

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  bool? shouldGoToHomeScreen;

  late CometChatColorPalette colorPalette;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize typography, color palette, and spacing
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    if (AppCredentials.appId.isNotEmpty ||
        AppCredentials.authKey.isNotEmpty ||
        AppCredentials.region.isNotEmpty) {
      init();
    }
  }

  getCallButtonConfiguration() {
    return CallButtonsConfiguration(
        callButtonsStyle: CometChatCallButtonsStyle(
      voiceCallIconColor: colorPalette.iconPrimary,
      videoCallIconColor: colorPalette.iconPrimary,
    ));
  }

  init() async {
    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = AppCredentials.region
          ..autoEstablishSocketConnection = true
          ..appId = AppCredentials.appId
          ..authKey = AppCredentials.authKey
          ..callingExtension = CometChatCallingExtension()
          ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions()
          ..aiFeature = CometChatUIKitChatAIFeatures.getDefaultAiFeatures())
        .build();

    CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (successMessage) async {
        alreadyLoggedIn(context);
        try {
          CometChat.setDemoMetaInfo(jsonObject: {
            "name": DemoMetaInfoConstants.name,
            "type": DemoMetaInfoConstants.type,
            "version": DemoMetaInfoConstants.version,
            "bundle": DemoMetaInfoConstants.bundle,
            "platform": DemoMetaInfoConstants.platform,
          });
        } catch (e) {
          if (kDebugMode) {
            debugPrint("setDemoMetaInfo ended with error");
          }
        }
      },
    );
    debugPrint("CallingExtension enable with context called in login");
  }

  alreadyLoggedIn(context) async {
    final user = await CometChatUIKit.getLoggedInUser();
    if (user != null) {
      await CometChatUIKit.login(
        user.uid,
        onSuccess: (user) {
          setState(() {
            shouldGoToHomeScreen = true;
          });
        },
        onError: (excep) {
          if (kDebugMode) {
            print("Error while logging in: ${excep.message}");
          }
        },
      );
    } else {
      setState(() {
        shouldGoToHomeScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppCredentials.appId.isEmpty ||
        AppCredentials.authKey.isEmpty ||
        AppCredentials.region.isEmpty) {
      return const LoginAppCredential();
    }

    return (shouldGoToHomeScreen == null)
        ? Material(
            color: colorPalette.background1,
            child: const SizedBox(),
          )
        : (shouldGoToHomeScreen!
            ? const MyHomePage()
            : const LoginSampleUsers());
  }
}
