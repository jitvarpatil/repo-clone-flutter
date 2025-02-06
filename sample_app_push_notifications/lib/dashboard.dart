import 'dart:io';

import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:master_app/create_group/cometchat_create_group.dart';
import 'package:master_app/guard_screen.dart';
import 'package:master_app/messages.dart';
import 'package:master_app/notifications/services/cometchat_services.dart';
import 'package:master_app/utils/join_protected_group_util.dart';

import 'call_log_details/cometchat_call_log_details.dart';
import 'notifications/services/apns_services.dart';
import 'notifications/services/firebase_services.dart';
import 'notifications/services/globals.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver, CometChatUIEventListener {
  final FirebaseService notificationService = FirebaseService();
  final APNSService apnsServices = APNSService();

  int _selectedIndex = 0;
  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;

  late String _dateString;

  String conversationEventListenerId = "CWMConversationListener";

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _dateString = DateTime.now().millisecondsSinceEpoch.toString();

    CometChatUIEvents.addUiListener(
        _dateString + conversationEventListenerId, this);
    super.initState();
    if (Platform.isAndroid) {
      notificationService.init(context);
    } else {
      apnsServices.init(context);
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (useFcm && Platform.isAndroid) {
        notificationService.resumeCallListeners(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    CometChatUIEvents.removeUiListener(
        _dateString + conversationEventListenerId);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    typography = CometChatThemeHelper.getTypography(context);
    spacing = CometChatThemeHelper.getSpacing(context);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void openChat(
    User? user,
    Group? group,
  ) {
    navigateToMessages(user: user, group: group);
  }

  bool isLoading = false;

  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });

    try {
      PNRegistry.unregisterPNService();
      await CometChatUIKit.logout(
        onSuccess: (p0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GuardScreen(),
            ),
          );
        },
      );
    } catch (e) {
      // Handle any errors here
      print("Logout failed: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToMessages({User? user, Group? group}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MessagesSample(
            user: user,
            group: group,
          );

          // return MyScrollTestWidget();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPalette.background1,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CometChatConversations(
            showBackButton: false,
            appBarOptions: [
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(spacing.radius2 ?? 0),
                  side: BorderSide(
                    color: colorPalette.borderLight ?? Colors.transparent,
                    width: 1,
                  ),
                ),
                color: colorPalette.background1,
                elevation: 4,
                menuPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                icon: Padding(
                  padding: EdgeInsets.only(
                    left: spacing.padding3 ?? 0,
                    right: spacing.padding4 ?? 0,
                  ),
                  child: CometChatAvatar(
                    width: 40,
                    height: 40,
                    image: CometChatUIKit.loggedInUser?.avatar,
                    name: CometChatUIKit.loggedInUser?.name,
                  ),
                ),
                onSelected: (value) {
                  switch (value) {
                    case '/Create':
                      setState(() {
                        _selectedIndex = 2;
                      });
                      break;
                    case '/logout':
                      logout();
                      break;
                    case '/name':
                      break;
                    case '/version':
                      break;
                  }
                },
                position: PopupMenuPosition.under,
                enableFeedback: false,
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      height: 44,
                      padding: EdgeInsets.all(spacing.padding4 ?? 0),
                      value: '/Create',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: spacing.padding2 ?? 0),
                            child: Icon(
                              Icons.add_comment_outlined,
                              color: colorPalette.iconSecondary,
                              size: 24,
                            ),
                          ),
                          Text(
                            "Create Conversation",
                            style: TextStyle(
                              fontSize: typography.body?.regular?.fontSize,
                              fontFamily: typography.body?.regular?.fontFamily,
                              fontWeight: typography.body?.regular?.fontWeight,
                              color: colorPalette.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      height: 44,
                      padding: EdgeInsets.all(spacing.padding4 ?? 0),
                      value: '/name',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: spacing.padding2 ?? 0),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: colorPalette.iconSecondary,
                              size: 24,
                            ),
                          ),
                          Text(
                            CometChatUIKit.loggedInUser?.name ?? "",
                            style: TextStyle(
                              fontSize: typography.body?.regular?.fontSize,
                              fontFamily: typography.body?.regular?.fontFamily,
                              fontWeight: typography.body?.regular?.fontWeight,
                              color: colorPalette.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      height: 44,
                      padding: EdgeInsets.all(spacing.padding4 ?? 0),
                      value: '/logout',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: spacing.padding2 ?? 0),
                            child: Icon(
                              Icons.logout,
                              color: colorPalette.error,
                              size: 24,
                            ),
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: typography.body?.regular?.fontSize,
                              fontFamily: typography.body?.regular?.fontFamily,
                              fontWeight: typography.body?.regular?.fontWeight,
                              color: colorPalette.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      height: 44,
                      padding: EdgeInsets.zero,
                      value: '/version',
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: colorPalette.borderLight ??
                                  Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spacing.padding4 ?? 0),
                          child: Text(
                            "V5.0.0_alpha9",
                            style: TextStyle(
                              fontSize: typography.body?.regular?.fontSize,
                              fontFamily: typography.body?.regular?.fontFamily,
                              fontWeight: typography.body?.regular?.fontWeight,
                              color: colorPalette.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
            onItemTap: (conversation) {
              User? user;
              Group? group;
              if (conversation.conversationWith is User) {
                user = conversation.conversationWith as User;
              } else {
                group = conversation.conversationWith as Group;
              }
              navigateToMessages(user: user, group: group);
            },
          ),
          CometChatCallLogs(
            showBackButton: false,
            onItemClick: (callLog) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CometChatCallLogDetails(
                      callLog: callLog,
                    );
                  },
                ),
              );
            },
          ),
          CometChatUsers(
            showBackButton: false,
            onBack: () {},
            onItemTap: (context, user) {
              navigateToMessages(user: user);
            },
          ),
          CometChatGroups(
            appBarOptions: (context) {
              return [
                IconButton(
                  onPressed: () {
                    showCreateGroup(
                      context: context,
                      colorPalette: colorPalette,
                      typography: typography,
                      spacing: spacing,
                    );
                  },
                  icon: Icon(
                    Icons.group_add,
                    color: colorPalette.iconHighlight,
                  ),
                ),
              ];
            },
            showBackButton: false,
            onItemTap: (context, group) {
              JoinProtectedGroupUtils.onGroupItemTap(
                  context, group, colorPalette, typography, spacing);
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: spacing.padding ?? 0),
        decoration: BoxDecoration(
          color: colorPalette.background1,
          border: Border(
            top: BorderSide(
              color: colorPalette.borderLight ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, // Remove ripple effect
            highlightColor: Colors.transparent, // Disable highlight feedback
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            elevation: 0,
            onTap: _onItemTapped,
            selectedItemColor: colorPalette.primary,
            showUnselectedLabels: true,
            unselectedItemColor: colorPalette.textSecondary,
            selectedLabelStyle: TextStyle(
              color: colorPalette.primary,
              fontSize: typography.caption1?.medium?.fontSize,
              fontFamily: typography.caption1?.medium?.fontFamily,
              fontWeight: typography.caption1?.medium?.fontWeight,
            ),
            unselectedLabelStyle: TextStyle(
              color: colorPalette.textSecondary,
              fontSize: typography.caption1?.regular?.fontSize,
              fontFamily: typography.caption1?.regular?.fontFamily,
              fontWeight: typography.caption1?.regular?.fontWeight,
            ),
            iconSize: 32,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorPalette.background1,
            enableFeedback: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_outlined,
                  color: colorPalette.iconSecondary,
                ),
                activeIcon: Icon(
                  Icons.chat_rounded,
                  color: colorPalette.primary,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.call_outlined,
                  color: colorPalette.iconSecondary,
                ),
                activeIcon: Icon(
                  Icons.call_rounded,
                  color: colorPalette.primary,
                ),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded,
                    color: colorPalette.iconSecondary),
                activeIcon: Icon(
                  Icons.person_rounded,
                  color: colorPalette.primary,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: colorPalette.iconSecondary,
                ),
                activeIcon: Icon(
                  Icons.people_alt_rounded,
                  color: colorPalette.primary,
                ),
                label: 'Groups',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
