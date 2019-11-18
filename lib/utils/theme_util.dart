import 'package:flutter/material.dart';
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
}