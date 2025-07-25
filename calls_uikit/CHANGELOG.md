## 5.0.4

## Enhancements
- Updated `cometchat_uikit_shared` to version `5.0.4`.

## Fixes
- Updated call icons in the Call tab to distinguish between incoming and missed calls more clearly.
- Resolved an issue where the app was rejected due to the use of deprecated media permissions. The permissions have been updated to comply with current platform requirements.

## 5.0.3

## Enhancements
- Updated `cometchat_sdk` to version `4.0.23`.
- Updated `cometchat_uikit_shared` to version `5.0.3`.

## Fixes
- Fixed an issue where the ringtone continued ringing even after the call had ended following a single ring.

## 5.0.2

## Enhancements
- Updated `cometchat_uikit_shared` to version `5.0.2`.

## Fixes
- Resolved a crash that occurred when users double-tapped the "End Call" button and then immediately initiated a new call.

## 5.0.1

## Enhancements
- Updated `cometchat_sdk` to version `4.0.22`.
- Updated `cometchat_uikit_shared` to version `5.0.1`.
- Updated `cometchat_calls_sdk` to version `4.1.0`.

## Fixes
- Addressed an issue preventing call initiation after the app was force-closed during an ongoing call.
- Fixed a bug where the call screen remained visible after the device screen was turned off.

## 5.0.0

## Enhancements
- Updated `cometchat_uikit_shared` to version `5.0.0`.
- Updated properties for all components to improve flexibility, customization, and overall usability.
- Enhanced the **Call Logs Component** with refined properties for better filtering and call log management.
- Improved the **Incoming Call Component** by introducing configurable properties for handling call notifications.
- Optimized the **Call Buttons Component**, allowing better control over button actions and styles.
- Upgraded the **Outgoing Call Component** with new properties to support call customization.

## 5.0.0-beta.2

## Enhancements
- Updated `cometchat_uikit_shared` to version `5.0.0-beta.2`.
- Updated properties for all components to improve flexibility, customization, and overall usability.
- Enhanced the **Call Logs Component** with refined properties for better filtering and call log management.
- Improved the **Incoming Call Component** by introducing configurable properties for handling call notifications.
- Optimized the **Call Buttons Component**, allowing better control over button actions and styles.
- Upgraded the **Outgoing Call Component** with new properties to support call customization.

## Fixes
- **Call Icon Behavior**: Fixed an issue where tapping the call icon displayed call details instead of initiating a call.

## 5.0.0-beta.1

## New
- **Revamped UI**: Experience a fresh, modern design for improved visual appeal and consistency. The updated look enhances usability and engagement.
- **Restructured Components**: Enjoy a redesigned component architecture that improves scalability, making it easier to build and maintain modular designs.

## Enhancements
- **Optimized User Experience**: Interactions have been streamlined to provide a smoother, more intuitive experience, reducing friction during use.
- **Advanced Styling and Theming**: Gain greater flexibility with enhanced customization options, allowing you to tailor appearances to suit your brand effortlessly.
- **Simplified Integration**: Set up faster and with ease thanks to a more intuitive, streamlined integration process.

## Fixes
- None

## Removals
- **Style Props Removed**: Style-specific props have been deprecated to encourage the use of modern theming practices, which offer more robust and scalable customization options.

## 5.0.0-alpha.1

## New
- **Revamped UI**: Experience a fresh, modern design for improved visual appeal and consistency. The updated look enhances usability and engagement.
- **Restructured Components**: Enjoy a redesigned component architecture that improves scalability, making it easier to build and maintain modular designs.

## Enhancements
- **Optimized User Experience**: Interactions have been streamlined to provide a smoother, more intuitive experience, reducing friction during use.
- **Advanced Styling and Theming**: Gain greater flexibility with enhanced customization options, allowing you to tailor appearances to suit your brand effortlessly.
- **Simplified Integration**: Set up faster and with ease thanks to a more intuitive, streamlined integration process.

## Fixes
- None

## Removals
- **Style Props Removed**: Style-specific props have been deprecated to encourage the use of modern theming practices, which offer more robust and scalable customization options.

## 4.3.4

**Enhancements**
- Added a check to ensure users cannot navigate back from the group call screen, preventing multiple views of the same user when trying to rejoin the call after going back to Message List.
- Updated `cometchat_uikit_shared` to version `4.4.9`.
- Updated `cometchat_sdk` to version `4.0.17`.


## 4.3.3
**Enhancements**
- Updated `cometchat_uikit_shared` to version `4.4.4`.
- Updated `cometchat_sdk` to version `4.0.14`.

**Fixes**
- Added logic to manually clear active call object using `CometChat.clearActiveCall()` when a call ends unexpectedly, allowing subsequent call initiation.

## 4.3.2
**New**
- Introduced real-time updates for the last message and unread count in conversations based on App setting configured via dashboard, ensuring up-to-date information is displayed.

**Enhancements**
- Updated `cometchat_uikit_shared` to version `4.4.2`.
- Updated `cometchat_sdk` to version `4.0.12`.

## 4.3.1

**Enhancements**
- The `cometchat_uikit_shared` dependency has been updated to `4.4.1` for better performance

**Fixes**
- Solved an error popup issue that occurred when the receiver clicks the accept button multiple times when an incoming call is received.

## 4.3.0
**Enhancements**
- Updated all 3rd-party plugins versions.
- Resolved all static Dart Analyser suggestions
- Added namespaces in build.gradle to avoid conflicts.

## 4.2.1
**Enhancements**
- `cometchat_sdk` dependency has been updated to version `4.0.10` for better performance.
- `cometchat_uikit_shared` dependency has been updated to `4.3.0` for better performance
- `contentView` property of `CometChatMessageTemplate` now accepts an optional `AdditionalConfigurations` object as argument to support formatting of text shown in message bubbles.

## 4.2.0
**Enhancements**
- Updated `cometchat_sdk` to version `4.0.8`
- Updated `cometchat_uikit_shared` to version `4.2.9`
- Updated `cometchat_calls_sdk` to version `4.0.4`

## 4.1.1
**New**
- Added `voiceCallIcon` property in `CometChatCallButtons` and `CallButtonsConfiguration`. This property should be used instead of `voiceCallIconURL` and `voiceCallIconPackage` which have been deprecated and should not be used
- Added `videoCallIcon` property in `CometChatCallButtons` and `CallButtonsConfiguration`. This property should be used instead of `videoCallIconURL` and `videoCallIconPackage` which have been deprecated and should not be used

**Enhancements**
- Upgraded `cometchat_sdk` to version `4.0.7`
- Upgraded `cometchat_uikit_shared` to version `4.2.6`
- Upgraded `cometchat_calls_sdk` to version `4.0.3`

**Fixes**
- Removed excess space between the voice call icon and video call icon in `CometChatCallButtons`

## 4.1.0
**Added**
- New components : `CometChatCallLogs`, `CometChatCallLogsWithDetails`, `CometChatCallLogRecordings`, `CometChatCallLogParticipants`, `CometChatCallLogHistory` , `CometChatCallLogDetails`
- Models: `CometChatCallLogDetailsOption`, `CometChatCallLogDetailsTemplate`

**Changed**
- [cometchat_calls_sdk](https://pub.dev/packages/cometchat_calls_sdk) dependency upgraded to `cometchat_calls_sdk: ^4.0.2`
- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.4`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.1.0`

## 4.0.1
**Fixes**
- Issue with ending a user to user call

**Changed**
- [cometchat_calls_sdk](https://pub.dev/packages/cometchat_calls_sdk) dependency upgraded to `cometchat_calls_sdk: ^4.0.1`
- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.2`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.0.2`

## 4.0.0
**Added**
- `CometChatCallingExtension` conforms to the updated `ExtensionsDataSource` class by implementing new methods `addExtension` and `getExtensionId`.
- Properties introduced in `CallBubbleStyle` to configure height, width, background color, border and border radius and join call button background of `CometChatCallBubble`

**Changed**
- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.1`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.0.1`
- [GetX](https://pub.dev/packages/get) dependency upgraded to `get: ^4.6.5`
- Replaced implementation of `SoundManager` with `CometChatUIKit.soundManager`.
- End call flow of `CometChatOngoingCall` updated
- `CometChatIncomingCall` will now display if the call is a audio call or video call

**Removed**
- Unused imports
- Dead code

## 4.0.0-beta.1
- 🎉 First release!

