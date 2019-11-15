import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/pages/navigation_error_page.dart';
import 'package:flutter_file_explorer/pages/splash_page.dart';

class AppNavigator extends NavigatorObserver {
  AppNavigator._internal();
  static final AppNavigator appNavigation = AppNavigator._internal();
  factory AppNavigator() => appNavigation;

  /// 静态路由（无参数）
  static final Map<String, WidgetBuilder> _routes = {
    SplashPage.navigationName: (_) => SplashPage(),
    HomePage.navigationName: (_) => HomePage(),
  };
  Map<String, WidgetBuilder> get routes => _routes;

  /// 带参数路由
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case HomePage.navigationName:
        final String args = settings.arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return HomePage();
          },
        );
      default:
        return MaterialPageRoute(builder: (context) {return NavigationErrorPage(route: settings.name);});
    }
  }
  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {

  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if(previousRoute.settings != null && previousRoute.settings.name != null){
      setPreferredOrientations(previousRoute.settings);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if(route.settings != null && route.settings.name != null){
      setPreferredOrientations(route.settings);
    }
  }

  void setPreferredOrientations(RouteSettings settings) {
    /*
    if(targetName == "/") {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // 恢复系统默认UI：显示状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else if(CategoryPage.routeName == targetName) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // 隐藏状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else if(DetailPage.routeName == targetName) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // 隐藏状态栏、虚拟按键导航栏
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
    */
  }
}

AppNavigator appNavigation = AppNavigator();