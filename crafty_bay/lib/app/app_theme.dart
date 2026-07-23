import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.themeColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    progressIndicatorTheme: _progressIndicatorThemeData,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    filledButtonTheme: _filledButtonThemeData,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.themeColor,
    progressIndicatorTheme: _progressIndicatorThemeData,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    filledButtonTheme: _filledButtonThemeData
  );

  static final ProgressIndicatorThemeData _progressIndicatorThemeData =
      ProgressIndicatorThemeData(color: AppColors.themeColor);

  static final TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        contentPadding: .symmetric(horizontal: 12, vertical: 0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor),
        ),
      );

  static final FilledButtonThemeData _filledButtonThemeData =
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          fixedSize: Size.fromWidth(double.maxFinite),
          padding: .symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 16,
          ),
        ),
      );
}
