import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String language = 'en';

  void changeLanguage(String newLanguage) async {
    if (language == newLanguage) {
      return;
    }
    language = newLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (themeMode == newTheme) {
      return;
    }
    themeMode = newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'theme',
        newTheme == ThemeMode.dark
            ? 'dark'
            : newTheme == ThemeMode.system
                ? 'system'
                : 'light');
    notifyListeners();
  }


}
