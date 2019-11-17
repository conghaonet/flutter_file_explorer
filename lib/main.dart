import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/navigation/app_navigator.dart';
import 'package:flutter_file_explorer/pages/splash_page.dart';
import 'package:flutter_file_explorer/providers/theme_provider.dart';
import 'package:flutter_file_explorer/utils/app_shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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

  SystemUiOverlayStyle getOverlayStyle(BuildContext _context) {
    return Provider.of<ThemeProvider>(_context).isDark ?
    SystemUiOverlayStyle.light.copyWith(
//      statusBarBrightness: Theme.of(context).primaryColorBrightness,
////      statusBarBrightness: ThemeData.estimateBrightnessForColor(Theme.of(context).primaryColor),
//      statusBarIconBrightness: Theme.of(context).primaryColorBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: ThemeData.dark().primaryColor, //系统导航栏（虚拟按键）背景色
      systemNavigationBarIconBrightness: ThemeData.estimateBrightnessForColor(ThemeData.dark().primaryColor) == Brightness.dark ? Brightness.light : Brightness.dark,

    ) : SystemUiOverlayStyle.dark.copyWith();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return AnnotatedRegion(
            value: getOverlayStyle(context),
            child: MaterialApp(
              // 定义静态路由，不能传递参数
              routes: appNavigation.routes,
              //动态路由，可传递参数
              onGenerateRoute: appNavigation.generateRoute,
              navigatorObservers: [
                appNavigation,
              ],
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
              theme: Provider.of<ThemeProvider>(context).isDark ? ThemeData.dark() : ThemeData.light(),
              home: SplashPage(),
            ),
          );
        },
      ),
    );
  }

}