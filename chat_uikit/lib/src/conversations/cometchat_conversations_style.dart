import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[CometChatConversationsStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatConversations]
///``` dart
///CometChatConversationsStyle(
/// backgroundColor: Colors.white,
/// border: Border.all(color: Colors.white, width: 0),
/// );
/// ```
class CometChatConversationsStyle
    extends ThemeExtension<CometChatConversationsStyle> {
  const CometChatConversationsStyle(
      {this.backgroundColor,
        this.border,
        this.borderRadius,
        this.backIconColor,
        this.titleTextStyle,
        this.titleTextColor,
        this.emptyStateTextStyle,
        this.emptyStateTextColor,
        this.errorStateTextStyle,
        this.errorStateTextColor,
        this.emptyStateSubTitleTextStyle,
        this.emptyStateSubTitleTextColor,
        this.errorStateSubTitleTextStyle,
        this.errorStateSubTitleTextColor,
        this.itemTitleTextStyle,
        this.itemTitleTextColor,
        this.itemSubtitleTextStyle,
        this.itemSubtitleTextColor,
        this.messageTypeIconColor,
        this.separatorColor,
        this.separatorHeight,
        this.typingIndicatorStyle,
        this.avatarStyle,
        this.statusIndicatorStyle,
        this.badgeStyle,
        this.receiptStyle,
        this.mentionsStyle,
        this.dateStyle,
        this.deleteConversationDialogStyle});

  ///[backgroundColor] provides background color for the widget
  final Color? backgroundColor;

  ///[border] provides border for the widget
  final Border? border;

  ///[borderRadius] provides border radius for the widget
  final BorderRadiusGeometry? borderRadius;

  ///[backIconColor] provides color for the back icon
  final Color? backIconColor;

  ///[title] provides title for the widget
  final TextStyle? titleTextStyle;

  ///[titleTextColor] provides text color for the title
  final Color? titleTextColor;

  ///[emptyStateTextStyle] provides text style for empty state
  final TextStyle? emptyStateTextStyle;

  ///[emptyStateTextColor] provides text color for empty state
  final Color? emptyStateTextColor;

  ///[emptyStateSubTitleTextStyle] provides text style for empty state
  final TextStyle? emptyStateSubTitleTextStyle;

  ///[emptyStateSubTitleTextColor] provides text color for empty state
  final Color? emptyStateSubTitleTextColor;

  ///[errorStateTextStyle] provides text style for error state
  final TextStyle? errorStateTextStyle;

  ///[errorStateTextStyle] provides sub-title text style for error state
  final TextStyle? errorStateSubTitleTextStyle;

  ///[errorStateTextColor] provides text color for error state
  final Color? errorStateTextColor;

  ///[errorStateSubTitleTextColor] provides sub-title text color for error state
  final Color? errorStateSubTitleTextColor;

  ///[itemTitleTextStyle] provides text style for item tile title
  final TextStyle? itemTitleTextStyle;

  ///[itemTitleTextColor] provides text color for item tile title
  final Color? itemTitleTextColor;

  ///[itemSubtitleTextStyle] provides text style for item tile title
  final TextStyle? itemSubtitleTextStyle;

  ///[itemSubtitleTextColor] provides text color for item tile title
  final Color? itemSubtitleTextColor;

  ///[messageTypeIconColor] provides icon color for message type
  final Color? messageTypeIconColor;

  ///[separatorHeight] provides height for the separator
  final double? separatorHeight;

  ///[separatorColor] provides color for the separator
  final Color? separatorColor;

  ///[typingIndicatorStyle] provides style for typing indicator
  final CometChatTypingIndicatorStyle? typingIndicatorStyle;

  ///[dateStyle] provides styling for CometChatDate
  final CometChatDateStyle? dateStyle;

  ///[avatarStyle] set style for avatar
  final CometChatAvatarStyle? avatarStyle;

  ///[statusIndicatorStyle] set style for status indicator
  final CometChatStatusIndicatorStyle? statusIndicatorStyle;

  ///[badgeStyle] used to customize the unread messages count indicator
  final CometChatBadgeStyle? badgeStyle;

  ///[receiptStyle] sets the style for the receipts shown in the subtitle
  final CometChatMessageReceiptStyle? receiptStyle;

  ///[mentionsStyle] sets the style for the mentions shown in the subtitle
  final CometChatMentionsStyle? mentionsStyle;

  ///[deleteConversationDialogStyle] sets the style for the dialog for deleting conversation
  final CometChatConfirmDialogStyle? deleteConversationDialogStyle;

  static CometChatConversationsStyle of(BuildContext context) =>
      const CometChatConversationsStyle();

  @override
  CometChatConversationsStyle copyWith({
    Color? backgroundColor,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    Color? backIconColor,
    TextStyle? titleTextStyle,
    Color? titleTextColor,
    TextStyle? emptyStateTextStyle,
    Color? emptyStateTextColor,
    TextStyle? errorStateTextStyle,
    Color? errorStateTextColor,
    TextStyle? emptyStateSubtitleTextStyle,
    Color? emptyStateSubtitleTextColor,
    TextStyle? errorStateSubTitleTextStyle,
    Color? errorStateSubTitleTextColor,
    TextStyle? itemTitleTextStyle,
    Color? itemTitleTextColor,
    TextStyle? itemSubtitleTextStyle,
    Color? itemSubtitleTextColor,
    Color? messageTypeIconColor,
    double? separatorHeight,
    Color? separatorColor,
    CometChatAvatarStyle? messageBubbleAvatarStyle,
    CometChatStatusIndicatorStyle? statusIndicatorStyle,
    CometChatBadgeStyle? badgeStyle,
    CometChatMessageReceiptStyle? receiptStyle,
    CometChatMentionsStyle? mentionsStyle,
    CometChatDateStyle? dateStyle,
    CometChatTypingIndicatorStyle? typingIndicatorStyle,
    CometChatConfirmDialogStyle? deleteConversationDialogStyle,
  }) {
    return CometChatConversationsStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      backIconColor: backIconColor ?? this.backIconColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      emptyStateTextStyle: emptyStateTextStyle ?? this.emptyStateTextStyle,
      emptyStateTextColor: emptyStateTextColor ?? this.emptyStateTextColor,
      errorStateTextStyle: errorStateTextStyle ?? this.errorStateTextStyle,
      errorStateTextColor: errorStateTextColor ?? this.errorStateTextColor,
      emptyStateSubTitleTextStyle:
      emptyStateSubtitleTextStyle ?? this.emptyStateSubTitleTextStyle,
      emptyStateSubTitleTextColor:
      emptyStateSubtitleTextColor ?? this.emptyStateSubTitleTextColor,
      errorStateSubTitleTextStyle:
      errorStateSubTitleTextStyle ?? this.errorStateSubTitleTextStyle,
      errorStateSubTitleTextColor:
      errorStateSubTitleTextColor ?? this.errorStateSubTitleTextColor,
      itemTitleTextStyle: itemTitleTextStyle ?? this.itemTitleTextStyle,
      itemTitleTextColor: itemTitleTextColor ?? this.itemTitleTextColor,
      itemSubtitleTextStyle:
      itemSubtitleTextStyle ?? this.itemSubtitleTextStyle,
      itemSubtitleTextColor:
      itemSubtitleTextColor ?? this.itemSubtitleTextColor,
      messageTypeIconColor: messageTypeIconColor ?? this.messageTypeIconColor,
      separatorHeight: separatorHeight ?? this.separatorHeight,
      separatorColor: separatorColor ?? this.separatorColor,
      avatarStyle: messageBubbleAvatarStyle ?? this.avatarStyle,
      statusIndicatorStyle: statusIndicatorStyle ?? this.statusIndicatorStyle,
      badgeStyle: badgeStyle ?? this.badgeStyle,
      receiptStyle: receiptStyle ?? this.receiptStyle,
      mentionsStyle: mentionsStyle ?? this.mentionsStyle,
      dateStyle: dateStyle ?? this.dateStyle,
      typingIndicatorStyle: typingIndicatorStyle ?? this.typingIndicatorStyle,
      deleteConversationDialogStyle:
      deleteConversationDialogStyle ?? this.deleteConversationDialogStyle,
    );
  }

  CometChatConversationsStyle merge(CometChatConversationsStyle? style) {
    if (style == null) return this;
    return copyWith(
      errorStateTextColor: style.errorStateTextColor,
      emptyStateSubtitleTextStyle: style.emptyStateSubTitleTextStyle,
      emptyStateSubtitleTextColor: style.emptyStateSubTitleTextColor,
      errorStateSubTitleTextStyle: style.errorStateSubTitleTextStyle,
      errorStateSubTitleTextColor: style.errorStateSubTitleTextColor,
      itemTitleTextStyle: style.itemTitleTextStyle,
      itemTitleTextColor: style.itemTitleTextColor,
      itemSubtitleTextStyle: style.itemSubtitleTextStyle,
      itemSubtitleTextColor: style.itemSubtitleTextColor,
      messageTypeIconColor: style.messageTypeIconColor,
      separatorHeight: style.separatorHeight,
      separatorColor: style.separatorColor,
      messageBubbleAvatarStyle: style.avatarStyle,
      typingIndicatorStyle: style.typingIndicatorStyle,
      badgeStyle: style.badgeStyle,
      dateStyle: style.dateStyle,
      mentionsStyle: style.mentionsStyle,
      receiptStyle: style.receiptStyle,
      statusIndicatorStyle: style.statusIndicatorStyle,
      deleteConversationDialogStyle: style.deleteConversationDialogStyle,
      backgroundColor: style.backgroundColor,
      border: style.border,
      borderRadius: style.borderRadius,
      backIconColor: style.backIconColor,
      titleTextStyle: style.titleTextStyle,
      titleTextColor: style.titleTextColor,
      emptyStateTextStyle: style.emptyStateTextStyle,
      emptyStateTextColor: style.emptyStateTextColor,
      errorStateTextStyle: style.errorStateTextStyle,
    );
  }

  @override
  CometChatConversationsStyle lerp(
      ThemeExtension<CometChatConversationsStyle>? other, double t) {
    if (other is! CometChatConversationsStyle) {
      return this;
    }
    return CometChatConversationsStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      border: Border.lerp(border, other.border, t),
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
      backIconColor: Color.lerp(backIconColor, other.backIconColor, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      emptyStateTextStyle:
      TextStyle.lerp(emptyStateTextStyle, other.emptyStateTextStyle, t),
      emptyStateTextColor:
      Color.lerp(emptyStateTextColor, other.emptyStateTextColor, t),
      errorStateTextStyle:
      TextStyle.lerp(errorStateTextStyle, other.errorStateTextStyle, t),
      errorStateTextColor:
      Color.lerp(errorStateTextColor, other.errorStateTextColor, t),
      emptyStateSubTitleTextStyle: TextStyle.lerp(
          emptyStateSubTitleTextStyle, other.emptyStateSubTitleTextStyle, t),
      emptyStateSubTitleTextColor: Color.lerp(
          emptyStateSubTitleTextColor, other.emptyStateSubTitleTextColor, t),
      errorStateSubTitleTextStyle: TextStyle.lerp(
          errorStateSubTitleTextStyle, other.errorStateSubTitleTextStyle, t),
      errorStateSubTitleTextColor: Color.lerp(
          errorStateSubTitleTextColor, other.errorStateSubTitleTextColor, t),
      itemTitleTextStyle:
      TextStyle.lerp(itemTitleTextStyle, other.itemTitleTextStyle, t),
      itemTitleTextColor:
      Color.lerp(itemTitleTextColor, other.itemTitleTextColor, t),
      itemSubtitleTextStyle:
      TextStyle.lerp(itemSubtitleTextStyle, other.itemSubtitleTextStyle, t),
      itemSubtitleTextColor:
      Color.lerp(itemSubtitleTextColor, other.itemSubtitleTextColor, t),
      messageTypeIconColor:
      Color.lerp(messageTypeIconColor, other.messageTypeIconColor, t),
      separatorHeight: lerpDouble(separatorHeight, other.separatorHeight, t),
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t),
      avatarStyle: avatarStyle?.lerp(other.avatarStyle, t),
      typingIndicatorStyle:
      typingIndicatorStyle?.lerp(other.typingIndicatorStyle, t),
      badgeStyle: badgeStyle?.lerp(other.badgeStyle, t),
      dateStyle: dateStyle?.lerp(other.dateStyle, t),
      mentionsStyle: mentionsStyle?.lerp(other.mentionsStyle, t),
      receiptStyle: receiptStyle?.lerp(other.receiptStyle, t),
      statusIndicatorStyle:
      statusIndicatorStyle?.lerp(other.statusIndicatorStyle, t),
      deleteConversationDialogStyle: deleteConversationDialogStyle?.lerp(
          other.deleteConversationDialogStyle, t),
    );
  }
}
