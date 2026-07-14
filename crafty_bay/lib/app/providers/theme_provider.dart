import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String _themeKey = 'themeMode';

  ThemeMode _currentThemeMode = ThemeMode.system;

  List<ThemeMode> get themeModes => [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark,
  ];

  ThemeMode get currentThemeMode => _currentThemeMode;

  void changeThemeMode(ThemeMode mode) {
    _currentThemeMode = mode;
    _saveCurrentThemeMode(mode);
    notifyListeners();
  }

  Future<void> init() async {
    await _setCurrentThemeMode();
  }

  Future<void> _saveCurrentThemeMode(ThemeMode mode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_themeKey, mode.name);
  }

  Future<void> _setCurrentThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? themeMode = sharedPreferences.getString(_themeKey);
    _currentThemeMode = _getThemeMode(themeMode);
  }

  ThemeMode _getThemeMode(String? themeMode) {
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
