import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';

class AppTheme {
  AppTheme._();
  static getApplicationTheme(bool isDark) {
    return ThemeData(
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
            )
          : const ColorScheme.light(
              primary: Colors.blueAccent,
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,

      fontFamily: 'Montserrat',
      useMaterial3: true,

      // scaffoldBackgroundColor: Colors.white,

      //app bar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeConstant
            .primaryColor, // yesma edit xa AppColorConstant.primaryColor,

        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),

      ////////Elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 0, 65, 118),
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),

      // text theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18,
        ),
      ),

      // input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color.fromARGB(255, 208, 206, 206),
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),

        /////error border
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 65, 118),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 2, 46, 82),
          ),
        ),
      ),

      // Navigation theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 0, 47, 85),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
            iconColor: isDark
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(
                    Colors.black) // Light theme icon color
            ),
      ),

      // fontFamily: 'Montserrat',
      // useMaterial3: true,
    );
  }
}
