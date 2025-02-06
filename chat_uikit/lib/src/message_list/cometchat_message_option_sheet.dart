import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[CometchatMessageOptionSheet] renders a bottom modal sheet
///that contains all the actions available to execute on a particular type of message
class CometchatMessageOptionSheet extends StatefulWidget {
  const CometchatMessageOptionSheet({
    super.key,
    required this.messageObject,
    required this.actionItems,
    this.title,
    this.state,
    this.data,
    this.favoriteReactions,
    this.hideReactions = false,
    this.onReactionTap,
    this.onAddReactionIconTap,
    this.addReactionIcon,
    this.messageOptionStyle,
  });

  ///[actionItems] is a list of [ActionItem] which is used to set the actions
  final List<ActionItem> actionItems;

  ///[title] sets the title for the bottom sheet
  final String? title;

  ///[data] is a parameter used to set the data
  final dynamic data;

  ///[state] is a parameter used to set the state
  final CometChatMessageListController? state;

  ///[favoriteReactions] is a list of frequently used reactions
  final List<String>? favoriteReactions;

  ///[messageObject] is a parameter used to set the message object
  final BaseMessage messageObject;

  ///[hideReactions] is a parameter used to hide the reactions
  final bool? hideReactions;

  ///[onReactionTap] is a callback which gets called when a reaction is pressed
  final Function(BaseMessage message, String? reaction)? onReactionTap;

  ///[addReactionIcon] sets custom icon for adding reaction
  final Widget? addReactionIcon;

  ///[onAddReactionIconTap] sets custom onTap for adding reaction
  final Function(BaseMessage)? onAddReactionIconTap;

  ///[messageOptionStyle] sets the style for the message option bottom sheet
  final CometChatMessageOptionSheetStyle? messageOptionStyle;

  @override
  State<CometchatMessageOptionSheet> createState() =>
      _CometchatMessageOptionSheetState();
}

class _CometchatMessageOptionSheetState
    extends State<CometchatMessageOptionSheet> {
  late List<String> favoriteReactions;
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    favoriteReactions =
        widget.favoriteReactions ?? ['👍', '❤️', '😂', '😢', '🙏'];
  }

  @override
  Widget build(BuildContext context) {
    final optionStyle =
        CometChatThemeHelper.getTheme<CometChatMessageOptionSheetStyle>(
                context: context,
                defaultTheme: CometChatMessageOptionSheetStyle.of)
            .merge(widget.messageOptionStyle);
    final spacing = CometChatThemeHelper.getSpacing(context);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final typography = CometChatThemeHelper.getTypography(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: optionStyle.border,
            borderRadius: optionStyle.borderRadius ??
                BorderRadius.vertical(
                  top: Radius.circular(
                    spacing.radius6 ?? 0,
                  ),
                ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Min size based on content
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: spacing.padding3 ?? 0,
                  bottom: spacing.padding2 ?? 0,
                ),
                decoration: BoxDecoration(
                  color:
                      optionStyle.backgroundColor ?? colorPalette.background1,
                  borderRadius: optionStyle.borderRadius ??
                      BorderRadius.vertical(
                        top: Radius.circular(
                          spacing.radius6 ?? 0,
                        ),
                      ),
                ),
                child: Center(
                  child: Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      color: colorPalette.neutral500,
                      borderRadius: BorderRadius.circular(
                        spacing.radiusMax ?? 0,
                      ),
                    ),
                  ),
                ),
              ),
              if (!(widget.hideReactions ?? false))
                Container(
                  decoration: BoxDecoration(
                    color:
                        optionStyle.backgroundColor ?? colorPalette.background1,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: spacing.padding2 ?? 0,
                    horizontal: spacing.padding5 ?? 0,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...favoriteReactions.map(
                          (reaction) => SizedBox(
                            height: 40,
                            width: 40,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop();
                                if (widget.onReactionTap != null) {
                                  widget.onReactionTap!(
                                      widget.messageObject, reaction);
                                }
                              },
                              child: CircleAvatar(
                                radius: spacing.radiusMax,
                                backgroundColor: colorPalette.background3,
                                child: Text(
                                  reaction,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        typography.heading1?.regular?.fontSize,
                                    fontWeight: typography
                                        .heading1?.regular?.fontWeight,
                                    fontFamily: typography
                                        .heading1?.regular?.fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                            radius: spacing.radiusMax,
                            backgroundColor: colorPalette.background3,
                            child: IconButton(
                              onPressed: () async {
                                if (widget.onAddReactionIconTap != null) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  widget.onAddReactionIconTap!(
                                      widget.messageObject);
                                }
                              },
                              icon: Icon(
                                Icons.add_reaction_outlined,
                                size: 24,
                                color: colorPalette.iconSecondary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (!(widget.hideReactions ?? false))
                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorPalette.borderLight,
                ),
              //---reactions---
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.actionItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      minVerticalPadding: 0,
                      minTileHeight: 0,
                      horizontalTitleGap: spacing.padding2,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          selectedIndex = index;
                        });
                        Navigator.of(context).pop(widget.actionItems[index]);
                      },
                      contentPadding: EdgeInsets.symmetric(
                        vertical: spacing.padding3 ?? 0,
                        horizontal: spacing.padding5 ?? 0,
                      ),
                      dense: true,
                      selected: selectedIndex == index,
                      selectedTileColor:
                          widget.actionItems[index].style?.backgroundColor ??
                              optionStyle.backgroundColor ??
                              colorPalette.background4,
                      minLeadingWidth: 0,
                      leading: widget.actionItems[index].icon,
                      iconColor: widget.actionItems[index].style?.iconColor ??
                          optionStyle.iconColor ??
                          colorPalette.iconSecondary,
                      tileColor:
                          widget.actionItems[index].style?.backgroundColor ??
                              optionStyle.backgroundColor ??
                              colorPalette.background1,
                      title: Text(
                        widget.actionItems[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: widget.actionItems[index].style?.titleColor ??
                              optionStyle.titleColor ??
                              colorPalette.textPrimary,
                          fontSize: typography.body?.regular?.fontSize,
                          fontWeight: typography.body?.regular?.fontWeight,
                          fontFamily: typography.body?.regular?.fontFamily,
                        )
                            .merge(
                              widget.actionItems[index].style?.titleTextStyle ??
                                  optionStyle.titleTextStyle,
                            )
                            .copyWith(
                              color:
                                  widget.actionItems[index].style?.titleColor ??
                                      optionStyle.titleColor,
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

///Function to show message option bottom sheet
Future<ActionItem?> showMessageOptionSheet({
  required BuildContext context,
  required List<ActionItem> actionItems,
  required CometChatColorPalette colorPalette,
  final String? title,
  required final dynamic message,
  required final CometChatMessageListController state,
  final Function(BaseMessage, String?)? onReactionTap,
  final Widget? addReactionIcon,
  final Function(BaseMessage)? addReactionIconTap,
  bool hideReactions = false,
  List<String>? favoriteReactions,
  CometChatMessageOptionSheetStyle? style,
}) {
  return showModalBottomSheet<ActionItem>(
    backgroundColor: colorPalette.background1,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (BuildContext context) => CometchatMessageOptionSheet(
      messageObject: message,
      actionItems: actionItems,
      title: title,
      data: message,
      state: state,
      addReactionIcon: addReactionIcon,
      onAddReactionIconTap: addReactionIconTap,
      hideReactions: hideReactions,
      favoriteReactions: favoriteReactions,
      onReactionTap: onReactionTap,
      messageOptionStyle: style,
    ),
  );
}
