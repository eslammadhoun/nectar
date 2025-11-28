import 'package:flutter/material.dart';

class AppTheme {
   static const Color mainColor = Color(0xFF53B175);
  static const Color textColor = Color(0xFF181725);
  static const Color errorColor = Colors.red;
  static const Color backgroundColor = Colors.white;
  static const Color googleBlue = Color(0xFF5383EC);
  static const Color facebookBlue = Color(0xFF4A66AC);
  static const Color lightGrey = Color(0xFF828282);
  static const Color lightBackground = Color(0xFFFCFCFC);
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color secondaryText = Color(0xFF7C7C7C);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: mainColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Gilroy',
      colorScheme: ColorScheme.light(
        primary: mainColor,
        secondary: mainColor,
        error: errorColor,
        surface: backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Gilroy',
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
