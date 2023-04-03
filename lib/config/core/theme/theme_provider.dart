import 'package:flutter/material.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

/////// Han che de Opacity !

class MyThemes {
  static final darkTheme = ThemeData(
      indicatorColor: const Color(0xffF9D205),
      scaffoldBackgroundColor: const Color.fromARGB(255, 78, 78, 78),
      backgroundColor: Colors.white.withOpacity(0.8),
      primaryColor: Colors.white,
      primaryColorDark: Colors.black,
      primaryColorLight: CustomColor.backgroundAppbar,
      cardColor: const Color.fromARGB(255, 78, 78, 78),
      colorScheme: const ColorScheme.dark(),
      iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 216, 187, 39))); //// han che opacity
  // iconTheme: const IconThemeData(
  //     color: iconMenu, opacity: 0.8)); //de ocpacity la 0 de test lag
  // );
  static final lightTheme = ThemeData(
      indicatorColor: Colors.white,
      //background appbar
      // scaffoldBackgroundColor: const Color.fromARGB(255, 248, 216, 161),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.6),
      //color text
      primaryColor: Colors.black,
      primaryColorDark: const Color(0xffEDF0F3),
      primaryColorLight: CustomColor.backgroundAppbar,
      cardColor: Colors.white,
      colorScheme: const ColorScheme.light().copyWith(
        background: Colors.orangeAccent.withOpacity(0.4),
      ),
      iconTheme: const IconThemeData(
        color: Colors.amber,
      ));
  // iconTheme: const IconThemeData(color: iconMenu, opacity: 0.8));
  // );
}
