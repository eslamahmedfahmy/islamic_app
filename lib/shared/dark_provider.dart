import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// دي صفحه الي بيتخزن فيه الوضع الحالي لي التطبيق
// علشان لما اخرج من التطبيق وهو وضع ليللي ارجع القي هو لسه وضع ليلي

class ThemeProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;
  late SharedPreferences _prefs;

  ThemeProvider() {
    _loadFromPrefs();
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleTheme() async {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    notifyListeners();

    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isDarkModeEnabled', _isDarkModeEnabled);
  }

  Future<void> _loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkModeEnabled = _prefs.getBool('isDarkModeEnabled') ?? false;
    notifyListeners();
  }
}
