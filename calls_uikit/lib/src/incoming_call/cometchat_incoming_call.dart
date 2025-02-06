import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

///[CometChatIncomingCall] is a widget which is used to display incoming call.
///when the logged in user receives a call, this widget will be invoked.
///
/// ```dart
/// CometChatIncomingCall(
/// user: user,
/// subtitle: 'Incoming Call',
/// declineButtonText: 'Decline',
/// declineButtonTextStyle: TextStyle(color: Colors.white),
/// declineButtonIconUrl: 'assets/images/decline.png',
/// declineButtonIconUrlPackage: 'assets',
/// acceptButtonText: 'Accept',
/// acceptButtonTextStyle: TextStyle(color: Colors.white),
/// acceptButtonIconUrl: 'assets/images/accept.png',
/// acceptButtonIconUrlPackage: 'assets',
/// );
/// ```
///
//ignore: must_be_immutable
class CometChatIncomingCall extends StatelessWidget {
  ///[user] is used to set a custom user for the widget
  final User? user;

  ///[subtitle] is used to set a custom subtitle
  final Widget? subtitle;

  ///[style] is used to set a custom incoming call style
  final CometChatIncomingCallStyle? style;

  ///[_incomingCallController] contains view model for [CometChatIncomingCall] widget
  final CometChatIncomingCallController _incomingCallController;

  ///[callSettingsBuilder] is used to set the call settings
  final CallSettingsBuilder? callSettingsBuilder;

  ///[height] is used to set the height of the widget.
  final double? height;

  ///[width] is used to set the width of the widget.
  final double? width;

  ///[declineButtonText] is used to set a custom decline text
  final String? declineButtonText;

  ///[acceptButtonText] is used to set a custom accept text
  final String? acceptButtonText;

  ///[callIcon] is used to set a custom call icon
  final Widget? callIcon;

  CometChatIncomingCall({
    Key? key,
    required Call call,
    this.user,
    OnError? onError,
    this.subtitle,
    Function(BuildContext, Call)? onDecline,
    Function(BuildContext, Call)? onAccept,
    bool? disableSoundForCalls,
    String? customSoundForCalls,
    String? customSoundForCallsPackage,
    this.style,
    this.callSettingsBuilder,
    this.height,
    this.width,
    this.declineButtonText,
    this.acceptButtonText,
    this.callIcon
  })  : _incomingCallController = CometChatIncomingCallController(
          onAccept: onAccept,
          onDecline: onDecline,
          activeCall: call,
          onError: onError,
          disableSoundForCalls: disableSoundForCalls,
          customSoundForCalls: customSoundForCalls,
          customSoundForCallsPackage: customSoundForCallsPackage,
          callSettingsBuilder: callSettingsBuilder,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final incomingCallStyle =
        CometChatThemeHelper.getTheme<CometChatIncomingCallStyle>(
                context: context, defaultTheme: CometChatIncomingCallStyle.of)
            .merge(style);
    final typography = CometChatThemeHelper.getTypography(context);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final spacing = CometChatThemeHelper.getSpacing(context);

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(context).popScreenDisabled,
              style: TextStyle(
                color: colorPalette.white,
                fontSize: typography.button?.medium?.fontSize,
                fontWeight: typography.button?.medium?.fontWeight,
                fontFamily: typography.button?.medium?.fontFamily,
              ),
            ),
            backgroundColor: colorPalette.error,
          ),
        );
        return false;
      },
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(spacing.padding5 ?? 0),
        decoration: BoxDecoration(
          color: incomingCallStyle.backgroundColor ?? colorPalette.background3,
          border: incomingCallStyle.border ??
              Border.all(
                width: 1,
                color: colorPalette.borderLight ?? Colors.transparent,
              ),
          borderRadius: incomingCallStyle.borderRadius ??
              BorderRadius.circular(
                spacing.radius3 ?? 0,
              ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10182808),
              offset: Offset(0, 4),
              blurRadius: 6,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Color(0x10182814),
              offset: Offset(0, 12),
              blurRadius: 16,
              spreadRadius: -4,
            ),
          ],
        ),
        child: GetBuilder(
          init: _incomingCallController,
          global: false,
          dispose: (GetBuilderState<CometChatIncomingCallController> state) =>
              state.controller?.onClose(),
          builder: (CometChatIncomingCallController viewModel) {
            viewModel.context = context;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: spacing.padding4 ?? 0,
                  ),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    minLeadingWidth: 0,
                    minVerticalPadding: 0,
                    minTileHeight: 0,
                    trailing: CometChatAvatar(
                      height: 48,
                      width: 48,
                      image: user?.avatar,
                      name: user?.name,
                      style: CometChatAvatarStyle(
                        placeHolderTextStyle: TextStyle(
                          fontSize: typography.heading1?.bold?.fontSize,
                          fontWeight: typography.heading1?.bold?.fontWeight,
                          fontFamily: typography.heading1?.bold?.fontFamily,
                        ).merge(
                          incomingCallStyle.avatarStyle?.placeHolderTextStyle,
                        ),
                        backgroundColor:
                            incomingCallStyle.avatarStyle?.backgroundColor,
                        placeHolderTextColor:
                            incomingCallStyle.avatarStyle?.placeHolderTextColor,
                        borderRadius:
                            incomingCallStyle.avatarStyle?.borderRadius,
                        border: incomingCallStyle.avatarStyle?.border,
                      ),
                    ),
                    title: Text(
                      user?.name ?? '',
                      style: TextStyle(
                        fontSize: typography.heading1?.bold?.fontSize,
                        fontWeight: typography.heading1?.bold?.fontWeight,
                        fontFamily: typography.heading1?.bold?.fontFamily,
                        color: incomingCallStyle.titleColor ??
                            colorPalette.textPrimary,
                      )
                          .merge(
                            incomingCallStyle.titleTextStyle,
                          )
                          .copyWith(
                            color: incomingCallStyle.titleColor,
                          ),
                    ),
                    subtitle: subtitle ??
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: spacing.padding ?? 0,
                              ),
                              child: callIcon ?? Icon(
                                Icons.call,
                                color: incomingCallStyle.callIconColor ?? colorPalette.iconSecondary,
                                size: 16,
                              ),
                            ),
                            Text(
                              viewModel.getSubtitle(context),
                              style: TextStyle(
                                fontSize: typography.body?.regular?.fontSize,
                                fontWeight:
                                    typography.body?.regular?.fontWeight,
                                fontFamily:
                                    typography.body?.regular?.fontFamily,
                                color: incomingCallStyle.subtitleColor ??
                                    colorPalette.textSecondary,
                              )
                                  .merge(
                                    incomingCallStyle.subtitleTextStyle,
                                  )
                                  .copyWith(
                                    color: incomingCallStyle.subtitleColor,
                                  ),
                            ),
                          ],
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: spacing.padding2 ?? 0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            viewModel.rejectCall(
                                context, colorPalette, typography);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              incomingCallStyle.declineButtonColor ??
                                  colorPalette.error,
                            ),
                            side: WidgetStateProperty.all(
                              BorderSide(
                                color: colorPalette.borderDark ??
                                    Colors.transparent,
                                width: 1,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                  color: colorPalette.borderDark ??
                                      Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    spacing.radius2 ?? 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            declineButtonText ??
                                Translations.of(context).decline,
                            style: TextStyle(
                              fontSize: typography.button?.medium?.fontSize,
                              fontWeight: typography.button?.medium?.fontWeight,
                              fontFamily: typography.button?.medium?.fontFamily,
                              color: incomingCallStyle.declineTextColor ??
                                  colorPalette.buttonIconColor,
                            )
                                .merge(
                                  incomingCallStyle.declineTextStyle,
                                )
                                .copyWith(
                                  color: incomingCallStyle.declineTextColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (viewModel.disabled == false) {
                            viewModel.acceptCall(
                                context, colorPalette, typography);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            incomingCallStyle.acceptButtonColor ??
                                colorPalette.success,
                          ),
                          side: WidgetStateProperty.all(
                            BorderSide(
                              color:
                                  colorPalette.borderDark ?? Colors.transparent,
                              width: 1,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: colorPalette.borderDark ??
                                    Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  spacing.radius2 ?? 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          acceptButtonText ?? Translations.of(context).accept,
                          style: TextStyle(
                            fontSize: typography.button?.medium?.fontSize,
                            fontWeight: typography.button?.medium?.fontWeight,
                            fontFamily: typography.button?.medium?.fontFamily,
                            color: incomingCallStyle.acceptTextColor ??
                                colorPalette.buttonIconColor,
                          )
                              .merge(
                                incomingCallStyle.acceptTextStyle,
                              )
                              .copyWith(
                                color: incomingCallStyle.acceptTextColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
