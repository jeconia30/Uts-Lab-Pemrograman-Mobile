import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void setDark(bool value) {
    _mode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}