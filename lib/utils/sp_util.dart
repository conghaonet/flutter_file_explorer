import 'package:flutter/material.dart';

import 'app_shared_preferences.dart';

class SpUtil {
  @Deprecated('Use `_themeMode` instead.')
  static const String _darkMode = 'darkMode';

  static const String _themeMode = 'themeMode';
  static const String _themeColorIndex = 'themeColorIndex';
  static const String _accentColorIndex = 'accentColorIndex';

  @Deprecated('Use `getThemeMode()` instead.')
  static bool isDarkMode() => appSP.getBool(_darkMode) ?? false;
  @Deprecated('Use `setThemeMode(ThemeMode)` instead.')
  static Future<bool> setDarkMode(bool isDark) => appSP.setBool(_darkMode, isDark);

  static ThemeMode getThemeMode() {
    int modeIndex = appSP.getInt(_themeMode);
    if(modeIndex == ThemeMode.dark.index) return ThemeMode.dark;
    else if(modeIndex == ThemeMode.system.index) return ThemeMode.system;
    else return ThemeMode.light;
  }
  static Future<bool> setThemeMode(ThemeMode mode) {
    return appSP.setInt(_themeMode, mode.index);
  }

  static int getThemeColorIndex() => appSP.getInt(_themeColorIndex) ?? -1;
  static Future<bool> setThemeColorIndex(int colorIndex) => appSP.setInt(_themeColorIndex, colorIndex);

  static int getAccentColorIndex() => appSP.getInt(_accentColorIndex) ?? -1;
  static Future<bool> setAccentColorIndex(int colorIndex) => appSP.setInt(_accentColorIndex, colorIndex);
}