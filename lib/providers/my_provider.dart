import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode mode = ThemeMode.light;

  changeLanguage(String lan) async {
    language = lan;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(lan, lan);
    notifyListeners();
  }

  changeTheme(ThemeMode theme) async {
    mode = theme;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('mode', mode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }
}
