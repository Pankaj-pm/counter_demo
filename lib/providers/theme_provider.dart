import 'package:counter_demo/main.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;

  ThemeProvider() {
    var m = prefs.getString("app_mode") ?? "";
    print(m);
    if (m == "dark") {
      mode = ThemeMode.dark;
    } else if (m == "light") {
      mode = ThemeMode.light;
    } else {
      mode = ThemeMode.system;
    }
  }

  void changeTheme() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
      prefs.setString("app_mode", "dark");
    } else if (mode == ThemeMode.dark) {
      mode = ThemeMode.system;
      prefs.setString("app_mode", "system");
    } else {
      mode = ThemeMode.light;
      prefs.setString("app_mode", "light");
    }
    notifyListeners();
  }
}
