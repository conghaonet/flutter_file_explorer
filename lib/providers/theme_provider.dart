import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = SpUtil.isDarkMode();
  int _themeColorIndex = SpUtil.getThemeColorIndex();
  int _accentColorIndex = SpUtil.getAccentColorIndex();

  bool get isDark => this._isDark;
  int get themeColorIndex => this._themeColorIndex;
  int get accentColorIndex => this._accentColorIndex;


  void setThemeIsDarkMode(bool isDark) async {
    this._isDark = isDark;
    await SpUtil.setDarkMode(this._isDark);
    notifyListeners();
  }
  void setThemeColorIndex(int colorIndex) async {
    this._themeColorIndex = colorIndex;
    await SpUtil.setThemeColorIndex(this._themeColorIndex);
    notifyListeners();
  }
  void setAccentColorIndex(int colorIndex) async {
    this._accentColorIndex = colorIndex;
    await SpUtil.setAccentColorIndex(this._accentColorIndex);
    notifyListeners();
  }
}