import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppConstants.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: AppConstants.primaryColor,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black, fontSize: 20),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        borderSide: const BorderSide(color: AppConstants.primaryColor),
      ),
    ),
  );
}
