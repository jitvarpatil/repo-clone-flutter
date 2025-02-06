import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:master_app/thread_screen/cometchat_thread.dart';
import 'package:master_app/user_info/cometchat_user_info.dart';

import 'group_info/cometchat_group_info.dart';

class MessagesSample extends StatelessWidget {
  final User? user;
  final Group? group;

  const MessagesSample({
    Key? key,
    this.user,
    this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ccColor = CometChatThemeHelper.getColorPalette(context);
    final spacing = CometChatThemeHelper.getSpacing(context);
    final typography = CometChatThemeHelper.getTypography(context);
    return Scaffold(
      backgroundColor: ccColor.background1,
      appBar: CometChatMessageHeader(
        user: user,
        group: group,
        appBarOptions: (user, group, context) {
          if (group != null) {
            return [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CometchatGroupInfo(
                        group: group,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                  color: ccColor.iconPrimary,
                ),
              ),
            ];
          } else if (user != null) {
            return [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CometchatUserInfo(
                          user: user,
                        );
                      },
                    ),
                  );
                },
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    Icons.info_outline,
                    color: ccColor.iconPrimary,
                    size: 24,
                  ),
                ),
              ),
            ];
          }
        },
      ),
      resizeToAvoidBottomInset: true, // Ensures layout adjusts when keyboard appears
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: CometChatMessageList(
                user: user,
                group: group,
                showAvatar: true,
                onThreadRepliesClick: (message, context, {template}) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CometChatThread(
                        user: user,
                        group: group,
                        message: message,
                        template: template,
                      )
                    ),
                  );
                },
              ),
            ),
          ),
          CometChatMessageComposer(
            user: user,
            group: group,
          ),
        ],
      ),
    );
  }
}
