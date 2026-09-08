import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.card,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(),
    cardTheme: CardThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
    dividerTheme: DividerThemeData(),
  );


  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: DarkTheme.card,
    ),
    scaffoldBackgroundColor: DarkTheme.darkbackground,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(),
    cardTheme: CardThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
    dividerTheme: DividerThemeData(),
  );
}

