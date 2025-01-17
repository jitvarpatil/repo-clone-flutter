import 'package:cometchat_chat_uikit/src/ai/ai_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[CometChatAIConversationStarterView] is a widget that is rendered as the content view for [AIConversationStarterExtension]
///```dart
/// CometChatAiConversationStarterTopView(
///   style: AiConversationStarterStyle(),
///   user: User(),
///   emptyStateText: Text("Error occurred"),
///   loadingStateView: Text("Loading..."),
///   theme: CometChatTheme(),
///   )
/// ```

class CometChatAIConversationStarterView extends StatefulWidget {
  const CometChatAIConversationStarterView(
      {super.key,
      this.user,
      this.group,
      this.style,
      this.emptyStateText,
      this.errorStateText,
      this.theme,
      this.customView,
      this.loadingStateText,
      this.loadingIconUrl,
      this.loadingStateView,
      this.errorIconUrl,
      this.errorStateView,
      this.emptyStateView,
      this.emptyIconUrl,
      this.loadingIconPackageName,
      this.emptyIconPackageName,
      this.errorIconPackageName,
      this.apiConfiguration});

  /// set [User] object, one is mandatory either [user] or [group]
  final User? user;

  ///set [Group] object, one is mandatory either [user] or [group]
  final Group? group;

  ///[style] provides styling to the reply chips/bubbles
  final CometChatAIConversationStarterStyle? style;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[emptyStateText] text to be displayed when the replies are empty
  final String? emptyStateText;

  ///[errorStateText] text to be displayed when error occur
  final String? errorStateText;

  ///[loadingStateText] text to be displayed when loading occur
  final String? loadingStateText;

  ///[loadingIconPackageName] package name for loading icon to be displayed when loading state
  final String? loadingIconPackageName;

  ///[errorIconPackageName] package name for error icon to be displayed when error occur
  final String? errorIconPackageName;

  ///[emptyIconPackageName] package name for empty icon to be displayed when empty state
  final String? emptyIconPackageName;

  ///[customView] gives conversation starter view
  final Widget Function(List<String> replies, BuildContext context)? customView;

  ///[emptyStateView] returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[loadingStateView] returns view for loading state
  final WidgetBuilder? loadingStateView;

  ///[errorStateView] returns view for error state
  final WidgetBuilder? errorStateView;

  ///[errorIconUrl] used to set the error icon
  final String? errorIconUrl;

  ///[emptyIconUrl] used to set the empty icon
  final String? emptyIconUrl;

  ///[loadingIconUrl] used to set the loading icon
  final String? loadingIconUrl;

  ///[apiConfiguration] sets the api call configuration for ai conversation starter
  final Map<String, dynamic>? apiConfiguration;

  @override
  State<CometChatAIConversationStarterView> createState() =>
      _CometChatAIConversationStarterViewState();
}

class _CometChatAIConversationStarterViewState extends State<CometChatAIConversationStarterView>
    with WidgetsBindingObserver {
  List<String> _replies = [];

  bool isLoading = false;

  bool isError = false;

  bool isKeyboardOpen = false;

  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;
  late CometChatAIConversationStarterStyle style;

  @override
  void initState() {
    getReply();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final value = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    if (value > 0 != isKeyboardOpen) {
      setState(() {
        isKeyboardOpen = !isKeyboardOpen;
      });
    }
  }

  @override
  void didChangeDependencies() {
    style =
        CometChatThemeHelper.getTheme<CometChatAIConversationStarterStyle>(
            context: context, defaultTheme: CometChatAIConversationStarterStyle.of)
            .merge(widget.style);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
    typography = CometChatThemeHelper.getTypography(context);
    print("147 style: $style");
    super.didChangeDependencies();
  }


  getReply() async {
    await getReplies();
  }

  Future<void> getReplies() async {
    setState(() {
      isLoading = true;
    });
    _replies.clear();
    String receiverId = "";
    String receiverType = "";
    if (widget.user != null) {
      receiverId = widget.user!.uid;
      receiverType = CometChatReceiverType.user;
    } else if (widget.group != null) {
      receiverId = widget.group!.guid;
      receiverType = CometChatReceiverType.group;
    }
    await CometChat.getConversationStarter(receiverId, receiverType,
        configuration: widget.apiConfiguration, onSuccess: (reply) {
      _replies = reply;
      setState(() {});
    }, onError: (error) {
      if (kDebugMode) {
        debugPrint("Error in AI conversation starter : ${error.details}");
      }
      isError = true;
      setState(() {});
    });
    isLoading = false;
    setState(() {});
  }

  Widget _getOnError(BuildContext context, CometChatTheme theme) {
    if (widget.errorStateView != null) {
      return Center(
        child: widget.errorStateView!(context),
      );
    } else {
      return AIUtils.getOnError(context, theme,
          backgroundColor: style.backgroundColor,
          shadowColor: style.shadowColor,
          errorIconUrl: widget.errorIconUrl,
          errorIconTint: style.errorIconTint,
          errorStateText: widget.errorStateText,
          errorTextStyle: style.errorTextStyle,
          errorIconPackageName: widget.errorIconPackageName);
    }
  }

  Widget _getEmptyView(BuildContext context, CometChatTheme theme) {
    if (widget.emptyStateView != null) {
      return widget.emptyStateView!(context);
    } else {
      return AIUtils.getEmptyView(context, theme,
          backgroundColor: style.backgroundColor,
          shadowColor: style.shadowColor,
          emptyIconUrl: widget.emptyIconUrl,
          emptyIconTint: style.emptyIconTint,
          emptyStateText: widget.emptyStateText,
          emptyTextStyle: style.emptyTextStyle,
          emptyIconPackageName: widget.emptyIconPackageName);
    }
  }

  Widget _getLoadingIndicator(CometChatTheme theme) {
    if (widget.loadingStateView != null) {
      return widget.loadingStateView!(context);
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.padding2 ?? 0, vertical: spacing.padding1 ?? 0),
        child: CometChatShimmerEffect(
          colorPalette: colorPalette,
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.padding3 ?? 0,
                  vertical: spacing.padding2 ?? 0,
                ),
                margin: EdgeInsets.only(
                  bottom: spacing.margin2 ?? 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    spacing.radiusMax ?? 0,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  onClickReply(String reply) async {
    Map<String, dynamic> id = {};
    String receiverId = "";
    if (widget.user != null) {
      receiverId = widget.user!.uid;
    } else if (widget.group != null) {
      receiverId = widget.group!.guid;
    }
    id['uid'] = receiverId;
    id['guid'] = receiverId;
    CometChatUIEvents.hidePanel(id, CustomUIPosition.composerTop);

    CometChatUIEvents.ccComposeMessage(reply, MessageEditStatus.inProgress);
  }

  @override
  Widget build(BuildContext context) {
    return (!isKeyboardOpen)
        ? (widget.customView != null)
                        ? widget.customView!(_replies, context)
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: spacing.padding2 ?? 0, vertical: spacing.padding1 ?? 0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    itemCount: _replies.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, int item) {
                                      return GestureDetector(
                                        onTap: () {
                                          onClickReply(_replies[item]);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: spacing.padding5 ?? 0,
                                              vertical: spacing.padding2 ?? 0),
                                          decoration: BoxDecoration(
                                            color: style.backgroundColor ?? colorPalette.background1,
                                            border: style.border ??
                                                Border.all(
                                                    color:colorPalette.borderLight ?? Colors.transparent,
                                                    width: 1),
                                            borderRadius: style.borderRadius ??
                                                 BorderRadius.all(
                                                  Radius.circular(
                                                    spacing.radiusMax ?? 0,
                                                  ),
                                                ),
                                          ),
                                          child: Text(
                                            _replies[item],
                                            style: style.itemTextStyle ??
                                                TextStyle(
                                                  fontSize: typography.body?.regular?.fontSize,
                                                  fontWeight: typography.body?.regular?.fontWeight,
                                                  color: colorPalette.textPrimary,
                                                ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, int i) {
                                      return const SizedBox(
                                        height: 8,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
        : const SizedBox();
  }
}
