import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:master_app/guard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorPalette = CometChatThemeHelper.getColorPalette(context);

    return MaterialApp(
      title: 'CometChat sample app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        Translations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
        extensions: [

        ]
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('ar', ''),
        Locale('de', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('ms', ''),
        Locale('pt', ''),
        Locale('ru', ''),
        Locale('sv', ''),
        Locale('zh', ''),
        Locale('hu', ''),
      ],
      home: GuardScreen(
        key: CallNavigationContext.navigatorKey,
      ),
    );
  }
}
