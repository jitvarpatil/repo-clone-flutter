import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///Function to show comeChat action sheet
Future<CometChatMessageComposerAction?>? showCometChatAiOptionSheet(
    {required BuildContext context,
    required List<CometChatMessageComposerAction> actionItems,
    final User? user,
    final Group? group,
    final CometChatColorPalette? colorPalette,
    final CometChatTypography? typography,
    final CometChatSpacing? spacing,
      final CometChatAiOptionSheetStyle? style,
    }) {
  final aiOptionSheetStyle = CometChatThemeHelper.getTheme<CometChatAiOptionSheetStyle>(
    context: context,
    defaultTheme: CometChatAiOptionSheetStyle.of,
  ).merge(style);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: aiOptionSheetStyle.backgroundColor ?? colorPalette?.background1,
    shape: RoundedRectangleBorder(
      side: aiOptionSheetStyle.border ?? BorderSide.none,
      borderRadius: aiOptionSheetStyle.borderRadius ?? BorderRadius.vertical(
        top: Radius.circular(spacing?.radius6 ?? 0),
      ),
    ),

    builder: (builder) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: actionItems.length,
        padding: EdgeInsets.only(
          top: spacing?.padding5 ?? 0,
          bottom: spacing?.padding5 ?? 0,
        ),
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              if (actionItems[index].onItemClick != null) {
                actionItems[index].onItemClick!(context, user, group);
              }
            },
            child: ListTile(
              contentPadding: EdgeInsets.all(
                spacing?.padding4 ?? 0,
              ),
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              minTileHeight: 0,
              leading: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      aiOptionSheetStyle.iconColor ?? Colors.transparent,
                      BlendMode.srcIn),
                  child: actionItems[index].icon),
              title: Text(
                actionItems[index].title,
                style: TextStyle(
                    fontSize: typography?.body?.regular?.fontSize,
                    fontWeight: typography?.body?.regular?.fontWeight,
                    color: colorPalette?.textPrimary,
                    fontFamily: typography?.body?.regular?.fontFamily)
                    .merge(
                  actionItems[index].style?.titleTextStyle ?? aiOptionSheetStyle.textStyle,
                ),
              ),
            ),
          );
        },
      );
    },
  );
  // }
// }
  return null;
}
