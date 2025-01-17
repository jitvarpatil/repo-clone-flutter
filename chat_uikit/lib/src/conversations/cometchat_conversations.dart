import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cometchat_chat_uikit.dart';
import '../../../cometchat_chat_uikit.dart' as cc;

///[CometChatConversations] is a component that shows all conversations involving the logged in user with the help of [CometChatListBase] and [CometChatListItem]
///By default, for each conversation that will be listed, the name of the user or group the logged in user is having conversation with will be displayed in the title of every list item,
///the subtitle will contain the last message in that conversation along with its receipt status, the leading view will contain the avatars of the user and groups and
///status indicator will indicate if users are online and icons for indicating a private or password protected group,
///and the trailing view will contain the time of the last message in that conversation and the number of unread messages.
///
///fetched conversations are listed down according to the order of recent activity
///conversations are fetched using [ConversationsBuilderProtocol] and [ConversationsRequestBuilder]
///
/// ```dart
/// CometChatConversations(
///  avatarStyle: CometChatAvatarStyle(),
///  statusIndicatorStyle: CometChatStatusIndicatorStyle(),
///  badgeStyle: CometChatBadgeStyle(),
///  receiptStyle: CometChatMessageReceiptStyle(),
///  appBarOptions: [],
///  disableUsersPresence: false,
///  disableReceipt: false,
///  hideReceipt: false,
///  protectedGroupIcon: Icon(Icons.lock),
///  privateGroupIcon: Icon(Icons.lock),
///  )
///  ```

class CometChatConversations extends StatelessWidget {
  CometChatConversations({
    super.key,
    this.conversationsProtocol,
    this.subtitleView,
    this.listItemView,
    this.style = const CometChatConversationsStyle(),
    this.controller,
    this.backIcon,
    this.showBackButton = false,
    this.selectionMode,
    this.onSelection,
    this.title,
    this.stateCallBack,
    this.conversationsRequestBuilder,
    this.hideError,
    this.loadingStateText,
    this.emptyStateView,
    this.errorStateView,
    this.listItemStyle,
    this.tailView,
    this.appBarOptions,
    this.disableUsersPresence = false,
    this.hideReceipt,
    this.protectedGroupIcon,
    this.privateGroupIcon,
    this.readIcon,
    this.deliveredIcon,
    this.sentIcon,
    this.activateSelection,
    this.datePattern,
    String? customSoundForMessages,
    bool disableSoundForMessages = false,
    this.typingIndicatorText,
    this.onBack,
    this.onItemTap,
    this.onItemLongPress,
    bool? disableTyping,
    OnError? onError,
    this.hideAppbar = false,
    this.disableMentions,
    this.textFormatters,
    this.datePadding,
    this.dateHeight,
    this.dateBackgroundIsTransparent,
    this.dateWidth,
    this.badgeWidth,
    this.badgeHeight,
    this.badgePadding,
    this.statusIndicatorWidth,
    this.statusIndicatorHeight,
    this.statusIndicatorBorderRadius,
    this.avatarMargin,
    this.avatarPadding,
    this.avatarWidth,
    this.avatarHeight,
  }) : conversationsController = CometChatConversationsController(
          conversationsBuilderProtocol: conversationsProtocol ??
              UIConversationsBuilder(
                conversationsRequestBuilder ?? ConversationsRequestBuilder(),
              ),
          mode: selectionMode,
          disableSoundForMessages: disableSoundForMessages,
          customSoundForMessages: customSoundForMessages,
          disableUsersPresence: disableUsersPresence,
          disableReceipt: hideReceipt,
          hideReceipt: hideReceipt,
          disableTyping: disableTyping,
          onError: onError,
          textFormatters: textFormatters,
          disableMentions: disableMentions,
          mentionsStyle: style.mentionsStyle,
          conversationsStyle: style,
        );

  ///property to be set internally by using passed parameters [conversationsProtocol] ,[selectionMode] ,[options]
  ///these are passed to the [CometChatConversationsController] which is responsible for the business logic
  final CometChatConversationsController conversationsController;

  ///[conversationsProtocol] set custom conversations request builder protocol
  final ConversationsBuilderProtocol? conversationsProtocol;

  ///[conversationsRequestBuilder] set custom conversations request builder
  final ConversationsRequestBuilder? conversationsRequestBuilder;

  ///[subtitleView] to set subtitle for each conversation
  final Widget? Function(BuildContext, Conversation)? subtitleView;

  ///[tailView] to set tailView for each conversation
  final Widget? Function(Conversation)? tailView;

  ///[listItemView] set custom view for each conversation
  final Widget Function(Conversation)? listItemView;

  ///[conversationsStyle] sets style
  final CometChatConversationsStyle style;

  ///[controller] sets controller for the list
  final ScrollController? controller;

  ///[backIcon] back button
  final Widget? backIcon;

  ///[showBackButton] switch on/off back button
  final bool showBackButton;

  ///[selectionMode] specifies mode conversations module is opening in
  final SelectionMode? selectionMode;

  ///[onSelection] function will be performed
  final Function(List<Conversation>?)? onSelection;

  ///[title] sets title for the list
  final String? title;

  ///[loadingStateText] returns view fow loading state
  final WidgetBuilder? loadingStateText;

  ///[emptyStateView] returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[errorStateView] returns view fow error state behind the dialog
  final WidgetBuilder? errorStateView;

  ///[hideError] toggle visibility of error dialog
  final bool? hideError;

  ///[stateCallBack] to access controller functions  from parent pass empty reference of  CometChatConversationsController object
  final Function(CometChatConversationsController controller)? stateCallBack;

  ///[listItemStyle] style for every list item
  final ListItemStyle? listItemStyle;

  ///[appBarOptions] list of options to be visible in app bar
  final List<Widget>? appBarOptions;

  ///[disableUsersPresence] controls visibility of status indicator shown if a user is online
  final bool? disableUsersPresence;

  ///[hideReceipt] controls visibility of read receipts
  final bool? hideReceipt;

  ///[protectedGroupIcon] provides icon in status indicator for protected group
  final Widget? protectedGroupIcon;

  ///[privateGroupIcon] provides icon in status indicator for private group
  final Widget? privateGroupIcon;

  ///[readIcon] provides icon in read receipts if a message is read
  final Widget? readIcon;

  ///[deliveredIcon] provides icon in read receipts if a message is delivered
  final Widget? deliveredIcon;

  ///[sentIcon] provides icon in read receipts if a message is sent
  final Widget? sentIcon;

  ///[activateSelection] lets the widget know if conversations are allowed to be selected
  final ActivateSelection? activateSelection;

  ///[datePattern] is used to generate customDateString for CometChatDate
  final String Function(Conversation conversation)? datePattern;

  ///[typingIndicatorText] if not null is visible instead of default text shown when another user is typing
  final String? typingIndicatorText;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[onItemTap] callback triggered on tapping a conversation item
  final Function(Conversation)? onItemTap;

  ///[onItemLongPress] callback triggered on pressing for long on a conversation item
  final Function(Conversation)? onItemLongPress;

  ///[hideAppbar] toggle visibility for app bar
  final bool? hideAppbar;

  ///[disableMentions] disables formatting of mentions in the subtitle of the conversation
  final bool? disableMentions;

  ///[textFormatters] is a list of text formatters for message bubbles with type text
  final List<CometChatTextFormatter>? textFormatters;

  ///[datePadding] provides padding for [CometChatDate]
  final EdgeInsets? datePadding;

  ///[dateHeight] provides height for [CometChatDate]
  final double? dateHeight;

  ///[dateBackgroundIsTransparent] controls the background of [CometChatDate]
  final bool? dateBackgroundIsTransparent;

  ///[dateWidth] provides width for [CometChatDate]
  final double? dateWidth;

  ///[badgeWidth] provides width for [CometChatBadge]
  final double? badgeWidth;

  ///[badgeHeight] provides height for [CometChatBadge]
  final double? badgeHeight;

  ///[badgePadding] provides padding to the widget
  final EdgeInsetsGeometry? badgePadding;

  ///[avatarWidth] provides width to the widget
  final double? avatarWidth;

  ///[avatarHeight] provides height to the widget
  final double? avatarHeight;

  ///[avatarPadding] provides padding to the widget
  final EdgeInsetsGeometry? avatarPadding;

  ///[avatarMargin] provides margin to the widget
  final EdgeInsetsGeometry? avatarMargin;

  ///[statusIndicatorWidth] provides width to the status indicator
  final double? statusIndicatorWidth;

  ///[statusIndicatorHeight] provides height to the status indicator
  final double? statusIndicatorHeight;

  ///[statusIndicatorBorderRadius] provides borderRadius to the status indicator
  final double? statusIndicatorBorderRadius;

  final RxBool _isSelectionOn = false.obs;

  Widget getDefaultItem(
    Conversation conversation,
    CometChatConversationsController controller,
    BuildContext context,
    CometChatConversationsStyle conversationStyle,
    GlobalKey key,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    Widget? subtitle;
    Widget? tail;
    Color? backgroundColor;
    Widget? icon;

    if (subtitleView != null) {
      subtitle = subtitleView!(
        context,
        conversation,
      );
    } else {
      subtitle = getDefaultSubtitle(
        context: context,
        conversation: conversation,
        showTypingIndicator: controller.typingMap.containsKey(
          conversation.conversationId,
        ),
        hideThreadIndicator: controller.getHideThreadIndicator(
          conversation,
        ),
        controller: controller,
        conversationStyle: conversationStyle,
        colorPalette: colorPalette,
        typography: typography,
        spacing: spacing,
      );
    }
    if (tailView != null) {
      tail = tailView!(
        conversation,
      );
    } else {
      tail = Padding(
        padding: EdgeInsets.only(
          left: spacing.padding2 ?? 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: getTime(
                conversation,
                conversationStyle,
                context,
                colorPalette,
                spacing,
                typography,
              ),
            ),
            const SizedBox(
              height: 6.5,
            ),
            Flexible(
              child: getUnreadCount(
                conversation,
                conversationStyle,
                context,
              ),
            ),
          ],
        ),
      );
    }

    User? conversationWithUser;
    Group? conversationWithGroup;
    if (conversation.conversationWith is User) {
      conversationWithUser = conversation.conversationWith as User;
    } else {
      conversationWithGroup = conversation.conversationWith as Group;
    }

    final statusStyle =
        CometChatThemeHelper.getTheme<CometChatStatusIndicatorStyle>(
                context: context,
                defaultTheme: CometChatStatusIndicatorStyle.of)
            .merge(conversationStyle.statusIndicatorStyle);

    StatusIndicatorUtils statusIndicatorUtils =
        StatusIndicatorUtils.getStatusIndicatorFromParams(
            context: context,
            isSelected:
                controller.selectionMap[conversation.conversationId] != null,
            user: conversationWithUser,
            group: conversationWithGroup,
            onlineStatusIndicatorColor:
                statusStyle.backgroundColor ?? colorPalette.success,
            privateGroupIcon: privateGroupIcon,
            protectedGroupIcon: protectedGroupIcon,
            // privateGroupIconBackground:
            //     conversationsStyle.privateGroupIconBackground,
            // protectedGroupIconBackground:
            //     conversationsStyle.protectedGroupIconBackground,
            disableUsersPresence:
                controller.hideUserPresence(conversationWithUser));

    backgroundColor = statusIndicatorUtils.statusIndicatorColor;
    icon = statusIndicatorUtils.icon;
    return GestureDetector(
      key: UniqueKey(),
      onTap: () {
        if (activateSelection == ActivateSelection.onClick ||
            (activateSelection == ActivateSelection.onLongClick &&
                    controller.selectionMap.isNotEmpty) &&
                !(selectionMode == null ||
                    selectionMode == SelectionMode.none)) {
          controller.onTap(conversation);
          if (controller.selectionMap.isEmpty) {
            _isSelectionOn.value = false;
          } else if (activateSelection == ActivateSelection.onClick &&
              controller.selectionMap.isNotEmpty &&
              _isSelectionOn.value == false) {
            _isSelectionOn.value = true;
          }
        } else if (onItemTap != null) {
          onItemTap!(conversation);
          controller.activeConversation = conversation.conversationId;
        }
      },
      onLongPress: () {
        if (activateSelection == ActivateSelection.onLongClick &&
            controller.selectionMap.isEmpty &&
            !(selectionMode == null || selectionMode == SelectionMode.none)) {
          controller.onTap(conversation);

          _isSelectionOn.value = true;
        } else if (onItemLongPress != null) {
          onItemLongPress!(conversation);

          controller.activeConversation = conversation.conversationId;
        } else {
          List<CometChatOption>? options = ConversationUtils.getDefaultOptions(
              conversation, controller, context, colorPalette);
          controller.showPopupMenu(
            context,
            options ?? [],
            colorPalette,
            typography,
            spacing,
            key,
          );
        }
      },
      child: CometChatListItem(
        avatarHeight: avatarHeight ?? 48,
        avatarWidth: avatarWidth ?? 48,
        avatarPadding: avatarPadding,
        statusIndicatorBorderRadius: statusIndicatorBorderRadius,
        avatarMargin: avatarMargin,
        statusIndicatorHeight: statusIndicatorHeight,
        statusIndicatorWidth: statusIndicatorWidth,
        id: conversation.conversationId,
        avatarName: conversationWithUser?.name ?? conversationWithGroup?.name,
        avatarURL: conversationWithUser?.avatar ?? conversationWithGroup?.icon,
        title: conversationWithUser?.name ?? conversationWithGroup?.name,
        key: UniqueKey(),
        subtitleView: subtitle,
        tailView: tail,
        avatarStyle:
            conversationStyle.avatarStyle ?? const CometChatAvatarStyle(),
        statusIndicatorColor: backgroundColor,
        statusIndicatorIcon: icon,
        statusIndicatorStyle: CometChatStatusIndicatorStyle(
          border: statusStyle.border ??
              Border.all(
                width: spacing.spacing ?? 0,
                color: colorPalette.background1 ?? Colors.transparent,
              ),
          backgroundColor: statusStyle.backgroundColor ?? colorPalette.success,
        ),
        hideSeparator: true,
        style: ListItemStyle(
          background: listItemStyle?.background ?? colorPalette.transparent,
          titleStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: typography.heading4?.medium?.fontSize,
            fontWeight: typography.heading4?.medium?.fontWeight,
            fontFamily: typography.heading4?.medium?.fontFamily,
            color: conversationStyle.itemTitleTextColor ??
                colorPalette.textPrimary,
          ).merge(
            listItemStyle?.titleStyle ?? conversationStyle.itemTitleTextStyle,
          ),
          height: listItemStyle?.height,
          border: listItemStyle?.border,
          borderRadius: listItemStyle?.borderRadius,
          gradient: listItemStyle?.gradient,
          width: listItemStyle?.width,
          margin: listItemStyle?.margin,
          padding: listItemStyle?.padding ??
              EdgeInsets.symmetric(
                horizontal: spacing.padding4 ?? 0,
                vertical: spacing.padding3 ?? 0,
              ),
        ),
      ),
    );
  }

  Widget getListItem(
    Conversation conversation,
    CometChatConversationsController controller,
    BuildContext context,
    CometChatConversationsStyle conversationStyle,
    GlobalKey key,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    if (listItemView != null) {
      return listItemView!(conversation);
    } else {
      return getDefaultItem(conversation, controller, context,
          conversationStyle, key, colorPalette, spacing, typography);
    }
  }

  Widget _getLoadingIndicator(
    BuildContext context,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    if (loadingStateText != null) {
      return Center(
        child: loadingStateText!(context),
      );
    } else {
      return CometChatShimmerEffect(
        colorPalette: colorPalette,
        child: ListView.builder(
          itemCount: 30,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.padding4 ?? 0,
                vertical: spacing.padding3 ?? 0,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: spacing.padding3 ?? 0,
                    ),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title shimmer bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 19.0,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(
                                  spacing.radius2 ?? 0,
                                ),
                              ),
                            ),
                            Container(
                              height: 19.0,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(
                                  spacing.radius2 ?? 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        // Subtitle shimmer bar
                        Container(
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              spacing.radius2 ?? 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Widget _getNoConversationIndicator(
    BuildContext context,
    CometChatConversationsStyle conversationsStyle,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    if (emptyStateView != null) {
      return Center(child: emptyStateView!(context));
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: spacing.padding5 ?? 0,
              ),
              child: Image.asset(
                AssetConstants(CometChatThemeHelper.getBrightness(context))
                    .conversationEmpty,
                package: UIConstants.packageName,
                width: 162,
                height: 121,
              ),
            ),
            Text(
              cc.Translations.of(context).noConversationsYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: conversationsStyle.emptyStateTextColor ??
                    colorPalette.textPrimary,
                fontSize: typography.heading3?.bold?.fontSize,
                fontWeight: typography.heading3?.bold?.fontWeight,
                fontFamily: typography.heading3?.bold?.fontFamily,
              )
                  .merge(
                    conversationsStyle.emptyStateTextStyle,
                  )
                  .copyWith(
                    color: conversationsStyle.emptyStateTextColor,
                  ),
            ),
            Text(
              cc.Translations.of(context).startNewChatOrInvite,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: conversationsStyle.emptyStateSubTitleTextColor ??
                    colorPalette.textSecondary,
                fontSize: typography.heading3?.regular?.fontSize,
                fontWeight: typography.heading3?.regular?.fontWeight,
                fontFamily: typography.heading3?.regular?.fontFamily,
              )
                  .merge(
                    conversationsStyle.emptyStateSubTitleTextStyle,
                  )
                  .copyWith(
                    color: conversationsStyle.emptyStateSubTitleTextColor,
                  ),
            ),
          ],
        ),
      );
    }
  }

  Widget _showErrorView(
    String errorText,
    BuildContext context,
    CometChatConversationsController controller,
    CometChatConversationsStyle conversationsStyle,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: spacing.padding5 ?? 0,
            ),
            child: Image.asset(
              AssetConstants(CometChatThemeHelper.getBrightness(context)).messagesError,
              package: UIConstants.packageName,
              width: 120,
              height: 120,
            ),
          ),
          Text(
            cc.Translations.of(context).oops,
            style: TextStyle(
              color: conversationsStyle.errorStateTextColor ??
                  colorPalette.textPrimary,
              fontSize: typography.heading3?.bold?.fontSize,
              fontWeight: typography.heading3?.bold?.fontWeight,
              fontFamily: typography.heading3?.bold?.fontFamily,
            )
                .merge(
                  conversationsStyle.errorStateTextStyle,
                )
                .copyWith(
                  color: conversationsStyle.errorStateTextColor,
                ),
          ),
          Text(
            "${cc.Translations.of(context).looksLikeSomethingWrong}.\n${cc.Translations.of(context).pleaseTryAgain}.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: conversationsStyle.errorStateSubTitleTextColor ??
                  colorPalette.textSecondary,
              fontSize: typography.heading3?.regular?.fontSize,
              fontWeight: typography.heading3?.regular?.fontWeight,
              fontFamily: typography.heading3?.regular?.fontFamily,
            )
                .merge(
                  conversationsStyle.errorStateSubTitleTextStyle,
                )
                .copyWith(
                  color: conversationsStyle.errorStateSubTitleTextColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _showError(
    CometChatConversationsController controller,
    BuildContext context,
    CometChatConversationsStyle conversationsStyle,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    String error;
    if (controller.error != null && controller.error is CometChatException) {
      error = Utils.getErrorTranslatedText(
          context, (controller.error as CometChatException).code);
    } else {
      error = cc.Translations.of(context).noChatsFound;
    }
    return _showErrorView(error, context, controller, conversationsStyle,
        colorPalette, spacing, typography);
  }

  Widget _getList(
    CometChatConversationsController conversationController,
    BuildContext context,
    CometChatConversationsStyle conversationsStyle,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    return GetBuilder(
      init: conversationController,
      global: false,
      dispose: (GetBuilderState<CometChatConversationsController> state) =>
          state.controller?.onClose(),
      builder: (CometChatConversationsController value) {
        value.context = context;
        if (value.hasError == true) {
          if (hideError == true) {
            return const SizedBox();
          }
          if (errorStateView != null) {
            return errorStateView!(context);
          }
          return _showError(value, context, conversationsStyle, colorPalette,
              spacing, typography);
        } else if (value.isLoading == true && (value.list.isEmpty)) {
          return _getLoadingIndicator(
              context, colorPalette, spacing, typography);
        } else if (value.list.isEmpty) {
          //----------- empty list widget-----------
          return _getNoConversationIndicator(
              context, conversationsStyle, colorPalette, spacing, typography);
        } else {
          List<GlobalKey> tileKeys =
              List.generate(value.list.length, (index) => GlobalKey());
          return ListView.builder(
            controller: controller,
            itemCount:
                value.hasMoreItems ? value.list.length + 1 : value.list.length,
            itemBuilder: (context, index) {
              if (index >= value.list.length) {
                value.loadMoreElements();
                return _getLoadingIndicator(
                  context,
                  colorPalette,
                  spacing,
                  typography,
                );
              }

              return SizedBox(
                key: tileKeys[index],
                child: getListItem(
                  value.list[index],
                  value,
                  context,
                  conversationsStyle,
                  tileKeys[index],
                  colorPalette,
                  spacing,
                  typography,
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget getSelectionWidget(
    CometChatConversationsController conversationsController,
  ) {
    if (_isSelectionOn.value) {
      return IconButton(
        onPressed: () {
          List<Conversation>? conversations =
              conversationsController.getSelectedList();
          if (onSelection != null) {
            onSelection!(conversations);
          }
        },
        icon: Image.asset(
          AssetConstants.checkmark,
          package: UIConstants.packageName,
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversationStyle =
        CometChatThemeHelper.getTheme<CometChatConversationsStyle>(
                context: context, defaultTheme: CometChatConversationsStyle.of)
            .merge(style);
    final typography = CometChatThemeHelper.getTypography(context);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final spacing = CometChatThemeHelper.getSpacing(context);

    if (stateCallBack != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => stateCallBack!(conversationsController));
    }

    return ClipRRect(
      borderRadius: conversationStyle.borderRadius ??
          BorderRadius.circular(
            0,
          ),
      child: CometChatListBase(
        title: title ?? cc.Translations.of(context).chats,
        hideSearch: true,
        hideAppBar: hideAppbar,
        backIcon: backIcon,
        showBackButton: showBackButton,
        onBack: onBack,
        menuOptions: [
          if (appBarOptions != null && appBarOptions!.isNotEmpty)
            ...appBarOptions!,
          Obx(
            () => getSelectionWidget(conversationsController),
          )
        ],
        style: ListBaseStyle(
          background:
              conversationStyle.backgroundColor ?? colorPalette.background1,
          titleStyle: TextStyle(
            color: conversationStyle.titleTextColor ?? colorPalette.textPrimary,
            fontSize: typography.heading1?.bold?.fontSize,
            fontWeight: typography.heading1?.bold?.fontWeight,
            fontFamily: typography.heading1?.bold?.fontFamily,
          )
              .merge(
                conversationStyle.titleTextStyle,
              )
              .copyWith(
                color: conversationStyle.titleTextColor,
              ),
          backIconTint:
              conversationStyle.backIconColor ?? colorPalette.iconPrimary,
          border: conversationStyle.border,
          borderRadius: conversationStyle.borderRadius,
        ),
        container: Column(
          children: [
            Divider(
              color:
                  conversationStyle.separatorColor ?? colorPalette.borderLight,
              height: conversationStyle.separatorHeight ?? 1,
            ),
            Expanded(
              child: _getList(
                conversationsController,
                context,
                conversationStyle,
                colorPalette,
                spacing,
                typography,
              ),
            ),
          ],
        ),
      ),
    );
  }

//----------- default subtitle
  Widget getDefaultSubtitle({
    required BuildContext context,
    required Conversation conversation,
    required bool showTypingIndicator,
    required CometChatConversationsController controller,
    bool? hideThreadIndicator = true,
    String? threadIndicatorText,
    required CometChatConversationsStyle conversationStyle,
    required CometChatColorPalette colorPalette,
    required CometChatSpacing spacing,
    required CometChatTypography typography,
  }) {
    final typingStyle =
        CometChatThemeHelper.getTheme<CometChatTypingIndicatorStyle>(
                context: context,
                defaultTheme: CometChatTypingIndicatorStyle.of)
            .merge(conversationStyle.typingIndicatorStyle);
    String prefix = "";
    if (hideThreadIndicator != null && hideThreadIndicator == false) {
      if (conversation.conversationWith is User) {
        if (conversation.lastMessage?.sender?.uid !=
            CometChatUIKit.loggedInUser?.uid) {
          prefix = "${conversation.lastMessage?.sender?.name}: ";
        } else {
          prefix = "${cc.Translations.of(context).you}: ";
        }
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hideThreadIndicator != null && hideThreadIndicator == false)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getReceiptIcon(
                context,
                conversation: conversation,
                conversationStyle: conversationStyle,
                hideReceipt: controller.getHideReceipt(
                  conversation,
                  hideReceipt,
                ),
                colorPalette: colorPalette,
                spacing: spacing,
                typography: typography,
              ),
              Icon(
                Icons.subdirectory_arrow_right,
                color: colorPalette.iconSecondary,
                size: 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: spacing.padding ?? 0, right: spacing.padding ?? 0),
                child: Text(
                  prefix,
                  style: TextStyle(
                    color: conversationStyle.itemSubtitleTextColor ??
                        colorPalette.textSecondary,
                    fontWeight: typography.body?.regular?.fontWeight,
                    fontSize: typography.body?.regular?.fontSize,
                    fontFamily: typography.body?.regular?.fontFamily,
                  )
                      .merge(
                        conversationStyle.itemSubtitleTextStyle,
                      )
                      .copyWith(
                        color: conversationStyle.itemSubtitleTextColor,
                      ),
                ),
              ),
            ],
          ),
        if (!showTypingIndicator && hideThreadIndicator != null && hideThreadIndicator != false)
          getReceiptIcon(
            context,
            conversation: conversation,
            conversationStyle: conversationStyle,
            hideReceipt: controller.getHideReceipt(
              conversation,
              hideReceipt,
            ),
            colorPalette: colorPalette,
            spacing: spacing,
            typography: typography,
          ),
        if (showTypingIndicator)
          Expanded(
            child: Text(
              typingIndicatorText ??
                  ((conversation.conversationWith is User)
                      ? cc.Translations.of(context).isTyping
                      : "${controller.typingMap[conversation.conversationId]?.sender.name ?? ''} ${cc.Translations.of(context).isTyping}"),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorPalette.textHighlight,
                fontWeight: typography.body?.regular?.fontWeight,
                fontSize: typography.body?.regular?.fontSize,
                fontFamily: typography.body?.regular?.fontFamily,
              ).merge(
                typingStyle.textStyle,
              ),
            ),
          )
        else
          Expanded(
            child: getSubtitle(context, conversation, controller,
                conversationStyle, colorPalette, spacing, typography),
          ),
      ],
    );
  }

  Widget getReceiptIcon(
    context, {
    required Conversation conversation,
    required CometChatConversationsStyle conversationStyle,
    bool? hideReceipt,
    required CometChatColorPalette colorPalette,
    required CometChatSpacing spacing,
    required CometChatTypography typography,
  }) {
    if (hideReceipt ?? false) {
      return const SizedBox();
    } else if (conversation.lastMessage != null &&
        conversation.lastMessage?.sender != null &&
        conversation.lastMessage!.deletedAt == null &&
        conversation.lastMessage!.type != "groupMember") {
      ReceiptStatus status =
          MessageReceiptUtils.getReceiptStatus(conversation.lastMessage!);
      final receiptStyle =
          CometChatThemeHelper.getTheme<CometChatMessageReceiptStyle>(
                  context: context,
                  defaultTheme: CometChatMessageReceiptStyle.of)
              .merge(conversationStyle.receiptStyle);
      return Padding(
        padding: EdgeInsets.only(
          right: spacing.padding1 ?? 0,
        ),
        child: CometChatReceipt(
          status: status,
          style: receiptStyle,
          deliveredIcon: deliveredIcon ??
              Icon(
                Icons.done_all,
                color: receiptStyle.deliveredIconColor ??
                    colorPalette.iconSecondary,
                size: 16,
              ),
          readIcon: readIcon ??
              Icon(
                Icons.done_all,
                color: receiptStyle.readIconColor ?? colorPalette.iconHighlight,
                size: 16,
              ),
          sentIcon: sentIcon ??
              Icon(
                Icons.check,
                color: receiptStyle.sentIconColor ?? colorPalette.iconSecondary,
                size: 16,
              ),
          errorIcon: Icon(
            Icons.error_outlined,
            color: receiptStyle.errorIconColor ?? colorPalette.error,
            size: 16,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget getSubtitle(
    BuildContext context,
    Conversation conversation,
    CometChatConversationsController controller,
    CometChatConversationsStyle conversationsStyle,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    TextStyle subtitleStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      color: conversationsStyle.itemSubtitleTextColor ??
          colorPalette.textSecondary,
      fontSize: typography.body?.regular?.fontSize,
      fontWeight: typography.body?.regular?.fontWeight,
      fontFamily: typography.body?.regular?.fontFamily,
    )
        .merge(
          conversationsStyle.itemSubtitleTextStyle,
        )
        .copyWith(
          color: conversationsStyle.itemSubtitleTextColor,
        );

    AdditionalConfigurations? configurations;

    if (conversation.lastMessage != null) {
      configurations = AdditionalConfigurations(
        textFormatters: controller.getTextFormatters(conversation.lastMessage!),
      );
    }

    Widget subtitle = CometChatUIKit.getDataSource().getConversationSubtitle(
        conversation,
        context,
        subtitleStyle,
        conversationsStyle.messageTypeIconColor ?? colorPalette.iconSecondary,
        additionalConfigurations: configurations);

    return subtitle;
  }

//----------- last message update time and unread message count -----------
  Widget getTime(
    Conversation conversation,
    CometChatConversationsStyle conversationStyle,
    context,
    CometChatColorPalette colorPalette,
    CometChatSpacing spacing,
    CometChatTypography typography,
  ) {
    DateTime? lastMessageTime =
        conversation.lastMessage?.updatedAt ?? conversation.lastMessage?.sentAt;
    if (lastMessageTime == null) return const SizedBox();

    String? customDateString;

    if (datePattern != null) {
      customDateString = datePattern!(conversation);
    }

    final datesStyle = CometChatThemeHelper.getTheme<CometChatDateStyle>(
            context: context, defaultTheme: CometChatDateStyle.of)
        .merge(conversationStyle.dateStyle);

    return CometChatDate(
      date: lastMessageTime,
      padding: datePadding ?? const EdgeInsets.all(0),
      height: dateHeight,
      isTransparentBackground: dateBackgroundIsTransparent,
      width: dateWidth,
      style: CometChatDateStyle(
        backgroundColor: datesStyle.backgroundColor ?? colorPalette.transparent,
        textStyle: TextStyle(
          color: datesStyle.textColor ?? colorPalette.textSecondary,
          fontSize: typography.caption1?.regular?.fontSize,
          fontWeight: typography.caption1?.regular?.fontWeight,
          fontFamily: typography.caption1?.regular?.fontFamily,
        ).merge(datesStyle.textStyle).copyWith(
              color: datesStyle.textColor,
            ),
        border: datesStyle.border ??
            Border.all(
              width: 0,
              color: Colors.transparent,
            ),
        borderRadius: datesStyle.borderRadius,
        textColor: datesStyle.textColor,
      ),
      customDateString: customDateString,
      pattern: DateTimePattern.dayDateTimeFormat,
    );
  }

  Widget getUnreadCount(Conversation conversation,
      CometChatConversationsStyle conversationStyle, context) {
    return CometChatBadge(
      count: conversation.unreadMessageCount ?? 0,
      width: badgeWidth,
      height: badgeHeight ?? 20,
      style: conversationStyle.badgeStyle ?? const CometChatBadgeStyle(),
      padding: badgePadding,
    );
  }
}
