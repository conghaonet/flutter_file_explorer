import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/pages/splash_page.dart';
import 'package:flutter_file_explorer/utils/app_shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';

void main() async {
  await appSP.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 国际化设置
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // for iOS
      ],
      supportedLocales: S.delegate.supportedLocales,
      //指定默认语言
//            localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en','')),
      title: 'File Explorer',
      onGenerateTitle: (context) => S.current.appTitle,
      theme: ThemeData.dark(),
      home: SplashPage(),
    );
  }

}