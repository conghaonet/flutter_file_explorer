import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = SpUtil.isDarkMode();
  ThemeMode _themeMode = SpUtil.getThemeMode();
  int _themeColorIndex = SpUtil.getThemeColorIndex();
  int _accentColorIndex = SpUtil.getAccentColorIndex();

  @Deprecated('')
  bool get isDark => this._isDark;

  ThemeMode get themeMode => this._themeMode;
  int get themeColorIndex => this._themeColorIndex;
  int get accentColorIndex => this._accentColorIndex;

  @Deprecated('')
  void setThemeIsDarkMode(bool isDark) async {
    this._isDark = isDark;
    await SpUtil.setDarkMode(this._isDark);
    notifyListeners();
  }
  void setThemeMode(ThemeMode mode) async {
    this._themeMode = mode;
    await SpUtil.setThemeMode(this._themeMode);
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