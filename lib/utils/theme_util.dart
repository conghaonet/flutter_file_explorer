import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/resources/app_const.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';

class ThemeUtil {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: SpUtil.getThemeColorIndex() != -1 ? AppConst.themeColors[SpUtil.getThemeColorIndex()] : Theme.of(context).primaryColor,
      primaryColorDark: SpUtil.getThemeColorIndex() != -1 ? AppConst.themeColors[SpUtil.getThemeColorIndex()][700] : Theme.of(context).primaryColorDark,
      accentColor: SpUtil.getAccentColorIndex() != -1 ? AppConst.accentColors[SpUtil.getAccentColorIndex()] : Theme.of(context).accentColor,
      toggleableActiveColor: SpUtil.getAccentColorIndex() != -1 ? AppConst.accentColors[SpUtil.getAccentColorIndex()] : Theme.of(context).accentColor,
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      accentColor: SpUtil.getAccentColorIndex() != -1 ? AppConst.accentColors[SpUtil.getAccentColorIndex()] : Theme.of(context).accentColor,
      toggleableActiveColor: SpUtil.getAccentColorIndex() != -1 ? AppConst.accentColors[SpUtil.getAccentColorIndex()] : Theme.of(context).accentColor,
    );
  }

  static SystemUiOverlayStyle getSystemUiOverlayStyle(BuildContext context) {
    if((SpUtil.getThemeMode() == ThemeMode.light)
        || (SpUtil.getThemeMode() == ThemeMode.system
            && MediaQuery.of(context).platformBrightness == Brightness.light)) {
      return SystemUiOverlayStyle(
        statusBarColor: SpUtil.getThemeColorIndex() != -1 ? AppConst.themeColors[SpUtil.getThemeColorIndex()] : Theme.of(context).primaryColor,
        statusBarBrightness: Theme.of(context).primaryColorBrightness,
        statusBarIconBrightness: Theme.of(context).primaryColorBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: SpUtil.getThemeColorIndex() != -1 ? AppConst.themeColors[SpUtil.getThemeColorIndex()] : Theme.of(context).primaryColor, //系统导航栏（虚拟按键）背景色
        systemNavigationBarIconBrightness: ThemeData.estimateBrightnessForColor(Theme.of(context).primaryColor) == Brightness.dark ? Brightness.light : Brightness.dark,
      );
    } else {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: ThemeData.dark().primaryColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ThemeData.dark().primaryColor, //系统导航栏（虚拟按键）背景色
        systemNavigationBarIconBrightness: Brightness.light,
      );
    }
  }
}